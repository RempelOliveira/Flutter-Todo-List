import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/actions/UsersActions.dart";

AppState userReducer(AppState state, dynamic action)
{
    if(action is SignIn)
    {
        return state.copyWith
        (
            user: action.user

        );

    }

    if(action is SignInByToken)
    {
        return state.copyWith
        (
            user: action.user

        );

    }

    if(action is SignUp)
    {
        return state.copyWith
        (
            user: action.user

        );

    }

    if(action is UpdateUser)
    {
        return state.copyWith
        (
            user: action.user

        );

    }

    if(action is SignOut)
    {
        return state.copyWith
        (
            user: {}

        );

    }

    if(action is ChangeIsLoadingSignIn)
    {
        return state.copyWith
        (
            isLoadingSignIn: action.isLoadingSignIn

        );

    }

    if(action is ChangeIsLoadingSignUp)
    {
        return state.copyWith
        (
            isLoadingSignUp: action.isLoadingSignUp

        );

    }

    return state;

}