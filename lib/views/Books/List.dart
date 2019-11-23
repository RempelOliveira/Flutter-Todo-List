import "package:flutter/material.dart";
import "package:flutter_redux/flutter_redux.dart";

import "package:google_books_api/actions/BooksActions.dart";
import "package:google_books_api/states/AppState.dart";

import "List/Categories.dart";
import "List/Header.dart";
import "List/Main.dart";

import "../Components/Drawer/DrawerMenu.dart";
import "../Components/Drawer/DrawerIcon.dart";

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

    String tab = "browse";
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

            AppState state =
                StoreProvider.of<AppState>(context).state;

            if(state.books.length < state.booksTotal && !state.isLoadingMore)
            {
                if(scrollController.offset >= scrollController.position.maxScrollExtent - 100)
                {
                    StoreProvider.of<AppState>(context)
                        .dispatch(ChangeIsLoadingMore(true));

                    StoreProvider.of<AppState>(context)
                        .dispatch(getBooks);

                }

            }

        });

    }

    @override
    void didChangeDependencies()
    {
        super.didChangeDependencies();

        StoreProvider.of<AppState>(context)
            .dispatch(getBooks);

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

                                                        MainScreen()

                                                    ]

                                                )

                                            ),

                                            DrawerMenu
                                            (
                                                animationController: animationController

                                            )

                                        ]

                                    )

                                );

                            }

                        ),

                        DrawerIcon
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