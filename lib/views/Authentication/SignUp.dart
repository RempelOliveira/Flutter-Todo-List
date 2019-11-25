import "package:flutter/material.dart";

import "SignUp/Header.dart";
import "SignUp/Main.dart";

class SignUpScreen extends StatefulWidget
{
    @override
    _SignUpScreenState createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen>
{
    int page = 0;
    double offset = 0.0;

    ScrollController scrollController;

    final PageController pageController = PageController
    (
        initialPage: 0

    );

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

        pageController.addListener(()
        {
            print(pageController.page);

            setState(()
            {
                page = pageController.page.toInt();

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
                        page: page,
                        offset: offset,
                        pageController: pageController

                    )

                ),

                body: MainScreen
                (
                    pageController: pageController,
                    scrollController: scrollController

                ),

            )

        );

    }

}