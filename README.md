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
This package works using Riverpod. So we wrap the MyApp method in main with ProviderScope as shown below
```dart
void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}
```
## Android Requirements
The minium sdk version should be set to 19 in the ```android/app/build.gradle```.

```xml
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

# Introducing Bani Shopper Integration

Integrate Bani Shopper payments into your application in three easy steps!

## Step One
The first step requires collating the data you intend to send to Bani Shopper. The following variables below are data you can pass, with **collectorRef** being the only required variable:
- The collector ref (formally known as the merchant tribe-ref)
- The amount.
- The Transaction Reference
- The Branch ID
- Custom Data


```dart
String collectorRef = "BN-e78b38qwrt4bebz514ya1dzpz9";
String amount = "5000";
String transactionReference = "dsfWDFDFddfREEGDfREw";
String branchID = "21";
```

## Step Two
The second step involves placing the variables, into the payInBaniShopper function. The **BaniShopper.payInBaniShopper** function, handles the heavy lifting of constructing the string and launching BaniShopper with all the variables you created in Step One:


```dart
  Future<void> payInBaniShopper({
    required String? collectorRef,
    String? amount,
    String? transactionReference,
    String? branchID,
    Map<String, dynamic>? customData,
  })
```

## Step Three
The final step is the easiest! We call the **payInBaniShopper** function! This is an asynchronous call so it is important to await its call.:
```dart
ElevatedButton(
	onPressed: () async {
	await payInBaniShopper(
            collectorRef: collectorRef,
            amount: amount,
            branchID: branchID,        
            transactionReference: transactionReference,
            customData: {
            "is_internal": isInternal,
            "order_id": orderID,
        });
},
	child:  const  Text("Launch Bani Shopper"),
),
```

The above code creates an Elevated Button, launches the url link in the web browser in it's onPressed callback. If the user has **BaniShopper** installed, it will open the app and prompt them to sign in. If the user doesn't have the app installed, they will be redirected to a website to complete the purchase!
Once redirected, they will confirm the purchase, provide authorization, and will be redirected back to the source application!



