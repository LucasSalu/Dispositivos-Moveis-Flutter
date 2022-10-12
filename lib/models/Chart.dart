import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  ChartState createState() {
    return ChartState();
  }
}

class ChartState extends State<Chart> {
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Grafico 1'),
        Container(
          child: Container(
            color: Colors.red,
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: BezierChart(

              bezierChartScale: BezierChartScale.CUSTOM,
              xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
              series: const [
                BezierLine(
                  label: "Grafico 1",
                  data: const [
                    DataPoint<double>(value: 10, xAxis: 0),
                    DataPoint<double>(value: 130, xAxis: 5),
                    DataPoint<double>(value: 50, xAxis: 10),
                    DataPoint<double>(value: 150, xAxis: 15),
                    DataPoint<double>(value: 75, xAxis: 20),
                    DataPoint<double>(value: 0, xAxis: 25),
                    DataPoint<double>(value: 5, xAxis: 30),
                    DataPoint<double>(value: 45, xAxis: 35),
                  ],
                ),
                BezierLine(
                  label: "Grafico 2",
                  lineColor: Colors.black,
                  data: const [
                    DataPoint<double>(value: 20, xAxis: 0),
                    DataPoint<double>(value: 140, xAxis: 5),
                    DataPoint<double>(value: 60, xAxis: 10),
                    DataPoint<double>(value: 110, xAxis: 15),
                    DataPoint<double>(value: 55, xAxis: 20),
                    DataPoint<double>(value: 1, xAxis: 25),
                    DataPoint<double>(value: 22, xAxis: 30),
                    DataPoint<double>(value: 33, xAxis: 35),
                  ],
                ),
              ],
              config: BezierChartConfig(
                verticalIndicatorStrokeWidth: 3.0,
                verticalIndicatorColor: Colors.black26,
                showVerticalIndicator: true,
                backgroundColor: Colors.red,
                snap: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget sample1(BuildContext context) {
  return Center(
    child: Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width * 0.9,
      child: BezierChart(
        bezierChartScale: BezierChartScale.CUSTOM,
        xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
        series: const [
          BezierLine(
            data: const [
              DataPoint<double>(value: 10, xAxis: 0),
              DataPoint<double>(value: 130, xAxis: 5),
              DataPoint<double>(value: 50, xAxis: 10),
              DataPoint<double>(value: 150, xAxis: 15),
              DataPoint<double>(value: 75, xAxis: 20),
              DataPoint<double>(value: 0, xAxis: 25),
              DataPoint<double>(value: 5, xAxis: 30),
              DataPoint<double>(value: 45, xAxis: 35),
            ],
          ),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          backgroundColor: Colors.red,
          snap: false,
        ),
      ),
    ),
  );
}
