import 'package:app_generator_management/application/bloc/category_genarator_management/generator_telemetry_bloc.dart';
import 'package:app_generator_management/models/chart/generator_telemetry.dart';
import 'package:app_generator_management/presentation/widgets/neumophic_checkbox.dart';
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
  double _interval = 10;
  DateFormat _dateFormat = DateFormat('HH:mm');
  DateTimeIntervalType _dateTimeIntervalType = DateTimeIntervalType.minutes;
  GeneratorTelemetryType generatorTelemetryType =
      GeneratorTelemetryType.oneHour;
  List<GeneratorTelemetry> generatorTelemetries = [];
  List<GeneratorTelemetry> defaultGeneratorTelemetries = [
    GeneratorTelemetry(
      id: 'none',
      aqBatVol: 0,
      aqChrgVol: 0,
      consCur: 0,
      mainL1Vol: 0,
      mainL2Vol: 0,
      mainL3Vol: 0,
      avrPF: 0,
      oilLvl: 0,
      oilPrssr: 0,
      wtrTemp: 0,
      oilTemp: 0,
      tlRunTime: 0,
      ndname: 'No data',
      ndErrCode: 0,
      ndBatVol: 0,
      ndCnctSts: 0,
      ndEleSts: false,
      createDate: DateTime.now(),
    ),
    GeneratorTelemetry(
      id: 'none',
      aqBatVol: 0,
      aqChrgVol: 0,
      consCur: 0,
      mainL1Vol: 0,
      mainL2Vol: 0,
      mainL3Vol: 0,
      avrPF: 0,
      oilLvl: 0,
      oilPrssr: 0,
      wtrTemp: 0,
      oilTemp: 0,
      tlRunTime: 0,
      ndname: 'none',
      ndErrCode: 0,
      ndBatVol: 0,
      ndCnctSts: 0,
      ndEleSts: false,
      createDate: DateTime.now().subtract(Duration(seconds: 1)),
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Builder(builder: (context) {
        return BlocListener<GeneratorTelemetryBloc, GeneratorTelemetryState>(
            listener: (context, state) {
              if (state is GeneratorTelemetryLoaded &&
                  state.type == generatorTelemetryType) {
                  setState(() {
                    generatorTelemetries = state.data;
                  });
              }
            },
            child: Padding(
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
                    SizedBox(
                      height: 300,
                      child: SfCartesianChart(
                        plotAreaBackgroundColor: Colors.white,
                        enableAxisAnimation: false,
                        title: ChartTitle(
                            text: widget.chartTitle,
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Roboto')),
                        primaryXAxis: DateTimeAxis(
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
                              dataSource: (generatorTelemetries.length > 2) ? generatorTelemetries : defaultGeneratorTelemetries,
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
                      ),
                    )
                  ],
                ),
              ),
            ));
      }),
    );
  }

  void changeMode1H(BuildContext context) {
    _interval = 10;
    _dateFormat = DateFormat('HH:mm');
    _dateTimeIntervalType = DateTimeIntervalType.minutes;
    generatorTelemetryType = GeneratorTelemetryType.oneHour;
    context.read<GeneratorTelemetryBloc>().add(ListGeneratorTelemetryIn1H());
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

  const SecondaryTabbar({
    super.key,
    this.radius = 0,
    required this.onPressed1H,
    required this.onPressed3H,
    required this.onPressed1D,
    required this.onPressed3D,
    required this.onPressed7D,
  });

  @override
  _SecondaryTabbarState createState() => _SecondaryTabbarState();
}

class _SecondaryTabbarState extends State<SecondaryTabbar> {
  int selectedIndex = -1;

  void _handleTap(int index, VoidCallback callback) {
    setState(() {
      selectedIndex = (selectedIndex == index) ? -1 : index;
    });
    callback();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab("1H", 0, widget.onPressed1H),
        _buildTab("3H", 1, widget.onPressed3H),
        _buildTab("1D", 2, widget.onPressed1D),
        _buildTab("3D", 3, widget.onPressed3D),
        _buildTab("7D", 4, widget.onPressed7D),
      ],
    );
  }

  Widget _buildTab(String label, int index, VoidCallback callback) {
    return Expanded(
      child: Row(
        children: [
          Text(label),
          const SizedBox(width: 5),
          SizedBox(
            width: 20,
            height: 20,
            child: NeumorphicCheckBox(
              isSelected: selectedIndex == index,
              onTap: () => _handleTap(index, callback),
            ),
          ),
        ],
      ),
    );
  }
}
