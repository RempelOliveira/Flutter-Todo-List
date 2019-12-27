import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class SnackComponent extends StatelessWidget
{
    final String type;
    final dynamic message;

    SnackComponent({
        this.type = "info", this.message});

    @override
    Widget build(BuildContext context)
    {
        int color;
        IconData icon;
        String sufix;

        switch(type)
        {
            case "info":
                icon  = FontAwesomeIcons.exclamationCircle;
                color = 0xff323232;
                sufix = "";
            break;
            case "warning":
                icon = FontAwesomeIcons.exclamationCircle;
                color = 0xffffc100;
                sufix = "Warning";
            break;
            case "danger":
                icon = FontAwesomeIcons.exclamationCircle;
                color = 0xffd32f2f;
                sufix = "Error";
            break;
            case "success":
                icon = FontAwesomeIcons.solidCheckCircle;
                color = 0xff43a047;
                sufix = "Success";
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
                                child: message.runtimeType == String
                                    ?
                                        Text("$sufix! $message", style: TextStyle
                                        (
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500

                                        ))
                                    :
                                        RichText
                                        (
                                            text: TextSpan
                                            (
                                                text: "$sufix! ",
                                                style: TextStyle
                                                (
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500

                                                ),

                                                children: message

                                            )

                                        )

                            )

                        )

                    ]

                )

            )

        );

    }

}