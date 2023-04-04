import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:round_up_calculator/views/profile_page.dart';
import 'package:round_up_calculator/views/roundup_page.dart';
import 'package:round_up_calculator/views/transaction_page.dart';

const backgroundColor = Colors.black;
var secondaryColor = Colors.blue[800];
var secondary = Colors.indigo;
List pages = [AddTransactionPage(), TransactionListPage(), ProfilePage()];
var firestore = FirebaseFirestore.instance;
var fireAuth = FirebaseAuth.instance;
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
