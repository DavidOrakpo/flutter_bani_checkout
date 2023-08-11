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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await BaniShopper.checkoutModalSheet(
              context: context,
              baniObject: BaniObject(
                text: "Pay with Bani",
                amount: "200",
                phoneNumber: "+2347037142576",
                merchantKey: "pub_test_KB9A23HSYR327H5DKW45Y",
                ref: "ref-${Random.secure().nextInt(900000) + 100000}",
                email: "danielorakpo@gmail.com",
                firstName: "Daniel",
                lastName: "Orakpo",
                metaData: {
                  "order_ref": "fake_0rderre6",
                },
              ),
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
      ),
    );
    // return Scaffold(
    //   body: BaniShopperCheckout(
    //     baniObject: BaniObject(
    //       text: "Pay with Bani",
    //       amount: "200",
    //       phoneNumber: "+2347037142576",
    //       merchantKey: "pub_test_KB9A23HSYR327H5DKW45Y",
    //       ref: "ref-${Random.secure().nextInt(900000) + 100000}",
    //       email: "danielorakpo@gmail.com",
    //       firstName: "Daniel",
    //       lastName: "Orakpo",
    //       metaData: {
    //         "order_ref": "fake_0rderre6",
    //       },
    //     ),
    //     onClose: (event) {
    //       dev.log(event.toString());
    //       dev.log("Closed!");
    //     },
    //   ),
    // );
  }
}
