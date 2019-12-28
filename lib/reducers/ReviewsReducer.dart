import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/actions/Reviews.dart";

AppState reviewsReducer(AppState state, dynamic action)
{
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