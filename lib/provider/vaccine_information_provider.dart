import 'package:bc_cov_pass/vaccine_information.dart';
import 'package:flutter/cupertino.dart';

class VaccineInformationProvider extends ChangeNotifier {
  VaccineInformationProvider([this._vaccineInformation]);

  VaccineInformation? _vaccineInformation;
  VaccineInformation? get vaccineInformation => _vaccineInformation;
  set vaccineInformation(VaccineInformation? information) {
    if (_vaccineInformation != null) return;
    _vaccineInformation = information;
    notifyListeners();
  }
}