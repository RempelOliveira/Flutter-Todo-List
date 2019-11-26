import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "../../Authentication/SignIn.dart";

class HeaderScreen extends StatelessWidget
{
    final double offset;
    final String favorite;

    HeaderScreen({
        @required this.offset, this.favorite});

    @override
    Widget build(BuildContext context)
    {
        return AppBar
        (
            elevation: 0,
            backgroundColor: Colors.white,

            leading: IconButton
            (
                icon: Icon(FontAwesomeIcons.chevronLeft, color: Color(0xff292929)),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,

                onPressed: ()
                {
                    Navigator.of(context).pop(null);

                }

            ),

            actions: <Widget>
            [
                IconButton
                (
                    icon: Icon(favorite == "true" ? Icons.bookmark : Icons.bookmark_border, color: Color(favorite == "true" ? 0xff039be5 : 0xff929292)),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,

                    onPressed: ()
                    {
                        if(1 == 1)
                        {
                            Navigator.of(context).push
                            (
                                MaterialPageRoute(builder: (BuildContext context) => SignInScreen())

                            );

                        }

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