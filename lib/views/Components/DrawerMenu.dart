import "package:flutter/material.dart";
import "package:flutter_redux/flutter_redux.dart";

import "package:google_books_api/store/Store.dart";
import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/actions/UsersActions.dart";

import "package:google_books_api/views/Authentication/SignIn.dart";
import "package:google_books_api/views/Authentication/SignUp.dart";
import "package:google_books_api/views/PrivacyAndTerms/Details.dart";

import "package:google_books_api/views/Components/SnackBar.dart";

class DrawerMenu extends StatefulWidget
{
    final double offset;
    final ScrollController scrollController;
    final AnimationController animationController;

    DrawerMenu({
        @required this.offset, @required this.scrollController, @required this.animationController});

    @override
    _DrawerMenuState createState() => _DrawerMenuState();

}

class _DrawerMenuState extends State<DrawerMenu>
{
    final ColorTween overlayAnimation =
        ColorTween(begin: Colors.transparent, end: Colors.black54);

	void handleSignOutUser()
    {
        SnackComponent snackBar =
            SnackComponent(context);

        snackBar.show
        (
            message: "Processing data! Please wait a few moments."

        );

        Future.delayed(Duration(milliseconds: 1000), () async
        {
            signOut(context).then((data)
            {
                snackBar.show
                (
                    type: "success",
                    message: "Now you are logged out."

                );

            });

            widget.animationController.reverse();

        });

    }

