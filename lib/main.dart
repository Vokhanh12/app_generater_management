import 'package:app_generator_management/core/app/app.dart';
import 'package:app_generator_management/core/firebase_options/firebase_options.dart';
import 'package:app_generator_management/core/observer/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // it won't work for some emulators.
  // change emulators or use physical device.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  Bloc.observer = NibblesBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // if (!kIsWeb) {
  //   await setupFlutterNotifications();
  // }
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: LiveLineChart(),
//     );
//   }
// }

// class ChartData {
//   final DateTime time;
//   final double temperature;

//   ChartData(this.time, this.temperature);
// }

// class LiveLineChart extends StatefulWidget {
//   const LiveLineChart({super.key});

//   @override
//   State<LiveLineChart> createState() => _LiveLineChartState();
// }

// class _LiveLineChartState extends State<LiveLineChart> {
//   late Timer timer;
//   List<ChartData> chartData = [];
//   final Random random = Random();

//   @override
//   void initState() {
//     super.initState();

//     chartData.add(ChartData(DateTime.now(), _generateRandomTemperature()));

//     timer = Timer.periodic(const Duration(milliseconds: 2000), (Timer t) {
//       setState(() {
//         chartData.add(
//           ChartData(DateTime.now(), _generateRandomTemperature()),
//         );
//       });
//     });
//   }

//   double _generateRandomTemperature() {
//     return 26 + random.nextDouble() * 10; // Giả lập khoảng 26 - 31 °C
//   }

