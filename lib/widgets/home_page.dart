import 'package:barcode_widget/barcode_widget.dart';
import 'package:bc_cov_pass/provider/vaccine_information_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: const Color(0xFF003366),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        color: const Color(0xFF003366),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        color: const Color(0xFF2E8540),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(flex: 46),
                    const Text(
                      'BC Vaccine Card',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                    ),
                    const Spacer(flex: 38),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      color: const Color(0xFFFCBA19),
                      height: 3,
                    ),
                    const Spacer(flex: 46),
                    Text(
                      context.watch<VaccineInformationProvider>().vaccineInformation?.name ??
                          'John Doe',
                      style: const TextStyle(fontSize: 23),
                    ),
                    const Spacer(flex: 75),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.check_circle_rounded, size: 64),
                        SizedBox(width: 8),
                        Text(
                          'Vaccinated',
                          style: TextStyle(fontSize: 39),
                        )
                      ],
                    ),
                    const Spacer(flex: 46),
                    Text(
                      context.watch<VaccineInformationProvider>().vaccineInformation
                              ?.issuedFormatted ??
                          'January-01-2021, 12:00',
                      style: const TextStyle(fontSize: 21),
                    ),
                    const Spacer(flex: 25),
                    Flexible(
                      flex: 600,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: BarcodeWidget(
                          barcode: Barcode.qrCode(),
                          data: context.watch<VaccineInformationProvider>().vaccineInformation
                                  ?.qrCodeData ??
                              'NO DATA AVAILABLE',
                        ),
                      ),
                    ),
                    const Spacer(flex: 95),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
