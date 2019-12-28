import "package:flutter/material.dart";
import "package:flutter_redux/flutter_redux.dart";

import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/actions/Reviews.dart";

import "Reviews/Header.dart";
import "Reviews/Main.dart";

class ReviewsScreen extends StatefulWidget
{
    final String title;

    ReviewsScreen({
            @required this.title});

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
    void didChangeDependencies()
    {
        super.didChangeDependencies();

        StoreProvider.of<AppState>(context)
            .dispatch(getReviews);

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
                        offset: offset,
                        title: widget.title

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