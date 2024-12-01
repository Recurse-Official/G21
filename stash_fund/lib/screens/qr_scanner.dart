import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stash_fund/components/android_transaction.dart';
import 'package:stash_fund/components/ios_transaction.dart';

class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Map<String, String>? upiDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Scanner"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              onDetect: (barcodeCapture) {
                final List<Barcode> barcodes = barcodeCapture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null) {
                    final String code = barcode.rawValue!;
                    setState(() {
                      upiDetails = parseUPIData(code);
                    });
                  }
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (upiDetails != null)
                    ? Column(
                        children: [
                          Text('Payee Name: ${upiDetails!["pn"] ?? "Unknown"}'),
                          Text('UPI ID: ${upiDetails!["pa"] ?? "Unknown"}'),
                          Text('Transaction Note: ${upiDetails!["tn"] ?? "None"}'),
                          SizedBox(height: 20),
                          // Platform-specific transaction widget
                          Platform.isIOS
                              ? IOSTransactionWidget(upiDetails: upiDetails!)
                              : AndroidTransactionWidget(upiDetails: upiDetails!),
                        ],
                      )
                    : Text('Scan a UPI QR code'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Parse UPI QR Code data
  Map<String, String>? parseUPIData(String? data) {
    if (data == null || !data.startsWith("upi://pay")) {
      return null;
    }
    try {
      final Uri uri = Uri.parse(data);
      return uri.queryParameters;
    } catch (e) {
      print("Error parsing UPI data: $e");
      return null;
    }
  }
}
