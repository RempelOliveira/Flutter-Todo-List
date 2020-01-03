import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_redux/flutter_redux.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

import "package:google_books_api/states/AppState.dart";
import "package:google_books_api/store/Store.dart";

import "views/Books/List.dart";

Future main() async
{
    await DotEnv().load(".env");

    runApp(AnnotatedRegion<SystemUiOverlayStyle>
    (
        value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
        child: MaterialApp
        (
            title: "Google Books Api",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: "Avenir", dividerColor: Color(0xffeaeaea)),

            home: StoreProvider<AppState>
            (
                store: store,
                child: ListScreen()

            )

        )

    ));

}