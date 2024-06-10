import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/screens/add_expense/views/add_expense.dart';
import 'package:flutter_expense_tracker/screens/home/views/main_screen.dart';
import 'package:flutter_expense_tracker/screens/stats/stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  late Color selectedItem = Colors.yellow.shade700;
  Color unselectedItem = Colors.grey;

  @override
  void initState() {
    // selectedItem = Theme.of(context).colorScheme.primary;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedItem = Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          print(value);

          setState(() {
            index = value;
          });
        },
        backgroundColor: Colors.white10,
        elevation: 3,
        currentIndex: index,
        selectedItemColor:
            index == 0 ? selectedItem : unselectedItem, // Add this line
        items: [
          BottomNavigationBarItem(
            label: 'Strona główna',
            icon: Icon(
              CupertinoIcons.home,
              color: index == 0 ? selectedItem : unselectedItem,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Statystyki',
            icon: Icon(
              CupertinoIcons.graph_square,
              color: index == 1 ? selectedItem : unselectedItem,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: ((BuildContext context) => const AddExpense())));
        },
        child: const Icon(CupertinoIcons.plus),
      ),
      body: index == 0 ? const MainScreen() : const StatScreen(),
    );
  }
}
