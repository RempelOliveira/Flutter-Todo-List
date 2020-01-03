import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_redux/flutter_redux.dart";
import "package:smooth_star_rating/smooth_star_rating.dart";

import "package:google_books_api/store/Store.dart";

import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/utils/FormValidate.dart";

import "package:google_books_api/views/Authentication/SignIn.dart";

import "package:google_books_api/views/Components/SnackBar.dart";
import "package:google_books_api/views/Components/SpinnerIndicator.dart";

import "package:google_books_api/actions/Reviews.dart";

class MainScreen extends StatefulWidget
{
    @override
    _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen>
{
    final formKey =
        GlobalKey<FormState>();

    final reviewController =
        TextEditingController();

    final Map<String, Map<String, dynamic>> validation =
    {
        "rating":
        {
            "value": 0

        },

        "review":
        {
            "value"     : "",
            "validation":
            {
                "required": true

            }

        },

        "errors": {}

    };

    double rating = 0;

    void handleCreateReview()
    {
        SnackComponent snackBar =
            SnackComponent(context);

        validation["rating"]["value"] = rating;
        validation["review"]["value"] = reviewController.text;

        Map<String, dynamic> isValid =
            formValidate(validation);

        if(isValid.length == 0)
        {
            store.dispatch(
                ChangeIsLoadingReview(true)

            );

            snackBar.show
            (
                message: "Processing data! Please wait a few moments."

            );

            setState(()
            {
                validation["errors"] = isValid;

            });

            Future.delayed(Duration(milliseconds: 1000), () async
            {
                createReview(context, { "rating": validation["rating"]["value"].toInt().toString(), "review": validation["review"]["value"] }).then((Map<String, dynamic> data)
                {
                    if(data.isNotEmpty)
                    {
                        if(data["error"] == null)
                        {
                            snackBar.show
                            (
                                type: "success",
                                message: "Thanks for your review."

                            );

                            rating = 0;
                            reviewController.clear();

                        }
                        else
                        {
                            if(data["error"]["internal"] == null)
                            {
								if(data["error"] == "authorization")
								{
                                    Navigator.of(context).pushAndRemoveUntil
                                    (
                                        MaterialPageRoute(builder: (BuildContext context) => StoreProvider<AppState>
                                        (
                                            store: store,
                                            child: SignInScreen()

                                        )),

                                        (Route<dynamic> route) => false

                                    );

								}
								else
								{
                                    setState(()
                                    {
                                        validation["errors"] = data["error"];

                                    });

                                    snackBar.show
                                    (
                                        type: "danger",
                                        message: "Please check the form fields."

                                    );

								}

                            }
							else
							{
                                snackBar.show
                                (
                                    type: "danger",
                                    message: data["error"]["internal"]

                                );

							}

                        }

                    }

                    store.dispatch(
                        ChangeIsLoadingReview(false)

                    );

                }).catchError((error)
                {
                    snackBar.show
                    (
                        type: "danger",
                        message: "An internal error occurred."

                    );

                    store.dispatch(
                        ChangeIsLoadingReview(false)

                    );

                });

            });

        }
        else
        {
            setState(()
            {
                validation["errors"] = isValid;

            });

            snackBar.show
            (
                type: "danger",
                message: "Please check the form fields."

            );

        }

    }

    List<Widget> renderReviews(items)
    {
        List<Widget> list = [];

        for(int i = 0; i < items.length; i++)
        {
            list.add
            (
                Container
                (
                    margin: EdgeInsets.only(top: i == 0 ? 6 : 24),
                    child: Column
                    (
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>
                        [
                            Text(items[i]["user"]["name"], style: TextStyle
                            (
                                color: Color(0xff292929),
                                fontSize: 14,
                                fontWeight: FontWeight.w500

                            )),

                            SmoothStarRating
                            (
                                rating: items[i]["rating"].toDouble(),
                                starCount: 5,
                                size: 18,
                                allowHalfRating: false,
                                color: Color(0xffffaf2e),
                                borderColor: Color(0xffffaf2e)

                            ),

                            Container
                            (
                                margin: EdgeInsets.only(top: 12),
                                child: Text(items[i]["review"], style: TextStyle
                                (
                                    color: Color(0xff929292),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w100

                                ))

                            )

                        ]

                    )

                )

            );

        }

        return list;

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
                    margin: EdgeInsets.fromLTRB(24, 0, 24, 20),
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
                                            rating: state.user.isEmpty ? 5 : rating,
                                            starCount: 5,
                                            size: 18,
                                            allowHalfRating: false,
                                            color: state.user.isEmpty ? Color(0xffcbd3e3) : Color(0xffffaf2e),
                                            borderColor: state.user.isEmpty ? Color(0xffcbd3e3) : Color(0xffffaf2e),

                                            onRatingChanged: (double value)
                                            {
                                                setState(()
                                                {
                                                    rating = value;

                                                });

                                            }

                                        ),

                                        Stack
                                        (
                                            children: <Widget>
                                            [
                                                Container
                                                (
                                                    margin: EdgeInsets.only(top: 6, bottom: 6),
                                                    child: TextField
                                                    (
                                                        enabled: state.user.isEmpty || state.isLoadingReview ? false : true,
                                                        controller: reviewController,

                                                        minLines: 5,
                                                        maxLines: 5,

                                                        style: TextStyle
                                                        (
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w300

                                                        ),

                                                        decoration: InputDecoration
                                                        (
                                                            filled: true,
                                                            fillColor: state.user.isEmpty || state.isLoadingReview ? Color(0xfff5f5f5) : Colors.white,

                                                            border: OutlineInputBorder
                                                            (
                                                                borderSide: BorderSide(color: Color(0xffdbdbdb)),
                                                                borderRadius: BorderRadius.circular(4)

                                                            ),

                                                            enabledBorder: OutlineInputBorder
                                                            (
                                                                borderSide: BorderSide(color: validation["errors"]["review"] != null ? Color(0xffff3860) : Color(0xffdbdbdb)),
                                                                borderRadius: BorderRadius.circular(4)

                                                            ),

                                                            disabledBorder: OutlineInputBorder
                                                            (
                                                                borderSide: BorderSide(color: Color(0xfff5f5f5)),
                                                                borderRadius: BorderRadius.circular(4)

                                                            ),

                                                            focusedBorder: OutlineInputBorder
                                                            (
                                                                borderSide: BorderSide(color: validation["errors"]["review"] != null ? Color(0xffff3860) : Color(0xffdbdbdb)),
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
                                                    visible: validation["errors"]["review"] != null,
                                                    child: Container
                                                    (
                                                        color: Colors.white,
                                                        margin: EdgeInsets.only(top: 0, left: 11.5),
                                                        padding: EdgeInsets.only(left: 2, right: 2),

                                                        child: Text("Required" ?? "", style: TextStyle
                                                        (
                                                            color: Color(0xffff3860),
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.w300

                                                        ))

                                                    )

                                                )

                                            ]

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

                                                    Stack
                                                    (
                                                        children: <Widget>
                                                        [
                                                            Container
                                                            (
                                                                alignment: Alignment.center,
                                                                child: RaisedButton
                                                                (
                                                                    color: Color(0xff039be5),
                                                                    disabledColor: Color(0xff039be5),
                                                                    elevation: 0,
                                                                    padding: EdgeInsets.fromLTRB(22, 12, 20, 11),

                                                                    shape: RoundedRectangleBorder
                                                                    (
                                                                        borderRadius: BorderRadius.all(Radius.circular(4))

                                                                    ),

                                                                    child: Text(state.isLoadingSignOut || state.isLoadingReview ? "" : "SUBMIT", style: TextStyle
                                                                    (
                                                                        color: Colors.white,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w500

                                                                    )),

                                                                    onPressed: state.user.isEmpty || state.isLoadingReview ? null : ()
                                                                    {
                                                                        handleCreateReview();

                                                                    }

                                                                )

                                                            ),

                                                            Visibility
                                                            (
                                                                visible: state.isLoadingReview,
                                                                child: Container
                                                                (
                                                                    alignment: Alignment.center,
                                                                    margin: EdgeInsets.only(top: 13.5, left: 33),

                                                                    child: SpinnerIndicator()

                                                                ),

                                                            )

                                                        ]

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
                                                        children: renderReviews(state.reviews)..add
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