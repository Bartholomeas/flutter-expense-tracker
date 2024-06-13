import 'dart:ffi';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:flutter_expense_tracker/screens/add_expense/blocs/get_categories_bloc/bloc/get_categories_bloc.dart';
import 'package:flutter_expense_tracker/screens/add_expense/views/category_creation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  DateTime selectDate = DateTime.now();

  late Expense expense;
  bool isLoading = false;

  @override
  void initState() {
    dateController.text = DateFormat('dd.mm.yyyy').format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.pop(context, expense);
        } else {}
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Dodaj transakcję',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: expenseController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: const Text("Wartość"),
                            prefixIcon: expense.category == Category.empty
                                ? const Icon(FontAwesomeIcons.moneyBill1,
                                    size: 20, color: Colors.grey)
                                : Image.asset(
                                    'assets/${expense.category.icon}.png',
                                    scale: 2,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: categoryController,
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true,
                          onTap: () {},
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: expense.category == Category.empty
                                ? Colors.black
                                : Color(expense.category.color),
                            label: const Text("Kategoria"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: const Icon(FontAwesomeIcons.layerGroup,
                                size: 20, color: Colors.grey),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                var category =
                                    await getCategoryCreation(context);
                                setState(() {
                                  state.categories.insert(0, category);
                                });
                              },
                              icon: const Icon(FontAwesomeIcons.plus,
                                  size: 20, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black54,
                        child: ListView.builder(
                          itemCount: state.categories.length,
                          itemBuilder: (context, int i) {
                            return Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        expense.category = state.categories[i];
                                        categoryController.text =
                                            expense.category.name;
                                      });
                                    },
                                    leading: Image.asset(
                                      'assets/${state.categories[i].icon}.png',
                                      scale: 2,
                                    ),
                                    title: Text(
                                      state.categories[i].name,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    tileColor: Color(state.categories[i].color),
                                  ),
                                ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: nameController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              label: const Text("Nazwa"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: const Icon(FontAwesomeIcons.signature,
                                  size: 20, color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: dateController,
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: expense.date,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)));
                            if (newDate != null) {
                              setState(() {
                                dateController.text =
                                    DateFormat('dd.MM.yyyy').format(newDate);
                                // selectDate = newDate;
                                expense.date = newDate;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              label: const Text("Data"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: const Icon(FontAwesomeIcons.calendar,
                                  size: 20, color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: kToolbarHeight,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                expense.amount =
                                    int.parse(expenseController.text);

                                context
                                    .read<CreateExpenseBloc>()
                                    .add(CreateExpense(expense));
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: const Text(
                              'Zapisz',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
