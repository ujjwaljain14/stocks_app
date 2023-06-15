import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LineChartWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  LineChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    double prevValue = 9223372036854775807.toDouble();
    List interval_values=[9223372036854775807, 0];
    List<FlSpot> spots = data.entries.map((entry) {
      if(entry.value < interval_values[0]) {
          interval_values[0] = entry.value;
      }
      if(entry.value > interval_values[1]) {
        interval_values[1] = entry.value;
      }
      DateTime time = DateTime.parse(entry.key);
      double value = entry.value;
      return FlSpot(time.microsecondsSinceEpoch.toDouble(), value);
    }).toList();

    return Container(
      // Set the desired height
      padding: EdgeInsets.all(1.h),
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                getTooltipItems: (touchedSpots){
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    const TextStyle textStyle = TextStyle(
                      color: Colors.white, // Set the color of the tooltip text
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    );
                    return LineTooltipItem(
                      '${touchedSpot.y}',
                      textStyle,
                    );
                  }).toList();
                },
              ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.green,
              barWidth: 2,
              isStrokeCapRound: true,

              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.green,
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade900,
                    Colors.black,
                  ],

                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )
              )
            ),
          ],
          minX: spots.first.x+10,
          maxX: spots.last.x,
          minY: spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b),
          maxY: spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: SideTitles(
                showTitles: true,
            )),
            leftTitles: AxisTitles(sideTitles:
              SideTitles(showTitles: true,
                reservedSize: 10.w,
                interval: (data.length/6).round().toDouble(),
                getTitlesWidget: (value, meta) {
                if((prevValue - value).abs() >  ((interval_values[1] - interval_values[0])/6).round()){
                  prevValue = value;
                  return SizedBox(child: Text(value.round().toString(),overflow: TextOverflow.visible, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),));
                }
                return const SizedBox(height: 0,width: 0,);
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),),
          ),
          gridData: FlGridData(
            drawHorizontalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.white24,
                strokeWidth: 1,
              );
            },
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.white24,
                strokeWidth: 1,
              );
            },
          ),
        ),
      ),
    );
  }
}
