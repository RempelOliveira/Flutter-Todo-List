import "package:flutter/material.dart";

import "Reviews/Header.dart";
import "Reviews/Main.dart";

class ReviewsScreen extends StatefulWidget
{
    @override
    _ReviewsScreenState createState() => _ReviewsScreenState();

}

class _ReviewsScreenState extends State<ReviewsScreen>
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
                    child: MainScreen
                    ()

                )

            )

        );

    }

}