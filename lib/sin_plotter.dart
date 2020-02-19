import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plotter_app/function_painter.dart';

class SinPlotter extends StatefulWidget {
  final double f;
  SinPlotter(this.f);

  @override
  _SinPlotterState createState() => _SinPlotterState();
}

class _SinPlotterState extends State<SinPlotter> {
  List<double> x;
  List<double> y;
  final int numOfHorGridLines = 5;
  final int numOfVerGridLines = 11;
  final int numOfXTicks = 11;
  final int numOfYTicks = 5;
  final int numOfPoints = 1000;
  final double xMin = -20;
  final double xMax = 20;

  

  @override
  Widget build(BuildContext context) {
    x = List.generate(numOfPoints + 1, (int i) {
      return xMin + i * (xMax - xMin) / numOfPoints;
    });
    y = List.generate(numOfPoints + 1, (int i) {
      return sin((x[i]) * widget.f);
    });    
    return Container(
      height: 300,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.topCenter,
            child: CustomPaint(
              foregroundPainter: FunctionPainter(
                  x,
                  y,                  
                  numOfHorGridLines,
                  numOfVerGridLines,
                  numOfXTicks,
                  numOfYTicks),
              child: Container(
                width: constraints.maxWidth * 0.8,
                height: constraints.maxHeight * 0.8,
              ),
            ),
          );
        },
      ),
    );
  }
}
