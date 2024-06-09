import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionsData = [
  {
    "icon": const FaIcon(
      FontAwesomeIcons.bowlFood,
      color: Colors.white,
    ),
    "color": Colors.red,
    "name": "Zakupy spożywcze",
    "totalAmount": "-45.00 PLN",
    "date": "09.06.2024",
  },
  {
    "icon": const FaIcon(FontAwesomeIcons.moneyBill, color: Colors.white),
    "color": Colors.red,
    "name": "Rachunki",
    "totalAmount": "-200.00 PLN",
    "date": "09.06.2024",
  },
  {
    "icon": const FaIcon(FontAwesomeIcons.kitMedical, color: Colors.white),
    "color": Colors.red,
    "name": "Lekarstwa",
    "totalAmount": "-99.00 PLN",
    "date": "09.06.2024",
  },
  {
    "icon": const FaIcon(FontAwesomeIcons.arrowTrendUp, color: Colors.white),
    "color": Colors.green,
    "name": "Giełda",
    "totalAmount": "+350.00 PLN",
    "date": "09.06.2024",
  }
];
