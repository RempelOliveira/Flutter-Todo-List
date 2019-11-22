import "dart:convert";
import "package:http/http.dart" as http;
import "package:redux/redux.dart";
import "package:redux_thunk/redux_thunk.dart";

import "package:google_books_api/states/AppState.dart";

ThunkAction<AppState> getBooks = (Store<AppState> store)
{
    if(!store.state.isLoading && !store.state.isLoadingMore)
    {
        store.dispatch(
            ChangeIsLoading(true)

        );

    }

    Future.delayed(Duration(milliseconds: 500), () async
    {
        http.Response response = await http.get(
            Uri.encodeFull("http://192.168.0.5:3002/api/books?tab=${store.state.tab}&category=${store.state.category}&skip=${store.state.skip}"));

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
                    UpdateBooksList(data["total"], data["books"], store.state.skip == 0)

                );

                store.dispatch(
                    ChangeSkip(store.state.skip + data["books"].length)

                );

            }

            if(store.state.isLoading)
            {
                store.dispatch(
                    ChangeIsLoading(false)

                );

            }

            if(store.state.isLoadingMore)
            {
                store.dispatch(
                    ChangeIsLoadingMore(false)

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

class ChangeIsLoading
{
    bool isLoading;
    ChangeIsLoading(this.isLoading);

}

class ChangeIsLoadingMore
{
    bool isLoadingMore;
    ChangeIsLoadingMore(this.isLoadingMore);

}

class ChangeSkip
{
    int skip;
    ChangeSkip(this.skip);

}

class UpdateBooksList
{
    int booksTotal;
    List<dynamic> books;

    bool clean;

    UpdateBooksList(this.booksTotal, this.books, this.clean);

}