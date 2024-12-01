import 'package:flutter/material.dart';
import 'package:upi_pay/upi_pay.dart';

class AndroidTransactionWidget extends StatelessWidget {
  final Map<String, String> upiDetails;

  AndroidTransactionWidget({required this.upiDetails});

  Future<void> initiateTransaction(BuildContext context) async {
    try {
      final upiPay = UpiPay();
      final transaction = await upiPay.initiateTransaction(
        app: UpiApplication.googlePay, 
        receiverUpiAddress: upiDetails["pa"]!,
        receiverName: upiDetails["pn"] ?? 'Unknown',
        transactionRef: 'DemoTxn${DateTime.now().millisecondsSinceEpoch}',
        transactionNote: upiDetails["tn"] ?? 'UPI Payment',
        amount: upiDetails["am"] ?? '10.00',
      );

      print("Transaction Result: ${transaction.status}");
      if (transaction.status == UpiTransactionStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Transaction Successful!")),
        );
      } else if (transaction.status == UpiTransactionStatus.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Transaction Failed.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Transaction Cancelled.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => initiateTransaction(context),
      child: Text("Pay with UPI (Android)"),
    );
  }
}
