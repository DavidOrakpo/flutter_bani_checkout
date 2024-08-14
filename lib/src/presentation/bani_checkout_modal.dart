import 'package:flutter/material.dart';
import 'package:flutter_bani_checkout/src/presentation/viewmodel/bani_checkout_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../flutter_bani_checkout.dart';

class BaniShopper {
  static Future<bool> checkoutModalSheet({
    required BuildContext context,
    required BaniObject baniObject,
    Function(EventResponse)? onClose,
    Function(EventResponse)? onSuccess,
    Function(EventResponse)? onCustomerExists,
    Function(EventResponse)? onCheckOutClose,
  }) async {
    return await showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      builder: (context) {
        final size = MediaQuery.sizeOf(context);
        return Consumer(
          builder: (context, ref, child) {
            // final provider = ref.watch(baniCheckoutVM);
            // provider.isModal = true;
            return SizedBox(
              height: size.height * 0.95,
              child: BaniShopperCheckout(
                baniObject: baniObject,
                onClose: onClose,
                onCustomerExists: onCustomerExists,
                oncheckOutClose: (p0) {
                  if (onCheckOutClose == null) {
                  } else {
                    onCheckOutClose(p0);
                  }
                  if (context.mounted) {
                    Navigator.pop(context, false);
                  }
                },
                onSuccess: onSuccess,
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> payInBaniShopper({
    required String? collectorRef,
    String? amount,
    String? transactionReference,
    String? branchID,
    Map<String, dynamic>? customData,
  }) async {
    var initialGateway =
        "https://banishopper.page.link/?link=https://shopper.bani.africa/makePayment?collector_ref%3D$collectorRef";
    var fallBackLink =
        "https://qr.banishopper.com/merchant?collector_ref%3D$collectorRef";

    if (amount != null) {
      initialGateway = "$initialGateway%26amount%3D$amount";
      fallBackLink = "$fallBackLink%26amount%3D$amount";
    }
    if (transactionReference != null) {
      initialGateway =
          "$initialGateway%26transaction_ref%3D$transactionReference";
      fallBackLink = "$fallBackLink%26transaction_ref%3D$transactionReference";
    }
    if (branchID != null) {
      initialGateway = "$initialGateway%26branch_id%3D$branchID";
      fallBackLink = "$fallBackLink%26branch_id%3D$branchID";
    }
    if (customData != null) {
      customData.forEach((key, value) {
        initialGateway = "$initialGateway%26$key%3D$value";
        fallBackLink = "$fallBackLink%26$key%3D$value";
      });
    }

    var modifiedGateway =
        "$initialGateway&apn=com.bani.shopper&isi=6465788827&ibi=com.bani.shopper&afl=$fallBackLink&ifl=$fallBackLink";

    await launchUrlString(modifiedGateway);
  }
}
