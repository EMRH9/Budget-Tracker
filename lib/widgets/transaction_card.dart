import 'package:budget_tracker1/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(Transaction vle) onRemoveTransaction;
  TransactionCard(
      {required this.onRemoveTransaction,
      required this.transaction,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: transaction.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(
            transaction[index],
          ),
          onDismissed: (direction) => {
            onRemoveTransaction(transaction[index]),
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_right,
                    size: 35,
                  ),
                  Text(transaction[index].title),
                  const Spacer(),
                  Text(
                    "\$${transaction[index].amount.toStringAsFixed(2)}",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
