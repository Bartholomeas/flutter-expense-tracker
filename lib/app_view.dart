import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:flutter_expense_tracker/screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Kontroluj wydatki",
        theme: ThemeData(
            colorScheme: const ColorScheme.dark(
          background: Color.fromARGB(134, 0, 0, 0),
          onBackground: Colors.white,
          primary: Color.fromARGB(255, 255, 204, 0),
          secondary: Color.fromARGB(255, 237, 110, 13),
          tertiary: Color.fromARGB(255, 231, 77, 0),
          outline: Colors.grey,
        )),
        home: BlocProvider(
          create: (context) =>
              GetExpensesBloc(FirebaseExpenseRepo())..add(GetExpenses()),
          child: const HomeScreen(),
        ));
  }
}
