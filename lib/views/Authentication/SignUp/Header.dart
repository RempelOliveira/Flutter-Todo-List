import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class HeaderScreen extends StatelessWidget
{
    final int page;
    final double offset;

    final PageController pageController;

    HeaderScreen({
        @required this.page, @required this.offset, @required this.pageController});

    @override
    Widget build(BuildContext context)
    {
        return AppBar
        (
            elevation: 0,
            backgroundColor: Colors.white,

            leading: page == 0 ? null : IconButton
            (
                icon: Icon(FontAwesomeIcons.chevronLeft, color: Color(0xff292929)),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,

                onPressed: ()
                {
                    pageController.animateToPage(
                        0, curve: Curves.ease, duration: Duration(milliseconds: 325));

                }

            ),

            actions: <Widget>
            [
                IconButton
                (
                    icon: Icon(FontAwesomeIcons.times, color: Color(0xff292929)),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,

                    onPressed: ()
                    {
                        Navigator.of(context).pop(null);

                    }

                )

            ],

            bottom: PreferredSize
            (
                preferredSize: Size.fromHeight(1),
                child: Container
                (
                    decoration: BoxDecoration
                    (
                        border: Border(bottom: BorderSide
                        (
                            width: 1,
                            color: offset > 0 ? Color(0xffeaeaea) : Colors.transparent

                        ))

                    )

                )

            )

        );

    }

}