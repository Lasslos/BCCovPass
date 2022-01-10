import 'package:bc_cov_pass/utils.dart';

class VaccineInformation {
  final String name;
  final DateTime issued;
  final String qrCodeData;

  const VaccineInformation(this.name, this.issued, this.qrCodeData);
  factory VaccineInformation.fromJSON(Map<String, dynamic> json) {
    String name = json['name'];
    DateTime issued = DateTime.fromMicrosecondsSinceEpoch(json['issued']);
    String qrCodeData = json['qrCodeData'];
    return VaccineInformation(name, issued, qrCodeData);
  }
  Map<String, dynamic> toJSON() => <String, dynamic>{
        'name': name,
        'issued': issued.microsecondsSinceEpoch,
        'qrCodeData': qrCodeData,
      };

  String get issuedFormatted =>
      '${Month.values[issued.month].name.capitalizeFirst()}'
      '-'
      '${issued.day.toString().padLeft(2, '0')}'
      '-'
      '${issued.year}'
      ', '
      '${issued.hour.toString().padLeft(2, '0')}'
      ':'
      '${issued.minute.toString().padLeft(2, '0')}';

  VaccineInformation copyWith(
          {String? name, DateTime? issued, String? qrCodeData}) =>
      VaccineInformation(name ?? this.name, issued ?? this.issued,
          qrCodeData ?? this.qrCodeData);
}
