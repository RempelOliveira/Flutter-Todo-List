import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_redux/flutter_redux.dart";
import "package:smooth_star_rating/smooth_star_rating.dart";

import "package:google_books_api/store/Store.dart";

import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/actions/BooksActions.dart";

import "package:google_books_api/views/Authentication/SignIn.dart";

class MainScreen extends StatelessWidget
{
    final formKey = GlobalKey<FormState>();

    renderReviews(items)
    {
        return items.map<Widget>((dynamic item) =>
            Container
            (
                margin: EdgeInsets.only(top: 6),
                child: Column
                (
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>
                    [
                        Text(item["user"]["name"], style: TextStyle
                        (
                            color: Color(0xff292929),
                            fontSize: 14,
                            fontWeight: FontWeight.w500

                        )),

                        SmoothStarRating
                        (
                            rating: item["rating"].toDouble(),
                            starCount: 5,
                            size: 18,
                            allowHalfRating: false,
                            color: Color(0xffffaf2e),
                            borderColor: Color(0xffffaf2e)

                        ),

                        Container
                        (
                            margin: EdgeInsets.only(top: 12),
                            child: Text(item["review"], style: TextStyle
                            (
                                color: Color(0xff929292),
                                fontSize: 10,
                                fontWeight: FontWeight.w100

                            ))

                        )

                    ]

                )

            ));

    }

    @override
    Widget build(BuildContext context)
    {
        return StoreConnector<AppState, AppState>
        (
            converter: (store) => store.state,
            builder: (BuildContext context, AppState state)
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
                                            rating: state.user.isEmpty ? 5 : 0,
                                            starCount: 5,
                                            size: 18,
                                            allowHalfRating: false,
                                            color: state.user.isEmpty ? Color(0xffcbd3e3) : Color(0xffffaf2e),
                                            borderColor: state.user.isEmpty ? Color(0xffcbd3e3) : Color(0xffffaf2e)

                                        ),

                                        Container
                                        (
                                            margin: EdgeInsets.only(top: 6, bottom: 6),
                                            child: TextField
                                            (
                                                maxLines: 5,
                                                minLines: 5,
                                                enabled: state.user.isEmpty ? false : true,

                                                style: TextStyle
                                                (
                                                    color: Color(0xffd0d0d0),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300

                                                ),

                                                decoration: InputDecoration
                                                (
                                                    filled: true,
                                                    fillColor: state.user.isEmpty ? Color(0xfff5f5f5) : Colors.white,

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

                                        Visibility
                                        (
                                            visible: state.user.isEmpty,
                                            child: Row
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

                                            )

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

                                                        onPressed: state.user.isEmpty ? null : ()
                                                        {


                                                        }

                                                    )

                                                ]

                                            )

                                        )

                                    ]

                                )

                            ),

                            Column
                            (
                                children: <Widget>
                                [
                                    state.isLoadingReviews
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
                                            state.reviews.length > 0
                                                ?
                                                    Column
                                                    (
                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: renderReviews(state.reviews).toList()..add
                                                        (
                                                            Visibility
                                                            (
                                                                visible: state.reviews.length < state.reviewsTotal,
                                                                child: Container
                                                                (
                                                                    margin: EdgeInsets.only(top: 24),
                                                                    child: RaisedButton
                                                                    (
                                                                        elevation: 0,
                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                                                                        color: Color(0xff039be5),
                                                                        disabledColor: Color(0xfff5f5f5),
                                                                        padding: EdgeInsets.fromLTRB(22, 12, 20, 11),

                                                                        child: state.isLoadingAllReviews
                                                                            ?
                                                                                Container
                                                                                (
                                                                                    width: 14,
                                                                                    height: 14,
                                                                                    child: CircularProgressIndicator
                                                                                    (
                                                                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                        strokeWidth: 2

                                                                                    )

                                                                                )

                                                                            :
                                                                                Text("SHOW ALL COMMENTS", style: TextStyle
                                                                                (
                                                                                    color: Colors.white,
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w500

                                                                                )

                                                                        ),

                                                                        onPressed: ()
                                                                        {
                                                                            StoreProvider.of<AppState>(context)
                                                                                .dispatch(getReviews);

                                                                        }

                                                                    )

                                                                )

                                                            )

                                                        )

                                                    )

                                                :
                                                    Container
                                                    (
                                                        height: (MediaQuery.of(context).size.height / 2) - 3,
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

                                                                ))

                                                            ]

                                                        )

                                                    )

                                ]

                            )

                        ]

                    )

                );

            }

        );

    }

}