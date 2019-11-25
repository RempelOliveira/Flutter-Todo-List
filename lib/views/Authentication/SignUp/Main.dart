import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class MainScreen extends StatefulWidget
{
    final PageController pageController;
    final ScrollController scrollController;

    MainScreen({
        @required this.pageController, @required this.scrollController});

    @override
    _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen>
{
    bool showPassword = false;

    @override
    Widget build(BuildContext context)
    {
        return Form
        (
            child: PageView
            (
                controller: widget.pageController,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),

                children: <Widget>
                [
                    SingleChildScrollView
                    (
                        controller: widget.scrollController,
                        child: Container
                        (
                            margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
                            child: Column
                            (
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>
                                [
                                    Text("Welcome to Google\nBooks Api!", style: TextStyle
                                    (
                                        color: Color(0xff292929),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500

                                    )),

                                    Container
                                    (
                                        margin: EdgeInsets.only(top: 24),
                                        child: TextField
                                        (
                                            enabled: 1 == 2 ? false: true,
                                            style: TextStyle
                                            (
                                                color: Color(0xffd0d0d0),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300

                                            ),

                                            decoration: InputDecoration
                                            (
                                                filled: true,
                                                fillColor: 1 == 2 ? Color(0xfff5f5f5) : Colors.white,

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

                                                hintText: "Name",
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

                                    Container
                                    (
                                        margin: EdgeInsets.only(top: 6),
                                        child: Text("Enter name and surname", style: TextStyle
                                        (
                                            color: Color(0xffc2c2c2),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300

                                        ))

                                    ),

                                    Container
                                    (
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: 24),

                                        child: RaisedButton
                                        (
                                            color: Color(0xff039be5),
                                            elevation: 0,
                                            padding: EdgeInsets.all(12),

                                            shape: RoundedRectangleBorder
                                            (
                                                borderRadius: BorderRadius.all(Radius.circular(4))

                                            ),

                                            child: Text("NEXT", style: TextStyle
                                            (
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500

                                            )),

                                            onPressed: ()
                                            {
                                                widget.pageController.animateToPage(
                                                    1, curve: Curves.ease, duration: Duration(milliseconds: 325));

                                            }

                                        )

                                    )

                                ]

                            )

                        )

                    ),

                    SingleChildScrollView
                    (
                        controller: widget.scrollController,
                        child: Container
                        (
                            margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
                            child: Column
                            (
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>
                                [
                                    Text("Almost there!\nJust a few more fields.", style: TextStyle
                                    (
                                        color: Color(0xff292929),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500

                                    )),

                                    Container
                                    (
                                        margin: EdgeInsets.only(top: 24),
                                        child: TextField
                                        (
                                            enabled: 1 == 2 ? false: true,
                                            style: TextStyle
                                            (
                                                color: Color(0xffd0d0d0),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300

                                            ),

                                            decoration: InputDecoration
                                            (
                                                filled: true,
                                                fillColor: 1 == 2 ? Color(0xfff5f5f5) : Colors.white,

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

                                    Container
                                    (
                                        margin: EdgeInsets.only(top: 12),
                                        child: TextField
                                        (
                                            enabled: 1 == 2 ? false: true,
                                            obscureText: !showPassword,

                                            style: TextStyle
                                            (
                                                color: Color(0xffd0d0d0),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300

                                            ),

                                            decoration: InputDecoration
                                            (
                                                filled: true,
                                                fillColor: 1 == 2 ? Color(0xfff5f5f5) : Colors.white,

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
                                                        color: Color(0xffdbdbdb),

                                                    ),

                                                    onTap: ()
                                                    {
                                                        setState(() => showPassword = !showPassword);

                                                    }

                                                ),

                                                contentPadding: EdgeInsets.fromLTRB(13, 9, 12, 9)

                                            )

                                        )

                                    ),

                                    Container
                                    (
                                        margin: EdgeInsets.only(top: 6),
                                        child: Text("Between 6 to 12 characters", style: TextStyle
                                        (
                                            color: Color(0xffc2c2c2),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300

                                        ))

                                    ),

                                    Container
                                    (
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: 24),

                                        child: RaisedButton
                                        (
                                            color: Color(0xff039be5),
                                            elevation: 0,
                                            padding: EdgeInsets.all(12),

                                            shape: RoundedRectangleBorder
                                            (
                                                borderRadius: BorderRadius.all(Radius.circular(4))

                                            ),

                                            child: Text("SIGN UP", style: TextStyle
                                            (
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500

                                            )),

                                            onPressed: ()
                                            {


                                            }

                                        )

                                    ),

                                    Container
                                    (
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: 6),

                                        child: GestureDetector
                                        (
                                            child: Text("PRIVACY & TERMS", style: TextStyle
                                            (
                                                color: Color(0xff039be5),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500

                                            )),

                                            onTap: ()
                                            {


                                            }

                                        )

                                    )

                                ]

                            )

                        )

                    ),

                ]

            )

        );

    }

}