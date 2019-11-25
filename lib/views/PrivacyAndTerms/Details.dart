import "package:flutter/material.dart";

import "Details/Header.dart";
import "Details/Main.dart";

class DetailsScreen extends StatefulWidget
{
    @override
    _DetailsScreenState createState() => _DetailsScreenState();

}

class _DetailsScreenState extends State<DetailsScreen>
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