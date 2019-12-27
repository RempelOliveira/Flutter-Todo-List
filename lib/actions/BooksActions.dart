import "dart:io";
import "dart:convert";
import "package:http/http.dart" as http;

import "package:redux/redux.dart";
import "package:redux_thunk/redux_thunk.dart";
import "package:flutter_redux/flutter_redux.dart";

import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/actions/UsersActions.dart";

import "package:google_books_api/utils/UserAuthentication.dart";

Future<Map<String, dynamic>> getBooks(context) async
{
    final store =
        StoreProvider.of<AppState>(context);

    try
    {
        http.Response response = await http.get(
            Uri.encodeFull("http://192.168.0.8:3002/api/books?tab=${store.state.tab}&category=${store.state.category}&skip=${store.state.skipBooks}"), headers: { HttpHeaders.authorizationHeader: await getAuthUser(true) });

        Map<String, dynamic> data =
            jsonDecode(response.body);

        if(data["error"] == "authorization")
            signOut(context);

        store.dispatch(
            UpdateBooksList(data["total"], data["books"], store.state.skipBooks == 0)

        );

        store.dispatch(
            ChangeSkipBooks(data["books"] != null ? store.state.skipBooks + data["books"].length : 0)

        );

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

Future<Map<String, dynamic>> getBook(context, String bookId) async
{
    final store =
        StoreProvider.of<AppState>(context);

    try
    {
        http.Response response = await http.get(
            Uri.encodeFull("http://192.168.0.8:3002/api/books/$bookId"), headers: { HttpHeaders.authorizationHeader: await getAuthUser(true) });

        Map<String, dynamic> data =
            jsonDecode(response.body);

        if(data["error"] == "authorization")
            signOut(context);

        store.dispatch(
            UpdateBook(data["book"])

        );

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

Future<Map<String, dynamic>> updateBook(context, Map<String, dynamic> book, String action) async
{
    final store =
        StoreProvider.of<AppState>(context);

    try
    {
        http.Response response = await http.patch(
            Uri.encodeFull("http://192.168.0.8:3002/api/books/$action"), body: { "id": book["id"] }, headers: { HttpHeaders.authorizationHeader: await getAuthUser(true) });

        Map<String, dynamic> data =
            jsonDecode(response.body);

        if(data["error"] == "authorization")
        {
            signOut(context);

        }
        else
        {
            store.dispatch(
                UpdateBook(data["book"])

            );

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
            Map data =
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

class ChangeTab
{
    String tab;
    ChangeTab(this.tab);

}

class ChangeCategory
{
    String category;
    ChangeCategory(this.category);

}

class ChangeIsLoadingBooks
{
    bool isLoadingBooks;
    ChangeIsLoadingBooks(this.isLoadingBooks);

}

class ChangeIsLoadingMoreBooks
{
    bool isLoadingMoreBooks;
    ChangeIsLoadingMoreBooks(this.isLoadingMoreBooks);

}

class ChangeSkipBooks
{
    int skipBooks;
    ChangeSkipBooks(this.skipBooks);

}

class UpdateBooksList
{
    int booksTotal;
    List<dynamic> books;

    bool clean;

    UpdateBooksList(this.booksTotal, this.books, this.clean);

}

class UpdateBook
{
    Map<String, dynamic> book;
    UpdateBook(this.book);

}

class ChangeAllReviews
{
    bool allReviews;
    ChangeAllReviews(this.allReviews);

}

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