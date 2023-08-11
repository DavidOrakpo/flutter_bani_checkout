import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bani_checkout/flutter_bani_checkout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

final baniCheckoutVM = ChangeNotifierProvider((ref) => BaniCheckoutViewModel());

class BaniCheckoutViewModel with ChangeNotifier {
  WebViewController? controller = WebViewController();
  static const String jsClientName = "BaniShopperClient";
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  Map<String, dynamic> baniObjectReady = {};
  Future<void> initialize(
    BaniObject baniObject, {
    Function(EventResponse)? onClose,
    Function(EventResponse)? onSuccess,
    Function(EventResponse)? onCustomerExists,
    Function(EventResponse)? onCheckOutClose,
  }) async {
    baniObjectReady = {
      ...baniObject.toMap(),
      "checkoutReady": true,
    };
    this.onCheckOutClose = onCheckOutClose;
    this.onClose = onClose;
    this.onSuccess = onSuccess;
    this.onCustomerExists = onCustomerExists;
    controller = WebViewController.fromPlatformCreationParams(
        const PlatformWebViewControllerCreationParams())
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(jsClientName,
          onMessageReceived: onMessageReceieved)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            isLoading.value = true;
            isLoading.notifyListeners();
          },
          onPageFinished: (String url) async {
            // isLoading.value = false;
            await injectPeerStack();
          },
          onWebResourceError: (WebResourceError error) {
            log(error.toString());
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(computeUrl(baniObject)));
  }

  String computeUrl(BaniObject baniObject) {
    return baniObject.merchantKey.contains("test")
        ? 'https://stage-checkout.getbani.com'
        : 'https://live-checkout.getbani.com';
  }

  void Function(EventResponse)? onClose;
  void Function(EventResponse)? onSuccess;
  void Function(EventResponse)? onCustomerExists;
  void Function(EventResponse)? onCheckOutClose;

  Future<void> injectPeerStack() async {
    try {
      await controller!
          .runJavaScriptReturningResult(
        injectedJS(),
      )
          .then((value) {
        log(value.toString());
      });
    } catch (e) {
      log(e.toString());
    }
  }

  bool _isModal = false;

  bool get isModal => _isModal;

  set isModal(bool value) {
    _isModal = value;
    notifyListeners();
  }

  void handleResponse(String response) {
    try {
      log("This is response$response");
      Map responseAsMap = jsonDecode(response);
      var message = responseAsMap["message"];

      switch (message) {
        case 'CHECKOUTREADY':
          isLoading.value = false;
          break;
        case 'CHECKOUTCLOSE':
          // var eventResponse =
          //     EventResponse.fromMap(responseAsMap["eventMessage"]);
          if (onCheckOutClose == null) {
            return;
          }
          onCheckOutClose!(EventResponse(null, null, null, null));
          log("message");
          break;
        case 'ONCLOSE':
          var eventResponse =
              EventResponse.fromMap(responseAsMap["eventMessage"]);
          if (onClose == null) return;
          onClose!(eventResponse);

          break;
        case 'CALLBACK':
          var eventResponse =
              EventResponse.fromMap(responseAsMap["eventMessage"]);
          if (onSuccess == null) return;
          onSuccess!(eventResponse);
          break;
        case 'CUSTOMER_EXISTS':
          isLoading.value = true;
          isLoading.notifyListeners();
          var eventResponse =
              EventResponse.fromMap(responseAsMap["eventMessage"]);
          if (onCustomerExists == null) return;
          onCustomerExists!(eventResponse);
          break;
        default:
        // code block
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void onMessageReceieved(JavaScriptMessage data) {
    try {
      handleResponse(data.message);
    } catch (e) {
      log(e.toString());
    }
  }

  final message = {
    'message': 'yourMessage',
    'eventMessage': 'yourEventMessage'
  };
  String injectedJS() => '''
      window.postMessage(${jsonEncode(baniObjectReady)}, "*");

     // Create our shared stylesheet:
    //  var style = document.createElement("style");
    //   // Add EventListener for onMessage Event
      window.addEventListener("message", (event) => {
        sendMessage(event)
      });

      
      // Send callback to dart JSMessageClient
      function sendMessage(event) {
        let message = event?.data?.type || event?.data;
        let eventMessage = event?.data?.response;
        switch (message) {
          case "CHECKOUTREADY":
            $jsClientName.postMessage(JSON.stringify({message,eventMessage}));
            break;
          case "CHECKOUTCLOSE":
            // hideIframe();
            $jsClientName.postMessage(JSON.stringify({message,eventMessage}));
            break;
          case "ONCLOSE":
            // hideIframe();
            // onClose && onClose({ ...eventMessage });
            $jsClientName.postMessage(JSON.stringify({message,eventMessage}));
            break;
          case "CALLBACK":
            // onCallback && onCallback({ ...eventMessage });
            $jsClientName.postMessage(JSON.stringify({message,eventMessage}));
          case "CUSTOMER_EXISTS":
            // onCustomerExists && onCustomerExists({ ...eventMessage });
            $jsClientName.postMessage(JSON.stringify({message,eventMessage}));
            break;
          default:
          // code block
      }
          // if (window.$jsClientName && window.$jsClientName.postMessage) {
          //     $jsClientName.postMessage(JSON.stringify(message));
          // }
    } 

      // // Send raw callback to dart JSMessageClient
      // function sendMessageRaw(event) {
      //     if (window.$jsClientName && window.$jsClientName.postMessage) {
      //         $jsClientName.postMessage(message);
      //     }
      // } 
''';
}
