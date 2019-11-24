import "package:flutter/material.dart";
import "package:flutter_redux/flutter_redux.dart";

import "package:google_books_api/states/AppState.dart";

import "../Details.dart";
import "../../Components/Book.dart";

class MainScreen extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        return SliverList
        (
            delegate: SliverChildListDelegate
            (
                <Widget>
                [
                    StoreConnector<AppState, AppState>
                    (
                        converter: (store) => store.state,
                        builder: (BuildContext context, AppState state)
                        {
                            return Column
                            (
                                children: <Widget>
                                [
                                    state.isLoading
                                        ?
                                            Container
                                            (
                                                margin: EdgeInsets.only(top: 10, bottom: 2),
                                                child: CircularProgressIndicator
                                                (
                                                    valueColor: AlwaysStoppedAnimation(Color(0xff039be5))

                                                )

                                            )

                                        :
                                            state.books.length > 0
                                                ?
                                                    Column
                                                    (
                                                        children: <Widget>
                                                        [
                                                            ...state.books.map((dynamic item) =>
                                                                GestureDetector
                                                                (
                                                                    child: BookComponent
                                                                    (
                                                                        title: item["title"],
                                                                        subtitle: item["subtitle"],
                                                                        thumbnail: item["thumbnail"],
                                                                        reviews: item["reviews"],
                                                                        rating: {
                                                                            "stars": item["rating"]["stars"], "total": item["rating"]["total"], "users": item["rating"]["users"]
                                                                        }

                                                                    ),

                                                                    onTap: ()
                                                                    {
                                                                        Navigator.of(context).push
                                                                        (
                                                                            MaterialPageRoute(builder: (BuildContext context) => DetailsScreen(book: item))

                                                                        );

                                                                    }

                                                                )),

                                                            Visibility
                                                            (
                                                                visible: state.books.length < state.booksTotal,
                                                                child: Container
                                                                (
                                                                    margin: EdgeInsets.only(top: 2, bottom: 26),
                                                                    child: CircularProgressIndicator
                                                                    (
                                                                        valueColor: AlwaysStoppedAnimation(Color(0xff039be5))

                                                                    )

                                                                )

                                                            )

                                                        ]

                                                    )

                                                :
                                                    Container
                                                    (
                                                        height: MediaQuery.of(context).size.height - 162,
                                                        alignment: Alignment.center,
                                                        child: Column
                                                        (
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>
                                                            [
                                                                Text("No records found!", style: TextStyle
                                                                (
                                                                    color: Colors.black,
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w500

                                                                )),

                                                                Visibility
                                                                (
                                                                    visible: state.tab == "favorites",
                                                                    child: Text("Sign in app to see your favorites", style: TextStyle
                                                                    (
                                                                        color: Colors.black,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w100

                                                                    ))

                                                                )

                                                            ]

                                                        )

                                                    )

                                ]

                            );

                        }

                    )

                ]

            )

        );

    }

}