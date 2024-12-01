// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IOSTransactionWidget extends StatelessWidget {
  final Map<String, String> upiDetails;

  IOSTransactionWidget({required this.upiDetails});

  Future<void> initiateTransaction(BuildContext context) async {
    final String upiUri = Uri(
      scheme: 'upi',
      host: 'pay',
      queryParameters: {
        'pa': upiDetails["pa"],
        'pn': upiDetails["pn"] ?? 'Unknown',
        'tn': upiDetails["tn"] ?? 'UPI Payment',
        'am': upiDetails["am"] ?? '1.00',
        'cu': 'INR',
      },
    ).toString();

    print("Generated UPI URI: $upiUri");

    try {

      // if (await canLaunch(upiUri)) {

      //   await launch(upiUri);
      // } else {
      await launch(upiUri);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("No UPI app found to handle payment.")),
        // );
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error launching UPI app: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => initiateTransaction(context),
      child: Text("Pay with UPI (iOS)"),
    );
  }
}
