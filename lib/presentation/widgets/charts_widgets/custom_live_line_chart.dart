import 'package:app_generator_management/models/chart/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomLiveLineChart extends StatelessWidget {
  final List<ChartData> dataSource;

  const CustomLiveLineChart({super.key, required this.dataSource});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      enableAxisAnimation: false,
      title: ChartTitle(text: 'Title'),
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.hours,
        interval: 3,
        dateFormat: DateFormat('MM/dd\nHH:mm'),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        minimum: DateTime.now().subtract(Duration(days: 7)),
        maximum: DateTime.now(),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Title1'),
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
