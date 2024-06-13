import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:flutter_expense_tracker/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:flutter_expense_tracker/screens/add_expense/blocs/get_categories_bloc/bloc/get_categories_bloc.dart';
import 'package:flutter_expense_tracker/screens/add_expense/views/add_expense.dart';
import 'package:flutter_expense_tracker/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
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
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if (state is GetExpensesSuccess) {
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                var newExpense = await Navigator.push(
                    context,
                    MaterialPageRoute<Expense>(
                        builder: ((BuildContext context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) =>
                                      CreateCategoryBloc(FirebaseExpenseRepo()),
                                ),
                                BlocProvider(
                                  create: (context) =>
                                      CreateExpenseBloc(FirebaseExpenseRepo()),
                                ),
                                BlocProvider(
                                  create: (context) =>
                                      GetCategoriesBloc(FirebaseExpenseRepo())
                                        ..add(GetCategories()),
                                ),
                              ],
                              child: const AddExpense(),
                            ))));

                if (newExpense != null) {
                  setState(() {
                    state.expenses.add(newExpense);
                  });
                }
              },
              child: const Icon(CupertinoIcons.plus),
            ),
            body: index == 0 ? MainScreen(state.expenses) : const StatScreen(),
          );
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
