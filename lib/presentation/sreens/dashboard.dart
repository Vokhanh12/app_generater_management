import 'dart:async';

import 'package:app_generator_management/application/bloc/category_genarator_management/generator_telemetry_bloc.dart';
import 'package:app_generator_management/models/chart/chart_data.dart';
import 'package:app_generator_management/models/chart/generator_telemetry.dart';
import 'package:app_generator_management/presentation/widgets/charts_widgets/filterable_line_chart.dart';
import 'package:app_generator_management/presentation/widgets/status_items.dart';
import 'package:app_generator_management/repositories/category_genrator_repo/generator_telemytry_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  final bloc = GeneratorTelemetryBloc(
      generatorTelemetryRepo: GeneratorTelemetryRepository());

  @override
  void initState() {
    bloc.add(ListGeneratorTelemetryUpdate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider.value(
          value: bloc,
          child: BlocListener<GeneratorTelemetryBloc, GeneratorTelemetryState>(
            listener: (context, state) {
              if (state is GeneratorTelemetryUpdateSuccess ||
                  state is GeneratorTelemetryRealtimeUpdated) {
                bloc.add(ListGeneratorTelemetryIn1H());
                bloc.add(ListGeneratorTelemetryIn3H());
                bloc.add(ListGeneratorTelemetryIn1D());
                bloc.add(ListGeneratorTelemetryIn3D());
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Tên node",
                            category: "Ndname",
                            amount: "100",
                            imgUrl: "png/electric-generator.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Mã lỗi (0 - 255)",
                            category: "NdErrCode",
                            amount: "100",
                            imgUrl: "png/cross.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Hiệu điện thế Pin18650",
                            category: "NdBatVol",
                            imgUrl: "png/lightning.png",
                            amount: "100",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Trạng thái kết nối",
                            category: "NdCnctSts",
                            imgUrl: "png/freelance.png",
                            amount: "100",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Áp suất dầu (PSI)",
                            category: "OilPrssr",
                            imgUrl: "png/performance.png",
                            amount: "100",
                          ),
                        ),
                      ),
                      Expanded(
                        child: StatusItem(
                          bloc: bloc,
                          title: "Trạng thái Node",
                          category: "NdEleSts",
                          imgUrl: "png/charger.png",
                          amount: "100",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Phần trăm dầu còn trong máy (%)",
                            category: "OilLvl",
                            imgUrl: "png/gas-pump.png",
                            amount: "100",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Nhiệt độ nước làm mát (°C)",
                            category: "WtrTemp",
                            imgUrl: "png/smart.png",
                            amount: "100",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Nhiệt độ dầu (°C)",
                            category: "OilTemp",
                            imgUrl: "png/temperature.png",
                            amount: "100",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Hiệu điện thế nạp Acquy (Vol)",
                            category: "OilPrssr",
                            imgUrl: "png/lighting-1.png",
                            amount: "100",
                            fontSizeTitle: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Hiệu điện thế Acquy (Vol)",
                            imgUrl: "png/lighting-2.png",
                            category: "OilLvl",
                            amount: "100",
                            fontSizeTitle: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: StatusItem(
                          bloc: bloc,
                          title: "Tổng thời gian chạy ",
                          category: "TlRunTime",
                            imgUrl: "png/wall-clock_5378485.png",
                          amount: "100",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Dòng tiêu thụ (A)",
                            category: "WtrTemp",
                             imgUrl: "png/lightning.png", 
                            amount: "100",
                            fontSizeTitle: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Điện áp lưới L1 (V)",
                            category: "OilTemp",
                             imgUrl: "png/thunder.png", 
                            amount: "100",
                            fontSizeTitle: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Điện áp lưới L2 (V)",
                            category: "TlRunTime",
                            imgUrl: "png/thunderbolt.png", 
                            amount: "100",
                            fontSizeTitle: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Điện áp lưới L3 (V)",
                            category: "TlRunTime",
                            imgUrl: "png/ray.png", 
                            amount: "100",
                            fontSizeTitle: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: StatusItem(
                            bloc: bloc,
                            title: "Công suất trung bình",
                            category: "TlRunTime",
                            amount: "100",
                            imgUrl: "png/deep-learning.png",
                            fontSizeTitle: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: StatusItem(
                          bloc: bloc,
                          title: "Cập nhật lần cuối",
                          category: "CreateDate",
                          imgUrl: "png/schedule.png",
                          amount: "100",
                          fontSizeTitle: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilterableLineChart(
                        bloc: bloc,
                        chartTitle: "Hiệu điện thế Acquy (Vol)",
                        axisTitle: "Vol",
                        fieldName: "AqBatVol",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilterableLineChart(
                        bloc: bloc,
                        chartTitle: "Hiệu điện thế nạp Acquy (Vol)",
                        axisTitle: "Vol",
                        fieldName: "AqChrgVol",
                      ),
                    ),
                    Expanded(
                      child: FilterableLineChart(
                        bloc: bloc,
                        chartTitle: "Dòng tiêu thụ (A)",
                        axisTitle: "A",
                        fieldName: "ConsCur",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilterableLineChart(
                        bloc: bloc,
                        chartTitle: "Điện áp lưới L1 (V)",
                        axisTitle: "V",
                        fieldName: "MainL1Vol",
                      ),
                    ),
                    Expanded(
                      child: FilterableLineChart(
                        bloc: bloc,
                        chartTitle: "Điện áp lưới L2 (V)",
                        axisTitle: "V",
                        fieldName: "MainL2Vol",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilterableLineChart(
                        bloc: bloc,
                        chartTitle: "Điện áp lưới L3 (V)",
                        axisTitle: "V",
                        fieldName: "MainL3Vol",
                      ),
                    ),
                    Expanded(
                      child: FilterableLineChart(
                        bloc: bloc,
                        chartTitle: "Công suất trung bình",
                        axisTitle: "",
                        fieldName: "AvrPF",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
