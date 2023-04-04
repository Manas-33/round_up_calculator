// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  String uid;
  String type;
  int amount;
  int roundUp;
  final timeOfTransaction;

  Payment(
      {required this.uid,
      required this.type,
      required this.amount,
      required this.roundUp,
      required this.timeOfTransaction});

  Map<String, dynamic> toJson() => {
        'type': type,
        'amount': amount,
        'timeOfTransaction': timeOfTransaction,
        'roundUp': roundUp,
        'uid': uid
      };

  static Payment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Payment(
        amount: snapshot['amount'],
        type: snapshot['type'],
        roundUp: snapshot['roundUp'],
        timeOfTransaction: snapshot['timeOfTransaction'],
        uid: snapshot['uid']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'type': type,
      'amount': amount,
      'roundUp': roundUp,
      'timeOfTransaction': timeOfTransaction
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      uid: map['uid'] as String,
      type: map['type'] as String,
      amount: map['amount'] as int,
      roundUp: map['roundUp'] as int,
      timeOfTransaction: map['timeOfTransaction'],
    );
  }

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source) as Map<String, dynamic>);
}
