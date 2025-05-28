import 'dart:async';

import 'package:app_generator_management/models/chart/chart_data.dart';
import 'package:app_generator_management/models/chart/generator_telemetry.dart';
import 'package:app_generator_management/presentation/widgets/charts_widgets/filterable_line_chart.dart';
import 'package:app_generator_management/presentation/widgets/status_items.dart';
import 'package:flutter/material.dart';

class DashboardSceen extends StatefulWidget {
  const DashboardSceen({super.key});

  @override
  State<DashboardSceen> createState() => _DashbroadSceenState();
}

class _DashbroadSceenState extends State<DashboardSceen> {
  late List<GeneratorTelemetry> telemetryList;

  late List<ChartData> chartDataList = [];

  late List<num> data = [];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                spacing: 10.0,
                children: [
                  Expanded(
                      child: StatusItem(
                    title: "Tên node",
                    category: "Ndname",
                    amount: "100",
                    imgUrl: "png/electric-generator.png",
                  )),
                  Expanded(
                      child: StatusItem(
                    title: "Mã lỗi (0 - 255)",
                    category: "NdErrCode",
                    amount: "100",
                    imgUrl: "png/cross.png",
                  )),
                  Expanded(
                      child: StatusItem(
                          title: "Hiệu điện thế Pin18650",
                          category: "NdBatVol",
                          imgUrl: "png/lightning.png",
                          amount: "100")),
                  Expanded(
                      child: StatusItem(
                          title: "Trạng thái kết nối",
                          category: "NdCnctSts",
                          imgUrl: "png/freelance.png",
                          amount: "100")),
                  Expanded(
                      child: StatusItem(
                          title: "Trạng thái Node",
                          category: "NdEleSts",
                          imgUrl: "png/charger.png",
                          amount: "100")),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                spacing: 10.0,
                children: [
                  Expanded(
                      child: StatusItem(
                          title: "Phần trăm dầu còn trong máy (%)",
                          category: "OilLvl",
                          imgUrl: "png/gas-pump.png",
                          amount: "100")),
                  Expanded(
                      child: StatusItem(
                          title: "Áp suất dầu (PSI)",
                          category: "OilPrssr",
                          imgUrl: "png/performance.png",
                          amount: "100")),
                  Expanded(
                      child: StatusItem(
                          title: "Nhiệt độ nước làm mát (*C)",
                          category: "WtrTemp",
                          imgUrl: "png/smart.png",
                          amount: "100")),
                  Expanded(
                      child: StatusItem(
                          title: "Nhiệt độ dầu (*C)",
                          category: "OilTemp",
                          imgUrl: "png/temperature.png",
                          amount: "100")),
                  Expanded(
                      child: StatusItem(
                          title: "Tổng thời gian chạy ",
                          category: "TlRunTime",
                          imgUrl: "png/wall-clock_5378485.png",
                          amount: "100")),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: FilterableLineChart(
                  chartTitle: "Hiệu điện thế Acquy (Vol)",
                  axisTitle: "Vol",
                  fieldName: "waterTemperature",
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: FilterableLineChart(
                  chartTitle: "Hiệu điện thế nạp Acquy (Vol)",
                  axisTitle: "Vol",
                  fieldName: "waterTemperature",
                )),
                Expanded(
                  child: FilterableLineChart(
                    chartTitle: "Dòng tiêu thụ (A)",
                    axisTitle: "A",
                    fieldName: "oilTemperature",
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: FilterableLineChart(
                  chartTitle: "Điện áp lưới L1 (V)",
                  axisTitle: "V",
                  fieldName: "waterTemperature",
                )),
                Expanded(
                  child: FilterableLineChart(
                    chartTitle: "Điện áp lưới L2 (V)",
                    axisTitle: "Temp",
                    fieldName: "oilTemperature",
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: FilterableLineChart(
                  chartTitle: "Điện áp lưới L3 (V)",
                  axisTitle: "V",
                  fieldName: "waterTemperature",
                )),
                Expanded(
                  child: FilterableLineChart(
                    chartTitle: "Công suất trung bình",
                    axisTitle: "",
                    fieldName: "oilTemperature",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
