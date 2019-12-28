import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/actions/BooksActions.dart";

AppState booksReducer(AppState state, dynamic action)
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

    if(action is ChangeIsLoadingBooks)
    {
        return state.copyWith
        (
            isLoadingBooks: action.isLoadingBooks

        );

    }

    if(action is ChangeIsLoadingMoreBooks)
    {
        return state.copyWith
        (
            isLoadingMoreBooks: action.isLoadingMoreBooks

        );

    }

    if(action is ChangeSkipBooks)
    {
        return state.copyWith
        (
            skipBooks: action.skipBooks

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

    if(action is UpdateBook)
    {
        return state.copyWith
        (
            book: action.book

        );

    }

    return state;

}