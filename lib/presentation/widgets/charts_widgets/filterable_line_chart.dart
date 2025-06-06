import 'dart:math';

import 'package:app_generator_management/application/bloc/category_genarator_management/generator_telemetry_bloc.dart';
import 'package:app_generator_management/models/chart/generator_telemetry.dart';
import 'package:app_generator_management/presentation/widgets/neumophic_checkbox.dart';
import 'package:app_generator_management/repositories/category_genrator_repo/generator_telemytry_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FilterableLineChart extends StatefulWidget {
  const FilterableLineChart(
      {super.key,
      required this.fieldName,
      required this.chartTitle,
      required this.axisTitle,
      required this.bloc});

  final String fieldName;
  final String chartTitle;
  final String axisTitle;
  final GeneratorTelemetryBloc bloc;

  @override
  State<FilterableLineChart> createState() => _FilterableLineChartState();
}

class _FilterableLineChartState extends State<FilterableLineChart> {
  DateTime? dateTime;
  double _interval = 10;
  DateFormat _dateFormat = DateFormat('HH:mm');
  DateTimeIntervalType _dateTimeIntervalType = DateTimeIntervalType.minutes;
  GeneratorTelemetryType generatorTelemetryType =
      GeneratorTelemetryType.oneHour;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Builder(builder: (context) {
        return BlocBuilder<GeneratorTelemetryBloc, GeneratorTelemetryState>(
          builder: (context, state) {
            if (state is GeneratorTelemetryLoading &&
                state.type == generatorTelemetryType) {
              return CircularProgressIndicator();
            } else if (state is GeneratorTelemetryLoaded &&
                state.type == generatorTelemetryType) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SizedBox(
                                width: 280,
                                height: 25,
                                child: SecondaryTabbar(
                                  onPressed1H: () => changeMode1H(context),
                                  onPressed3H: () => changeMode3H(context),
                                  onPressed1D: () => changeMode1D(context),
                                  onPressed3D: () => changeMode3D(context),
                                  onPressed7D: () => changeMode7D(context),
                                )),
                          )),
                      SfCartesianChart(
                        plotAreaBackgroundColor: Colors.white,
                        enableAxisAnimation: false,
                        title: ChartTitle(
                            text: widget.chartTitle,
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Roboto')),
                        primaryXAxis: DateTimeAxis(
                          minimum: dateTime,
                          intervalType: _dateTimeIntervalType,
                          interval: _interval,
                          dateFormat: _dateFormat,
                        ),
                        primaryYAxis: NumericAxis(
                          title: AxisTitle(text: widget.axisTitle),
                          minimum: 0,
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        series: <CartesianSeries>[
                          LineSeries<GeneratorTelemetry, DateTime>(
                              dataSource: state.data,
                              xValueMapper: (GeneratorTelemetry data, _) =>
                                  data.createDate,
                              yValueMapper: (GeneratorTelemetry data, _) =>
                                  data.toJson()[widget.fieldName] as double,
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: false),
                              markerSettings:
                                  const MarkerSettings(isVisible: false),
                              animationDuration: 0),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }

            return Container();
          },
        );
      }),
    );
  }

  void changeMode1H(BuildContext context) {
    // _interval = 10;
    // _dateFormat = DateFormat('HH:mm');
    // _dateTimeIntervalType = DateTimeIntervalType.minutes;
    // generatorTelemetryType = GeneratorTelemetryType.oneHour;
    // context.read<GeneratorTelemetryBloc>().add(ListGeneratorTelemetryIn1H());
  }

  void changeMode3H(BuildContext context) {
    _interval = 30;
    _dateFormat = DateFormat('HH:mm');
    _dateTimeIntervalType = DateTimeIntervalType.minutes;
    generatorTelemetryType = GeneratorTelemetryType.threeHour;
    context.read<GeneratorTelemetryBloc>().add(ListGeneratorTelemetryIn3H());
  }

  void changeMode1D(BuildContext context) {
    _interval = 1;
    _dateFormat = DateFormat('HH:mm');
    _dateTimeIntervalType = DateTimeIntervalType.hours;
    generatorTelemetryType = GeneratorTelemetryType.oneDay;
    context.read<GeneratorTelemetryBloc>().add(ListGeneratorTelemetryIn1D());
  }

  void changeMode3D(BuildContext context) {
    _interval = 1;
    _dateFormat = DateFormat('MM/dd');
    _dateTimeIntervalType = DateTimeIntervalType.days;
    generatorTelemetryType = GeneratorTelemetryType.threeDays;
    context.read<GeneratorTelemetryBloc>().add(ListGeneratorTelemetryIn3D());
    print("3d");
  }

  void changeMode7D(BuildContext context) {
    _interval = 1;
    _dateFormat = DateFormat('MM/dd');
    _dateTimeIntervalType = DateTimeIntervalType.days;
    generatorTelemetryType = GeneratorTelemetryType.sevenDays;
    context.read<GeneratorTelemetryBloc>().add(ListGeneratorTelemetryIn7D());
  }
}

class SecondaryTabbar extends StatefulWidget {
  final double radius;
  final VoidCallback onPressed1H;
  final VoidCallback onPressed3H;
  final VoidCallback onPressed1D;
  final VoidCallback onPressed3D;
  final VoidCallback onPressed7D;
  const SecondaryTabbar(
      {super.key,
      this.radius = 0,
      required this.onPressed1H,
      required this.onPressed3H,
      required this.onPressed1D,
      required this.onPressed3D,
      required this.onPressed7D});

  @override
  _SecondaryTabbarState createState() => _SecondaryTabbarState();
}

class _SecondaryTabbarState extends State<SecondaryTabbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                '1H',
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                  width: 20,
                  height: 20,
                  child: NeumorphicCheckBox(
                    isSelected: false,
                    onTap: () => widget.onPressed1H(),
                  ))
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                '3H',
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                  width: 20,
                  height: 20,
                  child: NeumorphicCheckBox(
                    isSelected: false,
                    onTap: () => widget.onPressed3H(),
                  ))
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                '1D',
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                  width: 20,
                  height: 20,
                  child: NeumorphicCheckBox(
                    isSelected: false,
                    onTap: () => widget.onPressed1D(),
                  ))
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                '3D',
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                  width: 20,
                  height: 20,
                  child: NeumorphicCheckBox(
                    isSelected: false,
                    onTap: () => widget.onPressed3D(),
                  ))
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                '7D',
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                  width: 20,
                  height: 20,
                  child: NeumorphicCheckBox(
                    isSelected: false,
                    onTap: () => widget.onPressed7D(),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
