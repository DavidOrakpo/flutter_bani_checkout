<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
# Flutter Bani Checkout

Integrate Bani Checkout Seamlessly into your Flutter Applications using this package!

## Installation

Run this in your workspace terminal
```
flutter pub add flutter_bani_checkout
```
Import the package in your application
```
import 'package:flutter_bani_checkout/flutter_bani_checkout.dart';
```

## Android Requirements
The minium sdk version should be set to 19 in the ```android/app/build.gradle```.

```
android {
    defaultConfig {
        minSdkVersion 19
    }
}
```

## Features

Make use of either ```BaniShopperCheckout``` Widget in a stand alone page, or ```BaniShopper.checkoutModalSheet``` bottom sheet.

### BaniShopperCheckout 
This Widget takes a custom class, ```BaniObject``` as a required property.
```dart
  final String text; // Text to be displayed to user
  final String amount; // Amount to be purchased
  final String phoneNumber; // Phone number of user in ITU standard Eg: +234 xxx xxxx xxxx
  final String merchantKey; //Merchant Key
  final String ref; // Transaction Reference. Should be a unique String
  final String email; //User Email
  final String firstName; // User First name
  final String lastName; // Users Last Name
  final Map<String, dynamic> metaData; // Metea Data
```
Optional Functions listed below can be given to be notified when an ```Event Response``` is receieved from the Widget.

- onClose: This function is called whenever the Widget or Modal is closed or dismissed.
- onSuccess: This function is called whenever a successful transaction has been carried out.
- onCustomerExists: This function is called on confirmation of a valid Customer.
- onCheckOutClose: This function is called after a successful payment has been receieved and widget closed.

The ```EventResponse``` class returned, contains the transaction reference and customer Ref

#### Example
```dart
  BaniShopperCheckout(
        baniObject: BaniObject(
          text: "Pay with Bani",
          amount: "200",
          phoneNumber: "+23408039485758",
          merchantKey: "pub_test_KB9A23HSYR327H5DKW45Y",
          ref: "ref-${Random.secure().nextInt(900000) + 100000}",
          email: "usercustomer@gmail.com",
          firstName: "John",
          lastName: "Doe",
          metaData: {
            "order_ref": "fake_0rderre6",
          },
        ),
        onSuccess: (eventResponse){
            dev.log("Success!");
        },
        onClose: (eventResponse) {
          dev.log(event.toString());
          dev.log("Closed!");
        },
      ),
```

```dart
await BaniShopper.checkoutModalSheet(
              context: context,
              baniObject: BaniObject(
                text: "Pay with Bani",
                amount: "200",
                phoneNumber: "+23408038475839",
                merchantKey: "pub_test_KB9A23HSYR327H5DKW45Y",
                ref: "ref-${Random.secure().nextInt(900000) + 100000}",
                email: "usercustomer@gmail.com",
                firstName: "John",
                lastName: "Doe",
                metaData: {
                  "order_ref": "fake_0rderre6",
                },
              ),
              // onClose: onClose,
              // onSuccess: onSuccess,
              // onCustomerExists: onCustomerExists,
            )
```

Check out the example package for a working demo.