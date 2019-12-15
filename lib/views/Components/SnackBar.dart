import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class SnackComponent extends StatelessWidget
{
    final String type;
    final String message;

    SnackComponent({
        this.type = "info", @required this.message});

    @override
    Widget build(BuildContext context)
    {
        int color;
        IconData icon;

        switch(type)
        {
            case "info":
                icon  = FontAwesomeIcons.exclamationCircle;
                color = 0xff323232;
            break;
            case "warning":
                icon = FontAwesomeIcons.exclamationCircle;
                color = 0xffffc100;
            break;
            case "danger":
                icon = FontAwesomeIcons.exclamationCircle;
                color = 0xffd32f2f;
            break;
            case "success":
                icon = FontAwesomeIcons.exclamationCircle;
                color = 0xff43a047;
            break;

        }

        Scaffold.of(context).
            removeCurrentSnackBar();

        return SnackBar
        (
            elevation: 6,
            backgroundColor: Color(color),
            behavior: SnackBarBehavior.floating,
            duration: Duration(milliseconds: 5000),

            content: Container
            (
                child: Row
                (
                    children: <Widget>
                    [
                        Icon(icon, size: 20),

                        Expanded
                        (
                            child: Container
                            (
                                margin: EdgeInsets.only(left: 12),
                                child: Text(message, style: TextStyle
                                (
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500

                                ))

                            )

                        )

                    ]

                )

            )

        );

    }

}