import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final DateTime time;
  final double temperature;

  ChartData({required this.time, required this.temperature});
}

class CustomLiveLineChart extends StatelessWidget {
  final List<ChartData> dataSource;

  const CustomLiveLineChart({super.key, required this.dataSource});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      enableAxisAnimation: false,
      title: ChartTitle(text: ''),
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.hours,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: ''),
        minimum: 0,
        maximum: 100,
      ),
      series: <CartesianSeries>[
        LineSeries<ChartData, DateTime>(
          dataSource: dataSource,
          xValueMapper: (ChartData data, _) => data.time,
          yValueMapper: (ChartData data, _) => data.temperature,
          dataLabelSettings: const DataLabelSettings(isVisible: false),
          markerSettings: const MarkerSettings(isVisible: false),
        ),
      ],
    );
  }
}
