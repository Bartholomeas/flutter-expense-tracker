import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_expense_tracker/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

Future getCategoryCreation(BuildContext context) {
  List<String> myCategoriesIcons = ['food'];

  return showDialog(
      context: context,
      builder: (ctx) {
        bool isExpanded = false;
        String iconSelected = '';
        Color categoryColor = Colors.black12;

        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryIconController = TextEditingController();
        TextEditingController categoryColorController = TextEditingController();
        Category category = Category.empty;

        return BlocProvider.value(
          value: context.read<CreateCategoryBloc>(),
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return BlocListener<CreateCategoryBloc, CreateCategoryState>(
                  listener: (context, state) {
                    if (state is CreateCategorySuccess) {
                      Navigator.pop(ctx, category);
                    } else {}
                  },
                  child: AlertDialog(
                      backgroundColor: Colors.black,
                      title: const Text('Stwórz kategorię'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: categoryNameController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                isDense: true,
                                label: const Text("Nazwa"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
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
                            textAlignVertical: TextAlignVertical.center,
                            readOnly: true,
                            decoration: InputDecoration(
                              isDense: true,
                              suffixIcon:
                                  const Icon(CupertinoIcons.chevron_down),
                              label: const Text("Ikona"),
                              border: OutlineInputBorder(
                                  borderRadius: isExpanded
                                      ? const BorderRadius.vertical(
                                          top: Radius.circular(10))
                                      : BorderRadius.circular(10)),
                              prefixIcon: const Icon(FontAwesomeIcons.icons,
                                  size: 20, color: Colors.grey),
                            ),
                          ),
                          isExpanded
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.vertical(
                                          bottom: Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3),
                                        itemCount: myCategoriesIcons.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                iconSelected =
                                                    myCategoriesIcons[index];
                                              });
                                            },
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 3,
                                                      color: iconSelected ==
                                                              myCategoriesIcons[
                                                                  index]
                                                          ? Colors.green
                                                          : Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: DecorationImage(
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
                            textAlignVertical: TextAlignVertical.center,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (ctxTwo) {
                                    return BlocProvider.value(
                                      value: context.read<CreateCategoryBloc>(),
                                      child: AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ColorPicker(
                                              pickerColor: categoryColor,
                                              onColorChanged: (value) {
                                                setState(() {
                                                  categoryColor = value;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 50,
                                              child: TextButton(
                                                  onPressed: () {
                                                    print(categoryColor);
                                                    Navigator.pop(ctxTwo);
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
                                        ),
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
                                    borderRadius: BorderRadius.circular(10)),
                                prefixIcon: const Icon(FontAwesomeIcons.palette,
                                    size: 20, color: Colors.grey)),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: kToolbarHeight,
                            child: TextButton(
                                onPressed: () {
                                  // Category category = Category.empty;
                                  setState(() {
                                    category.categoryId = const Uuid().v1();
                                    category.name = categoryNameController.text;
                                    category.icon = iconSelected;
                                    category.color = categoryColor.value;
                                  });
                                  context
                                      .read<CreateCategoryBloc>()
                                      .add(CreateCategory(category));
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
                      )));
            },
          ),
        );
      });
}
