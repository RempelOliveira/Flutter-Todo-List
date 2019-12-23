import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "package:google_books_api/actions/UsersActions.dart";
import "package:google_books_api/store/Store.dart";

class HeaderScreen extends StatelessWidget
{
    final double offset;

    HeaderScreen({
        @required this.offset});

    @override
    Widget build(BuildContext context)
    {
        store.dispatch(
            ChangeIsLoadingSignIn(false)

        );

        return AppBar
        (
            elevation: 0,
            backgroundColor: Colors.white,

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