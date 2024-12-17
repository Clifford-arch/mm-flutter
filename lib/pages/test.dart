import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String selectedDuration = "1D";

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
          margin: EdgeInsets.all(10),
          child: SvgPicture.asset(
            'assets/icons/cross-close.svg',
            height: 18,
            width: 18,
          ),
          decoration: BoxDecoration(
              color: Color(0xff9DCEFF),
              borderRadius: BorderRadius.circular(25)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Indian Indices',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildDurationButton("1D"),
                SizedBox(width: 10),
                _buildDurationButton("1W"),
                SizedBox(width: 10),
                _buildDurationButton("1M"),
                SizedBox(width: 10),
                _buildDurationButton("YTD"),
                SizedBox(width: 10),
                _buildDurationButton("1Y"),
                SizedBox(width: 10),
                _buildDurationButton("3Y"),
              ],
            ),
          ),
          // SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Text(
          //     'Selected Duration: $selectedDuration',
          //     style: TextStyle(
          //       fontSize: 18,
          //       fontWeight: FontWeight.w500,
          //       color: Colors.grey.shade800,
          //     ),
          //   ),
          // ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DataTable(
              columnSpacing: 120,
              border: TableBorder.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              columns: [
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
                DataRow(cells: [
                  DataCell(Text('Sensex')),
                  DataCell(Text('72,350.45')),
                  DataCell(
                    Text(
                      '+0.52%',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ]),
                DataRow(cells: [
                  DataCell(Text('Nifty 50')),
                  DataCell(Text('21,950.10')),
                  DataCell(
                    Text(
                      '+0.35%',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ]),
                DataRow(cells: [
                  DataCell(Text('BSE100')),
                  DataCell(Text('48,750.25')),
                  DataCell(
                    Text(
                      '+0.68%',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ]),
                DataRow(cells: [
                  DataCell(Text('BSE200')),
                  DataCell(Text('72,350.45')),
                  DataCell(
                    Text(
                      '+0.52%',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ]),
                DataRow(cells: [
                  DataCell(Text('BSE500')),
                  DataCell(Text('72,350.45')),
                  DataCell(
                    Text(
                      '+0.52%',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
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
