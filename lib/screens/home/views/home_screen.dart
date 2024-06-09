import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/screens/home/views/main_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white10,
        elevation: 3,
        items: const [
          BottomNavigationBarItem(
            label: 'Strona główna',
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            label: 'Statystyki',
            icon: Icon(CupertinoIcons.graph_square),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(CupertinoIcons.plus),
      ),
      body: MainScreen(),
    );
  }
}
