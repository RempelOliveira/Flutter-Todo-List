import "dart:math" as math;
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class SpinnerIndicator extends StatefulWidget
{
    final bool animating;
    final double radius;
    final Color color;

    SpinnerIndicator({
        Key key, this.animating = true, this.radius = 11, this.color = const Color(0xffffffff) }) : assert(animating != null), assert(radius != null), assert(radius > 0), super(key: key);

    @override
    _SpinnerIndicatorState createState() => _SpinnerIndicatorState();

}

class _SpinnerIndicatorState extends State<SpinnerIndicator> with TickerProviderStateMixin
{
    AnimationController animationController;

    Animation<double> fadeAnimation;
    Animation<double> scaleAnimation;

    @override
    void initState()
    {
        super.initState();

		animationController = AnimationController(
		    vsync: this, duration: Duration(milliseconds: 225));

        fadeAnimation  = Tween(begin: 0.0, end: 1.0).animate(animationController);
        scaleAnimation = Tween(begin: 3.0, end: 1.2).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInCubic));

        animationController.forward();

    }

    @override
    Widget build(BuildContext context)
    {
        return FadeTransition
        (
            opacity: fadeAnimation,
            child: ScaleTransition
            (
                scale: scaleAnimation,
                child: _Indicator
                (
                    color: widget.color,
                    radius: widget.radius,
                    animating: widget.animating

                )

            )

        );

    }

}

class _Indicator extends StatefulWidget
{
    final bool animating;
    final double radius;
    final Color color;

    const _Indicator({
        Key key, this.animating, this.radius, this.color });

    @override
    _IndicatorState createState() => _IndicatorState();

}

class _IndicatorState extends State<_Indicator> with SingleTickerProviderStateMixin
{
    AnimationController _controller;

    @override
    void initState()
    {
        super.initState();

        _controller = AnimationController(
            duration: const Duration(seconds: 1), vsync: this);

        if(widget.animating)
            _controller.repeat();

    }

    @override
    void didUpdateWidget(_Indicator oldWidget)
    {
        super.didUpdateWidget(oldWidget);

        if(widget.animating != oldWidget.animating)
        {
            if(widget.animating)
            {
                _controller.repeat();

            }
            else
                _controller.stop();

        }

    }

    @override
    Widget build(BuildContext context)
    {
        return SizedBox
        (
            height: widget.radius * 2,
            width: widget.radius * 2,

            child: CustomPaint
            (
                painter: _SpinnerActivityIndicatorPainter
                (
                    position: _controller,
                    activeColor: widget.color,
                    radius: widget.radius

                )

            )

        );

    }

    @override
    void dispose()
    {
        _controller.dispose();
        super.dispose();

    }

}

class _SpinnerActivityIndicatorPainter extends CustomPainter
{
    final Animation<double> position;
    final RRect tickFundamentalRRect;
    final Color activeColor;

    _SpinnerActivityIndicatorPainter({ @required this.position, @required this.activeColor, double radius }) : tickFundamentalRRect = RRect.fromLTRBXY
    (
        -radius,
         radius / (radius * 1.2),
        -radius / 2.0,
        -radius / (radius * 1.2),
         radius / (radius * 1.2),
         radius / (radius * 1.2)

    ), super(repaint: position);

    final double _kTwoPI         = math.pi * 2.0;
    final int _kTickCount        = 12;
    final List<int> _alphaValues = <int>[255, 239, 222, 202, 186, 169, 152, 152, 152, 152, 152, 152];

    @override
    void paint(Canvas canvas, Size size)
    {
        final Paint paint = Paint();

        canvas.save();
        canvas.translate(size.width / 2.0, size.height / 2.0);

        final int activeTick = (_kTickCount * position.value).floor();

        for(int i = 0; i < _kTickCount; ++ i)
        {
            final int t = (i + activeTick) % _kTickCount;

            paint.color = activeColor.withAlpha(_alphaValues[t]);
            canvas.drawRRect(tickFundamentalRRect, paint);
            canvas.rotate(-_kTwoPI / _kTickCount);

        }

        canvas.restore();

    }

    @override
    bool shouldRepaint(_SpinnerActivityIndicatorPainter oldPainter)
    {
        return oldPainter.position != position || oldPainter.activeColor != activeColor;

    }

}