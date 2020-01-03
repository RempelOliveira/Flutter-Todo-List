import "dart:io";
import "dart:convert";
import "package:http/http.dart" as http;
import "package:flutter_redux/flutter_redux.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/actions/UsersActions.dart";

import "package:google_books_api/utils/UserAuthentication.dart";


final String api =
    DotEnv().env["API_URL"] + "/api/books";

Future<Map<String, dynamic>> getBooks(context) async
{
    final store =
        StoreProvider.of<AppState>(context);

    try
    {
        http.Response response = await http.get(
            Uri.encodeFull("$api?tab=${store.state.tab}&category=${store.state.category}&skip=${store.state.skipBooks}"), headers: { HttpHeaders.authorizationHeader: await getAuthUser(true, store.state.token) });

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
            Uri.encodeFull("http://192.168.0.8:3002/api/books/$bookId"), headers: { HttpHeaders.authorizationHeader: await getAuthUser(true, store.state.token) });

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
            Uri.encodeFull("http://192.168.0.8:3002/api/books/$action"), body: { "id": book["id"] }, headers: { HttpHeaders.authorizationHeader: await getAuthUser(true, store.state.token) });

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