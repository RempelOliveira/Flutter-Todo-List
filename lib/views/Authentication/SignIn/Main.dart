import "package:flutter/material.dart";
import "package:flutter_redux/flutter_redux.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "package:google_books_api/store/Store.dart";
import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/actions/UsersActions.dart";

import "package:google_books_api/utils/FormValidate.dart";

import "package:google_books_api/views/Books/List.dart";
import "package:google_books_api/views/Components/SnackBar.dart";

import "../SignUp.dart";

class MainScreen extends StatefulWidget
{
    @override
    _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen>
{
    final formKey =
        GlobalKey<FormState>();

    final emailController    = TextEditingController();
    final passwordController = TextEditingController();

    final Map<String, Map<String, dynamic>> validation =
    {
        "email":
        {
            "value"     : "",
            "validation":
            {
                "required": true, "email": true

            }

        },

        "password":
        {
            "value"     : "",
            "validation":
            {
                "required": true, "min": 6, "max": 12

            }

        },

		"remember":
		{
			"value": true

		},

        "errors": {}

    };

    bool showPassword = false;

    void handleSignIn()
    {
        SnackComponent snackBar =
            SnackComponent(context);

        validation["email"]["value"]    = emailController.text;
        validation["password"]["value"] = passwordController.text;
        validation["remember"]["value"] = validation["remember"]["value"];

        Map<String, dynamic> isValid =
            formValidate(validation);

        if(isValid.length == 0)
        {
            store.dispatch(
                ChangeIsLoadingSignIn(true)

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
                signIn(context, { "email": validation["email"]["value"], "password": validation["password"]["value"], "remember": validation["remember"]["value"] }).then((Map<String, dynamic> data)
                {
					if(data.isNotEmpty)
					{
						if(data["error"] == null)
						{
							final String name =
								data["name"].split(" ")[0];

                            snackBar.show
                            (
                                type: "success",
                                message: <TextSpan>
                                [
                                    TextSpan(text: "Welcome back "),
                                    TextSpan(text: name, style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ", wait for automatic redirection."),

                                ]

                            );

							Future.delayed(Duration(milliseconds: 1750), () async
							{
                                Navigator.of(context).pushAndRemoveUntil
                                (
                                    MaterialPageRoute(builder: (BuildContext context) => StoreProvider<AppState>
                                    (
                                        store: store,
                                        child: ListScreen()

                                    )),

                                    (Route<dynamic> route) => false

                                );

                                store.dispatch(
                                    ChangeIsLoadingSignIn(false)

                                );

							});

						}
						else
						{
                            snackBar.show
                            (
                                type: "danger",
                                message: data["error"]["internal"]

                            );

                            store.dispatch(
                                ChangeIsLoadingSignIn(false)

                            );

						}

					}

                }).catchError((error)
                {
                    snackBar.show
                    (
                        type: "danger",
                        message: "An internal error occurred."

                    );

                    store.dispatch(
                        ChangeIsLoadingSignIn(false)

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

    @override
    Widget build(BuildContext context)
    {
        return StoreConnector<AppState, AppState>
        (
            converter: (store) => store.state,
            builder: (BuildContext context, AppState state)
            {
                return Form
                (
                    key: formKey,
                    child: Container
                    (
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: Column
                        (
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>
                            [
                                Text("Welcome Back!", style: TextStyle
                                (
                                    color: Color(0xff292929),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500

                                )),

                                Stack
                                (
                                    children: <Widget>
                                    [
                                        Container
                                        (
                                            margin: EdgeInsets.only(top: 24),
                                            child: TextField
                                            (
                                                enabled: !state.isLoadingSignIn,
                                                controller: emailController,

                                                style: TextStyle
                                                (
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300

                                                ),

                                                decoration: InputDecoration
                                                (
                                                    filled: true,
                                                    fillColor: state.isLoadingSignIn ? Color(0xfff5f5f5) : Colors.white,

                                                    border: OutlineInputBorder
                                                    (
                                                        borderSide: BorderSide(color: Color(0xffdbdbdb)),
                                                        borderRadius: BorderRadius.circular(4)

                                                    ),

                                                    enabledBorder: OutlineInputBorder
                                                    (
                                                        borderSide: BorderSide(color: validation["errors"]["email"] != null ? Color(0xffff3860) : Color(0xffdbdbdb)),
                                                        borderRadius: BorderRadius.circular(4)

                                                    ),

                                                    disabledBorder: OutlineInputBorder
                                                    (
                                                        borderSide: BorderSide(color: Color(0xfff5f5f5)),
                                                        borderRadius: BorderRadius.circular(4)

                                                    ),

                                                    focusedBorder: OutlineInputBorder
                                                    (
                                                        borderSide: BorderSide(color: validation["errors"]["email"] != null ? Color(0xffff3860) : Color(0xffdbdbdb)),
                                                        borderRadius: BorderRadius.circular(4)

                                                    ),

                                                    hintText: "E-mail",
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
                                            visible: validation["errors"]["email"] != null,
                                            child: Container
                                            (
                                                color: Colors.white,
                                                margin: EdgeInsets.only(top: 18, left: 11.5),
                                                padding: EdgeInsets.only(left: 2, right: 2),

                                                child: Text(validation["errors"]["email"] ?? "", style: TextStyle
                                                (
                                                    color: Color(0xffff3860),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w300

                                                ))

                                            )

                                        )

                                    ]

                                ),

                                Stack
                                (
                                    children: <Widget>
                                    [
                                        Container
                                        (
                                            margin: EdgeInsets.only(top: 12),
                                            child: TextField
                                            (
                                                enabled: !state.isLoadingSignIn,
                                                controller: passwordController,
                                                obscureText: !showPassword,

                                                style: TextStyle
                                                (
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300

                                                ),

                                                decoration: InputDecoration
                                                (
                                                    filled: true,
                                                    fillColor: state.isLoadingSignIn ? Color(0xfff5f5f5) : Colors.white,

                                                    border: OutlineInputBorder
                                                    (
                                                        borderSide: BorderSide(color: Color(0xffdbdbdb)),
                                                        borderRadius: BorderRadius.circular(4)

                                                    ),

                                                    enabledBorder: OutlineInputBorder
                                                    (
                                                        borderSide: BorderSide(color: validation["errors"]["password"] != null ? Color(0xffff3860) : Color(0xffdbdbdb)),
                                                        borderRadius: BorderRadius.circular(4)

                                                    ),

                                                    disabledBorder: OutlineInputBorder
                                                    (
                                                        borderSide: BorderSide(color: Color(0xfff5f5f5)),
                                                        borderRadius: BorderRadius.circular(4)

                                                    ),

                                                    focusedBorder: OutlineInputBorder
                                                    (
                                                        borderSide: BorderSide(color: validation["errors"]["password"] != null ? Color(0xffff3860) : Color(0xffdbdbdb)),
                                                        borderRadius: BorderRadius.circular(4)

                                                    ),

                                                    hintText: "Password",
                                                    hintStyle: TextStyle
                                                    (
                                                        color: Color(0xffd0d0d0),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w300

                                                    ),

                                                    suffixIcon: GestureDetector
                                                    (
                                                        child: Icon(showPassword ? FontAwesomeIcons.solidEyeSlash: FontAwesomeIcons.solidEye,

                                                            size: 18,
                                                            color: Color(0xffdbdbdb)

                                                        ),

                                                        onTap: state.isLoadingSignIn ? null : ()
                                                        {
                                                            setState(() => showPassword = !showPassword);

                                                        }

                                                    ),

                                                    contentPadding: EdgeInsets.fromLTRB(13, 9, 12, 9)

                                                )

                                            )

                                        ),

                                        Visibility
                                        (
                                            visible: validation["errors"]["password"] != null,
                                            child: Container
                                            (
                                                color: Colors.white,
                                                margin: EdgeInsets.only(top: 6, left: 11.5),
                                                padding: EdgeInsets.only(left: 2, right: 2),

                                                child: Text(validation["errors"]["password"] ?? "", style: TextStyle
                                                (
                                                    color: Color(0xffff3860),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w300

                                                ))

                                            )

                                        )

                                    ]

                                ),

                                Container
                                (
                                    margin: EdgeInsets.only(top: 6),
                                    child: Row
                                    (
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>
                                        [
                                            Text("Between 6 to 12 characters", style: TextStyle
                                            (
                                                color: Color(0xffc2c2c2),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w300

                                            )),

                                            GestureDetector
                                            (
                                                child: Text("Forgot Password?", style: TextStyle
                                                (
                                                    color: Color(0xff039be5),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500

                                                )),

                                                onTap: ()
                                                {


                                                }

                                            )

                                        ]

                                    )

                                ),

                                Container
                                (
                                    margin: EdgeInsets.only(top: 6),
                                    child: Row
                                    (
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>
                                        [
                                            Switch
                                            (
                                                value: validation["remember"]["value"],

                                                activeColor: Color(0xff039be5),
                                                activeTrackColor: Color(0xff039be5).withOpacity(.5),

                                                inactiveThumbColor: !state.isLoadingSignIn ? Colors.white : (validation["remember"]["value"] ? Color(0xff039be5) : Colors.white),
                                                inactiveTrackColor: !state.isLoadingSignIn ? Colors.black.withOpacity(.38) : (validation["remember"]["value"] ? Color(0xff039be5).withOpacity(.5) : Colors.black.withOpacity(.38)),

                                                onChanged: state.isLoadingSignIn ? null : (bool isChanged)
                                                {
                                                    setState(()
                                                    {
                                                        validation["remember"]["value"] =
                                                            !validation["remember"]["value"];

                                                    });

                                                }

                                            ),

                                            Text("Keep me Signed in", style: TextStyle
                                            (
                                                color: Color(0xff292929),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300

                                            ))

                                        ]

                                    )

                                ),

                                Container
                                (
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 6),

                                    child: RaisedButton
                                    (
                                        color: Color(0xff039be5),
                                        disabledColor: Color(0xff039be5),
                                        elevation: 0,
                                        padding: EdgeInsets.all(12),

                                        shape: RoundedRectangleBorder
                                        (
                                            borderRadius: BorderRadius.all(Radius.circular(4))

                                        ),

                                        child: state.isLoadingSignIn
                                            ?
                                                Container
                                                (
                                                    width: 14,
                                                    height: 14,
                                                    margin: EdgeInsets.zero,

                                                    child: CircularProgressIndicator
                                                    (
                                                        strokeWidth: 1.5,
                                                        valueColor: AlwaysStoppedAnimation(Colors.white)

                                                    )

                                                )

                                            :
                                                Text("SIGN IN", style: TextStyle
                                                (
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500

                                                )),

                                        onPressed: state.isLoadingSignIn ? null : ()
                                        {
                                            handleSignIn();

                                        }

                                    )

                                ),

                                Container
                                (
                                    margin: EdgeInsets.only(top: 6),
                                    child: Row
                                    (
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>
                                        [
                                            Text("NEW USER?", style: TextStyle
                                            (
                                                color: Color(0xff292929),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500

                                            )),

                                            Container
                                            (
                                                margin: EdgeInsets.only(left: 5),
                                                child: GestureDetector
                                                (
                                                    child: Text("SIGN UP", style: TextStyle
                                                    (
                                                        color: Color(0xff039be5),
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.w500

                                                    )),

                                                    onTap: ()
                                                    {
                                                        Navigator.of(context).push
                                                        (
                                                            MaterialPageRoute(builder: (BuildContext context) => SignUpScreen())

                                                        );

                                                    }

                                                )

                                            )

                                        ]

                                    )

                                )

                            ]

                        )

                    )

                );

            }

        );

    }

}