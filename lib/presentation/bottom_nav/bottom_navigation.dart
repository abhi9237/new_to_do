import 'package:firebase_demo_app/presentation/all_user/ui/all_user.dart';
import 'package:firebase_demo_app/presentation/bottom_nav/widget/bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../add_todo/view/add_todo.dart';
import '../home/view/home_view.dart';
import '../profile/view/profile_view.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int index = 0;
  List<Widget> screenList = <Widget>[
    HomeScreen(),
    AddTodoScreen(),
    AllUserScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: screenList.elementAt(index),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: GoogleFonts.alice(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 14),
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          currentIndex: index,
          onTap: (i) {
            index = i;
            setState(() {});
          },
          items: [
            bottomNavWidget(icon: Icons.home, label: 'Home'),
            bottomNavWidget(icon: Icons.add, label: 'Add'),
            bottomNavWidget(icon: Icons.message, label: 'Chat'),
            bottomNavWidget(icon: Icons.person, label: 'Profile'),
          ]),
    );
  }
}
