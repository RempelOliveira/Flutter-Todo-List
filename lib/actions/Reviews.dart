import "dart:io";
import "dart:convert";
import "package:http/http.dart" as http;
import "package:redux/redux.dart";
import "package:flutter_redux/flutter_redux.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

import "package:redux_thunk/redux_thunk.dart";
import "package:google_books_api/states/AppState.dart";

import "package:google_books_api/utils/UserAuthentication.dart";
import "package:google_books_api/actions/UsersActions.dart";

final String api =
    DotEnv().env["API_URL"] + "/api/books";

Future<Map<String, dynamic>> createReview(context, Map<String, dynamic> review, [bool all = false]) async
{
    final store =
        StoreProvider.of<AppState>(context);

    try
    {
        http.Response response = await http.post(
            Uri.encodeFull("$api/${store.state.book["id"]}/reviews${all ? "?all=true" : ""}"), body: review, headers: { HttpHeaders.authorizationHeader: await getAuthUser(true) });

        Map<String, dynamic> data =
            jsonDecode(response.body);

        if(data["error"] == "authorization")
        {
            signOut(context);

        }
        else
        {
            /*
                store.dispatch(
                    UpdateReviews(data["book"])

                );
            */

            store.dispatch(
                UpdateUser(await setAuthUser(data["user"]["token"]))

            );

        }

        return data;

    }
    on SocketException catch(error)
    {
        return { "error": { "internal": "Network fail" }};

    }
    catch(error)
    {
        return error.response.data;

    }

}

ThunkAction<AppState> getReviews = (Store<AppState> store)
{
    if(store.state.allReviews)
    {
        if(!store.state.isLoadingAllReviews)
        {
            store.dispatch(
                ChangeIsLoadingAllReviews(true)

            );

        }

    }
    else
    {
        if(!store.state.isLoadingReviews)
        {
            store.dispatch(
                ChangeIsLoadingReviews(true)

            );

        }

    }

    Future.delayed(Duration(milliseconds: 500), () async
    {
        http.Response response = await http.get(
            Uri.encodeFull("http://192.168.0.8:3002/api/books/${store.state.book["id"]}/reviews?all=${store.state.allReviews}"));

        if(response.statusCode == 200)
        {
            Map<String, dynamic> data =
                jsonDecode(response.body);

            if(data["error"] == "authorization")
            {
                print("authorization error");

            }
            else
            {
                store.dispatch(
                    UpdateBookReviews(data["reviews"]["total"], data["reviews"]["items"])

                );

                store.dispatch(
                    ChangeAllReviews(true)

                );

            }

            if(store.state.isLoadingReviews)
            {
                store.dispatch(
                    ChangeIsLoadingReviews(false)

                );

            }

            if(store.state.isLoadingAllReviews)
            {
                store.dispatch(
                    ChangeIsLoadingAllReviews(false)

                );

            }

        }
        else
        {
            print("catch error: $response");

        }

    });

};

class ChangeIsLoadingReviews
{
    bool isLoadingReviews;
    ChangeIsLoadingReviews(this.isLoadingReviews);

}

class ChangeIsLoadingAllReviews
{
    bool isLoadingAllReviews;
    ChangeIsLoadingAllReviews(this.isLoadingAllReviews);

}

class UpdateBookReviews
{
    int reviewsTotal;
    List<dynamic> reviews;

    UpdateBookReviews(this.reviewsTotal, this.reviews);

}

class ChangeAllReviews
{
    bool allReviews;
    ChangeAllReviews(this.allReviews);

}