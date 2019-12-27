import "package:flutter/material.dart";
import "package:flutter_redux/flutter_redux.dart";

import "package:google_books_api/store/Store.dart";

import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/actions/BooksActions.dart";

import "package:google_books_api/views/Books/Details.dart";
import "package:google_books_api/views/Components/Book.dart";
import "package:google_books_api/views/Components/SnackBar.dart";
import "package:google_books_api/views/400.dart";

class MainScreen extends StatefulWidget
{
    final ScrollController scrollController;

    MainScreen({
        @required this.scrollController});

    @override
    _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen>
{
    String tab = "browse";
    String category = "typography";

    bool isFirstRun = true;
    bool internalError = false;

    void handleList([delayed = false])
    {
        setState(()
        {
            if(tab != store.state.tab)
                tab = store.state.tab;

            if(category != store.state.category)
                category = store.state.category;

            if(isFirstRun)
                isFirstRun = false;

            if(internalError)
                internalError = false;

        });

        if(!store.state.isLoadingBooks && !store.state.isLoadingMoreBooks)
        {
            store.dispatch(
                ChangeIsLoadingBooks(true)

            );

        }

        Future.delayed(Duration(milliseconds: delayed || isFirstRun ? 1000 : 0), () async
        {
            getBooks(context).then((Map<String, dynamic> data)
            {
                if(data.isNotEmpty)
                {
                    if(data["error"] != null)
                    {
                        Scaffold.of(context).showSnackBar(
                            SnackComponent(type: "danger", message: data["error"]["internal"]).build(context));

                        if(!internalError)
                        {
                            setState(()
                            {
                                internalError = true;

                            });

                        }

                    }

                }

                if(store.state.isLoadingBooks)
                {
                    store.dispatch(
                        ChangeIsLoadingBooks(false)

                    );

                }

                if(store.state.isLoadingMoreBooks)
                {
                    store.dispatch(
                        ChangeIsLoadingMoreBooks(false)

                    );

                }

            }).catchError((error)
            {
                Scaffold.of(context).showSnackBar(
                    SnackComponent(type: "danger", message: "An internal error occurred.").build(context));

                if(!internalError)
                {
                    setState(()
                    {
                        internalError = true;

                    });

                }

                if(store.state.isLoadingBooks)
                {
                    store.dispatch(
                        ChangeIsLoadingBooks(false)

                    );

                }

            });

        });

    }

    @override
    void initState()
    {
        super.initState();

        handleList();

        widget.scrollController..addListener(()
        {
            AppState state =
                StoreProvider.of<AppState>(context).state;

            if(state.books.length < state.booksTotal && !state.isLoadingMoreBooks)
            {
                if(widget.scrollController.offset >= widget.scrollController.position.maxScrollExtent - 100)
                {
                    StoreProvider.of<AppState>(context)
                        .dispatch(ChangeIsLoadingMoreBooks(true));

                    handleList();

                }

            }

        });

    }

    @override
    Widget build(BuildContext context)
    {
        return SliverList
        (
            delegate: SliverChildListDelegate
            (
                <Widget>
                [
                    StoreConnector<AppState, AppState>
                    (
                        converter:
                            (store) => store.state,

                        onDidChange: (AppState state)
                        {
                            if(tab != state.tab || category != state.category)
                            {
                                store.dispatch(
                                    ChangeSkipBooks(0)

                                );

                                handleList();

                            }

                        },

                        builder: (BuildContext context, AppState state)
                        {
                            return Column
                            (
                                children: <Widget>
                                [
                                    state.isLoadingBooks
                                        ?
                                            Container
                                            (
                                                margin: EdgeInsets.only(top: 10, bottom: 2),
                                                child: CircularProgressIndicator
                                                (
                                                    valueColor: AlwaysStoppedAnimation(Color(0xff039be5))

                                                )

                                            )

                                        :
                                            internalError
                                                ?
                                                    BadRequest
                                                    (
                                                        onReload: handleList

                                                    )

                                                :
                                                    state.books.length > 0
                                                        ?
                                                            Column
                                                            (
                                                                children: <Widget>
                                                                [
                                                                    ...state.books.map((dynamic item) =>
                                                                        GestureDetector
                                                                        (
                                                                            child: BookComponent
                                                                            (
                                                                                title: item["title"],
                                                                                subtitle: item["subtitle"],
                                                                                thumbnail: item["thumbnail"],
                                                                                reviews: item["reviews"],
                                                                                rating: {
                                                                                    "stars": item["rating"]["stars"], "total": item["rating"]["total"], "users": item["rating"]["users"]
                                                                                }

                                                                            ),

                                                                            onTap: ()
                                                                            {
                                                                                Navigator.of(context).push
                                                                                (
                                                                                    MaterialPageRoute(builder: (BuildContext context) => StoreProvider<AppState>
                                                                                    (
                                                                                        store: store,
                                                                                        child: DetailsScreen(bookId: item["id"])

                                                                                    ))

                                                                                );

                                                                            }

                                                                        )),

                                                                    Visibility
                                                                    (
                                                                        visible: state.books.length < state.booksTotal,
                                                                        child: Container
                                                                        (
                                                                            margin: EdgeInsets.only(top: 2, bottom: 26),
                                                                            child: CircularProgressIndicator
                                                                            (
                                                                                valueColor: AlwaysStoppedAnimation(Color(0xff039be5))

                                                                            )

                                                                        )

                                                                    )

                                                                ]

                                                            )

                                                        :
                                                            Container
                                                            (
                                                                height: MediaQuery.of(context).size.height - 162,
                                                                alignment: Alignment.center,
                                                                child: Column
                                                                (
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: <Widget>
                                                                    [
                                                                        Text("No records found!", style: TextStyle
                                                                        (
                                                                            color: Colors.black,
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w500

                                                                        )),

                                                                        Visibility
                                                                        (
                                                                            visible: state.tab == "favorites" && state.user.isEmpty,
                                                                            child: Text("Sign in app to see your favorites", style: TextStyle
                                                                            (
                                                                                color: Colors.black,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w100

                                                                            ))

                                                                        )

                                                                    ]

                                                                )

                                                            )

                                ]

                            );

                        }

                    )

                ]

            )

        );

    }
}