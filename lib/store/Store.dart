import "package:google_books_api/reducers/BooksReducer.dart";
import "package:google_books_api/reducers/UsersReducer.dart";
import "package:google_books_api/reducers/ReviewsReducer.dart";

import "package:redux/redux.dart";
import "package:google_books_api/states/AppState.dart";
import "package:redux_thunk/redux_thunk.dart";

final store = Store<AppState>
(
    combineReducers([booksReducer, userReducer, reviewsReducer]), initialState: AppState
    (
        tab: "browse",
        category: "typography",
        booksTotal: 0,
        books: [],
        skipBooks: 0,
        isLoadingBooks: true,
        isLoadingMoreBooks: false,
        book: {},
        reviewsTotal: 0,
        reviews: [],
        allReviews: false,
        isLoadingReviews: true,
        isLoadingAllReviews: true,
        user: {},
        token: "",
        isLoadingSignIn: false,
        isLoadingSignUp: false

    ),

    middleware: [thunkMiddleware]

);