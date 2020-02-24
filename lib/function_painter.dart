import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plotter_app/rect_adaptor.dart';

class FunctionPainter extends CustomPainter {
  final List<double> x;
  final List<double> y;  
  final _numOfHorGridLines;
  final _numOfVerGridLines;
  final _numOfXTicks;
  final _numOfYTicks;

  FunctionPainter(
      this.x,
      this.y,      
      this._numOfHorGridLines,
      this._numOfVerGridLines,
      this._numOfXTicks,
      this._numOfYTicks)
      : super();

  @override
  void paint(Canvas canvas, Size size) {
    //paint the background box
    Rect bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    Paint bgPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(bgRect, bgPaint);

    // set the screen adaptor
    RectAdaptor rectAdaptor = RectAdaptor(
        minX: x.reduce(min),
        minY: y.reduce(min),
        maxX: x.reduce(max),
        maxY: y.reduce(max),
        rect: bgRect);

    // plot the grid lines
    List<Offset> verticalGridLinePoints =
        rectAdaptor.getVerticalGridPoints(_numOfVerGridLines);
    List<Offset> horizontalGridLinePoints =
        rectAdaptor.getHorizontalGridPoints(_numOfHorGridLines);
    Paint guidespaint = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    canvas.drawPoints(PointMode.lines, verticalGridLinePoints, guidespaint);
    canvas.drawPoints(PointMode.lines, horizontalGridLinePoints, guidespaint);

    // plot the x, y ticks
    List<Map<String, dynamic>> xTicks =
        rectAdaptor.getXAxisTicks(_numOfXTicks);
    List<Map<String, dynamic>> yTicks =
        rectAdaptor.getYAxisTicks(_numOfYTicks);
    String label;
    TextSpan span;
    TextPainter tp;
    Offset currentPoint;

    xTicks.forEach((Map<String, dynamic> mp) {
      label = mp['label'];
      span = new TextSpan(
          style: new TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),
          text: label);
      tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      currentPoint = mp['location'];
      tp.paint(
          canvas,
          Offset(
              currentPoint.dx - tp.width / 2, currentPoint.dy + 5));
    });
    yTicks.forEach((Map<String, dynamic> mp) {
      label = mp['label'];
      span = new TextSpan(
          style: new TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),
          text: label);
      tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      currentPoint = mp['location'];
      tp.paint(
          canvas,
          Offset(
              currentPoint.dx - tp.width - 5, currentPoint.dy - tp.height / 2));
    });   

    // plot the function
    List<double> screenX = rectAdaptor.mapXToScreen(x);
    List<double> screenY = rectAdaptor.mapYToScreen(y);
    List<Offset> points = List.generate(screenX.length, (int index) {
      return Offset(screenX[index], screenY[index]);
    });
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
