// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:math';
import "dart:developer" as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bani_checkout/flutter_bani_checkout.dart';

class WebViewTestPage extends StatefulWidget {
  static const routeIdentifier = "WEB_VIEW_TEST";
  const WebViewTestPage({super.key});

  @override
  State<WebViewTestPage> createState() => _WebViewTestPageState();
}

class _WebViewTestPageState extends State<WebViewTestPage> {
  var deepLink = "";
  String collectorRef = "BN-e78b38qwrt4bebz514ya1dzpz9";
  String transactionReference = "dsfWDFDFddfREEGDfREw";
  String branchID = "20";
  String amount = "5000";
  String orderID = "sj304w08r2io2";
  bool isInternal = false;
  String? paymentGateway;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await BaniShopper.checkoutModalSheet(
                  context: context,
                  baniObject: BaniObject(
                    text: "Pay with Bani",
                    amount: "200",
                    phoneNumber: "+2347037142576",
                    merchantKey: "pub_test_H9BH5C31T65T5QFAG2MSX",
                    ref: "ref-${Random.secure().nextInt(900000) + 100000}",
                    email: "testemail@gmail.com",
                    firstName: "Test",
                    lastName: "User",
                    metaData: {
                      "order_confirmation": "test MetaData",
                    },
                  ),
                  onClose: (p0) {
                    dev.log("Closed");
                  },
                  // onClose: onClose,
                  // onSuccess: onSuccess,
                  // onCustomerExists: onCustomerExists,
                ).then((value) {
                  if (!value) {
                    dev.log("Bani CLOSED FROM APP");
                  }
                });
              },
              child: const Text("Show Bani Checkout Modal"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await BaniShopper.payInBaniShopper(
                    collectorRef: collectorRef,
                    amount: amount,
                    // branchID: branchID,
                    // isInternal: isInternal,
                    // orderID: orderID,
                    transactionReference: transactionReference,
                    customData: {
                      "is_internal": isInternal,
                      "order_id": orderID,
                    });
              },
              child: const Text("Launch Bani Shopper"),
            ),
          ],
        ),
      ),
    );
  }
}
