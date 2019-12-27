import "package:google_books_api/reducers/BooksReducer.dart";
import "package:google_books_api/reducers/UsersReducer.dart";
import 'package:google_books_api/utils/UserAuthentication.dart';

import "package:redux/redux.dart";
import "package:google_books_api/states/AppState.dart";
import "package:redux_thunk/redux_thunk.dart";

final store = Store<AppState>
(
    combineReducers([booksReducer, userReducer]), initialState: AppState
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
        isLoadingSignIn: false,
        isLoadingSignUp: false

    ),

    middleware: [thunkMiddleware]

);