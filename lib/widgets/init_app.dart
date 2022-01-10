import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:bc_cov_pass/main.dart';
import 'package:bc_cov_pass/provider/vaccine_information_provider.dart';
import 'package:bc_cov_pass/vaccine_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitApp extends StatefulWidget {
  final GlobalKey<IntroductionScreenState> introductionScreenKey = GlobalKey();

  InitApp({Key? key}) : super(key: key);

  @override
  State<InitApp> createState() => InitAppState();
}

class InitAppState extends State<InitApp> {
  String? name;
  DateTime? issued;
  String? qrCodeData;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) => IntroductionScreen(
        key: widget.introductionScreenKey,
        freeze: true,
        isTopSafeArea: true,
        pages: [
          PageViewModel(
            image: Image.asset('assets/vaccine_passport_1.png'),
            title: 'Enter the name appearing on your\nBC Covid Passport',
            bodyWidget: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'John Doe',
              ),
            ),
          ),

          PageViewModel(
            title: 'Pick the date on your\nBC Covid Passport',
            bodyWidget: EnterDate(
                onDone: (date) {
                  issued = date;
                  next();
                },
            ),
          ),

          PageViewModel(
            title: 'Scan the QR Code',
            bodyWidget: ScanQRCode(
              onDone: (qrCode) async {
                qrCodeData = qrCode;
                var vaccineInformation = VaccineInformation(name!, issued!, qrCodeData!);
                var sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString(vaccineInformationPath, jsonEncode(vaccineInformation.toJSON()));
                context.read<VaccineInformationProvider>().vaccineInformation = vaccineInformation;
                Navigator.pushReplacementNamed(context, '/home');
              },
            )
          )
        ],
        showNextButton: true,
        onChange: (index) {
          if (index == 1) {
              if (controller.text.isNotEmpty) {
                name = controller.text;
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  action: SnackBarAction(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
                    },
                    label: 'Dismiss',
                    textColor: Colors.white,
                  ),
                  content: const Text('Please enter the name', style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              previous();
          }
        },
        next: const Icon(Icons.navigate_next),
        showDoneButton: false,
      );

  void next() {
    widget.introductionScreenKey.currentState?.next();
  }
  void previous() {
    widget.introductionScreenKey.currentState?.previous();
  }
}

class EnterDate extends StatefulWidget {
  final void Function(DateTime) onDone;

  const EnterDate({Key? key, required this.onDone}) : super(key: key);

  @override
  _EnterDateState createState() => _EnterDateState();
}

class _EnterDateState extends State<EnterDate> with AfterLayoutMixin<EnterDate> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    DateTime? date;

    do {
      date = await showDialog(
        context: context,
        builder: (context) => DatePickerDialog(
          initialDate: DateTime.now(),
          firstDate: DateTime.fromMillisecondsSinceEpoch(0),
          lastDate: DateTime.now(),
          cancelText: "",
        ),
      );
    } while(date == null);

    TimeOfDay? time;

    do {
      time = await showDialog(
        context: context,
        builder: (context) =>
            TimePickerDialog(
              initialTime: TimeOfDay.now(),
              cancelText: '',
            ),
      );
    } while (time == null);
    widget.onDone(DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }
}

class ScanQRCode extends StatefulWidget {
  final void Function(String) onDone;

  const ScanQRCode({Key? key, required this.onDone}) : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> with AfterLayoutMixin<ScanQRCode> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
      'F44336FF',
      '',
      true,
      ScanMode.QR,
    );
    widget.onDone(qrCode);
  }
}


