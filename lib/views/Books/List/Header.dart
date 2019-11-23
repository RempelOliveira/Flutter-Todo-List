import "package:flutter/material.dart";
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_books_api/actions/BooksActions.dart';
import 'package:google_books_api/states/AppState.dart';

class HeaderScreen extends StatelessWidget
{
    final double offset;

    final ScrollController scrollController;
    final AnimationController animationController;

    HeaderScreen({
        @required this.offset, @required this.scrollController, @required this.animationController});

    Animation headerAnimation;

    @override
    Widget build(BuildContext context)
    {
        headerAnimation = Tween(begin: 56.0, end: 0.0).animate(
            CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

        return SliverList
        (
            delegate: SliverChildListDelegate
            (
                <Widget>
                [
                    Container
                    (
                        color: Colors.white,
                        padding: EdgeInsets.only(top: 24, bottom: 0), //8

                        child: Row
                        (
                            children: <Widget>
                            [
                                StoreConnector<AppState, AppState>
                                (
                                    converter: (store) => store.state,
                                    builder: (BuildContext context, AppState state)
                                    {
                                        return AnimatedBuilder
                                        (
                                            animation: animationController,
                                            builder: (BuildContext context, Widget widget)
                                            {
                                                return Transform.translate
                                                (
                                                    offset: Offset(headerAnimation.value, 0),
                                                    child: Row
                                                    (
                                                        textBaseline: TextBaseline.alphabetic,
                                                        crossAxisAlignment: CrossAxisAlignment.baseline,

                                                        children: <Widget>
                                                        [
                                                            Container
                                                            (
                                                                margin: EdgeInsets.only(left: 22, right: 6),
                                                                child: GestureDetector
                                                                (
                                                                    child: Text("Browse", style: TextStyle
                                                                    (
                                                                        color: state.tab == "browse" ? Colors.black : Color(0xff929292),
                                                                        fontSize: state.tab == "browse" ? 28 : 14,
                                                                        fontWeight: state.tab == "browse" ? FontWeight.w500 : FontWeight.w300

                                                                    )),

                                                                    onTap: ()
                                                                    {
                                                                        if(offset != 0.0)
                                                                            scrollController.jumpTo(0);

                                                                        StoreProvider.of<AppState>(context)
                                                                            .dispatch(ChangeTab("browse"));

                                                                        StoreProvider.of<AppState>(context)
                                                                            .dispatch(ChangeSkip(0));

                                                                        StoreProvider.of<AppState>(context)
                                                                            .dispatch(getBooks);

                                                                    }

                                                                )

                                                            ),

                                                            Container
                                                            (
                                                                margin: EdgeInsets.only(left: 6, right: 6),
                                                                child: GestureDetector
                                                                (
                                                                    child: Text("Favorites", style: TextStyle
                                                                    (
                                                                        color: state.tab == "favorites" ? Colors.black : Color(0xff929292),
                                                                        fontSize: state.tab == "favorites" ? 28 : 14,
                                                                        fontWeight: state.tab == "favorites" ? FontWeight.w500 : FontWeight.w300

                                                                    )),

                                                                    onTap: ()
                                                                    {
                                                                        if(offset != 0.0)
                                                                            scrollController.jumpTo(0);

                                                                        StoreProvider.of<AppState>(context)
                                                                            .dispatch(ChangeTab("favorites"));

                                                                        StoreProvider.of<AppState>(context)
                                                                            .dispatch(ChangeSkip(0));

                                                                        StoreProvider.of<AppState>(context)
                                                                            .dispatch(getBooks);

                                                                    }

                                                                )

                                                            )

                                                        ]

                                                    )

                                                );

                                            }

                                        );

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
