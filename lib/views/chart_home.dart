import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineChartSample2 extends StatefulWidget {
  final List<Map<String, dynamic>> incomeTransactions;
  final List<Map<String, dynamic>> expenseTransactions;

  const LineChartSample2({
    Key? key,
    required this.incomeTransactions,
    required this.expenseTransactions,
  }) : super(key: key);

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 0,
              left: 30,
              top: 10,
              bottom: 12,
            ),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: SizedBox(
            width: 60,
            height: 34,
            child: TextButton(
              onPressed: () {
                setState(() {
                  showAvg = !showAvg;
                });
              },
              child: Text(
                'avg',
                style: TextStyle(
                  fontSize: 12,
                  color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    List<FlSpot> incomeSpots = [];
    List<FlSpot> expenseSpots = [];

    for (int i = 0; i < widget.incomeTransactions.length; i++) {
      incomeSpots.add(FlSpot(i.toDouble(), widget.incomeTransactions[i]['amount'].toDouble()));
    }

    for (int i = 0; i < widget.expenseTransactions.length; i++) {
      expenseSpots.add(FlSpot(i.toDouble(), widget.expenseTransactions[i]['amount'].toDouble()));
    }

    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false), 
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false), 
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false), 
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: widget.incomeTransactions.length.toDouble(),
      minY: 0,
      maxY: 10000000,
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipRoundedRadius: 8,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((spot) {
              final value = formatter.format(spot.y);
              return LineTooltipItem(
                value,
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: incomeSpots,
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(show: true, gradient: LinearGradient(colors: gradientColors.map((color) => color.withOpacity(0.3)).toList())),
        ),
        LineChartBarData(
          spots: expenseSpots,
          isCurved: true,
          gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(show: true, gradient: LinearGradient(colors: [Colors.red.withOpacity(0.3), Colors.orange.withOpacity(0.3)])),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!.withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!.withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
