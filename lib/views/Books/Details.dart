import "package:flutter/material.dart";
import "package:flutter/foundation.dart";

import "Details/Header.dart";
import "Details/Main.dart";

class DetailsScreen extends StatefulWidget
{
    final Map<String, dynamic> book;

    DetailsScreen({
        @required this.book});

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
                        offset: offset,
                        favorite: widget.book["favorite"].toString()

                    )

                ),

                body: SingleChildScrollView
                (
                    controller: scrollController,
                    child: MainScreen
                    (
                        book: widget.book,

                    )

                ),

                floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                floatingActionButton: FloatingActionButton.extended
                (
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                    backgroundColor: Color(0xff039be5),

                    label: Text("BUY NOW", style: TextStyle
                    (
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500

                    )),

                    onPressed: ()
                    {}

                ),

                persistentFooterButtons: <Widget>
                [
                    Container
                    (
                        height: 23,
                        width: MediaQuery.of(context).size.width - 21,
                        padding: EdgeInsets.only(top: 2.2),

                        child: Text("R\$ 93.63", style: TextStyle
                        (
                            color: Color(0xff039be5),
                            fontSize: 16,
                            fontWeight: FontWeight.w500

                        ))

                    )

                ]

            )

        );

    }

}