import 'dart:math';
import 'package:flutter/material.dart';

class DropSnow extends StatefulWidget {
  final int count;
  final Size size;

  DropSnow({Key key, @required this.count, this.size}) : super(key: key);

  @override
  State<DropSnow> createState() => _DropSnowState();
}

class _DropSnowState extends State<DropSnow>
    with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    var controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _fraction = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) controller.repeat();
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return CustomPaint(
        painter: DropSnowPainter(widget.count, _fraction),
        size: Size(widget.size?.width ?? size.maxWidth,
            widget?.size?.height ?? size.maxHeight),
      );
    });
  }
}

typedef callback = void Function();

class DropSnowPainter extends CustomPainter {
  final int _count;
  final double _fraction;

  DropSnowPainter(this._count, this._fraction);

  var _snows = List<Snow>();
  Size _recordSize;

  @override
  void paint(Canvas canvas, Size size) {
    var l = _snows.length;
    if (l != _count) {
      var snowSize = 3;

      if (l > _count) {
        for (int i = l; l > _count; l--) {
          _snows.removeAt(i);
        }
      } else {
        for (int i = l; i < _count; i++) {
          _snows.add(Snow(size, snowSize));
        }
        _recordSize = size;
      }
    }

    if (size.width != _recordSize.width || size.height != _recordSize.height) {
      for (var i in _snows) {
        i.updateSize(size);
      }
      _recordSize = size;
    }

    // canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
    //     Paint()..color = Color(0xFF000000));

    for (var i in _snows) {
      i.draw(canvas);
    }
  }

  @override
  bool shouldRepaint(DropSnowPainter oldDelegate) {
    if (oldDelegate._fraction != this._fraction) {
      this._snows = oldDelegate._snows;
      this._recordSize = oldDelegate._recordSize;
      return true;
    }
    return false;
  }
}

class Snow {
  num width;
  num height;
  num snowMaxSize;
  Random random;

  Snow(Size size, int snowMaxSize) {
    width = size.width;
    height = size.height;
    this.snowMaxSize = snowMaxSize;
    random = Random();
    initPosition();
  }

  double x = 0;
  double y = 0;
  double snowSize;
  Paint paint;

  void initPosition() {
    x = (random.nextInt(width.toInt() + 1)).toDouble();
    y = -(random.nextInt(height.toInt() + 1)).toDouble();
    snowSize = (random.nextInt(snowMaxSize + 1)).toDouble();
    var paintColor = Color.fromARGB(random.nextInt(255) + 230, 255, 255, 255);
    paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.fill;
  }

  void updateSize(Size size) {
    if (width != size.width) {
      x = x * (size.width / width);
      width = size.width;
    }

    if (height != size.height) {
      y = y * (size.height / height);
      height = size.height;
    }
  }

  void draw(Canvas canvas) {
    y += 0.4;
    canvas.drawCircle(Offset(x, y), snowSize, paint);

    if (y > height) initPosition();
  }
}
