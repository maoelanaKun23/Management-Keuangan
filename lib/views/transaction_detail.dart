import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionDetail extends StatefulWidget {
  final Map<String, dynamic> transaction;
  final Function(Map<String, dynamic>) onTransactionUpdated;
  final Function(String, String, bool) onTransactionDeleted;

  const TransactionDetail({
    Key? key,
    required this.transaction,
    required this.onTransactionUpdated,
    required this.onTransactionDeleted,
  }) : super(key: key);

  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  late Map<String, dynamic> transaction;

  @override
  void initState() {
    super.initState();
    transaction = widget.transaction;
  }

  Future<void> _deleteTransaction() async {
    final url = transaction['type'] == 'expense'
        ? 'https://6784c7481ec630ca33a595ad.mockapi.io/expense/${transaction['id']}'
        : 'https://6718f6bc7fc4c5ff8f4be207.mockapi.io/api/v1/income/${transaction['id']}';

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      widget.onTransactionDeleted(transaction['id'], transaction['type'], transaction['type'] == 'income');
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete the transaction.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = transaction['title'];
    int amount = transaction['amount'];
    String date = transaction['date'];
    String type = transaction['type'];
    String id = transaction['id'];
    print(transaction);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2499C0),
        title: const Text(
          "Detail Transaction",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Amount: ${formatRupiah(amount)}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return EditTransactionDialog(
                          initialTitle: title,
                          initialAmount: amount,
                          type: type,
                          id: id,
                          onSave: (newTitle, newAmount) {
                            final updatedTransaction = {
                              'id': id,
                              'title': newTitle,
                              'amount': newAmount,
                              'date': date,
                              'type': type,
                            };

                            setState(() {
                              transaction = updatedTransaction;
                            });

                            widget.onTransactionUpdated(updatedTransaction);
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirm Delete"),
                        content: const Text("Are you sure you want to delete this transaction?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _deleteTransaction();
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatRupiah(int amount) {
    final formatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }
}

class EditTransactionDialog extends StatefulWidget {
  final String initialTitle;
  final int initialAmount;
  final String type;
  final String id;
  final Function(String, int) onSave;

  const EditTransactionDialog({
    Key? key,
    required this.initialTitle,
    required this.initialAmount,
    required this.type,
    required this.id,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditTransactionDialogState createState() => _EditTransactionDialogState();
}

class _EditTransactionDialogState extends State<EditTransactionDialog> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _amountController =
        TextEditingController(text: widget.initialAmount.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _saveTransaction() async {
    final newTitle = _titleController.text;
    final newAmount = int.tryParse(_amountController.text);

    if (newTitle.isNotEmpty && newAmount != null) {
      final url = widget.type == 'expense'
          ? 'https://6784c7481ec630ca33a595ad.mockapi.io/expense/${widget.id}'
          : 'https://6718f6bc7fc4c5ff8f4be207.mockapi.io/api/v1/income/${widget.id}';

      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': newTitle,
          'amount': newAmount,
        }),
      );

      if (response.statusCode == 200) {
        widget.onSave(newTitle, newAmount);
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update the transaction.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in valid data.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Transaction'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveTransaction,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
