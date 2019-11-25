import "package:flutter/material.dart";

import "SignIn/Header.dart";
import "SignIn/Main.dart";

class SignInScreen extends StatefulWidget
{
    @override
    _SignInScreenState createState() => _SignInScreenState();

}

class _SignInScreenState extends State<SignInScreen>
{
    double offset = 0.0;
    ScrollController scrollController;

    @override
    void initState()
    {
        super.initState();

        scrollController = ScrollController()..addListener(()
        {
            setState(()
            {
                offset = scrollController.offset;

            });

        });

    }

    @override
    Widget build(BuildContext context)
    {
        return SafeArea
        (
            child: Scaffold
            (
                backgroundColor:
                    Colors.white,

                appBar: PreferredSize
                (
                    preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                    child: HeaderScreen
                    (
                        offset: offset

                    )

                ),

                body: SingleChildScrollView
                (
                    controller: scrollController,
                    child: MainScreen()

                )

            )

        );

    }

}