//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('')),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: MediaQuery.sizeOf(context).width / 3.5,
//                   height: MediaQuery.sizeOf(context).height / 2.5,
//                   child: SfSparkAreaChart(
//                     // Dữ liệu mẫu cho biểu đồ
//                     data: [10, 20, 30, 40, 35, 50, 45, 60, 70, 65, 80],
//                     // Định nghĩa màu sắc cho khu vực
//                     color: Colors.blue.withOpacity(0.5),
//                     // Đặt độ rộng đường viền
//                     borderWidth: 2,
//                     // Màu sắc đường viền
//                     borderColor: Colors.blue,
//                     // Màu sắc trục
//                     axisLineColor: Colors.grey,
//                     // Định nghĩa độ rộng trục
//                     axisLineWidth: 1,
//                     // Chỉ định kiểu đường trục chấm
//                     axisLineDashArray: [5, 5],
//                     // Định nghĩa màu sắc cho điểm cao nhất
//                     highPointColor: Colors.red,
//                     // Đảo ngược các trục nếu cần
//                     isInversed: false,
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.sizeOf(context).width / 3.5,
//                   height: MediaQuery.sizeOf(context).height / 2.5,
//                   child: SfCartesianChart(
//                     enableAxisAnimation: false,
//                     title: ChartTitle(text: ''),
//                     primaryXAxis: DateTimeAxis(
//                       intervalType: DateTimeIntervalType.seconds,
//                       edgeLabelPlacement: EdgeLabelPlacement.shift,
//                     ),
//                     primaryYAxis: NumericAxis(
//                       title: AxisTitle(text: ''),
//                       minimum: 25,
//                       maximum: 40,
//                     ),
//                     series: <CartesianSeries>[
//                       LineSeries<ChartData, DateTime>(
//                         dataSource: chartData,
//                         xValueMapper: (ChartData data, _) => data.time,
//                         yValueMapper: (ChartData data, _) => data.temperature,
//                         dataLabelSettings:
//                             const DataLabelSettings(isVisible: false),
//                         markerSettings: const MarkerSettings(isVisible: false),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: MediaQuery.sizeOf(context).width / 3.5,
//                   height: MediaQuery.sizeOf(context).height / 2.5,
//                   child: SfCartesianChart(
//                     enableAxisAnimation: false,
//                     title: ChartTitle(text: ''),
//                     primaryXAxis: DateTimeAxis(
//                       intervalType: DateTimeIntervalType.seconds,
//                       edgeLabelPlacement: EdgeLabelPlacement.shift,
//                     ),
//                     primaryYAxis: NumericAxis(
//                       title: AxisTitle(text: ''),
//                       minimum: 25,
//                       maximum: 40,
//                     ),
//                     series: <CartesianSeries>[
//                       LineSeries<ChartData, DateTime>(
//                         dataSource: chartData,
//                         xValueMapper: (ChartData data, _) => data.time,
//                         yValueMapper: (ChartData data, _) => data.temperature,
//                         dataLabelSettings:
//                             const DataLabelSettings(isVisible: false),
//                         markerSettings: const MarkerSettings(isVisible: false),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.sizeOf(context).width / 3.5,
//                   height: MediaQuery.sizeOf(context).height / 2.5,
//                   child: SfCartesianChart(
//                     enableAxisAnimation: false,
//                     title: ChartTitle(text: ''),
//                     primaryXAxis: DateTimeAxis(
//                       intervalType: DateTimeIntervalType.seconds,
//                       edgeLabelPlacement: EdgeLabelPlacement.shift,
//                     ),
//                     primaryYAxis: NumericAxis(
//                       title: AxisTitle(text: ''),
//                       minimum: 25,
//                       maximum: 40,
//                     ),
//                     series: <CartesianSeries>[
//                       LineSeries<ChartData, DateTime>(
//                         dataSource: chartData,
//                         xValueMapper: (ChartData data, _) => data.time,
//                         yValueMapper: (ChartData data, _) => data.temperature,
//                         dataLabelSettings:
//                             const DataLabelSettings(isVisible: false),
//                         markerSettings: const MarkerSettings(isVisible: false),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.sizeOf(context).width / 3.5,
//                   height: MediaQuery.sizeOf(context).height / 2.5,
//                   child: SfCartesianChart(
//                     enableAxisAnimation: false,
//                     title: ChartTitle(text: ''),
//                     primaryXAxis: DateTimeAxis(
//                       intervalType: DateTimeIntervalType.seconds,
//                       edgeLabelPlacement: EdgeLabelPlacement.shift,
//                     ),
//                     primaryYAxis: NumericAxis(
//                       title: AxisTitle(text: ''),
//                       minimum: 25,
//                       maximum: 40,
//                     ),
//                     series: <CartesianSeries>[
//                       LineSeries<ChartData, DateTime>(
//                         dataSource: chartData,
//                         xValueMapper: (ChartData data, _) => data.time,
//                         yValueMapper: (ChartData data, _) => data.temperature,
//                         dataLabelSettings:
//                             const DataLabelSettings(isVisible: false),
//                         markerSettings: const MarkerSettings(isVisible: false),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: MediaQuery.sizeOf(context).width / 3.5,
//                   height: MediaQuery.sizeOf(context).height / 2.5,
//                   child: SfCartesianChart(
//                     enableAxisAnimation: false,
//                     title: ChartTitle(text: ''),
//                     primaryXAxis: DateTimeAxis(
//                       intervalType: DateTimeIntervalType.seconds,
//                       edgeLabelPlacement: EdgeLabelPlacement.shift,
//                     ),
//                     primaryYAxis: NumericAxis(
//                       title: AxisTitle(text: ''),
//                       minimum: 25,
//                       maximum: 40,
//                     ),
//                     series: <CartesianSeries>[
//                       LineSeries<ChartData, DateTime>(
//                         dataSource: chartData,
//                         xValueMapper: (ChartData data, _) => data.time,
//                         yValueMapper: (ChartData data, _) => data.temperature,
//                         dataLabelSettings:
//                             const DataLabelSettings(isVisible: false),
//                         markerSettings: const MarkerSettings(isVisible: false),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.sizeOf(context).width / 3.5,
//                   height: MediaQuery.sizeOf(context).height / 2.5,
//                   child: SfCartesianChart(
//                     enableAxisAnimation: false,
//                     title: ChartTitle(text: ''),
//                     primaryXAxis: DateTimeAxis(
//                       intervalType: DateTimeIntervalType.seconds,
//                       edgeLabelPlacement: EdgeLabelPlacement.shift,
//                     ),
//                     primaryYAxis: NumericAxis(
//                       title: AxisTitle(text: ''),
//                       minimum: 25,
//                       maximum: 40,
//                     ),
//                     series: <CartesianSeries>[
//                       LineSeries<ChartData, DateTime>(
//                         dataSource: chartData,
//                         xValueMapper: (ChartData data, _) => data.time,
//                         yValueMapper: (ChartData data, _) => data.temperature,
//                         dataLabelSettings:
//                             const DataLabelSettings(isVisible: false),
//                         markerSettings: const MarkerSettings(isVisible: false),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.sizeOf(context).width / 3.5,
//                   height: MediaQuery.sizeOf(context).height / 2.5,
//                   child: SfCartesianChart(
//                     enableAxisAnimation: false,
//                     title: ChartTitle(text: ''),
//                     primaryXAxis: DateTimeAxis(
//                       intervalType: DateTimeIntervalType.seconds,
//                       edgeLabelPlacement: EdgeLabelPlacement.shift,
//                     ),
//                     primaryYAxis: NumericAxis(
//                       title: AxisTitle(text: ''),
//                       minimum: 25,
//                       maximum: 40,
//                     ),
//                     series: <CartesianSeries>[
//                       LineSeries<ChartData, DateTime>(
//                         dataSource: chartData,
//                         xValueMapper: (ChartData data, _) => data.time,
//                         yValueMapper: (ChartData data, _) => data.temperature,
//                         dataLabelSettings:
//                             const DataLabelSettings(isVisible: false),
//                         markerSettings: const MarkerSettings(isVisible: false),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: MediaQuery.sizeOf(context).width / 3.5,
//                   height: MediaQuery.sizeOf(context).height / 2.5,
//                   child: SfCartesianChart(
//                     enableAxisAnimation: false,
//                     title: ChartTitle(text: ''),
//                     primaryXAxis: DateTimeAxis(
//                       intervalType: DateTimeIntervalType.seconds,
//                       edgeLabelPlacement: EdgeLabelPlacement.shift,
//                     ),
//                     primaryYAxis: NumericAxis(
//                       title: AxisTitle(text: ''),
//                       minimum: 25,
//                       maximum: 40,
//                     ),
//                     series: <CartesianSeries>[
//                       LineSeries<ChartData, DateTime>(
//                         dataSource: chartData,
//                         xValueMapper: (ChartData data, _) => data.time,
//                         yValueMapper: (ChartData data, _) => data.temperature,
//                         dataLabelSettings:
//                             const DataLabelSettings(isVisible: false),
//                         markerSettings: const MarkerSettings(isVisible: false),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