    @override
    Widget build(BuildContext context)
    {
        final Animation drawerAnimation = Tween(begin: - (MediaQuery.of(context).size.width - 40), end: 0.0).animate(
            CurvedAnimation(parent: widget.animationController, curve: Curves.easeInOut));

        final Animation iconAnimation = Tween(begin: 24.0, end: MediaQuery.of(context).size.width - 100).animate(
            CurvedAnimation(parent: widget.animationController, curve: Curves.easeInOut));

        return StoreConnector<AppState, AppState>
        (
            converter: (store) => store.state,
            builder: (BuildContext context, AppState state)
            {
                return Stack
                (
                    children: <Widget>
                    [
                        AnimatedBuilder
                        (
                            animation: widget.animationController,
                            builder: (BuildContext context, Widget w)
                            {
                                return Transform.scale
                                (
                                    scale: widget.animationController.value > 0 ? 1 : 0,
                                    child: Container
                                    (
                                        color: overlayAnimation.evaluate(widget.animationController),

                                    )

                                );

                            }

                        ),

                        AnimatedBuilder
                        (
                            animation: widget.animationController,
                            builder: (BuildContext context, Widget w)
                            {
                                return Transform.translate
                                (
                                    offset: Offset(drawerAnimation.value, 0),
                                    child: Container
                                    (
                                        transform: Matrix4.translationValues(
                                            0, 0, 0), //- (MediaQuery.of(context).size.width - 40), 0, 0),

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
                                                            Text(state.user["name"] != null ? state.user["name"] : "Welcome!", style: TextStyle
                                                            (
                                                                color: Colors.black,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500

                                                            )),

                                                            Text(state.user["email"] != null ? state.user["email"] : "Sign in app to see your score", style: TextStyle
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
                                                                    Text(state.user["score"] != null ? state.user["score"]["likes"].toString() : "0", style: TextStyle
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
                                                                    Text(state.user["score"] != null ? state.user["score"]["favorites"].toString() : "0", style: TextStyle
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
                                                                    Text(state.user["score"] != null ? state.user["score"]["reviews"].toString() : "0", style: TextStyle
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
                                                            state.user.length != 0
                                                                ?
                                                                    GestureDetector
                                                                    (
                                                                        child: Container
                                                                        (
                                                                            alignment: Alignment.centerLeft,
                                                                            margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                                                                            padding: EdgeInsets.only(top: 12, bottom: 12),

                                                                            decoration: BoxDecoration
                                                                            (
                                                                                border: Border
                                                                                (
                                                                                    top: BorderSide(width: 1, color: Color(0xffeaeaea))

                                                                                )

                                                                            ),

                                                                            child: Text("Account", style: TextStyle
                                                                            (
                                                                                color: Colors.black,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w500

                                                                            ))

                                                                        ),

                                                                        onTap: ()
                                                                        {
                                                                            print("Account");

                                                                        }

                                                                    )
                                                                :
                                                                    Container(),

                                                            GestureDetector
                                                            (
                                                                child: Container
                                                                (
                                                                    alignment: Alignment.centerLeft,
                                                                    margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                                                                    padding: EdgeInsets.only(top: 12, bottom: 12),

                                                                    decoration: BoxDecoration
                                                                    (
                                                                        border: Border
                                                                        (
                                                                            top: BorderSide(width: 1, color: Color(0xffeaeaea)),
                                                                            bottom: BorderSide(width: 1, color: Color(0xffeaeaea)),

                                                                        )

                                                                    ),

                                                                    child: Text("Privacy & Terms", style: TextStyle
                                                                    (
                                                                        color: Colors.black,
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500

                                                                    ))

                                                                ),

                                                                onTap: ()
                                                                {
                                                                    Navigator.of(context).push
                                                                    (
                                                                        MaterialPageRoute(builder: (BuildContext context) => DetailsScreen())

                                                                    );

                                                                }

                                                            )

                                                        ]

                                                    )

                                                ),

                                                Container
                                                (
                                                    color: Color(0xfffcfcfc),
                                                    padding: EdgeInsets.all(24),

                                                    child: state.user.length != 0
                                                        ?
                                                            Column
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

                                                                        child: Text("SIGN OUT", style: TextStyle
                                                                        (
                                                                            color: Colors.white,
                                                                            fontSize: 12,
                                                                            fontWeight: FontWeight.w500

                                                                        )),

                                                                        onPressed: ()
                                                                        {
                                                                            handleSignOutUser();

                                                                        }

                                                                    )

                                                                ]

                                                            )

                                                        :
                                                            Column
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
                                                                            Navigator.of(context).push
                                                                            (
                                                                                MaterialPageRoute(builder: (BuildContext context) => StoreProvider<AppState>
                                                                                (
                                                                                    store: store,
                                                                                    child: SignInScreen()

                                                                                ))

                                                                            );

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
                                                                            Navigator.of(context).push
                                                                            (
                                                                                MaterialPageRoute(builder: (BuildContext context) => StoreProvider<AppState>
                                                                                (
                                                                                    store: store,
                                                                                    child: SignUpScreen()

                                                                                ))

                                                                            );

                                                                        }

                                                                    )

                                                                ]

                                                            )

                                                )

                                            ]

                                        )

                                    )

                                );

                            }

                        ),

                        AnimatedBuilder
                        (
                            animation: widget.animationController,
                            builder: (BuildContext context, Widget w)
                            {
                                return Transform.translate
                                (
                                    offset: Offset(iconAnimation.value, - widget.offset),
                                    child: GestureDetector
                                    (
                                        child: Container
                                        (
                                            padding: EdgeInsets.all(4),
                                            margin: EdgeInsets.only(top: 24),

                                            decoration: BoxDecoration
                                            (
                                                shape: BoxShape.circle, color: Color(0xffffc100)

                                            ),

                                            child: AnimatedIcon
                                            (
                                                icon: AnimatedIcons.menu_close,
                                                color: Colors.white,
                                                progress: widget.animationController

                                            )


                                        ),

                                        onTap: ()
                                        {
                                            if(widget.animationController.value != 1)
                                            {
                                                if(widget.offset != 0.0)
                                                {
                                                    widget.scrollController.animateTo(
                                                        0, curve: Curves.easeInOut, duration: Duration(milliseconds: 125));

                                                    Future.delayed(Duration(milliseconds: 125), ()
                                                    {
                                                        widget.animationController.forward();

                                                    });

                                                }
                                                else
                                                    widget.animationController.forward();

                                            }
                                            else
                                                widget.animationController.reverse();

                                        }

                                    )

                                );

                            }

                        )

                    ]

                );

            }

        );

    }
}