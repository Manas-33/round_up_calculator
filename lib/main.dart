import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:round_up_calculator/controllers/signin_provider.dart';
import 'package:round_up_calculator/controllers/transaction_provider.dart';
// import 'package:round_up_calculator/views/transaction_form.dart';
import 'package:round_up_calculator/views/home_page.dart';
import 'package:round_up_calculator/views/roundup_value_page.dart';
import 'package:round_up_calculator/views/signin_page.dart';

import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnonymousSignInProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: snackbarKey,
        title: "Round Up Calculator",
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
        home: Scaffold(
          body: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: secondaryColor,
                  );
                } else if (snapshot.hasData) {
                  return HomePage();
                } else if (snapshot.hasError) {
                  return (const Text("There was an Error!"));
                } else {
                  return SignInPage();
                }
              }),
        ),
      ),
    );
  }
}
