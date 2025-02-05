import 'package:flutter/material.dart';

class TransactionInfo extends StatelessWidget {
  final double totalAmount;
  final double expense;
  final double budget;
  final Widget mainContent;
  const TransactionInfo(
      {required this.mainContent,
      required this.totalAmount,
      required this.budget,
      required this.expense,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Total Balance",
                style: TextStyle(fontSize: 25),
              ),
              Text(
                totalAmount.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "\$$budget",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Text(
                        "Budget",
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("\$$expense", style: const TextStyle(fontSize: 20)),
                      const Text(
                        "Expense",
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
            child: const Text(
              "Transactions",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          mainContent,
        ],
      ),
    );
  }
}
