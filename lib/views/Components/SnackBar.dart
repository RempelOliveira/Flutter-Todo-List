import "package:flutter/material.dart";
import "package:flushbar/flushbar.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class SnackComponent
{
    static Flushbar current;
    static BuildContext buildContext;

    static final SnackComponent _singleton =
        new SnackComponent._internal();

    factory SnackComponent(BuildContext context){ buildContext = context; return _singleton; }

    SnackComponent._internal();

    show({String type = "info", dynamic message})
    {
        int color;
        String sufix;
        IconData icon;

        if(current != null)
            current.dismiss();

        switch(type)
        {
            case "info":
                color = 0xff323232;
                sufix = "";
                icon  = FontAwesomeIcons.exclamationCircle;
            break;
            case "warning":
                color = 0xffffc100;
                sufix = "Warning! ";
                icon  = FontAwesomeIcons.exclamationCircle;
            break;
            case "danger":
                color = 0xffd32f2f;
                sufix = "Error! ";
                icon  = FontAwesomeIcons.exclamationCircle;
            break;
            case "success":
                color = 0xff43a047;
                sufix = "Success! ";
                icon  = FontAwesomeIcons.solidCheckCircle;
            break;

        }

        current = Flushbar
        (
            icon: Icon(icon, size: 20, color: Colors.white),
            margin: EdgeInsets.all(8),
            duration: Duration(seconds: 5),
            borderRadius: 4,
            shouldIconPulse: false,
            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
            isDismissible: true,
            backgroundColor: Color(color),
            animationDuration: Duration(milliseconds: 250),

            boxShadows:
            [
                BoxShadow(color: Colors.black45, offset: Offset(0, 3), blurRadius: 3)

            ],

            messageText: message.runtimeType == String
                ?
                    Text("${sufix.toString().isNotEmpty ? sufix : ""}$message", style: TextStyle
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
                            text: "${sufix.toString().isNotEmpty ? sufix : ""}",
                            style: TextStyle
                            (
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500

                            ),

                            children: message

                        )

                    )

        )..show(buildContext);

    }

}