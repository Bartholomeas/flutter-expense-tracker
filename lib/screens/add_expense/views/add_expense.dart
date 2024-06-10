import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    dateController.text = DateFormat('dd.mm.yyyy').format(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Dodaj transakcję',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
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
                      prefixIcon: const Icon(FontAwesomeIcons.moneyBill1,
                          size: 20, color: Colors.grey)),
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
                    label: const Text("Kategoria"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(FontAwesomeIcons.layerGroup,
                        size: 20, color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                  backgroundColor: Colors.black,
                                  title: const Text('Stwórz kategorię'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            label: const Text("Nazwa"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            prefixIcon: const Icon(
                                                FontAwesomeIcons.calendar,
                                                size: 20,
                                                color: Colors.grey)),
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            label: const Text("Ikona"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            prefixIcon: const Icon(
                                                FontAwesomeIcons.calendar,
                                                size: 20,
                                                color: Colors.grey)),
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            label: const Text("Kolor"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            prefixIcon: const Icon(
                                                FontAwesomeIcons.calendar,
                                                size: 20,
                                                color: Colors.grey)),
                                      ),
                                    ],
                                  ));
                            });
                      },
                      icon: const Icon(FontAwesomeIcons.plus,
                          size: 20, color: Colors.grey),
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
                        firstDate: selectDate,
                        lastDate:
                            DateTime.now().add(const Duration(days: 365)));
                    if (newDate != null) {
                      setState(() {
                        dateController.text =
                            DateFormat('dd.MM.yyyy').format(newDate);
                        selectDate = newDate;
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
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
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
        ),
      ),
    );
  }
}
