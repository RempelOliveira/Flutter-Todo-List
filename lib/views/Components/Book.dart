import "dart:math";
import "package:flutter/material.dart";

import "package:decimal/decimal.dart";
import "package:smooth_star_rating/smooth_star_rating.dart";
import "package:cached_network_image/cached_network_image.dart";

class BookComponent extends StatelessWidget
{
    final String title;
    final String subtitle;
    final String thumbnail;
    final int reviews;
    final Map rating;
    final bool details;

    BookComponent({
        @required this.title, @required this.subtitle, @required this.thumbnail, @required this.reviews, @required this.rating, this.details = false});

    @override
    Widget build(BuildContext context)
    {
        return Container
        (
            height: 250,
            margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Stack
            (
                children: <Widget>
                [
                    Align
                    (
                        alignment: details ? Alignment.centerLeft : Alignment.centerRight,
                        child: Container
                        (
                            width: 190,
                            child: Container
                            (
                                width: 190,
                                height: 250,
                                child: ClipRRect
                                (
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    child: CachedNetworkImage
                                    (
                                        imageUrl: thumbnail,
                                        imageBuilder: (BuildContext context, ImageProvider<dynamic> imageProvider) => Container
                                        (
                                            decoration: BoxDecoration
                                            (
                                                image: DecorationImage
                                                (
                                                    fit: BoxFit.fill,
                                                    image: imageProvider

                                                )

                                            )

                                        )

                                    )

                                )

                            )

                        )

                    ),

                    Align
                    (
                        alignment: details ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container
                        (
                            width: 202,
                            height: 209,
                            padding: EdgeInsets.all(30),

                            decoration: BoxDecoration
                            (
                                color: Colors.white,

                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                boxShadow:
                                [
                                    BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 10))

                                ]

                            ),

                            child: Column
                            (
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: <Widget>
                                [
                                    Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle
                                    (
                                        color: Color(0xff292929),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700

                                    )),

                                    Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle
                                    (
                                        color: Color(0xff292929),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300

                                    )),

                                    Row
                                    (
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>
                                        [
                                            SmoothStarRating
                                            (
                                                rating: rating["stars"].toDouble(),
                                                starCount: 5,
                                                size: 18,
                                                allowHalfRating: false,
                                                color: Color(0xffffaf2e),
                                                borderColor: Color(0xffffaf2e)

                                            ),

                                            Padding
                                            (
                                                padding: EdgeInsets.only(left: 12),
                                                child: Text("${rating["stars"] > 9999 ? "10k+" : Decimal.parse(((rating["stars"] * pow(10, 2)).round() / pow(10, 2)).toStringAsFixed(2).toString())}", style: TextStyle
                                                (
                                                    color: Color(0xffffaf2e),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.2

                                                ))

                                            )

                                        ]

                                    ),

                                    Row
                                    (
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>
                                        [
                                            Text(reviews.toString(), style: TextStyle
                                            (
                                                color: Color(0xff039be5).withOpacity(.8),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500

                                            )),

                                            Expanded
                                            (
                                                child: Container
                                                (
                                                    margin: EdgeInsets.only(left: 6),
                                                    child: Text("Review${reviews == 0 || reviews > 1 ? "s" : ""}", style: TextStyle
                                                    (
                                                        color: Color(0xff039be5),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w500

                                                    ))

                                                )

                                            ),

                                            Visibility
                                            (
                                                visible: !details,
                                                child: Icon(Icons.arrow_forward_ios, color: Color(0xffbababa).withOpacity(.5), size: 20)

                                            )

                                        ]

                                    )

                                ]

                            )

                        )

                    )

                ]

            )

        );

    }

}