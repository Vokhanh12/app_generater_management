import 'package:app_generator_management/application/bloc/category_genarator_management/generator_telemetry_bloc.dart';
import 'package:app_generator_management/models/chart/generator_telemetry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusItem extends StatelessWidget {
  final String title;
  final String? category;
  final String amount;
  final String? imgUrl;
  final GeneratorTelemetryBloc bloc;

  

  const StatusItem(
      {super.key,
      required this.title,
      this.category,
      required this.amount,
      this.imgUrl,
      required this.bloc,
      });

  @override
  Widget build(BuildContext context) {

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



    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<GeneratorTelemetryBloc, GeneratorTelemetryState>(
        builder: (context, state) {
          if (state is GeneratorTelemetryLoaded) {
          List<GeneratorTelemetry> list;
          if (state.data.length != 0) {
            list = state.data;
          } else {
            list = defaultGeneratorTelemetries;
          }

          GeneratorTelemetry data = list
                .reduce((a, b) => a.createDate.isAfter(b.createDate) ? a : b);

            return Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.05),
                    offset: const Offset(-10, -10),
                    spreadRadius: 0,
                    blurRadius: 10),
              ]),
              child: Row(
                children: [
                  SizedBox(
                      height: 60,
                      width: 60,
                      child: NeumorphicCircle(
                        innerShadow: false,
                        outerShadow: true,
                        backgroundColor: Colors.white,
                        shadowColor: Colors.white,
                        highlightColor: Colors.white.withOpacity(0.05),
                        child: Image.asset(imgUrl ?? 'none',
                            width: 50, height: 50),
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      (data?.toJson()[category] == null)
                          ? const SizedBox.shrink()
                          : Text(data!.toJson()[category].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))
                    ],
                  )),
                  Text(amount,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600))
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class NeumorphicCircle extends StatelessWidget {
  final bool innerShadow;
  final bool outerShadow;
  final Color highlightColor;
  final Color shadowColor;
  final Color backgroundColor;
  final Widget? child;

  const NeumorphicCircle(
      {super.key,
      required this.innerShadow,
      required this.outerShadow,
      required this.highlightColor,
      required this.shadowColor,
      required this.backgroundColor,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: (outerShadow)
                  ? [
                      BoxShadow(
                          color: highlightColor,
                          offset: const Offset(-10, -10),
                          blurRadius: 20,
                          spreadRadius: 0),
                      BoxShadow(
                          color: shadowColor,
                          offset: const Offset(10, 10),
                          blurRadius: 20,
                          spreadRadius: 0)
                    ]
                  : null)),
      (innerShadow)
          ? ClipPath(
              clipper: HighlightClipper(),
              child: CircleInnerHighlight(
                highlightColor: highlightColor,
                backgroundColor: backgroundColor,
              ))
          : const SizedBox.shrink(),
      (innerShadow)
          ? ClipPath(
              clipper: ShadowClipper(),
              child: CircleInnerShadow(
                shadowColor: shadowColor,
                backgroundColor: backgroundColor,
              ),
            )
          : const SizedBox.shrink(),
      (child != null) ? child! : const SizedBox.shrink()
    ]);
  }
}

class CircleInnerShadow extends StatelessWidget {
  final Color shadowColor;
  final Color backgroundColor;

  const CircleInnerShadow(
      {super.key, required this.shadowColor, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            backgroundColor,
            shadowColor,
          ],
          center: const AlignmentDirectional(0.05, 0.05),
          focal: const AlignmentDirectional(0, 0),
          radius: 0.5,
          focalRadius: 0,
          stops: const [0.75, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 0.45],
                colors: [backgroundColor.withOpacity(0), backgroundColor])),
      ),
    );
  }
}

class CircleInnerHighlight extends StatelessWidget {
  final Color highlightColor;
  final Color backgroundColor;

  const CircleInnerHighlight(
      {super.key, required this.highlightColor, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            backgroundColor,
            highlightColor,
          ],
          center: const AlignmentDirectional(-0.05, -0.05),
          focal: const AlignmentDirectional(-0.05, -0.05),
          radius: 0.6,
          focalRadius: 0.1,
          stops: const [0.75, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.55, 1],
                colors: [backgroundColor, backgroundColor.withOpacity(0)])),
      ),
    );
  }
}

class ShadowClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
}

class HighlightClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }
}
