import "package:flutter/material.dart";

class MainScreen extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        return Container
        (
            margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column
            (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>
                [
                    Text("Let's start!", style: TextStyle
                    (
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500

                    )),

                    Container
                    (
                        margin: EdgeInsets.only(top: 24),
                        child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", style: TextStyle
                        (
                            color: Color(0xff929292),
                            fontSize: 10,
                            fontWeight: FontWeight.w100

                        ))

                    ),

                    Container
                    (
                        margin: EdgeInsets.only(top: 12),
                        child: Text("Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.", style: TextStyle
                        (
                            color: Color(0xff929292),
                            fontSize: 10,
                            fontWeight: FontWeight.w100

                        ))

                    ),

                    Container
                    (
                        margin: EdgeInsets.only(top: 12),
                        child: Text("Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", style: TextStyle
                        (
                            color: Color(0xff929292),
                            fontSize: 10,
                            fontWeight: FontWeight.w100

                        ))

                    ),

                    Container
                    (
                        margin: EdgeInsets.only(top: 12),
                        child: Text("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", style: TextStyle
                        (
                            color: Color(0xff929292),
                            fontSize: 10,
                            fontWeight: FontWeight.w100

                        ))

                    ),

                    Container
                    (
                        margin: EdgeInsets.only(top: 12),
                        child: Text("Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.", style: TextStyle
                        (
                            color: Color(0xff929292),
                            fontSize: 10,
                            fontWeight: FontWeight.w100

                        ))

                    ),

                    Container
                    (
                        margin: EdgeInsets.only(top: 12),
                        child: Text("At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.", style: TextStyle
                        (
                            color: Color(0xff929292),
                            fontSize: 10,
                            fontWeight: FontWeight.w100

                        ))

                    ),

                    Container
                    (
                        margin: EdgeInsets.only(top: 12),
                        child: Text("Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae.", style: TextStyle
                        (
                            color: Color(0xff929292),
                            fontSize: 10,
                            fontWeight: FontWeight.w100

                        ))

                    ),

                    Container
                    (
                        margin: EdgeInsets.only(top: 12),
                        child: Text("Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.", style: TextStyle
                        (
                            color: Color(0xff929292),
                            fontSize: 10,
                            fontWeight: FontWeight.w100

                        ))

                    )

                ]

            )

        );

    }

}