import 'package:flutter/material.dart';
import 'chart_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isIncomeSelected = true;
  double totalBalance = 90000;
  double totalIncome = 7000;
  double totalExpense = 472;

  List<Map<String, dynamic>> incomeTransactions = [
    {'title': 'Kedai Kopi', 'date': 'March 13, 2024', 'amount': 2000.0},
    {'title': 'Freelance Web Dev', 'date': 'March 6, 2024', 'amount': 1000.0},
    {'title': 'Zeus Motorworks', 'date': 'March 2, 2024', 'amount': 4000.0},
  ];

  List<Map<String, dynamic>> expenseTransactions = [
    {'title': 'Boarding House', 'date': 'March 10, 2024', 'amount': 200.0},
    {'title': 'Netflix', 'date': 'March 7, 2024', 'amount': 12.0},
    {'title': 'Consumption', 'date': 'March 3, 2024', 'amount': 250.0},
  ];

  void addTransaction(String title, double amount, bool isIncome) {
    setState(() {
      if (isIncome) {
        incomeTransactions.add({
          'title': title,
          'date': 'March 15, 2024',
          'amount': amount,
        });
        totalIncome += amount;
        totalBalance += amount;
      } else {
        expenseTransactions.add({
          'title': title,
          'date': 'March 15, 2024',
          'amount': amount,
        });
        totalExpense += amount;
        totalBalance -= amount;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2499C0),
        title: Text(
          'Hi, Yusuf!',
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
          // Stack untuk menempatkan komponen keluar dari container
          Stack(
            children: [
              // Widget di bawah (misalnya, kontainer utama)
              Container(
                width: MediaQuery.of(context).size.width * 1,
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
                      '\$${totalBalance.toStringAsFixed(2)}',
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
                left: MediaQuery.of(context).size.width *
                    0.25, // Tengah-tengah secara horizontal
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

          // Monthly Chart
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
                      '\$${isIncomeSelected ? totalIncome.toStringAsFixed(2) : totalExpense.toStringAsFixed(2)}',
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

          // Recent Transactions List
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
          addTransaction('New Transaction', 100.0, isIncomeSelected);
        },
        backgroundColor: isIncomeSelected ? Colors.green : Colors.red,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget recentTransactionItem(
      String title, String date, double amount, bool isIncome) {
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
        subtitle: Text(date),
        trailing: Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}