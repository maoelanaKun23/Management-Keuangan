import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/dummyIncome.dart';
import '../models/dummyExpense.dart';

List<Map<String, dynamic>> dummyIncomes = dummyIncome;
List<Map<String, dynamic>> dummyExpenses = dummyExpense;

class BarChartSample extends StatefulWidget {
  const BarChartSample({Key? key}) : super(key: key);

  @override
  State<BarChartSample> createState() => BarChartSampleState();
}

class BarChartSampleState extends State<BarChartSample> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AspectRatio(
        aspectRatio: 1.23,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your transaction statistics',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(45, 0, 0, 2),
                    child: Center(
                      child: BarChart(
                        BarChartData(
                          barGroups: [
                            ...mapDataToBars(dummyIncomes, Colors.green),
                            ...mapDataToBars(dummyExpenses, Colors.red),
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

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return Text('${value.toInt()}',
        style: style, textAlign: TextAlign.center);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    int index = value.toInt();
    String text;

    if (index < dummyIncomes.length) {
      text = dummyIncomes[index]['date'];
    } else {
      index -= dummyIncomes.length;
      text = dummyExpenses[index]['date'];
    }

    DateTime date = DateTime.parse(text);
    String formattedDate = DateFormat('dd MMM').format(date);

    return Text(formattedDate, style: style); 
  }
}
