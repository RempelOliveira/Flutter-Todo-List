import "package:flutter/material.dart";
import "package:flutter_redux/flutter_redux.dart";
import "package:google_books_api/actions/BooksActions.dart";
import "package:google_books_api/states/AppState.dart";

class CategoriesScreen extends StatelessWidget
{
    final double offset;
    final ScrollController scrollController;

	final List<String> categories =
	[
		"Typography", "Myths", "Photography", "Science", "Android", "iOS", "Flutter"

	];

    CategoriesScreen({
        @required this.offset, @required this.scrollController});

    @override
    Widget build(BuildContext context)
    {
        return SliverAppBar
        (
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,

            flexibleSpace: Column
            (
                children: <Widget>
                [
                    Container
                    (
                        height: 9,

                    ),

                    Container
                    (
                        height: 26,
                        margin: EdgeInsets.only(top: 15),

                        child: ListView.builder
                        (
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            padding: EdgeInsets.only(left: 24, right: 12),

                            itemBuilder: (BuildContext context, int index)
                            {
                                return StoreConnector<AppState, AppState>
                                (
                                    converter: (store) => store.state,
                                    builder: (BuildContext context, AppState state)
                                    {
                                        return GestureDetector
                                        (
                                            child: Container
                                            (
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(right: 12),
                                                padding: EdgeInsets.only(left: 32, right: 32),

                                                decoration: BoxDecoration
                                                (
                                                    color: state.category == categories.elementAt(index).toLowerCase() ? Color(0xff039BE5) : Color(0xffEDEDED),
                                                    borderRadius: BorderRadius.all(Radius.circular(40))

                                                ),

                                                child: Text
                                                (
                                                    categories.elementAt(index), style: TextStyle(color: state.category == categories.elementAt(index).toLowerCase() ? Colors.white : Color(0xff767676), fontSize: 12, fontWeight: FontWeight.w300)

                                                ),

                                            ),

                                            onTap: ()
                                            {
                                                if(offset != 0.0)
                                                    scrollController.jumpTo(0);

                                                StoreProvider.of<AppState>(context)
                                                    .dispatch(ChangeCategory(categories.elementAt(index).toLowerCase()));

                                                StoreProvider.of<AppState>(context)
                                                    .dispatch(ChangeSkip(0));

                                                StoreProvider.of<AppState>(context)
                                                    .dispatch(getBooks);

                                            }

                                        );

                                    }

                                );

                            }

                        )

                    )

                ]

            ),

            bottom: PreferredSize
            (
                preferredSize: Size.fromHeight(19),
                child: Container
                (
                    decoration: BoxDecoration
                    (
                        border: Border(bottom: BorderSide
                        (
                            width: 1,
                            color: offset >= 57 ? Color(0xffeaeaea) : Colors.transparent

                        ))

                    )

                )

            )

        );

    }

}
