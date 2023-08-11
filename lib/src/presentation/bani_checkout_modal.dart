import 'package:flutter/material.dart';
import 'package:flutter_bani_checkout/src/presentation/viewmodel/bani_checkout_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            final provider = ref.watch(baniCheckoutVM);
            provider.isModal = true;
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
}
