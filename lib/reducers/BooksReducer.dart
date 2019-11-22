import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/actions/BooksActions.dart";

AppState reducer(AppState state, dynamic action)
{
    if(action is ChangeTab)
    {
        return state.copyWith
        (
            tab: action.tab

        );

    }

    if(action is ChangeCategory)
    {
        return state.copyWith
        (
            category: action.category

        );

    }

    if(action is ChangeIsLoading)
    {
        return state.copyWith
        (
            isLoading: action.isLoading

        );

    }

    if(action is ChangeIsLoadingMore)
    {
        return state.copyWith
        (
            isLoadingMore: action.isLoadingMore

        );

    }

    if(action is ChangeSkip)
    {
        return state.copyWith
        (
            skip: action.skip

        );

    }

    if(action is UpdateBooksList)
    {
        return state.copyWith
        (
            books: state.books.length == 0 || action.clean ? action.books : state.books + action.books,
            booksTotal: action.booksTotal

        );

    }

    return state;

}