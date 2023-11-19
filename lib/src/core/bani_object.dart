// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class BaniObject {
  final String? text;
  final String amount;
  final String phoneNumber;
  final String merchantKey;
  final String ref;
  final String email;
  final String firstName;
  final bool? bankTransfer;
  final String lastName;
  final Map<String, dynamic>? metaData;
  BaniObject({
    this.text,
    required this.amount,
    required this.phoneNumber,
    required this.merchantKey,
    this.ref = "",
    this.bankTransfer,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.metaData,
  });

  BaniObject copyWith({
    String? text,
    String? amount,
    String? phoneNumber,
    String? merchantKey,
    bool? bankTransfer,
    String? ref,
    String? email,
    String? firstName,
    String? lastName,
    Map<String, dynamic>? metaData,
  }) {
    return BaniObject(
      text: text ?? this.text,
      amount: amount ?? this.amount,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      merchantKey: merchantKey ?? this.merchantKey,
      ref: ref ?? this.ref,
      email: email ?? this.email,
      bankTransfer: bankTransfer ?? this.bankTransfer,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      metaData: metaData ?? this.metaData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'amount': amount,
      'phoneNumber': phoneNumber,
      'merchantKey': merchantKey,
      'ref': ref,
      "bankTransfer": bankTransfer,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'metadata': metaData,
    };
  }

  factory BaniObject.fromMap(Map<String, dynamic> map) {
    return BaniObject(
        text: map['text'] as String,
        amount: map['amount'] as String,
        phoneNumber: map['phoneNumber'] as String,
        merchantKey: map['merchantKey'] as String,
        ref: map['ref'] as String,
        bankTransfer: map["bankTransfer"] as bool,
        email: map['email'] as String,
        firstName: map['firstName'] as String,
        lastName: map['lastName'] as String,
        metaData: Map<String, dynamic>.from(
          (map['metadata'] as Map<String, dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory BaniObject.fromJson(String source) =>
      BaniObject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BaniObject(text: $text, amount: $amount, bankTransfer: $bankTransfer, phoneNumber: $phoneNumber, merchantKey: $merchantKey, ref: $ref, email: $email, firstName: $firstName, lastName: $lastName, metadata: $metaData)';
  }

  @override
  bool operator ==(covariant BaniObject other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.amount == amount &&
        other.phoneNumber == phoneNumber &&
        other.merchantKey == merchantKey &&
        other.ref == ref &&
        other.email == email &&
        other.bankTransfer == bankTransfer &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        mapEquals(other.metaData, metaData);
  }

  @override
  int get hashCode {
    return text.hashCode ^
        amount.hashCode ^
        phoneNumber.hashCode ^
        bankTransfer.hashCode ^
        merchantKey.hashCode ^
        ref.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        metaData.hashCode;
  }
}
