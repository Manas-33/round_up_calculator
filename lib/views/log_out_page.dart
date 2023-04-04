import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/signin_provider.dart';

class LogOutPage extends StatelessWidget {
  const LogOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      width: double.maxFinite,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () {
                  final provider = Provider.of<AnonymousSignInProvider>(context,
                      listen: false);
                  provider.logOut();
                },
                child: const Text("Log Out", style: TextStyle(fontSize: 16))),
          ]),
    );
  }
}
