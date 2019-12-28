import "dart:io";
import "dart:convert";
import "package:http/http.dart" as http;
import "package:flutter_redux/flutter_redux.dart";

import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/utils/UserAuthentication.dart";

Future<Map<String, dynamic>> signUp(context, Map<String, dynamic> user) async
{
    final store =
        StoreProvider.of<AppState>(context);

    try
    {
        http.Response response = await http.post(
            Uri.encodeFull("http://192.168.0.8:3002/api/users/sign-up"), body: { "name": user["name"], "email": user["email"], "password": setAuthPassword(user["password"]) });

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

Future<Map<String, dynamic>> signIn(context, Map<String, dynamic> user) async
{
    final store =
        StoreProvider.of<AppState>(context);

    try
    {
        http.Response response = await http.post(
            Uri.encodeFull("http://192.168.0.8:3002/api/users/sign-in"), body: { "email": user["email"], "password": setAuthPassword(user["password"]), "remember": user["remember"].toString() });

        Map<String, dynamic> data =
            jsonDecode(response.body);

        if(data["error"] == null)
        {
            if(user["remember"] == false)
            {
                store.dispatch(
                    StoreToken(data["token"])

                );

            }

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
        print(error);

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

class StoreToken
{
    String token;
    StoreToken(this.token);

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