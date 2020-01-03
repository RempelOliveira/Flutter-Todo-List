import "package:flutter/material.dart";

import "package:google_books_api/store/Store.dart";

import "package:google_books_api/views/Books/List/Main.dart";
import "package:google_books_api/views/Books/List/Header.dart";
import "package:google_books_api/views/Books/List/Categories.dart";

import "package:google_books_api/views/Components/DrawerMenu.dart";

import 'package:google_books_api/actions/UsersActions.dart';

class ListScreen extends StatefulWidget
{
    @override
    _ListScreenState createState() => _ListScreenState();

}

class _ListScreenState extends State<ListScreen> with SingleTickerProviderStateMixin
{
	Animation containerAnimation;

	AnimationController animationController;
	ScrollController scrollController;

	double offset = 0.0;

    @override
    void initState()
    {
        super.initState();

		animationController = AnimationController(
            vsync: this, duration: Duration(milliseconds: 246));

        scrollController = ScrollController()..addListener(()
        {
            setState(()
            {
                offset = scrollController.offset;

            });

        });

    }

    @override
    void didChangeDependencies()
    {
        super.didChangeDependencies();

        store.dispatch(
            signInByToken(context)

        );

    }

    @override
    Widget build(BuildContext context)
    {
        containerAnimation = Tween(begin: 0.0, end: MediaQuery.of(context).size.width - 40).animate(
            CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

        return SafeArea
        (
            child: Scaffold
            (
                backgroundColor: Colors.white,
                body: Stack
                (
                    children: <Widget>
                    [
                        AnimatedBuilder
                        (
                            animation: animationController,
                            builder: (BuildContext context, Widget widget)
                            {
                                return Transform.translate
                                (
                                    offset: Offset(containerAnimation.value, 0),
                                    child: Stack
                                    (
                                        children: <Widget>
                                        [
                                            Container
                                            (
                                                color: Colors.white,
                                                child: CustomScrollView
                                                (
                                                    controller: scrollController,
                                                    slivers: <Widget>
                                                    [
                                                        HeaderScreen
                                                        (
                                                            offset: offset,
                                                            scrollController: scrollController,
                                                            animationController: animationController

                                                        ),

                                                        CategoriesScreen
                                                        (
                                                            offset: offset,
                                                            scrollController: scrollController

                                                        ),

                                                        MainScreen
                                                        (
                                                            scrollController: scrollController

                                                        ),

                                                    ]

                                                )

                                            )

                                        ]

                                    )

                                );

                            }

                        ),

                        DrawerMenu
                        (
                            offset: offset,
                            scrollController: scrollController,
                            animationController: animationController

                        )

                    ]

                )

            )

        );

    }

}