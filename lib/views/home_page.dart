import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            iconSize: 25,
            textSize: 16,
            textStyle: const TextStyle(fontWeight: FontWeight.w500),
            activeColor: secondaryColor,
            gap: 8,
            tabBackgroundColor: Colors.white24,
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.monetization_on,
                text: 'Transactions',
              ),
              GButton(
                icon: Icons.meeting_room_outlined,
                text: 'Log Out',
              ),
            ],
            onTabChange: (index) {
              setState(() {
                pageIndex = index;
              });
            },
          ),
        ),
        body: pages[pageIndex]);
  }
}
