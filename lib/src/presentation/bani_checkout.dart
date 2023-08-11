import 'package:flutter/cupertino.dart';
import 'package:flutter_bani_checkout/flutter_bani_checkout.dart';
import 'package:flutter_bani_checkout/src/presentation/viewmodel/bani_checkout_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BaniShopperCheckout extends ConsumerStatefulWidget {
  final BaniObject baniObject;
  final void Function(EventResponse)? onClose;
  final void Function(EventResponse)? onSuccess;
  final void Function(EventResponse)? onCustomerExists;
  final void Function(EventResponse)? oncheckOutClose;
  const BaniShopperCheckout({
    super.key,
    required this.baniObject,
    this.onClose,
    this.onSuccess,
    this.onCustomerExists,
    this.oncheckOutClose,
  });

  @override
  ConsumerState<BaniShopperCheckout> createState() => _BaniPackageTextState();
}

class _BaniPackageTextState extends ConsumerState<BaniShopperCheckout> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(baniCheckoutVM).initialize(
            widget.baniObject,
            onClose: widget.onClose,
            onCustomerExists: widget.onCustomerExists,
            onSuccess: widget.onSuccess,
            onCheckOutClose: ref.read(baniCheckoutVM).isModal
                ? widget.oncheckOutClose
                : (p0) {
                    if (widget.oncheckOutClose == null) {
                    } else {
                      widget.oncheckOutClose!(p0);
                    }
                    if (context.mounted) {
                      Navigator.pop(context, false);
                    }
                  },
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(baniCheckoutVM);
    return SafeArea(
      child: Column(
        children: [
          // Container(
          //   // height: 30,
          //   width: double.infinity,
          //   padding: const EdgeInsets.symmetric(vertical: 5),
          //   decoration: const BoxDecoration(
          //     color: Color(0xFF5444F2),
          //   ),
          //   child: Center(
          //     child: Text(
          //       widget.baniObject.text,
          //       style: const TextStyle(
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: provider.isLoading,
              builder: (context, isLoading, child) {
                if (isLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                return WebViewWidget(controller: provider.controller!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
