import 'dart:ui';

import 'package:flutter/material.dart';

class RectAdaptor {
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final Rect rect;

  RectAdaptor({
    @required this.minX,
    @required this.minY,
    @required this.maxX,
    @required this.maxY,
    @required this.rect,
  });

  List<double> mapXToScreen(List<double> x) {
    List<double> screenX;
    double coeff = (rect.right - rect.left) / (maxX - minX);
    screenX = x.map((double item) {
      return rect.left + (item - minX) * coeff;
    }).toList();
    return screenX;
  }

  List<double> mapYToScreen(List<double> y) {
    List<double> screenY;
    double coeff = (rect.top - rect.bottom) / (maxY - minY);
    screenY = y.map((double item) {
      return rect.bottom + (item - minY) * coeff;
    }).toList();
    return screenY;
  }

  List<Offset> getVerticalGridPoints([int numOfLines = 5]) {
    double deltaX = (maxX - minX) / (numOfLines - 1);
    List<double> gridX = List.generate(numOfLines, (int index) {
      return index * deltaX + minX;
    });
    List<double> gridY = [minY, maxY];
    List<double> screenGridX = mapXToScreen(gridX);
    List<double> screenGridY = mapYToScreen(gridY);
    List<Offset> verticalGridLinePoints = [];
    screenGridX.forEach((double val) {
      verticalGridLinePoints.add(Offset(val, screenGridY[0]));
      verticalGridLinePoints.add(Offset(val, screenGridY[1]));
    });
    return verticalGridLinePoints;
  }

  List<Offset> getHorizontalGridPoints([int numOfLines = 5]) {
    double deltaY = (maxY - minY) / (numOfLines - 1);
    List<double> gridX = [minX, maxX];
    List<double> gridY = List.generate(numOfLines, (int index) {
      return index * deltaY + minY;
    });
    List<double> screenGridX = mapXToScreen(gridX);
    List<double> screengridY = mapYToScreen(gridY);
    List<Offset> horizontalGridLinePoints = [];
    screengridY.forEach((double val) {
      horizontalGridLinePoints.add(Offset(screenGridX[0], val));
      horizontalGridLinePoints.add(Offset(screenGridX[1], val));
    });
    return horizontalGridLinePoints;
  }

  List<Map<String, dynamic>> getXAxisTicks(int numOfTicks) {
    List<Map<String, dynamic>> xAxisTicks = [];
    double deltaX = (maxX - minX) / (numOfTicks - 1);
    List<double> tickX = List.generate(numOfTicks, (int index) {
      return index * deltaX + minX;
    });
    List<double> screenTickX = mapXToScreen(tickX);    
    xAxisTicks = List.generate(screenTickX.length, (int index) {
      return {
        'label': tickX[index].toStringAsFixed(1),
        'location': Offset(screenTickX[index], rect.bottom),
      };
    });
    return xAxisTicks;
  }

  List<Map<String, dynamic>> getYAxisTicks(int numOfTicks) {
    List<Map<String, dynamic>> yAxisTicks = [];
    double deltaY = (maxY - minY) / (numOfTicks - 1);
    List<double> tickY = List.generate(numOfTicks, (int index) {
      return index * deltaY + minY;
    });
    List<double> screenTickY = mapYToScreen(tickY);    
    yAxisTicks = List.generate(screenTickY.length, (int index) {
      return {
        'label': tickY[index].toStringAsFixed(1),
        'location': Offset(rect.left, screenTickY[index]),
      };
    });
    return yAxisTicks;
  }
}