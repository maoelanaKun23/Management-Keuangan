import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({Key? key}) : super(key: key);

  @override
  State<LineChartSample1> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  // Data pemasukan dan pengeluaran
  final List<Map<String, dynamic>> incomeData = [
    {'date': '2024-03-01', 'amount': 500.0},
    {'date': '2024-03-03', 'amount': 800.0},
    {'date': '2024-03-05', 'amount': 1200.0},
    {'date': '2024-03-07', 'amount': 900.0},
    {'date': '2024-03-10', 'amount': 700.0},
    {'date': '2024-03-12', 'amount': 1100.0},
    {'date': '2024-03-14', 'amount': 1500.0},
  ];

  final List<Map<String, dynamic>> expenseData = [
    {'date': '2024-03-01', 'amount': 400.0},
    {'date': '2024-03-03', 'amount': 600.0},
    {'date': '2024-03-05', 'amount': 900.0},
    {'date': '2024-03-07', 'amount': 500.0},
    {'date': '2024-03-10', 'amount': 300.0},
    {'date': '2024-03-12', 'amount': 800.0},
    {'date': '2024-03-14', 'amount': 1200.0},
  ];

  // Konversi data pemasukan dan pengeluaran ke FlSpot
  List<FlSpot> mapDataToSpots(List<Map<String, dynamic>> data) {
    return data.asMap().entries.map((entry) {
      int index = entry.key;
      double amount = entry.value['amount'];
      return FlSpot(index.toDouble(), amount / 1000); // Skala Y dalam ribuan
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AspectRatio(
        aspectRatio: 1.23,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center, // Menjaga konten di tengah
              crossAxisAlignment: CrossAxisAlignment.center, // Menjaga chart tetap terpusat
              children: <Widget>[
                const SizedBox(height: 15),
                const Text(
                  'Your transaction statistics',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 2,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6), // Menjaga padding kiri dan kanan
                    child: Center( // Membuat chart tetap di tengah
                      child: LineChart(
                        isShowingMainData ? sampleData1 : sampleData2,
                        duration: const Duration(milliseconds: 250),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData get sampleData1 => LineChartData(
    lineTouchData: LineTouchData(enabled: true),
    gridData: const FlGridData(show: false),
    titlesData: FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: bottomTitleWidgets,
          reservedSize: 32,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 40,
        ),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: Colors.blueAccent, width: 2),
    ),
    lineBarsData: [
      LineChartBarData(
        isCurved: true,
        color: Colors.green, // Pemasukan
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
        spots: mapDataToSpots(incomeData),
      ),
      LineChartBarData(
        isCurved: true,
        color: Colors.red, // Pengeluaran
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
        spots: mapDataToSpots(expenseData),
      ),
    ],
  );

  LineChartData get sampleData2 => LineChartData(
    lineTouchData: LineTouchData(enabled: false),
    gridData: const FlGridData(show: false),
    titlesData: FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: bottomTitleWidgets,
          reservedSize: 32,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 40,
        ),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: Colors.redAccent, width: 2),
    ),
    lineBarsData: [
      LineChartBarData(
        isCurved: true,
        color: Colors.green.withOpacity(0.5), // Pemasukan dengan transparansi
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
        spots: mapDataToSpots(incomeData),
      ),
      LineChartBarData(
        isCurved: true,
        color: Colors.red.withOpacity(0.5), // Pengeluaran dengan transparansi
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
        spots: mapDataToSpots(expenseData),
      ),
    ],
  );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return Text('${(value * 1000).toInt()}',
        style: style, textAlign: TextAlign.center);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text = incomeData[value.toInt()]['date'];
    return Text(text.substring(5), style: style);
  }
}
