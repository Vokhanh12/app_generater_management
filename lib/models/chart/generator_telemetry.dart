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
      ndEleSts: (map['NdEleSts'] ?? 0) == 1,
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
      ndEleSts: (data['NdEleSts'] ?? false),
      createDate: (data['CreateDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
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
      'CreateDate': Timestamp.fromDate(createDate),
    };
  }

  factory GeneratorTelemetry.fromJson(Map<String, dynamic> json) {
    return GeneratorTelemetry(
      id: json['id'],
      aqBatVol: json['AqBatVol']?.toDouble() ?? 0,
      aqChrgVol: json['AqChrgVol']?.toDouble() ?? 0,
      consCur: json['ConsCur']?.toDouble() ?? 0,
      mainL1Vol: json['MainL1Vol']?.toDouble() ?? 0,
      mainL2Vol: json['MainL2Vol']?.toDouble() ?? 0,
      mainL3Vol: json['MainL3Vol']?.toDouble() ?? 0,
      avrPF: json['AvrPF']?.toDouble() ?? 0,
      oilLvl: json['OilLvl']?.toDouble() ?? 0,
      oilPrssr: json['OilPrssr']?.toDouble() ?? 0,
      wtrTemp: json['WtrTemp']?.toDouble() ?? 0,
      oilTemp: json['OilTemp']?.toDouble() ?? 0,
      tlRunTime: json['TlRunTime']?.toInt() ?? 0,
      ndname: json['Ndname'] ?? '',
      ndErrCode: json['NdErrCode']?.toInt() ?? 0,
      ndBatVol: json['NdBatVol']?.toDouble() ?? 0,
      ndCnctSts: json['NdCnctSts']?.toDouble() ?? 0,
      ndEleSts: json['NdEleSts'] ?? false,
      createDate: DateTime.parse(json['CreateDate']),
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
        'CreateDate': createDate.toIso8601String(),
      };

  static DateTime _parseDate(String? value) {
    if (value == null) return DateTime.now();
    try {
      return DateFormat("dd/MM/yyyy-HH:mm:ss").parse(value);
    } catch (_) {
      return DateTime.now();
    }
  }
}
