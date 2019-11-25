import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class HeaderScreen extends StatelessWidget
{
    final double offset;

    HeaderScreen({
        @required this.offset});

    @override
    Widget build(BuildContext context)
    {
        return AppBar
        (
            elevation: 0,
            backgroundColor: Colors.white,
			automaticallyImplyLeading: false,

            title: Text("Privacy & Terms", style: TextStyle
            (
                color: Color(0xff292929),
                fontSize: 14,
                fontWeight: FontWeight.w500

            )),

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