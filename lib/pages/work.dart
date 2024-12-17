import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chart_sparkline/chart_sparkline.dart';

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

const Map<String, Map<String, List<double>>> sensexGraphData = {
  'Sensex': {
    '1D': [
      85300.72,
      98000.12,
      92000.34,
      100000.45,
      96500.23,
      105000.89,
      93000.15,
      98000.98
    ],
    '1W': [
      110000.85,
      103500.45,
      106000.67,
      112500.56,
      110000.2,
      108500.7,
      114000.74,
      115500.65
    ],
    '1M': [
      120000.9,
      113000.72,
      117000.45,
      118500.8,
      115000.91,
      116000.8,
      121000.45,
      119000.15
    ],
    'YTD': [
      130000.5,
      125000.75,
      128500.15,
      127500.85,
      129500.35,
      130500.25,
      132000.55,
      133500.45
    ],
    '1Y': [
      135000.0,
      130000.25,
      133750.85,
      134500.55,
      132000.9,
      131250.75,
      130500.65,
      133000.35
    ],
    '3Y': [
      140000.0,
      145000.45,
      150000.5,
      148500.6,
      146500.45,
      147000.6,
      151000.35,
      146000.2
    ],
  },
  'Nifty 50': {
    '1D': [
      26500.15,
      30000.25,
      28550.3,
      31000.45,
      29520.5,
      30080.3,
      29060.6,
      30540.4
    ],
    '1W': [
      31500.5,
      32000.8,
      32520.1,
      33000.65,
      31520.5,
      32350.9,
      32850.3,
      33020.4
    ],
    '1M': [
      33500.25,
      33700.15,
      33000.85,
      33500.35,
      34000.1,
      33300.5,
      33800.6,
      34100.7
    ],
    'YTD': [
      35000.45,
      34200.25,
      34800.75,
      34950.55,
      34500.65,
      34000.6,
      35200.85,
      34550.45
    ],
    '1Y': [
      37000.5,
      36720.1,
      37500.2,
      38000.3,
      37300.6,
      36850.45,
      37550.8,
      37200.35
    ],
    '3Y': [
      38000.75,
      38850.6,
      39300.55,
      40000.4,
      39600.3,
      39520.6,
      40500.3,
      39650.4
    ],
  },
  'BSE100': {
    '1D': [
      45500.85,
      47000.65,
      46280.4,
      46000.1,
      45350.6,
      46650.7,
      46040.8,
      46400.2
    ],
    '1W': [
      47500.6,
      46980.9,
      47420.45,
      47270.5,
      47390.85,
      47850.6,
      47290.8,
      47530.75
    ],
    '1M': [
      48550.25,
      49100.75,
      49000.6,
      49220.2,
      48750.45,
      49130.3,
      49010.1,
      48980.7
    ],
    'YTD': [
      49050.6,
      48520.5,
      48000.8,
      48710.9,
      48530.75,
      48020.3,
      48850.6,
      48900.1
    ],
    '1Y': [
      50000.35,
      50520.1,
      50150.6,
      51000.4,
      50590.8,
      50460.7,
      51080.6,
      50820.5
    ],
    '3Y': [
      51000.2,
      52050.4,
      52510.6,
      52850.5,
      51580.3,
      52010.75,
      53000.2,
      52520.4
    ],
  },
  // Add other indices as needed
};

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  String selectedDuration = "1D";
  String selectedMarket = "Sensex";

  @override
  void initState() {
    super.initState();
    selectedMarket = sensexGraphData.keys.first;
  }

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
      ),
      body: SingleChildScrollView(
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
            Center(
              child: _buildMarketIndicesTable(screenWidth),
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: _buildMarketChart(screenWidth, screenHeight),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildDurationButtons(double screenWidth) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       children: ["1D", "1W", "1M", "YTD", "1Y", "3Y"]
  //           .map((duration) => Padding(
  //                 padding: EdgeInsets.only(right: screenWidth * 0.02),
  //                 child: _buildDurationButton(duration, screenWidth),
  //               ))
  //           .toList(),
  //     ),
  //   );
  // }

  // Widget _buildDurationButton(String duration, double screenWidth) {
  //   return SizedBox(
  //     height: screenWidth * 0.08,
  //     child: TextButton(
  //       onPressed: () => updateDuration(duration),
  //       style: TextButton.styleFrom(
  //         backgroundColor:
  //             selectedDuration == duration ? Colors.cyan : Colors.grey.shade200,
  //         foregroundColor:
  //             selectedDuration == duration ? Colors.white : Colors.black,
  //         padding: EdgeInsets.symmetric(
  //           horizontal: screenWidth * 0.03,
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(3),
  //         ),
  //       ),
  //       child: Text(
  //         duration,
  //         style: TextStyle(fontSize: screenWidth * 0.035),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildDurationButtons(double screenWidth) {
    return Container(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ["1D", "1W", "1M", "YTD", "1Y", "3Y"].map((duration) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: _buildDurationButton(duration, screenWidth),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDurationButton(String duration, double screenWidth) {
    return SizedBox(
      height: screenWidth * 0.08,
      child: TextButton(
        onPressed: () => updateDuration(duration),
        style: TextButton.styleFrom(
          backgroundColor:
              selectedDuration == duration ? Colors.cyan : Colors.grey.shade200,
          foregroundColor:
              selectedDuration == duration ? Colors.white : Colors.black,
          padding: EdgeInsets.zero, // Remove padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              duration,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildMarketIndicesTable(double screenWidth) {
  //   return Container(
  //     width: screenWidth * 0.9,
  //     child: SingleChildScrollView(
  //       // scrollDirection: Axis.horizontal,
  //       child: DataTable(
  //         columnSpacing: screenWidth * 0.05,
  //         horizontalMargin: screenWidth * 0.03,
  //         dataRowHeight: screenWidth * 0.12,
  //         headingRowHeight: screenWidth * 0.12,
  //         border: TableBorder.all(
  //           color: Colors.grey.shade300,
  //           width: 1,
  //         ),
  //         columns: ['Market', 'Price', 'Change']
  //             .map((String column) => DataColumn(
  //                   label: Container(
  //                     width: screenWidth * 0.25,
  //                     child: Text(
  //                       column,
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: screenWidth * 0.035,
  //                       ),
  //                     ),
  //                   ),
  //                 ))
  //             .toList(),
  //         rows: sensexGraphData.keys.map((market) {
  //           final latestValue = sensexGraphData[market]?['1D']?.last ?? 0.0;
  //           final previousValue = sensexGraphData[market]?['1D']?.first ?? 0.0;
  //           final change = ((latestValue - previousValue) / previousValue * 100)
  //               .toStringAsFixed(2);
  //           final isPositive = latestValue > previousValue;

  //           return _buildMarketRow(
  //               market,
  //               latestValue.toStringAsFixed(2),
  //               '${isPositive ? '+' : ''}$change%',
  //               isPositive ? Colors.green : Colors.red,
  //               screenWidth);
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }

  // DataRow _buildMarketRow(String market, String price, String change,
  //     Color changeColor, double screenWidth) {
  //   TextStyle cellStyle = TextStyle(fontSize: screenWidth * 0.035);

  //   return DataRow(
  //     selected: selectedMarket == market,
  //     onSelectChanged: (bool? selected) {
  //       if (selected != null) {
  //         setState(() {
  //           selectedMarket = market;
  //         });
  //       }
  //     },
  //     cells: [
  //       DataCell(
  //         Container(
  //           width: screenWidth * 0.25,
  //           child: Text(market, style: cellStyle),
  //         ),
  //       ),
  //       DataCell(
  //         Container(
  //           width: screenWidth * 0.25,
  //           child: Text(price, style: cellStyle),
  //         ),
  //       ),
  //       DataCell(
  //         Container(
  //           width: screenWidth * 0.25,
  //           child: Text(
  //             change,
  //             style: cellStyle.copyWith(color: changeColor),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildMarketIndicesTable(double screenWidth) {
    return Container(
      width: screenWidth * 0.9,
      child: SingleChildScrollView(
        child: DataTable(
          columnSpacing: screenWidth * 0.05,
          horizontalMargin: screenWidth * 0.03,
          dataRowHeight: screenWidth * 0.12,
          headingRowHeight: screenWidth * 0.12,
          showCheckboxColumn: false, // Remove checkbox column
          border: TableBorder.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          columns: ['Market', 'Price', 'Change']
              .map((String column) => DataColumn(
                    label: Container(
                      width: screenWidth * 0.25,
                      child: Text(
                        column,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          rows: sensexGraphData.keys.map((market) {
            final latestValue = sensexGraphData[market]?['1D']?.last ?? 0.0;
            final previousValue = sensexGraphData[market]?['1D']?.first ?? 0.0;
            final change = ((latestValue - previousValue) / previousValue * 100)
                .toStringAsFixed(2);
            final isPositive = latestValue > previousValue;

            return _buildMarketRow(
                market,
                latestValue.toStringAsFixed(2),
                '${isPositive ? '+' : ''}$change%',
                isPositive ? Colors.green : Colors.red,
                screenWidth);
          }).toList(),
        ),
      ),
    );
  }

  DataRow _buildMarketRow(String market, String price, String change,
      Color changeColor, double screenWidth) {
    TextStyle cellStyle = TextStyle(fontSize: screenWidth * 0.035);

    return DataRow(
      selected: selectedMarket == market,
      onSelectChanged: (_) {
        setState(() {
          selectedMarket = market;
        });
      },
      color: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          // Return different colors based on selection state
          if (selectedMarket == market) {
            return Colors.cyan.withOpacity(0.1);
          }
          return Colors.transparent;
        },
      ),
      cells: [
        DataCell(
          Container(
            width: screenWidth * 0.25,
            child: Text(market, style: cellStyle),
          ),
        ),
        DataCell(
          Container(
            width: screenWidth * 0.25,
            child: Text(price, style: cellStyle),
          ),
        ),
        DataCell(
          Container(
            width: screenWidth * 0.25,
            child: Text(
              change,
              style: cellStyle.copyWith(color: changeColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketChart(double screenWidth, double screenHeight) {
    final List<double> dataPoints =
        sensexGraphData[selectedMarket]?[selectedDuration] ?? [];

    return Container(
      height: screenHeight * 0.25,
      child: Sparkline(
        data: dataPoints,
        lineWidth: screenWidth * 0.005,
        lineColor: const Color.fromARGB(184, 66, 129, 32),
        fillMode: FillMode.below,
        fillColor: Colors.green.withOpacity(0.5),
        pointsMode: PointsMode.all,
        pointSize: screenWidth * 0.012,
        // pointColor: Colors.cyan,
        useCubicSmoothing: true,
        enableGridLines: true,
        gridLineColor: Colors.grey.withOpacity(0.2),
        gridLineLabelColor: Colors.transparent,
      ),
    );
  }
}
