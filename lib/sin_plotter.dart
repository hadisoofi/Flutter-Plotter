import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plotter_app/function_painter.dart';

class SinPlotter extends StatelessWidget {
  final double f;  
  final double xMin = -20;
  final double xMax = 20;
  final int numOfHorGridLines = 5;
  final int numOfVerGridLines = 11;
  final int numOfXTicks = 11;
  final int numOfYTicks = 5;
  final int numOfPoints = 1000; 
  SinPlotter(this.f);

  @override
  Widget build(BuildContext context) {
    List<double> x = List.generate(numOfPoints + 1, (int i) {
      return xMin + i * (xMax - xMin) / numOfPoints;
    });
    List<double> y = List.generate(numOfPoints + 1, (int i) {
      return sin((x[i]) * f);
    });    
    return Container(
      height: 300,         
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.center,
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
