import "dart:io";
import "dart:typed_data";

import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:flutter/foundation.dart";
import "package:esys_flutter_share/esys_flutter_share.dart";

import "../Components/Book.dart";

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

                appBar: AppBar
                (
                    elevation: 0,
                    backgroundColor: Colors.white,

                    leading: IconButton
                    (
                        icon: Icon(Icons.arrow_back_ios, color: Color(0xff292929)),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,

                        onPressed: ()
                        {
                            Navigator.pop(context);

                        }

                    ),

                    actions: <Widget>
                    [
                        IconButton
                        (
                            icon: Icon(Icons.bookmark_border, color: Color(0xff929292)),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,

                            onPressed: ()
                            {


                            }

                        )

                    ],

                    bottom: PreferredSize
                    (
                        preferredSize: Size.fromHeight(1),
                        child: Visibility
                        (
                            visible: offset.toInt() > 0,
                            child: Container
                            (
                                decoration: BoxDecoration
                                (
                                    border: Border(bottom: BorderSide
                                    (
                                        width: 1,
                                        color: Color(0xffeaeaea)

                                    ))

                                )

                            )

                        )

                    ),

                ),

                body: SingleChildScrollView
                (
                    controller: scrollController,
                    child: Column
                    (
                        children: <Widget>
                        [
                            BookComponent
                            (
                                title: widget.book["title"],
                                subtitle: widget.book["subtitle"],
                                thumbnail: widget.book["thumbnail"],
                                reviews: widget.book["reviews"],
                                rating: {
                                    "stars": widget.book["rating"]["stars"], "total": widget.book["rating"]["total"], "users": widget.book["rating"]["users"]
                                },

                                details: true

                            ),

                            Container
                            (
                                child: Row
                                (
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>
                                    [
                                        Container
                                        (
                                            margin: EdgeInsets.only(left: 12, right: 12),
                                            child: GestureDetector
                                            (
                                                child: Row
                                                (
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>
                                                    [

                                                        Icon
                                                        (
                                                            FontAwesomeIcons.solidCommentDots, color: Color(0xff929292), size: 20),

                                                        Padding
                                                        (
                                                            padding: EdgeInsets.only(left: 6),
                                                            child: Text
                                                            (
                                                                "See Reviews", style: TextStyle(color: Color(0xff555555), fontWeight: FontWeight.w300, fontSize: 10))

                                                        )

                                                    ]

                                                ),

                                                onTap: ()
                                                {


                                                }

                                            )

                                        ),

                                        Container
                                        (
                                            margin: EdgeInsets.only(left: 12, right: 12),
                                            child: GestureDetector
                                            (
                                                child: Row
                                                (
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>
                                                    [
                                                        Icon
                                                        (
                                                            FontAwesomeIcons.solidHeart, color: Color(0xff039be5), size: 20),

                                                        Padding
                                                        (
                                                            padding: EdgeInsets.only(left: 6),
                                                            child: Text
                                                            (
                                                                "Like", style: TextStyle(color: Color(0xff555555), fontWeight: FontWeight.w300, fontSize: 10))

                                                        )

                                                    ]

                                                ),

                                                onTap: ()
                                                {


                                                }

                                            )

                                        ),

                                        Container
                                        (
                                            margin: EdgeInsets.only(left: 12, right: 12),
                                            child: GestureDetector
                                            (
                                                child: Row
                                                (
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>
                                                    [
                                                        Icon
                                                        (
                                                            FontAwesomeIcons.share, color: Color(0xff929292), size: 20),

                                                        Padding
                                                        (
                                                            padding: EdgeInsets.only(left: 6),
                                                            child: Text
                                                            (
                                                                "Share", style: TextStyle(color: Color(0xff292929), fontWeight: FontWeight.w300, fontSize: 10))

                                                        )

                                                    ]

                                                ),

                                                onTap: () async
                                                {
                                                    var request  = await HttpClient().getUrl(Uri.parse(widget.book["thumbnail"]));
                                                    var response = await request.close();

                                                    Uint8List bytes =
                                                        await consolidateHttpClientResponseBytes(response);

                                                    await Share.file(widget.book["title"], "${widget.book["title"]}.png", bytes.buffer.asUint8List(), "image/png");

                                                }

                                            )

                                        )

                                    ]

                                )

                            ),

                            Container
                            (
                                padding: EdgeInsets.fromLTRB(34, 24, 34, 0),
                                alignment: Alignment.centerLeft,

                                child: Text
                                (
                                    "About the Book", style: TextStyle(color: Color(0xff292929), fontSize: 20, fontWeight: FontWeight.w700))

                            ),

                            Container
                            (
                                padding: EdgeInsets.fromLTRB(34, 24, 34, 34),
                                alignment: Alignment.centerLeft,

                                child: Text
                                (
                                    widget.book["description"], style: TextStyle(color: Color(0xff292929), fontSize: 16, fontWeight: FontWeight.w300, height: 1.2))

                            )

                        ]

                    )

                ),

                floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                floatingActionButton: FloatingActionButton.extended
                (
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                    backgroundColor: Color(0xff039BE5),

                    label: Text
                    (
                        "BUY NOW", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),

                    onPressed: ()
                    {


                    }

                ),

                persistentFooterButtons: <Widget>
                [
                    Container
                    (
                        height: 23,
                        width: MediaQuery.of(context).size.width - 21,
                        padding: EdgeInsets.only(top: 2.2),

                        child: Text
                        (
                            "R\$ 93.63", style: TextStyle(color: Color(0xff039BE5), fontSize: 16, fontWeight: FontWeight.w500))

                    )

                ]

            )

        );

    }

}