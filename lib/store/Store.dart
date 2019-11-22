import "package:google_books_api/reducers/BooksReducer.dart";
import "package:redux/redux.dart";
import "package:google_books_api/states/AppState.dart";
import "package:redux_thunk/redux_thunk.dart";

final store = Store<AppState>
(
    reducer,
    initialState: AppState
    (
        tab: "browse",
        category: "typography",
        booksTotal: 0,
        books: [],
        isLoading: true,
        isLoadingMore: false,
        skip: 0

    ),

    middleware: [thunkMiddleware]

);