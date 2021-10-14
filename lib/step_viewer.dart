library step_viewer;

import 'package:flutter/material.dart';

class StepViewer extends StatelessWidget {
  final double stopsRadius;
  final double pathHeight;
  final double space;
  final Color stopColor;
  final Color pathColor;
  final List<String> distanceValues;
  final List<String> stopValues;

  StepViewer({
    Key key,
    @required this.distanceValues,
    @required this.stopValues,
    this.stopsRadius = 10.0,
    this.pathHeight = 2.0,
    this.space = 2.0,
    this.stopColor = Colors.deepPurple,
    this.pathColor = Colors.blue,
  })  : assert(distanceValues != null && stopValues != null,
            'distance and stop values can not be null'),
        assert(distanceValues.length < stopValues.length,
            'distance values must be less than stop values'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double distanceWidth = (constraints.maxWidth -
                (stopValues.length * stopsRadius) -
                ((stopValues.length * 2) - 2) * space) /
            (stopValues.length - 1);
        return Column(
          children: [
            Row(
                children: List.generate(distanceValues.length, (index) {
              return Expanded(
                  child: Text(
                distanceValues[index],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 10.0),
              ));
            })),
            Row(
              children: List.generate((stopValues.length * 2) - 1, (index) {
                if (index % 2 == 0) {
                  return _buildStopView(index);
                } else {
                  return _buildPathView(distanceWidth, index);
                }
              }),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(stopValues.length, (index) {
                  return Text(
                    stopValues[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 8.0,
                        fontWeight: FontWeight.w400),
                  );
                })),
          ],
        );
      },
    );
  }

  Widget _buildPathView(double distanceWidth, int index) {
    return Row(
      children: [
        Container(
          height: pathHeight,
          width: distanceWidth,
          color: pathColor,
        ),
        SizedBox(
          width: space,
        )
      ],
    );
  }

  Widget _buildStopView(int index) {
    return Row(
      children: [
        Container(
          width: stopsRadius,
          height: stopsRadius,
          decoration: BoxDecoration(shape: BoxShape.circle, color: stopColor),
        ),
        if (index != (stopValues.length * 2) - 2)
          SizedBox(
            width: space,
          )
      ],
    );
  }
}
