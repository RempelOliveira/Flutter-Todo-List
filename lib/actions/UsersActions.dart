import "dart:io";
import "dart:convert";
import "package:http/http.dart" as http;
import "package:flutter_redux/flutter_redux.dart";

import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/utils/UserAuthentication.dart";

Future<Map<String, dynamic>> signUp(context, Map user) async
{
    final store =
        StoreProvider.of<AppState>(context);

    try
    {
        http.Response response = await http.post(
            Uri.encodeFull("http://192.168.5.1:3002/api/users/sign-up"), body: { "name": user["name"].toString(), "email": user["email"].toString(), "password": setAuthPassword(user["password"].toString()) });

        Map<String, dynamic> data =
            jsonDecode(response.body);

        if(data["error"] == null)
        {
            data = await setAuthUser(data["token"], true);

            store.dispatch(
                SignUp(data)

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

Future<Map<String, dynamic>> signIn(context, Map user) async
{
    final store =
        StoreProvider.of<AppState>(context);

    try
    {
        http.Response response = await http.post(
            Uri.encodeFull("http://192.168.5.1:3002/api/users/sign-in"), body: { "email": user["email"].toString(), "password": setAuthPassword(user["password"].toString()), "remember": user["remember"].toString() });

        Map<String, dynamic> data =
            jsonDecode(response.body);

        if(data["error"] == null)
        {
            data = await setAuthUser(data["token"], user["remember"]);

            store.dispatch(
                SignIn(data)

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

Future<void> signInByToken(context) async
{
    final store =
        StoreProvider.of<AppState>(context);

    dynamic user = await getAuthUser();

    if(user.toString().isNotEmpty)
    {
        store.dispatch(
            SignInByToken(user)

        );

    }

}

Future<void> signOut(context) async
{
    final store =
        StoreProvider.of<AppState>(context);

    await setAuthUser();

    store.dispatch(
        SignOut()

    );

}

class SignIn
{
    Map<String, dynamic> user;
    SignIn(this.user);

}

class SignInByToken
{
    Map<String, dynamic> user;
    SignInByToken(this.user);

}

class SignUp
{
    Map<String, dynamic> user;
    SignUp(this.user);

}

class SignOut
{
    SignOut();

}

class UpdateUser
{
    Map<String, dynamic> user;
    UpdateUser(this.user);

}

class ChangeIsLoadingSignIn
{
    bool isLoadingSignIn;
    ChangeIsLoadingSignIn(this.isLoadingSignIn);

}

class ChangeIsLoadingSignUp
{
    bool isLoadingSignUp;
    ChangeIsLoadingSignUp(this.isLoadingSignUp);

}