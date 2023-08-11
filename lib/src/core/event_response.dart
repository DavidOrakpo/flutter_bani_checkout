// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// export type EventResponsee = {
//   status?: string | null
//   type?: string | null
//   reference?: string | null
//   customer_ref?: string | null
// }

class EventResponse {
  final String? status;
  final String? type;
  final String? reference;
  final String? customerRef;

  EventResponse(
    this.status,
    this.type,
    this.reference,
    this.customerRef,
  );

  EventResponse copyWith({
    String? status,
    String? type,
    String? reference,
    String? customerRef,
  }) {
    return EventResponse(
      status ?? this.status,
      type ?? this.type,
      reference ?? this.reference,
      customerRef ?? this.customerRef,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'type': type,
      'reference': reference,
      'customerRef': customerRef,
    };
  }

  factory EventResponse.fromMap(Map<String, dynamic> map) {
    return EventResponse(
      map['status'] != null ? map['status'] as String : null,
      map['type'] != null ? map['type'] as String : null,
      map['reference'] != null ? map['reference'] as String : null,
      map['customerRef'] != null ? map['customerRef'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventResponse.fromJson(String source) =>
      EventResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventResponse(status: $status, type: $type, reference: $reference, customerRef: $customerRef)';
  }

  @override
  bool operator ==(covariant EventResponse other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.type == type &&
        other.reference == reference &&
        other.customerRef == customerRef;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        type.hashCode ^
        reference.hashCode ^
        customerRef.hashCode;
  }
}
