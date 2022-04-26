// ignore_for_file: sized_box_for_whitespace
/* Imports */
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import './constants.dart';
import 'home.dart';

void main() => runApp(const BarcodeScanner());

class BarcodeScanner extends StatelessWidget {
  const BarcodeScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        /* removes red banner on right side of screen*/
        debugShowCheckedModeBanner: false,
        home: BarcodeScannerPage());
  }
}

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String? scanResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bckgroundColour,
      /* Container to change size of FloatingActionButton */
      floatingActionButton: Container(
        /* Custom sizes */
        height: 60.0,
        width: 60.0,
        child: FittedBox(
          child: FloatingActionButton(
            /* materialTapTargetSize: MaterialTapTargetSize. */
            backgroundColor: buttonColour,
            /* call method responsible for invoking the barcode scanner */
            onPressed: _scanBarcode,
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 30.0,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      /* Creates a white bottom nav bar */
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(255, 255, 255, 1),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        /* Gives the nav bar sizes*/
        child: Container(
          height: 50.0,
          width: 50.0,
        ),
      ),
      body: const SafeArea(
        child: Home(),
      ),
    );
  }

  /*function responsible for invoking the scanner*/
  Future _scanBarcode() async {
    String scanResult;

    try {
      /* calls the scanBarcode method within the FlutterBarcodeScanner class 
        and stores a result after scanning in scanResult
      */
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        /* Colour of scanner line */
        '#ffffff',
        /* Text for cancel button */
        'Cancel',
        /* prevents flash icon from being displayed */
        false,
        /* Set scanner mode. in our case, it is barcode */
        ScanMode.BARCODE,
      );
      /* catch exceptions */
    } on PlatformException {
      scanResult = 'Failed to get platform version';
    } 
    if (!mounted) return;
    /* If user cancels */
    (scanResult == '-1')
        ? showDialog(
            context: context,
            builder: (context) =>
                const AlertDialog(
                  content: Text(
                    'No result. \nTry again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: mediumText,
                      color: buttonColour,
                      fontWeight: FontWeight.w500,
                    ),
                    )))
          /* if there is barcode */
        : showDialog(
            context: context,
            builder: (context) => AlertDialog(
                titlePadding: const EdgeInsets.fromLTRB(45, 45, 45, 0),
                contentPadding: const EdgeInsets.fromLTRB(45.0, 20, 45.0, 45.0),
                title: const Text(
                  'Barcode Information',
                  style: TextStyle(
                      fontSize: mediumText,
                      fontFamily: 'Poppins',
                      color: buttonColour),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      Text(
                        scanResult,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: smallText,
                        ),
                      ),
                    ]),
                    /* Creates space between the scanResult and barcode */
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        /* Generates and displays barcode based on scanResult */
                        BarcodeWidget(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2,
                          barcode: Barcode.code128(),
                          data: scanResult,
                          /* Stops contents of barcode from being displayed under the barcode */
                          drawText: false,
                        )
                      ],
                    )
                  ],
                )));
    /* set state for scanResult */
    setState(() {
      this.scanResult = scanResult;
    });
  }
}
