import 'package:budget_tracker1/widgets/new_transaction.dart';
import 'package:budget_tracker1/models/transaction.dart';
import 'package:budget_tracker1/widgets/transaction_card.dart';
import 'package:budget_tracker1/widgets/transaction_info.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({this.label, this.amount, this.description, super.key});
  final amount;
  final label;
  final description;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  double totalAmount = 0;
  double budget = 0;
  double expense = 0;

  final List<Transaction> _transactions = [
    Transaction(
        title: "New Shoes", amount: 100, description: "New Amount is added")
  ];

  calculateAmount() {
    double positive = 0;
    double negative = 0;
    for (var transaction in _transactions) {
      if (transaction.amount < 0) {
        negative += transaction.amount;
      }
      if (transaction.amount >= 0) {
        positive += transaction.amount;
      }
    }
    setState(
      () {
        budget = positive;
        expense = negative;
        totalAmount = budget - expense.abs();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    calculateAmount();
  }

  _addDate(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
    calculateAmount();
  }

  _removeTransaction(Transaction transaction) {
    int transactionIndex = _transactions.indexOf(transaction);
    setState(
      () {
        _transactions.remove(transaction);
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Deleted!'),
        action: SnackBarAction(
          label: "Undo!",
          onPressed: () {
            setState(
              () {
                _transactions.insert(
                  transactionIndex,
                  transaction,
                );
              },
            );
            calculateAmount();
          },
        ),
      ),
    );

    calculateAmount();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = Expanded(
      child: Center(
        child: Image.asset(
          "assets/images/background.png",
          color: const Color.fromARGB(87, 0, 0, 0),
          height: 100,
        ),
      ),
    );
    if (_transactions.isNotEmpty) {
      mainContent = TransactionCard(
        onRemoveTransaction: _removeTransaction,
        transaction: _transactions,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Tracker"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => NewTransaction(onAddTransaction: _addDate),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: width < 600
          ? Expanded(
              child: TransactionInfo(
                  mainContent: mainContent,
                  totalAmount: totalAmount,
                  budget: budget,
                  expense: expense),
            )
          : Row(
              children: [
                Expanded(
                  child: TransactionInfo(
                      mainContent: mainContent,
                      totalAmount: totalAmount,
                      budget: budget,
                      expense: expense),
                )
              ],
            ),
    );
  }
}
