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

    if(action is ChangeAllReviews)
    {
        return state.copyWith
        (
            allReviews: action.allReviews

        );

    }

    if(action is ChangeIsLoadingReviews)
    {
        return state.copyWith
        (
            isLoadingReviews: action.isLoadingReviews

        );

    }

    if(action is ChangeIsLoadingAllReviews)
    {
        return state.copyWith
        (
            isLoadingAllReviews: action.isLoadingAllReviews

        );

    }

    if(action is UpdateBookReviews)
    {
        return state.copyWith
        (
            reviews: action.reviews,
            reviewsTotal: action.reviewsTotal

        );

    }

    return state;

}