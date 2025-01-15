import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BarChartSample extends StatelessWidget {
  final List<Map<String, dynamic>> incomeTransactions;
  final List<Map<String, dynamic>> expenseTransactions;

  const BarChartSample({
    Key? key,
    required this.incomeTransactions,
    required this.expenseTransactions,
  }) : super(key: key);

  List<BarChartGroupData> mapDataToBars(List<Map<String, dynamic>> data, Color color) {
    return data.asMap().entries.map((entry) {
      int index = entry.key;
      int amount = entry.value['amount'];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: amount.toDouble(),
            color: color,
            width: 15,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    }).toList();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return Text('${value.toInt()}', style: style, textAlign: TextAlign.center);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    int index = value.toInt();
    String text;

    if (index < incomeTransactions.length) {
      text = incomeTransactions[index]['date'];
    } else {
      index -= incomeTransactions.length;
      text = expenseTransactions[index]['date'];
    }

    DateTime date = DateTime.parse(text);
    String formattedDate = DateFormat('dd MMM').format(date);

    return Text(formattedDate, style: style);
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          ...mapDataToBars(incomeTransactions, Colors.green),
          ...mapDataToBars(expenseTransactions, Colors.red),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              getTitlesWidget: bottomTitleWidgets,
              reservedSize: 32,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 40,
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.blueAccent, width: 2),
        ),
      ),
    );
  }
}
