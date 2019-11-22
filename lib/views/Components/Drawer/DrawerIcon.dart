import "package:flutter/material.dart";

class DrawerIcon extends StatelessWidget
{
    final double offset;

    final AnimationController animationController;
    final ScrollController scrollController;

    DrawerIcon({
        @required this.offset, @required this.animationController, @required this.scrollController});

    @override
    Widget build(BuildContext context)
    {
        final Animation iconAnimation = Tween(begin: 24.0, end: MediaQuery.of(context).size.width - 100).animate(
                    CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

        return AnimatedBuilder
        (
            animation: animationController,
            builder: (BuildContext context, Widget widget)
            {
                return Transform.translate
                (
                    offset: Offset(iconAnimation.value, - offset),
                    child: GestureDetector
                    (
                        child: Container
                        (
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(top: 24),

                            decoration: BoxDecoration
                            (
                                shape: BoxShape.circle, color: Color(0xffffc100)

                            ),

                            child: AnimatedIcon
                            (
                                icon: AnimatedIcons.menu_close,
                                color: Colors.white,
                                progress: animationController

                            )


                        ),

                        onTap: ()
                        {
                            if(animationController.value != 1)
                            {
                                if(offset != 0.0)
                                {
                                    scrollController.animateTo(
                                        0, curve: Curves.easeInOut, duration: Duration(milliseconds: 125));

                                    Future.delayed(Duration(milliseconds: 125), ()
                                    {
                                        animationController.forward();

                                    });

                                }
                                else
                                    animationController.forward();

                            }
                            else
                                animationController.reverse();

                        }

                    )

                );

            }

        );

    }

}
