import 'package:budget_tracker1/models/transaction.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.onAddTransaction});
  final void Function(Transaction transaction) onAddTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _amountController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  _validateData() {
    final validTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text);
    final invalidData = validTitle.isEmpty || enteredAmount == null;

    if (invalidData) {
      showDialog(
        context: context,
        builder: (value) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "The data you've entered is not valid. Please check and try again."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Okay"),
            )
          ],
        ),
      );
      return;
    }

    widget.onAddTransaction(
      Transaction(
          title: validTitle,
          amount: enteredAmount!,
          description: _descriptionController.text),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            right: 15,
            top: 35,
            child: CloseButton(),
          ),
          Center(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: "Title",
                        prefixIcon:
                            const Icon(Icons.label_important_outline_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Amount",
                        prefixIcon: const Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: "Description",
                        prefixIcon: const Icon(Icons.description_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: _validateData,
                      child: const Text("Add Transaction"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
