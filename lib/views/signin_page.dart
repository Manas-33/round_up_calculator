import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:round_up_calculator/controllers/signin_provider.dart';
class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50.0),
            const Text(
              'Sign in',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () {
                  final provider=Provider.of<AnonymousSignInProvider>(context,listen: false);
                  provider.signInAnonymously();
                },
                icon: SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.network(
                      'https://icons.veryicon.com/png/o/object/material-design-icons-1/incognito.png',
                      fit: BoxFit.cover),
                ),
                label: const Text("Sign In Anonymously",
                    style: TextStyle(fontSize: 16)))
          ],
        ),
      ),
    );
  }
}
