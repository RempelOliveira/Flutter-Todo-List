import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:flutter_redux/flutter_redux.dart";

import "package:google_books_api/store/Store.dart";
import "package:google_books_api/states/AppState.dart";

import "package:google_books_api/views/Components/SnackBar.dart";
import "package:google_books_api/views/Authentication/SignIn.dart";

import "package:google_books_api/actions/BooksActions.dart";

class HeaderScreen extends StatefulWidget
{
    final double offset;

    HeaderScreen({
        @required this.offset });

    @override
    _HeaderScreenState createState() => _HeaderScreenState();

}

class _HeaderScreenState extends State<HeaderScreen>
{
    void handleUpdateFavorite(Map<String, dynamic> book)
    {
        SnackComponent snackBar =
            SnackComponent(context);

        updateBook(context, book, book["favorite"].toString() == "false" ? "favorite" : "unfavorite").then((Map<String, dynamic> data)
        {
            if(data.isNotEmpty)
            {
                if(data["error"] != null)
                {
                    if(data["error"] == "authorization")
                    {
                        Navigator.of(context).push
                        (
                            MaterialPageRoute(builder: (BuildContext context) => StoreProvider<AppState>
                            (
                                store: store,
                                child: SignInScreen()

                            ))

                        );

                    }
                    else if(data["error"]["internal"])
                    {
                        snackBar.show
                        (
                            type: "danger",
                            message: data["error"]["internal"]

                        );

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

    }

    @override
    Widget build(BuildContext context)
    {
        return AppBar
        (
            elevation: 0,
            backgroundColor: Colors.white,

            leading: IconButton
            (
                icon: Icon(FontAwesomeIcons.chevronLeft, color: Color(0xff292929)),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,

                onPressed: ()
                {
                    Navigator.of(context).pop(null);

                }

            ),

            actions: <Widget>
            [
                StoreConnector<AppState, AppState>
                (
                    converter:(store) => store.state,
                    builder: (BuildContext context, AppState state)
                    {
                        return IconButton
                        (
                            icon: Icon(state.book["favorite"].toString() == "true" ? Icons.bookmark : Icons.bookmark_border, color: Color(state.book["favorite"].toString() == "true" ? 0xff039be5 : 0xff929292)),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,

                            onPressed: ()
                            {
                                if(state.user.isEmpty)
                                {
                                    Navigator.of(context).push
                                    (
                                        MaterialPageRoute(builder: (BuildContext context) => StoreProvider<AppState>
                                        (
                                            store: store,
                                            child: SignInScreen()

                                        ))

                                    );

                                }
                                else
                                    handleUpdateFavorite(state.book);

                            }

                        );

                    }

                )

            ],

            bottom: PreferredSize
            (
                preferredSize: Size.fromHeight(1),
                child: Container
                (
                    decoration: BoxDecoration
                    (
                        border: Border(bottom: BorderSide
                        (
                            width: 1,
                            color: widget.offset > 0 ? Color(0xffeaeaea) : Colors.transparent

                        ))

                    )

                )

            )

        );

    }
}