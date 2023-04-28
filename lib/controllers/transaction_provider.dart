import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:round_up_calculator/constants.dart';

import '../models/payment.dart';

class TransactionProvider extends ChangeNotifier {
  List<Payment> _transactions = [];

  List<Payment> get transactions => _transactions;

  var _month = DateTime.now().month;

  submitTransaction(String transactionType, int amount, int roundUp) async {
    try {
      String uid = fireAuth.currentUser!.uid;
      var allDocsMonth = await firestore
          .collection('transactions')
          .doc(uid)
          .collection('$_month')
          .get();
      int len = allDocsMonth.docs.length;
      Payment payment = Payment(
          uid: uid,
          type: transactionType,
          amount: amount,
          roundUp: roundUp,
          timeOfTransaction: DateTime.now());
      await firestore
          .collection('transactions')
          .doc(uid)
          .collection('$_month')
          .doc('Transaction $len')
          .set(payment.toJson());
      var allDocsHistory = await firestore
          .collection('allTransactions')
          .doc(uid)
          .collection('transactionHistory')
          .get();
      int len2 = allDocsHistory.docs.length;
      await firestore
          .collection('allTransactions')
          .doc(uid)
          .collection('transactionHistory')
          .doc('Transaction $len2')
          .set(payment.toJson());
      final SnackBar snackBar = SnackBar(
        content: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.check,
                weight: 20,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Transaction Details Submitted!",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey.withOpacity(0.1),
        elevation: 20,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        duration: const Duration(seconds: 2),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    } catch (e) {
      Get.snackbar("Error", "Error! ${e.toString()}");
    }
    notifyListeners();
  }

  Future<int> getTotal() async {
    try {
      int totalRoundUp = 0;
      var uid = fireAuth.currentUser!.uid;
      for (var i = 1; i <= 12; i++) {
        var allDocsMonth = await firestore
            .collection('transactions')
            .doc(uid)
            .collection('$i')
            .get();
        int len = allDocsMonth.docs.length;
        if (len != 0) {
          QuerySnapshot snapshot = await firestore
              .collection('transactions')
              .doc(uid)
              .collection('$i')
              .get();
          for(var doc in snapshot.docs){
            totalRoundUp += doc['roundUp'] as int;
          }
        }
      }
      return totalRoundUp;
    } catch (e) {
      Get.snackbar("Error", "Error! ${e.toString()}");
      return 0;
    }
  }


  getTransactions() async {
    try {
      var uid = fireAuth.currentUser!.uid;
      List<DocumentSnapshot> docs = [];
      for (var i = 1; i <= 12; i++) {
        var allDocsMonth = await firestore
            .collection('transactions')
            .doc(uid)
            .collection('$i')
            .get();
        int len = allDocsMonth.docs.length;
        if (len != 0) {
          QuerySnapshot snapshot = await firestore
              .collection('transactions')
              .doc(uid)
              .collection('$i')
              .orderBy('timeOfTransaction', descending: true)
              .get();
          docs.addAll(snapshot.docs);
        }
      }
      return docs;
    } catch (e) {
      Get.snackbar("Error", "Error! ${e.toString()}");
    }
  }

  // Future<int> getTotal() async {
  //   try {
  //     int totalRoundUp = 0;
  //     var uid = fireAuth.currentUser!.uid;
  //     QuerySnapshot snapshot = await firestore
  //         .collection('allTransactions')
  //         .doc(uid)
  //         .collection('transactionHistory')
  //         .get();
  //     List<DocumentSnapshot> docs = snapshot.docs;
  //     for (var doc in docs) {
  //       totalRoundUp += doc['roundUp'] as int;
  //     }
  //     return totalRoundUp;
  //   } catch (e) {
  //     Get.snackbar("Error", "Error! ${e.toString()}");
  //     return 0;
  //   }
  // }
  // getTransactions() async {
  //   try {
  //     var uid = fireAuth.currentUser!.uid;
  //     QuerySnapshot snapshot = await firestore
  //         .collection('allTransactions')
  //         .doc(uid)
  //         .collection('transactionHistory')
  //         .orderBy('timeOfTransaction', descending: true)
  //         .get();
  //     List<DocumentSnapshot> docs = snapshot.docs;
  //     return docs;
  //   } catch (e) {
  //     Get.snackbar("Error", "Error! ${e.toString()}");
  //   }
  // }
}
