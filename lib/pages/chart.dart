import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chart_sparkline/chart_sparkline.dart';

// Utility functions
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  String selectedDuration = "1D";
  String selectedMarket = "Sensex";

  // Chart data configuration
  final Map<String, Map<String, List<MarketData>>> _chartDataMap = {
    "Sensex": {
      "1D": [
        MarketData('9am', 70000, 21500),
        MarketData('10am', 81000, 21700),
        MarketData('11am', 61500, 21800),
        MarketData('12pm', 72000, 21900),
        MarketData('1pm', 72350, 21950),
        MarketData('2pm', 72400, 22000),
        MarketData('3pm', 72500, 22050),
      ],
      "1W": [
        MarketData('Mon', 70000, 21500),
        MarketData('Tue', 71000, 21700),
        MarketData('Wed', 71500, 21800),
        MarketData('Thu', 62000, 21900),
        MarketData('Fri', 42350, 21950),
      ],
      "1M": [
        MarketData('Week 1', 70000, 21500),
        MarketData('Week 2', 71000, 21700),
        MarketData('Week 3', 71500, 21800),
        MarketData('Week 4', 72000, 21900),
      ],
      "YTD": [
        MarketData('Jan', 70000, 21500),
        MarketData('Apr', 71000, 21700),
        MarketData('Jul', 71500, 21800),
        MarketData('Oct', 72000, 21900),
      ],
      "1Y": [
        MarketData('Jan 2023', 70000, 21500),
        MarketData('Apr 2023', 71000, 21700),
        MarketData('Jul 2023', 71500, 21800),
        MarketData('Oct 2023', 72000, 21900),
        MarketData('Jan 2024', 72350, 21950),
      ],
      "3Y": [
        MarketData('2021', 70000, 21500),
        MarketData('2022', 71000, 21700),
        MarketData('2023', 71500, 21800),
        MarketData('2024', 72000, 21900),
      ],
    },
    "Nifty 50": {
      "1D": [
        MarketData('9am', 21500, 6500),
        MarketData('10am', 21700, 6550),
        MarketData('11am', 21800, 6600),
        MarketData('12pm', 21900, 6650),
        MarketData('1pm', 21950, 6700),
        MarketData('2pm', 22000, 6750),
        MarketData('3pm', 22050, 6800),
      ],
      "1W": [
        MarketData('Mon', 21500, 6500),
        MarketData('Tue', 21700, 6550),
        MarketData('Wed', 21800, 6600),
        MarketData('Thu', 21900, 6650),
        MarketData('Fri', 21950, 6700),
      ],
      // Add other durations similarly
    },
    "BSE100": {
      "1D": [
        MarketData('9am', 48000, 14500),
        MarketData('10am', 48250, 14600),
        MarketData('11am', 48500, 14700),
        MarketData('12pm', 48750, 14800),
        MarketData('1pm', 48900, 14850),
        MarketData('2pm', 49000, 14900),
        MarketData('3pm', 49100, 14950),
      ],
      "1W": [
        MarketData('Mon', 48000, 14500),
        MarketData('Tue', 48250, 14600),
        MarketData('Wed', 48500, 14700),
        MarketData('Thu', 48750, 14800),
        MarketData('Fri', 48900, 14850),
      ],
      // Add other durations similarly
    },
  };

  void updateDuration(String duration) {
    setState(() {
      selectedDuration = duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = getScreenWidth(context);
    final screenHeight = getScreenHeight(context);
    final padding = screenWidth * 0.04;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          title: Text(
            'MarketsMojo',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.cyan,
          elevation: 1,
          leading: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: const Color(0xff9DCEFF),
              borderRadius: BorderRadius.circular(25),
            ),
            child: SvgPicture.asset(
              'assets/icons/cross-close.svg',
              height: screenWidth * 0.045,
              width: screenWidth * 0.045,
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Text(
                    'Indian Indices',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: _buildDurationButtons(screenWidth),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
                  child: _buildMarketIndicesTable(screenWidth),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: _buildMarketChart(screenWidth, screenHeight),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDurationButtons(double screenWidth) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ["1D", "1W", "1M", "YTD", "1Y", "3Y"]
            .map((duration) => Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.02),
                  child: _buildDurationButton(duration, screenWidth),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildDurationButton(String duration, double screenWidth) {
    return SizedBox(
      height: screenWidth * 0.1,
      child: TextButton(
        onPressed: () => updateDuration(duration),
        style: TextButton.styleFrom(
          backgroundColor:
              selectedDuration == duration ? Colors.cyan : Colors.grey.shade200,
          foregroundColor:
              selectedDuration == duration ? Colors.white : Colors.black,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.001,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        child: Text(
          duration,
          style: TextStyle(fontSize: screenWidth * 0.035),
        ),
      ),
    );
  }

  Widget _buildMarketIndicesTable(double screenWidth) {
    return Container(
      width: screenWidth * 1.2,
      child: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: screenWidth * 0.05,
          horizontalMargin: screenWidth * 0.03,
          dataRowHeight: screenWidth * 0.12,
          headingRowHeight: screenWidth * 0.12,
          border: TableBorder.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          columns: ['Market', 'Price', 'Change']
              .map((String column) => DataColumn(
                      label: Container(
                    width: screenWidth * 0.3,
                    child: Text(
                      column,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  )))
              .toList(),
          rows: [
            _buildMarketRow(
                'Sensex', '72,350.45', '+0.52%', Colors.green, screenWidth),
            _buildMarketRow(
                'Nifty 50', '21,950.10', '+0.35%', Colors.green, screenWidth),
            _buildMarketRow(
                'BSE100', '48,750.25', '+0.68%', Colors.green, screenWidth),
            _buildMarketRow(
                'BSE200', '72,350.45', '+0.52%', Colors.green, screenWidth),
            _buildMarketRow(
                'BSE500', '72,350.45', '+0.52%', Colors.green, screenWidth),
          ],
        ),
      ),
    );
  }

  DataRow _buildMarketRow(String market, String price, String change,
      Color changeColor, double screenWidth) {
    TextStyle cellStyle = TextStyle(fontSize: screenWidth * 0.035);

    return DataRow(
      selected: selectedMarket == market,
      onSelectChanged: (bool? selected) {
        if (selected != null) {
          setState(() {
            selectedMarket = market;
          });
        }
      },
      cells: [
        DataCell(Text(market, style: cellStyle)),
        DataCell(Text(price, style: cellStyle)),
        DataCell(Text(
          change,
          style: cellStyle.copyWith(color: changeColor),
        )),
      ],
    );
  }

  Widget _buildMarketChart(double screenWidth, double screenHeight) {
    final List<MarketData> chartData =
        _chartDataMap[selectedMarket]?[selectedDuration] ?? [];
    final List<double> dataPoints =
        chartData.map((data) => data.sensexValue.toDouble()).toList();

    return Container(
      height: screenHeight * 0.25,
      child: Sparkline(
        data: dataPoints,
        lineWidth: screenWidth * 0.005,
        lineColor: const Color.fromARGB(184, 66, 129, 32),
        fillMode: FillMode.below,
        fillColor: Colors.cyan.withOpacity(0.1),
        pointsMode: PointsMode.all,
        pointSize: screenWidth * 0.012,
        pointColor: Colors.cyan,
        useCubicSmoothing: true,
        enableGridLines: true,
        gridLineColor: Colors.grey.withOpacity(0.2),
        gridLineLabelColor: Colors.transparent,
      ),
    );
  }
}

class MarketData {
  final String time;
  final num sensexValue;
  final num niftyValue;

  MarketData(this.time, this.sensexValue, this.niftyValue);
}
