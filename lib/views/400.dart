import "package:flutter/material.dart";

class BadRequest extends StatelessWidget
{
    final onReload;

    BadRequest({
        @required this.onReload });

    @override
    Widget build(BuildContext context)
    {
        return Container
        (
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 162,
            color: Colors.white,

            child: Column
            (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>
                [
                    Container
                    (
                        margin: EdgeInsets.only(top: 19, bottom: 19),
                        alignment: Alignment.center,

                        child: Text("400 - Bad request", style: TextStyle
                        (
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500

                        ))

                    ),

                    Container
                    (
                        color: Color(0xfffcfcfc),
                        padding: EdgeInsets.all(24),

                        child: Column
                        (
                            children: <Widget>
                            [
                                RaisedButton
                                (
                                    color: Color(0xff039be5),
                                    elevation: 0,
                                    padding: EdgeInsets.all(12),

                                    shape: RoundedRectangleBorder
                                    (
                                        borderRadius: BorderRadius.all(Radius.circular(4))

                                    ),

                                    child: Text("TRY RELOAD", style: TextStyle
                                    (
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500

                                    )),

                                    onPressed: ()
                                    {
                                        onReload(true);

                                    }

                                )

                            ]

                        )

                    )

                ]

            )

        );

    }

}