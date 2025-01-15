import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chart_statistic.dart'; // Gantikan dengan path yang sesuai

class TransactionPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const TransactionPage({super.key, required this.userData});

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<Map<String, dynamic>> transactions = [];
  List<Map<String, dynamic>> incomeTransactions = [];
  List<Map<String, dynamic>> expenseTransactions = [];
  String sortOrder = 'asc';

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      // Fetch data
      final incomeData = await fetchAllIncomeData();
      final expenseData = await fetchAllExpenseData();

      // Filter data berdasarkan userId
      final filteredIncome = incomeData
          .where((transaction) =>
              transaction['userId'] == widget.userData['userId'])
          .toList();
      final filteredExpense = expenseData
          .where((transaction) =>
              transaction['userId'] == widget.userData['userId'])
          .toList();

      // Update state
      setState(() {
        incomeTransactions = filteredIncome;
        expenseTransactions = filteredExpense;
        transactions = [...filteredIncome, ...filteredExpense];
      });
    } catch (e) {
      print("Error fetching transactions: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllIncomeData() async {
    const url = 'https://6718f6bc7fc4c5ff8f4be207.mockapi.io/api/v1/income';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load income data');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllExpenseData() async {
    const url = 'https://6784c7481ec630ca33a595ad.mockapi.io/expense';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load expense data');
    }
  }

  void sortTransactions() {
    setState(() {
      transactions.sort((a, b) => sortOrder == 'asc'
          ? a['amount'].compareTo(b['amount'])
          : b['amount'].compareTo(a['amount']));
    });
  }

  String formatRupiah(int amount) {
    final formatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2499C0),
        title: const Text(
          'Statistics',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: BarChartSample(
                  incomeTransactions: incomeTransactions,
                  expenseTransactions: expenseTransactions,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Most popular transaction",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: sortOrder,
                  items: const [
                    DropdownMenuItem(
                      child: Text("Sort by Ascending"),
                      value: 'asc',
                    ),
                    DropdownMenuItem(
                      child: Text("Sort by Descending"),
                      value: 'desc',
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        sortOrder = value;
                        sortTransactions();
                      });
                    }
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        transaction['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(transaction['date']),
                      trailing: Text(
                        formatRupiah(transaction['amount']),
                        style: TextStyle(
                          color: incomeTransactions.contains(transaction)
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
