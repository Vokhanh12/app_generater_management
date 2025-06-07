import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class GeneratorTelemetry extends Equatable {
  final String id;

  final double aqBatVol;
  final double aqChrgVol;
  final double consCur;
  final double mainL1Vol;
  final double mainL2Vol;
  final double mainL3Vol;
  final double avrPF;

  final double oilLvl;
  final double oilPrssr;
  final double wtrTemp;
  final double oilTemp;
  final int tlRunTime;

  final String ndname;
  final int ndErrCode;
  final double ndBatVol;
  final double ndCnctSts;
  final bool ndEleSts;

  final DateTime createDate;

  const GeneratorTelemetry({
    required this.id,
    required this.aqBatVol,
    required this.aqChrgVol,
    required this.consCur,
    required this.mainL1Vol,
    required this.mainL2Vol,
    required this.mainL3Vol,
    required this.avrPF,
    required this.oilLvl,
    required this.oilPrssr,
    required this.wtrTemp,
    required this.oilTemp,
    required this.tlRunTime,
    required this.ndname,
    required this.ndErrCode,
    required this.ndBatVol,
    required this.ndCnctSts,
    required this.ndEleSts,
    required this.createDate,
  });

  @override
  List<Object?> get props => [
        id,
        aqBatVol,
        aqChrgVol,
        consCur,
        mainL1Vol,
        mainL2Vol,
        mainL3Vol,
        avrPF,
        oilLvl,
        oilPrssr,
        wtrTemp,
        oilTemp,
        tlRunTime,
        ndname,
        ndErrCode,
        ndBatVol,
        ndCnctSts,
        ndEleSts,
        createDate,
      ];

  factory GeneratorTelemetry.fromMap(String id, Map<String, dynamic> map) {
    return GeneratorTelemetry(
      id: id,
      aqBatVol: (map['AqBatVol'] ?? 0).toDouble(),
      aqChrgVol: (map['AqChrgVol'] ?? 0).toDouble(),
      consCur: (map['ConsCur'] ?? 0).toDouble(),
      mainL1Vol: (map['MainL1Vol'] ?? 0).toDouble(),
      mainL2Vol: (map['MainL2Vol'] ?? 0).toDouble(),
      mainL3Vol: (map['MainL3Vol'] ?? 0).toDouble(),
      avrPF: (map['AvrPF'] ?? 0).toDouble(),
      oilLvl: (map['OilLvl'] ?? 0).toDouble(),
      oilPrssr: (map['OilPrssr'] ?? 0).toDouble(),
      wtrTemp: (map['WtrTemp'] ?? 0).toDouble(),
      oilTemp: (map['OilTemp'] ?? 0).toDouble(),
      tlRunTime: (map['TlRunTime'] ?? 0).toInt(),
      ndname: (map['Ndname'] ?? '').toString(),
      ndErrCode: (map['NdErrCode'] ?? 0).toInt(),
      ndBatVol: (map['NdBatVol'] ?? 0).toDouble(),
      ndCnctSts: (map['NdCnctSts'] ?? 0).toDouble(),
      ndEleSts: map['NdEleSts'] is bool
          ? map['NdEleSts']
          : map['NdEleSts'] == 1, // nếu int 1 thì true
      createDate: _parseDate(map['CreateDate']),
    );
  }

  factory GeneratorTelemetry.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GeneratorTelemetry(
      id: doc.id,
      aqBatVol: (data['AqBatVol'] ?? 0).toDouble(),
      aqChrgVol: (data['AqChrgVol'] ?? 0).toDouble(),
      consCur: (data['ConsCur'] ?? 0).toDouble(),
      mainL1Vol: (data['MainL1Vol'] ?? 0).toDouble(),
      mainL2Vol: (data['MainL2Vol'] ?? 0).toDouble(),
      mainL3Vol: (data['MainL3Vol'] ?? 0).toDouble(),
      avrPF: (data['AvrPF'] ?? 0).toDouble(),
      oilLvl: (data['OilLvl'] ?? 0).toDouble(),
      oilPrssr: (data['OilPrssr'] ?? 0).toDouble(),
      wtrTemp: (data['WtrTemp'] ?? 0).toDouble(),
      oilTemp: (data['OilTemp'] ?? 0).toDouble(),
      tlRunTime: (data['TlRunTime'] ?? 0).toInt(),
      ndname: (data['Ndname'] ?? '').toString(),
      ndErrCode: (data['NdErrCode'] ?? 0).toInt(),
      ndBatVol: (data['NdBatVol'] ?? 0).toDouble(),
      ndCnctSts: (data['NdCnctSts'] ?? 0).toDouble(),
      ndEleSts: data['NdEleSts'] is bool ? data['NdEleSts'] : false,
      createDate: (data['CreateDate'] is Timestamp)
          ? (data['CreateDate'] as Timestamp).toDate()
          : _parseDate(data['CreateDate']),
    );
  }

  factory GeneratorTelemetry.fromJson(Map<String, dynamic> json) {
    return GeneratorTelemetry(
      id: json['id'] ?? '',
      aqBatVol: (json['AqBatVol'] ?? 0).toDouble(),
      aqChrgVol: (json['AqChrgVol'] ?? 0).toDouble(),
      consCur: (json['ConsCur'] ?? 0).toDouble(),
      mainL1Vol: (json['MainL1Vol'] ?? 0).toDouble(),
      mainL2Vol: (json['MainL2Vol'] ?? 0).toDouble(),
      mainL3Vol: (json['MainL3Vol'] ?? 0).toDouble(),
      avrPF: (json['AvrPF'] ?? 0).toDouble(),
      oilLvl: (json['OilLvl'] ?? 0).toDouble(),
      oilPrssr: (json['OilPrssr'] ?? 0).toDouble(),
      wtrTemp: (json['WtrTemp'] ?? 0).toDouble(),
      oilTemp: (json['OilTemp'] ?? 0).toDouble(),
      tlRunTime: (json['TlRunTime'] ?? 0).toInt(),
      ndname: (json['Ndname'] ?? '').toString(),
      ndErrCode: (json['NdErrCode'] ?? 0).toInt(),
      ndBatVol: (json['NdBatVol'] ?? 0).toDouble(),
      ndCnctSts: (json['NdCnctSts'] ?? 0).toDouble(),
      ndEleSts: json['NdEleSts'] is bool ? json['NdEleSts'] : false,
      createDate: _parseDate(json['CreateDate']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'AqBatVol': aqBatVol,
        'AqChrgVol': aqChrgVol,
        'ConsCur': consCur,
        'MainL1Vol': mainL1Vol,
        'MainL2Vol': mainL2Vol,
        'MainL3Vol': mainL3Vol,
        'AvrPF': avrPF,
        'OilLvl': oilLvl,
        'OilPrssr': oilPrssr,
        'WtrTemp': wtrTemp,
        'OilTemp': oilTemp,
        'TlRunTime': tlRunTime,
        'Ndname': ndname,
        'NdErrCode': ndErrCode,
        'NdBatVol': ndBatVol,
        'NdCnctSts': ndCnctSts,
        'NdEleSts': ndEleSts,
        'CreateDate': DateFormat("dd/MM/yyyy-HH:mm:ss").format(createDate),
      };

  static DateTime _parseDate(String? value) {
    if (value == null || value.isEmpty) return DateTime(2000);
    try {
      return DateFormat("dd/MM/yyyy-HH:mm:ss").parse(value);
    } catch (e) {
      return DateTime(2000);
    }
  }

  GeneratorTelemetry copyWith({
    String? id,
    double? aqBatVol,
    double? aqChrgVol,
    double? consCur,
    double? mainL1Vol,
    double? mainL2Vol,
    double? mainL3Vol,
    double? avrPF,
    double? oilLvl,
    double? oilPrssr,
    double? wtrTemp,
    double? oilTemp,
    int? tlRunTime,
    String? ndname,
    int? ndErrCode,
    double? ndBatVol,
    double? ndCnctSts,
    bool? ndEleSts,
    DateTime? createDate,
  }) {
    return GeneratorTelemetry(
      id: id ?? this.id,
      aqBatVol: aqBatVol ?? this.aqBatVol,
      aqChrgVol: aqChrgVol ?? this.aqChrgVol,
      consCur: consCur ?? this.consCur,
      mainL1Vol: mainL1Vol ?? this.mainL1Vol,
      mainL2Vol: mainL2Vol ?? this.mainL2Vol,
      mainL3Vol: mainL3Vol ?? this.mainL3Vol,
      avrPF: avrPF ?? this.avrPF,
      oilLvl: oilLvl ?? this.oilLvl,
      oilPrssr: oilPrssr ?? this.oilPrssr,
      wtrTemp: wtrTemp ?? this.wtrTemp,
      oilTemp: oilTemp ?? this.oilTemp,
      tlRunTime: tlRunTime ?? this.tlRunTime,
      ndname: ndname ?? this.ndname,
      ndErrCode: ndErrCode ?? this.ndErrCode,
      ndBatVol: ndBatVol ?? this.ndBatVol,
      ndCnctSts: ndCnctSts ?? this.ndCnctSts,
      ndEleSts: ndEleSts ?? this.ndEleSts,
      createDate: createDate ?? this.createDate,
    );
  }
}
