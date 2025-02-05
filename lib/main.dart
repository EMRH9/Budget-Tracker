import 'package:budget_tracker1/themes/theme_data.dart';
import 'package:budget_tracker1/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: myAppTheme,
      home: const TransactionList(),
    ),
  );
}
