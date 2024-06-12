import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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

  List<String> myCategoriesIcons = ['food'];
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
                              bool isExpanded = false;
                              String iconSelected = '';
                              Color categoryColor = Colors.black12;

                              TextEditingController categoryNameController =
                                  TextEditingController();
                              TextEditingController categoryIconController =
                                  TextEditingController();
                              TextEditingController categoryColorController =
                                  TextEditingController();

                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                      backgroundColor: Colors.black,
                                      title: const Text('Stwórz kategorię'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: categoryNameController,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                label: const Text("Nazwa"),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                prefixIcon: const Icon(
                                                    FontAwesomeIcons.calendar,
                                                    size: 20,
                                                    color: Colors.grey)),
                                          ),
                                          const SizedBox(height: 16),
                                          TextFormField(
                                            controller: categoryIconController,
                                            onTap: () {
                                              setState(() {
                                                isExpanded = !isExpanded;
                                              });
                                            },
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              suffixIcon: const Icon(
                                                  CupertinoIcons.chevron_down),
                                              label: const Text("Ikona"),
                                              border: OutlineInputBorder(
                                                  borderRadius: isExpanded
                                                      ? const BorderRadius
                                                          .vertical(
                                                          top: Radius.circular(
                                                              10))
                                                      : BorderRadius.circular(
                                                          10)),
                                              prefixIcon: const Icon(
                                                  FontAwesomeIcons.icons,
                                                  size: 20,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          isExpanded
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .vertical(
                                                              bottom: Radius
                                                                  .circular(
                                                                      10))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GridView.builder(
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3),
                                                        itemCount:
                                                            myCategoriesIcons
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                iconSelected =
                                                                    myCategoriesIcons[
                                                                        index];
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 50,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      border: Border.all(
                                                                          width:
                                                                              3,
                                                                          color: iconSelected == myCategoriesIcons[index]
                                                                              ? Colors
                                                                                  .green
                                                                              : Colors
                                                                                  .grey),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/${myCategoriesIcons[index]}.png'),
                                                                      )),
                                                            ),
                                                          );
                                                        }),
                                                  ))
                                              : Container(),
                                          const SizedBox(height: 16),
                                          TextFormField(
                                            controller: categoryColorController,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (ctxTwo) {
                                                    return AlertDialog(
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ColorPicker(
                                                            pickerColor:
                                                                categoryColor,
                                                            onColorChanged:
                                                                (value) {
                                                              setState(() {
                                                                categoryColor =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                double.infinity,
                                                            height: 50,
                                                            child: TextButton(
                                                                onPressed: () {
                                                                  print(
                                                                      categoryColor);
                                                                  Navigator.pop(
                                                                      ctxTwo);
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  backgroundColor: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary,
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  'Zapisz',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black),
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            readOnly: true,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                filled: true,
                                                fillColor: categoryColor,
                                                label: const Text("Kolor"),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                prefixIcon: const Icon(
                                                    FontAwesomeIcons.palette,
                                                    size: 20,
                                                    color: Colors.grey)),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            height: kToolbarHeight,
                                            child: TextButton(
                                                onPressed: () {
                                                  Category category =
                                                      Category.empty;

                                                  category.categoryId =
                                                      const Uuid().v1();
                                                  category.name =
                                                      categoryNameController
                                                          .text;
                                                  category.icon = iconSelected;
                                                  category.color =
                                                      categoryColor.toString();
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                ),
                                                child: const Text(
                                                  'Zapisz',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          )
                                        ],
                                      ));
                                },
                              );
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
