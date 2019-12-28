import "package:flutter/material.dart";
import "package:flutter/foundation.dart";
import "package:flutter_redux/flutter_redux.dart";
import "package:url_launcher/url_launcher.dart";

import "package:google_books_api/states/AppState.dart";

import "package:google_books_api/actions/BooksActions.dart";

import "package:google_books_api/views/Books/Details/Header.dart";
import "package:google_books_api/views/Books/Details/Main.dart";

import "package:google_books_api/views/Components/SnackBar.dart";

class DetailsScreen extends StatefulWidget
{
    final String bookId;

    DetailsScreen({
        @required this.bookId});

    @override
    _DetailsScreenState createState() => _DetailsScreenState();

}

class _DetailsScreenState extends State<DetailsScreen>
{
    double offset = 0.0;
    bool internalError = false;

    ScrollController scrollController;

    void handleRead([delayed = false])
    {
        SnackComponent snackBar =
            SnackComponent(context);

        Future.delayed(Duration(milliseconds: delayed ? 1000 : 0), () async
        {
            getBook(context, widget.bookId).then((Map<String, dynamic> data)
            {
                if(data.isNotEmpty)
                {
                    if(data["error"] != null)
                    {
                        snackBar.show
                        (
                            type: "danger",
                            message: data["error"]["internal"]

                        );

                        if(!internalError)
                        {
                            setState(()
                            {
                                internalError = true;

                            });

                        }

                    }

                }

            }).catchError((error)
            {
                snackBar.show
                (
                    type: "danger",
                    message: "An internal error occurred."

                );

            });

        });

    }

    @override
    void initState()
    {
        super.initState();

        scrollController = ScrollController()..addListener(()
        {
            setState(()
            {
                offset = scrollController.offset;

            });

        });

        handleRead();

    }

    @override
    void didChangeDependencies()
    {
        super.didChangeDependencies();

        StoreProvider.of<AppState>(context)
            .dispatch(ChangeAllReviews(false));

        StoreProvider.of<AppState>(context)
            .dispatch(ChangeIsLoadingAllReviews(false));

        StoreProvider.of<AppState>(context)
            .dispatch(UpdateBookReviews(0, []));

    }

    @override
    Widget build(BuildContext context)
    {
        return SafeArea
        (
            child: Scaffold
            (
                backgroundColor:
                    Colors.white,

                appBar: PreferredSize
                (
                    preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                    child: HeaderScreen
                    (
                        offset: offset

                    )

                ),

                body: SingleChildScrollView
                (
                    controller: scrollController,
                    child: StoreConnector<AppState, AppState>
                    (
                        converter:(store) => store.state,
                        builder: (BuildContext context, AppState state)
                        {
                            return MainScreen
                            (
                                user: state.user,
                                book: state.book

                            );

                        }

                    )

                ),

                floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                floatingActionButton: StoreConnector<AppState, AppState>
                (
                    converter:(store) => store.state,
                    builder: (BuildContext context, AppState state)
                    {
                        return FloatingActionButton.extended
                        (
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                            backgroundColor: Color(0xff039be5),

                            label: Text("BUY NOW", style: TextStyle
                            (
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500

                            )),

                            onPressed: () async
                            {
                                if(await canLaunch(state.book["url"]))
                                {
                                    await launch(state.book["url"]);

                                }
                                else
                                    throw "Could not launch ${state.book["url"]}";

                            }

                        );

                    }

                ),

                persistentFooterButtons: <Widget>
                [
                    StoreConnector<AppState, AppState>
                    (
                        converter:(store) => store.state,
                        builder: (BuildContext context, AppState state)
                        {
                            return Container
                            (
                                height: 23,
                                width: MediaQuery.of(context).size.width - 21,
                                padding: EdgeInsets.only(top: 2.2),

                                child: Text("R\$ ${state.book["price"]}", style: TextStyle
                                (
                                    color: Color(0xff039be5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500

                                ))

                            );

                        }

                    )

                ]

            )

        );

    }

}