import "package:flutter/material.dart";
import "package:flutter_redux/flutter_redux.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:share/share.dart";

import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/store/Store.dart";

import "../../Components/Book.dart";
import "../Reviews.dart";

class MainScreen extends StatelessWidget
{
    final Map<String, dynamic> book;

    MainScreen({
        @required this.book});

    @override
    Widget build(BuildContext context)
    {
        return Column
        (
            children: <Widget>
            [
                BookComponent
                (
                    title: book["title"],
                    subtitle: book["subtitle"],
                    thumbnail: book["thumbnail"],
                    reviews: book["reviews"],
                    rating: {
                        "stars": book["rating"]["stars"], "total": book["rating"]["total"], "users": book["rating"]["users"]
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
                                                child: Text
                                                (
                                                    "See Reviews", style: TextStyle(color: Color(0xff555555), fontWeight: FontWeight.w300, fontSize: 10))

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
                                                    title: book["title"]

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
                                                FontAwesomeIcons.solidHeart, color: Color(book["like"].toString() == "true" ? 0xff039be5 : 0xff929292), size: 20),

                                            Padding
                                            (
                                                padding: EdgeInsets.only(left: 6),
                                                child: Text
                                                (
                                                    "Like", style: TextStyle(color: Color(0xff555555), fontWeight: FontWeight.w300, fontSize: 10))

                                            )

                                        ]

                                    ),

                                    onTap: ()
                                    {


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
                                                child: Text
                                                (
                                                    "Share", style: TextStyle(color: Color(0xff292929), fontWeight: FontWeight.w300, fontSize: 10))

                                            )

                                        ]

                                    ),

                                    onTap: ()
                                    {
                                        Share.share
                                        (
                                            "What's up man?\n\nI found an amazing book and I think you'll like it!\n\nVisit the link below to see it.\n\ngba://deeplink.flutter.dev", subject: "Google Books Api - ${book["title"]}");

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

                    child: Text
                    (
                        "About the Book", style: TextStyle(color: Color(0xff292929), fontSize: 20, fontWeight: FontWeight.w700))

                ),

                Container
                (
                    padding: EdgeInsets.fromLTRB(34, 24, 34, 34),
                    alignment: Alignment.centerLeft,

                    child: Text
                    (
                        book["description"], style: TextStyle(color: Color(0xff292929), fontSize: 16, fontWeight: FontWeight.w300, height: 1.2))

                )

            ]

        );

    }

}