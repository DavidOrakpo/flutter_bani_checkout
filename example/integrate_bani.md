# Integrate Bani Shopper!

Integrate Bani Shopper payments into your application in three easy steps!

## Step One
The first steps requires constructing the **Payment Gateway** string. You need to provide two variables to complete this step:
- The merchant tribe-ref
- The price.
- transaction reference

These variables are inserted into the **paymentGateway** string as seen below. 

```dart
String merchantTribeRef = "BN-e78b38qwrt4bebz514ya1dzpz9";
String price = "5000";
String transactionReference = "dsfWDFDFddfREEGDfREw";
String paymentGateway = "https://shopper.bani.africa/makePayment/${merchantTribeRef}/${price}/${transactionReference}";
```

## Step Two
The second step involves constructing the **Deep link** string from the paymentGateway.
With the paymentGateway constructed as above, we can then insert the paymentGateway, into the dynamicLink as below:

```dart
String deepLink = "https://banishopper.page.link/?link=https://banishopper.page.link/?link%3D${paymentGateway}&apn=com.bani.shopper&ibi=com.bani.shopper&isi=6465788827&afl=https://www.google.com";
```
It is important to take note of where the paymentGateway string is inserted within the deepLink above.

## Step Three
The final step is the easiest! We **launch** a web browser using the created deepLink! Depending on the programming language being used, you can acccomplish this in many ways. The example below, shows how to do so using Dart/Flutter, and the url_launcher package:
```dart
ElevatedButton(
	onPressed: () async {
	await  launchUrlString(deepLink);
},
	child:  const  Text("Launch Bani Shopper"),
),
```

The above code creates an Elevated Button, launches the url link in the web browser in it's onPressed callback. If the user has **BaniShopper** installed, it will open the app and prompt them to sign in. From there, they will confirm the purchase, provide authorization, and will be redirected back to the source application!

