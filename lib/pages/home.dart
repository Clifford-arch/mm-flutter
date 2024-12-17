import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedDuration = "1D";
  String selectedMarket = "Sensex";

  // Expanded chart data configuration for different markets and durations
  final Map<String, Map<String, List<MarketData>>> _chartDataMap = {
    "Sensex": {
      "1D": [
        MarketData('9am', 70000, 21500),
        MarketData('10am', 71000, 21700),
        MarketData('11am', 71500, 21800),
        MarketData('12pm', 72000, 21900),
        MarketData('1pm', 72350, 21950),
        MarketData('2pm', 72400, 22000),
        MarketData('3pm', 72500, 22050),
      ],
      "1W": [
        MarketData('Mon', 70000, 21500),
        MarketData('Tue', 71000, 21700),
        MarketData('Wed', 71500, 21800),
        MarketData('Thu', 72000, 21900),
        MarketData('Fri', 72350, 21950),
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
      // Similar structure for other durations
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
      // Similar structure for other durations
    },
    // Add more markets as needed
  };

  void updateDuration(String duration) {
    setState(() {
      selectedDuration = duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MarketsMojo',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 1,
        leading: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color(0xff9DCEFF),
              borderRadius: BorderRadius.circular(25)),
          child: SvgPicture.asset(
            'assets/icons/cross-close.svg',
            height: 18,
            width: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Indian Indices',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Duration Selection Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildDurationButton("1D"),
                    const SizedBox(width: 10),
                    _buildDurationButton("1W"),
                    const SizedBox(width: 10),
                    _buildDurationButton("1M"),
                    const SizedBox(width: 10),
                    _buildDurationButton("YTD"),
                    const SizedBox(width: 10),
                    _buildDurationButton("1Y"),
                    const SizedBox(width: 10),
                    _buildDurationButton("3Y"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: _buildMarketIndicesTable(),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildMarketChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketIndicesTable() {
    return DataTable(
      columnSpacing: 110,
      border: TableBorder.all(
        color: Colors.grey.shade300,
        width: 1,
      ),
      columns: const [
        DataColumn(
          label: Text(
            'Market',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Price',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Change',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: [
        _buildMarketRow('Sensex', '72,350.45', '+0.52%', Colors.green),
        _buildMarketRow('Nifty 50', '21,950.10', '+0.35%', Colors.green),
        _buildMarketRow('BSE100', '48,750.25', '+0.68%', Colors.green),
        _buildMarketRow('BSE200', '72,350.45', '+0.52%', Colors.green),
        _buildMarketRow('BSE500', '72,350.45', '+0.52%', Colors.green),
      ],
    );
  }

  // DataRow _buildMarketRow(
  //     String market, String price, String change, Color changeColor) {
  //   return DataRow(
  //     color: MaterialStateProperty.resolveWith<Color?>(
  //         (Set<MaterialState> states) {
  //       // Change background color when selected
  //       if (states.contains(MaterialState.selected)) {
  //         return Colors.cyan.withOpacity(0.2);
  //       }
  //       return null; // Use default value
  //     }),
  //     selected: selectedMarket == market,
  //     onSelectChanged: (bool? selected) {
  //       if (selected != null && selected) {
  //         setState(() {
  //           selectedMarket = market;
  //         });
  //       }
  //     },
  //     cells: [
  //       DataCell(Text(market)),
  //       DataCell(Text(price)),
  //       DataCell(
  //         Text(
  //           change,
  //           style: TextStyle(color: changeColor),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  DataRow _buildMarketRow(
      String market, String price, String change, Color changeColor) {
    // return DataRow(
    //   selected: false, // This can still work for selection
    //   onSelectChanged: (isSelected) {
    //     // Handle row selection logic here
    //     print('$market selected: $isSelected');
    //   },
    //   cells: [
    //     DataCell(Row(
    //       children: [
    //         // Transparent Checkbox (effectively hides it)
    //         Opacity(
    //           opacity: 0, // Set opacity to 0 to hide
    //           child: Checkbox(
    //             value: false, // Set the checkbox state
    //             selected: selectedMarket == market,
    //             onChanged: (bool? value) {
    //               if (selected != null && selected) {
    //                 setState(() {
    //                   selectedMarket = market;
    //                 });
    //               }
    //             },
    //           ),
    //         ),
    //         Text(market),
    //       ],
    //     )),
    //     DataCell(Text(price)),
    //     DataCell(
    //       Text(
    //         change,
    //         style: TextStyle(color: changeColor),
    //       ),
    //     ),
    //   ],
    // );
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        // Change background color when selected
        if (states.contains(MaterialState.selected)) {
          return Colors.cyan.withOpacity(0.2);
        }
        return null; // Use default value
      }),
      selected: selectedMarket == market,
      onSelectChanged: (bool? selected) {
        if (selected != null) {
          setState(() {
            selectedMarket = market;
          });
        }
      },
      cells: [
        DataCell(Text(market)),
        DataCell(Text(price)),
        DataCell(
          Text(
            change,
            style: TextStyle(color: changeColor),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketChart() {
    // Get the chart data for the selected market and duration
    final List<MarketData> chartData =
        _chartDataMap[selectedMarket]?[selectedDuration] ?? [];

    return SfCartesianChart(
      // title: ChartTitle(text: _getChartTitle()),
      legend: Legend(isVisible: true),
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
          // title: AxisTitle(text: 'Value'),
          ),
      series: <CartesianSeries>[
        LineSeries<MarketData, String>(
          name: selectedMarket,
          dataSource: chartData,
          xValueMapper: (MarketData data, _) => data.time,
          yValueMapper: (MarketData data, _) => data.sensexValue,
          color: const Color.fromARGB(184, 66, 129, 32),
        ),
      ],
    );
  }

  String _getChartTitle() {
    return '$selectedMarket - ${_getDurationLabel()}';
  }

  String _getDurationLabel() {
    switch (selectedDuration) {
      case '1D':
        return '1 Day';
      case '1W':
        return '1 Week';
      case '1M':
        return '1 Month';
      case 'YTD':
        return 'Year to Date';
      case '1Y':
        return '1 Year';
      case '3Y':
        return '3 Years';
      default:
        return 'Market Performance';
    }
  }

  Widget _buildDurationButton(String duration) {
    return TextButton(
      onPressed: () {
        updateDuration(duration);
      },
      style: TextButton.styleFrom(
        backgroundColor:
            selectedDuration == duration ? Colors.cyan : Colors.grey.shade200,
        foregroundColor:
            selectedDuration == duration ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      child: Text(duration),
    );
  }
}

class MarketData {
  final String time;
  final num sensexValue;
  final num niftyValue;

  MarketData(this.time, this.sensexValue, this.niftyValue);
}
