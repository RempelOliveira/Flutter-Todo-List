import "package:flutter/material.dart";

class DrawerMenu extends StatelessWidget
{
    final AnimationController animationController;

    DrawerMenu({
        @required this.animationController});

    final ColorTween overlayAnimation =
        ColorTween(begin: Colors.transparent, end: Colors.black54);

    @override
    Widget build(BuildContext context)
    {
        return Stack
        (
            children: <Widget>
            [
                Visibility
                (
                    visible: animationController.value > 0,
                    child: Container
                    (
                        color: overlayAnimation.evaluate(animationController),

                    )

                ),

                Container
                (
                    transform: Matrix4.translationValues(
                        - (MediaQuery.of(context).size.width - 40), 0, 0),

                    width: MediaQuery.of(context).size.width - 40,
                    color: Colors.white,

                    child: Column
                    (
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>
                        [
                            Container
                            (
                                color: Color(0xfffcfcfc),
                                padding: EdgeInsets.all(24),

                                child: Column
                                (
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>
                                    [
                                        Text("Welcome!", style: TextStyle
                                        (
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500

                                        )),

                                        Text("Sign in app to see your score", style: TextStyle
                                        (
                                            color: Color(0xff929292),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w100

                                        ))

                                    ]

                                ),

                            ),

                            Container
                            (
                                padding: EdgeInsets.fromLTRB(24, 46, 24, 46),
                                child: Row
                                (
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>
                                    [
                                        Column
                                        (
                                            children: <Widget>
                                            [
                                                Text("0", style: TextStyle
                                                (
                                                    color: Color(0xff929292),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w100

                                                )),

                                                Text("Likes", style: TextStyle
                                                (
                                                    color: Color(0xff929292),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w100

                                                ))

                                            ]

                                        ),

                                        Column
                                        (
                                            children: <Widget>
                                            [
                                                Text("0", style: TextStyle
                                                (
                                                    color: Color(0xff929292),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w100

                                                )),

                                                Text("Favorites", style: TextStyle
                                                (
                                                    color: Color(0xff929292),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w100

                                                ))

                                            ]

                                        ),

                                        Column
                                        (
                                            children: <Widget>
                                            [
                                                Text("0", style: TextStyle
                                                (
                                                    color: Color(0xff929292),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w100

                                                )),

                                                Text("Reviews", style: TextStyle
                                                (
                                                    color: Color(0xff929292),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w100

                                                ))

                                            ]

                                        )

                                    ]

                                )

                            ),

                            Expanded
                            (
                                child: ListView
                                (
                                    children: <Widget>
                                    [
                                        Container
                                        (
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.fromLTRB(24, 0, 24, 0),

                                            decoration: BoxDecoration
                                            (
                                                border: Border
                                                (
                                                    top: BorderSide(width: 1, color: Color(0xffeaeaea)),
                                                    bottom: BorderSide(width: 1, color: Color(0xffeaeaea)),

                                                )

                                            ),

                                            child: FlatButton
                                            (
                                                padding: EdgeInsets.zero,
                                                child: Text("Privacy & Terms", style: TextStyle
                                                (
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500

                                                )),

                                                onPressed: ()
                                                {}

                                            )

                                        )

                                    ]

                                )

                            ),

                            Container
                            (
                                color: Color(0xfffcfcfc),
                                padding: EdgeInsets.all(24),

                                child: Column
                                (
                                    children: <Widget>
                                    [
                                        RaisedButton
                                        (
                                            color: Color(0xff039be5),
                                            elevation: 0,
                                            padding: EdgeInsets.all(12),

                                            shape: RoundedRectangleBorder
                                            (
                                                borderRadius: BorderRadius.all(Radius.circular(4))

                                            ),

                                            child: Text("SIGN IN", style: TextStyle
                                            (
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500

                                            )),

                                            onPressed: ()
                                            {


                                            }

                                        ),

                                        Divider
                                        (
                                            height: 6,
                                            color: Colors.transparent

                                        ),

                                        InkWell
                                        (
                                            child: Text("OR CREATE YOUR ACCOUNT", style: TextStyle
                                            (
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500

                                            )),

                                            onTap: ()
                                            {


                                            }

                                        )

                                    ]

                                )

                            )

                        ]

                    )

                )

            ]

        );

    }

}