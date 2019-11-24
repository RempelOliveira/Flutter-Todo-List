import "package:flutter/material.dart";
import "package:smooth_star_rating/smooth_star_rating.dart";

class MainScreen extends StatelessWidget
{
    final formKey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context)
    {
        return Container
        (
            margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column
            (
                children: <Widget>
                [
                    Form
                    (
                        key: formKey,
                        child: Column
                        (
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>
                            [
                                SmoothStarRating
                                (
                                    rating: 1 == 1 ? 5 : 0,
                                    starCount: 5,
                                    size: 18,
                                    allowHalfRating: false,
                                    color: 1 == 1 ? Color(0xffcbd3e3) : Color(0xffffaf2e),
                                    borderColor: 1 == 1 ? Color(0xffcbd3e3) : Color(0xffffaf2e)

                                ),

                                Container
                                (
                                    margin: EdgeInsets.only(top: 6, bottom: 6),
                                    child: TextField
                                    (
                                        maxLines: 5,
                                        minLines: 5,
                                        enabled: 1 == 1 ? false: true,

                                        style: TextStyle
                                        (
                                            color: Color(0xffd0d0d0),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300

                                        ),

                                        decoration: InputDecoration
                                        (
                                            filled: true,
                                            fillColor: 1 == 1 ? Color(0xfff5f5f5) : Colors.white,

                                            border: OutlineInputBorder
                                            (
                                                borderSide: BorderSide(color: Color(0xffdbdbdb)),
                                                borderRadius: BorderRadius.circular(4)

                                            ),

                                            enabledBorder: OutlineInputBorder
                                            (
                                                borderSide: BorderSide(color: Color(0xffdbdbdb)),
                                                borderRadius: BorderRadius.circular(4)

                                            ),

                                            disabledBorder: OutlineInputBorder
                                            (
                                                borderSide: BorderSide(color: Color(0xfff5f5f5)),
                                                borderRadius: BorderRadius.circular(4)

                                            ),

                                            focusedBorder: OutlineInputBorder
                                            (
                                                borderSide: BorderSide(color: Color(0xffdbdbdb)),
                                                borderRadius: BorderRadius.circular(4)

                                            ),

                                            hintText: "Write your review...",
                                            hintStyle: TextStyle
                                            (
                                                color: Color(0xffd0d0d0),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300

                                            ),

                                            contentPadding: EdgeInsets.fromLTRB(13, 9, 12, 9)

                                        )

                                    )

                                ),

                                Row
                                (
                                    children: <Widget>
                                    [
                                        GestureDetector
                                        (
                                            child: Text("SIGN IN", style: TextStyle
                                            (
                                                color: Color(0xff039be5),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500

                                            )),

                                            onTap: ()
                                            {


                                            }

                                        ),

                                        Container
                                        (
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text("to write a review", style: TextStyle
                                            (
                                                color: Color(0xffc2c2c2),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500

                                            ))

                                        )

                                    ]

                                ),

                                Container
                                (
                                    margin: EdgeInsets.only(top: 6),
                                    child: Row
                                    (
                                        children: <Widget>
                                        [
                                            Expanded
                                            (
                                                child: Divider
                                                (
                                                    color: Color(0xffdbdbdb)

                                                )

                                            ),

                                            Container
                                            (
                                                width: 24

                                            ),

                                            RaisedButton
                                            (
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                                                color: Color(0xff039be5),
                                                disabledColor: Color(0xfff5f5f5),
                                                padding: EdgeInsets.fromLTRB(22, 12, 20, 11),

                                                child: Text("SUBMIT", style: TextStyle
                                                (
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500

                                                )),

                                                onPressed: 1 == 1 ? null : ()
                                                {


                                                }

                                            )

                                        ]

                                    )

                                )

                            ]

                        )

                    ),

                    Container
                    (
                        margin: EdgeInsets.only(top: 6),
                        child: Column
                        (
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>
                            [
                                Text("Guilherme Rempel de Oliveira", style: TextStyle
                                (
                                    color: Color(0xff292929),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500

                                )),

                                SmoothStarRating
                                (
                                    rating: 5,
                                    starCount: 5,
                                    size: 18,
                                    allowHalfRating: false,
                                    color: Color(0xffffaf2e),
                                    borderColor: Color(0xffffaf2e)

                                ),

                                Container
                                (
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text("This is the first review of this book. He is awesome, I recommend your reading.", style: TextStyle
                                    (
                                        color: Color(0xff929292),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w100

                                    ))

                                )

                            ]

                        )

                    ),

                    Container
                    (
                        margin: EdgeInsets.only(top: 24),
                        child: Column
                        (
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>
                            [
                                Text("Guilherme Rempel de Oliveira", style: TextStyle
                                (
                                    color: Color(0xff292929),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500

                                )),

                                SmoothStarRating
                                (
                                    rating: 4.2,
                                    starCount: 5,
                                    size: 18,
                                    allowHalfRating: false,
                                    color: Color(0xffffaf2e),
                                    borderColor: Color(0xffffaf2e)

                                ),

                                Container
                                (
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text("This is the first review of this book. He is awesome, I recommend your reading.", style: TextStyle
                                    (
                                        color: Color(0xff929292),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w100

                                    ))

                                )

                            ]

                        )

                    ),

                    Container
                    (
                        margin: EdgeInsets.only(top: 24),
                        child: Column
                        (
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>
                            [
                                Text("Guilherme Rempel de Oliveira", style: TextStyle
                                (
                                    color: Color(0xff292929),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500

                                )),

                                SmoothStarRating
                                (
                                    rating: 2,
                                    starCount: 5,
                                    size: 18,
                                    allowHalfRating: false,
                                    color: Color(0xffffaf2e),
                                    borderColor: Color(0xffffaf2e)

                                ),

                                Container
                                (
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text("This is the first review of this book. He is awesome, I recommend your reading.", style: TextStyle
                                    (
                                        color: Color(0xff929292),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w100

                                    ))

                                )

                            ]

                        )

                    ),

                    Container
                    (
                        margin: EdgeInsets.only(top: 24),
                        child: Column
                        (
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>
                            [
                                Text("Guilherme Rempel de Oliveira", style: TextStyle
                                (
                                    color: Color(0xff292929),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500

                                )),

                                SmoothStarRating
                                (
                                    rating: 5,
                                    starCount: 5,
                                    size: 18,
                                    allowHalfRating: false,
                                    color: Color(0xffffaf2e),
                                    borderColor: Color(0xffffaf2e)

                                ),

                                Container
                                (
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text("This is the first review of this book. He is awesome, I recommend your reading.", style: TextStyle
                                    (
                                        color: Color(0xff929292),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w100

                                    ))

                                )

                            ]

                        )

                    )

                ]

            )

        );

    }

}