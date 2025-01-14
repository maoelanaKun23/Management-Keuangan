import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const HomePage({super.key, required this.userData});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isIncomeSelected = true;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  late String id;

  List<Map<String, dynamic>> incomeTransactions = [];
  List<Map<String, dynamic>> expenseTransactions = [];

  @override
  void initState() {
    super.initState();
    id = widget.userData['userId'];
    fetchAndFilterIncomeData();
    fetchAndFilterExpenseData();
    calculateTotals();
  }

  void calculateTotals() {
    setState(() {
      totalIncome = incomeTransactions.fold(
          0, (sum, item) => sum + (item['amount'] as int));
      totalExpense = expenseTransactions.fold(
          0, (sum, item) => sum + (item['amount'] as int));
      totalBalance = totalIncome - totalExpense;
    });
  }

  String formatRupiah(int amount) {
    final formatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }

  DateTime convertStringToDate(String dateString) {
    try {
      return DateFormat('MMMM dd, yyyy').parse(dateString);
    } catch (e) {
      print("Error parsing date: $e");
      return DateTime.now();
    }
  }

  Future<void> fetchAndFilterIncomeData() async {
    try {
      final data = await fetchAllIncomeData();
      List<Map<String, dynamic>> filteredData = [];
      
      for (var transaction in data) {
        if (transaction['userId'] == id) {
          filteredData.add(transaction);
        }
      }
      
      setState(() {
        incomeTransactions = filteredData;
      });
    } catch (e) {
      print("Error fetching and filtering income data: $e");
    }
  }

  Future<void> fetchAndFilterExpenseData() async {
    try {
      final data = await fetchAllExpenseData();
      List<Map<String, dynamic>> filteredData = [];
      
      for (var transaction in data) {
        if (transaction['userId'] == id) {
          filteredData.add(transaction);
        }
      }
      
      setState(() {
        expenseTransactions = filteredData;
      });
    } catch (e) {
      print("Error fetching and filtering expense data: $e");
    }
  }

  Future<List<dynamic>> fetchAllIncomeData() async {
    const url = 'https://6718f6bc7fc4c5ff8f4be207.mockapi.io/api/v1/income';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load income data');
      }
    } catch (e) {
      throw Exception('Error fetching income: $e');
    }
  }

  Future<List<dynamic>> fetchAllExpenseData() async {
    const url = 'https://6784c7481ec630ca33a595ad.mockapi.io/expense';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load expense data');
      }
    } catch (e) {
      throw Exception('Error fetching expense: $e');
    }
  }

  Future<void> addTransaction(String title, int amount, bool isIncome) async {
    final newTransaction = {
      'title': title,
      'date': DateTime.now().toIso8601String(),
      'amount': amount,
      'userId': id,
    };

    try {
      if (isIncome) {
        await postIncomeData(newTransaction);
      } else {
        await postExpenseData(newTransaction);
      }

      setState(() {
        if (isIncome) {
          incomeTransactions.add(newTransaction);
        } else {
          expenseTransactions.add(newTransaction);
        }
        calculateTotals();
      });
    } catch (e) {
      print("Error posting transaction: $e");
    }
  }

  Future<void> postIncomeData(Map<String, dynamic> transaction) async {
    const url = 'https://6718f6bc7fc4c5ff8f4be207.mockapi.io/api/v1/income';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(transaction),
      );
      if (response.statusCode == 201) {
      print('Data berhasil dikirim: ${response.body}');
    } else {
      print('Gagal mengirim data: ${response.statusCode}');
    }
    } catch (e) {
      throw Exception('Error posting income: $e');
    }
  }

  Future<void> postExpenseData(Map<String, dynamic> transaction) async {
    const url = 'https://6784c7481ec630ca33a595ad.mockapi.io/expense';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(transaction),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to post expense data');
      }
    } catch (e) {
      throw Exception('Error posting expense: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2499C0),
        title: Text(
          'Hi, ${widget.userData['name']}!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 170,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF2499C0),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Text(
                      formatRupiah(totalBalance),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Your total balance',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Positioned(
                top: 100,
                left: MediaQuery.of(context).size.width * 0.25,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isIncomeSelected = true;
                          });
                        },
                        child: Text('Income'),
                        style: TextButton.styleFrom(
                          foregroundColor: isIncomeSelected
                              ? Colors.white
                              : Colors.grey[350],
                          backgroundColor: isIncomeSelected
                              ? Color(0xFF2499C0)
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isIncomeSelected = false;
                          });
                        },
                        child: Text('Expense'),
                        style: TextButton.styleFrom(
                          foregroundColor: !isIncomeSelected
                              ? Colors.white
                              : Colors.grey[350],
                          backgroundColor: isIncomeSelected
                              ? Colors.transparent
                              : Color(0xFF2499C0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      isIncomeSelected
                          ? 'This month income'
                          : 'This month expense',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      formatRupiah(isIncomeSelected
                          ? totalIncome
                          : totalExpense),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isIncomeSelected ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                  Center(child: LineChartSample2()),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              isIncomeSelected ? 'Your recent income' : 'Your recent expense',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                SizedBox(height: 10),
                for (var transaction in isIncomeSelected
                    ? incomeTransactions
                    : expenseTransactions)
                  recentTransactionItem(
                      transaction['title'],
                      transaction['date'],
                      transaction['amount'],
                      isIncomeSelected),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return AddTransactionDialog(
                isIncomeSelected: isIncomeSelected,
                onAddTransaction: addTransaction,
              );
            },
          );
        },
        backgroundColor: isIncomeSelected ? Colors.green : Colors.red,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget recentTransactionItem(
      String title, dynamic date, int amount, bool isIncome) {

    DateTime transactionDate;
    if (date is String) {
      transactionDate = convertStringToDate(date); 
    } else {
      transactionDate = DateTime.fromMillisecondsSinceEpoch(date);
    }

    String formattedDate = DateFormat('MMMM d, yyyy').format(transactionDate);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(
            isIncome ? Icons.arrow_downward : Icons.arrow_upward,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
        title: Text(title),
        subtitle: Text(formattedDate),
        trailing: Text(
          formatRupiah(amount),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}

class AddTransactionDialog extends StatefulWidget {
  final bool isIncomeSelected;
  final Function(String, int, bool) onAddTransaction;

  const AddTransactionDialog({
    super.key,
    required this.isIncomeSelected,
    required this.onAddTransaction,
  });

  @override
  _AddTransactionDialogState createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _submit() {
  final title = _titleController.text;
  final amount = int.tryParse(_amountController.text);

  if (title.isEmpty || amount == null) {
    return;
  }

  print('Tombol Add ditekan: title=$title, amount=$amount, isIncome=${widget.isIncomeSelected}');
  
  widget.onAddTransaction(title, amount, widget.isIncomeSelected);

  Navigator.of(context).pop();
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Transaction'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Amount'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text('Add'),
        ),
      ],
    );
  }
}
