import "package:flutter/material.dart";
import "package:flutter_redux/flutter_redux.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:share/share.dart";

import "package:google_books_api/store/Store.dart";
import "package:google_books_api/states/AppState.dart";

import "package:google_books_api/views/Books/Reviews.dart";
import "package:google_books_api/views/Authentication/SignIn.dart";

import "package:google_books_api/views/Components/Book.dart";
import "package:google_books_api/views/Components/SnackBar.dart";

import "package:google_books_api/actions/BooksActions.dart";

class MainScreen extends StatefulWidget
{
    final Map user;
    final Map<String, dynamic> book;

    MainScreen({
        @required this.book, @required this.user});

    @override
    _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen>
{
    void handleUpdateLike(Map<String, dynamic> book)
    {
        updateBook(context, book, book["like"].toString() == "false" ? "like" : "dislike").then((Map<String, dynamic> data)
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
                        Scaffold.of(context).showSnackBar(
                            SnackComponent(type: "danger", message: data["error"]["internal"]).build(context));

                    }

                }

            }

        }).catchError((error)
        {
            Scaffold.of(context).showSnackBar(
                SnackComponent(type: "danger", message: "An internal error occurred.").build(context));

        });

    }

    @override
    Widget build(BuildContext context)
    {
        return widget.book.isEmpty
            ?
                Container()

            :
                Column
                (
                    children: <Widget>
                    [
                        BookComponent
                        (
                            title: widget.book["title"],
                            subtitle: widget.book["subtitle"],
                            thumbnail: widget.book["thumbnail"],
                            reviews: widget.book["reviews"],
                            rating: {
                                "stars": widget.book["rating"]["stars"], "total": widget.book["rating"]["total"], "users": widget.book["rating"]["users"]
                            },

                            details: true

                        ),

                        Container
                        (
                            child: Row
                            (
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>
                                [
                                    Container
                                    (
                                        margin: EdgeInsets.only(left: 12, right: 12),
                                        child: GestureDetector
                                        (
                                            child: Row
                                            (
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>
                                                [

                                                    Icon
                                                    (
                                                        FontAwesomeIcons.solidCommentDots, color: Color(0xff929292), size: 20),

                                                    Padding
                                                    (
                                                        padding: EdgeInsets.only(left: 6),
                                                        child: Text("See Reviews", style: TextStyle
                                                        (
                                                            color: Color(0xff555555),
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 10

                                                        ))

                                                    )

                                                ]

                                            ),

                                            onTap: ()
                                            {
                                                Navigator.of(context).push
                                                (
                                                    MaterialPageRoute(builder: (BuildContext context) => StoreProvider<AppState>
                                                    (
                                                        store: store,
                                                        child: ReviewsScreen
                                                        (
                                                            title: widget.book["title"]

                                                        )

                                                    ))

                                                );

                                            }

                                        )

                                    ),

                                    Container
                                    (
                                        margin: EdgeInsets.only(left: 12, right: 12),
                                        child: GestureDetector
                                        (
                                            child: Row
                                            (
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>
                                                [
                                                    Icon
                                                    (
                                                        FontAwesomeIcons.solidHeart, color: Color(widget.book["like"].toString() == "true" ? 0xff039be5 : 0xff929292), size: 20),

                                                    Padding
                                                    (
                                                        padding: EdgeInsets.only(left: 6),
                                                        child: Text("Like", style: TextStyle
                                                        (
                                                            color: Color(0xff555555),
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 10

                                                        ))

                                                    )

                                                ]

                                            ),

                                            onTap: ()
                                            {
                                                if(widget.user.isEmpty)
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
                                                    handleUpdateLike(widget.book);

                                            }

                                        )

                                    ),

                                    Container
                                    (
                                        margin: EdgeInsets.only(left: 12, right: 12),
                                        child: GestureDetector
                                        (
                                            child: Row
                                            (
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>
                                                [
                                                    Icon
                                                    (
                                                        FontAwesomeIcons.share, color: Color(0xff929292), size: 20),

                                                    Padding
                                                    (
                                                        padding: EdgeInsets.only(left: 6),
                                                        child: Text("Share", style: TextStyle
                                                        (
                                                            color: Color(0xff292929),
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 10

                                                        ))

                                                    )

                                                ]

                                            ),

                                            onTap: ()
                                            {
                                                Share.share
                                                (
                                                    "What's up man?\n\nI found an amazing book and I think you'll like it!\n\nVisit the link below to see it.\n\ngba://deeplink.flutter.dev", subject: "Google Books Api - ${widget.book["title"]}");

                                            }

                                        )

                                    )

                                ]

                            )

                        ),

                        Container
                        (
                            padding: EdgeInsets.fromLTRB(34, 24, 34, 0),
                            alignment: Alignment.centerLeft,

                            child: Text("About the Book", style: TextStyle
                            (
                                color: Color(0xff292929),
                                fontSize: 20,
                                fontWeight: FontWeight.w700

                            ))

                        ),

                        Container
                        (
                            padding: EdgeInsets.fromLTRB(34, 24, 34, 34),
                            alignment: Alignment.centerLeft,

                            child: Text(widget.book["description"], style: TextStyle
                            (
                                color: Color(0xff292929),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                height: 1.2

                            ))

                        )

                    ]

                );

    }
}