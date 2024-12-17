import 'package:flutter/material.dart';

class MarketData {
  final String name;
  final double value;
  final double change;

  MarketData({
    required this.name,
    required this.value,
    required this.change,
  });
}

class MarketsOverviewPage extends StatelessWidget {
  final marketData = [
    MarketData(name: 'SENSEX', value: 52133.12, change: 843.16),
    MarketData(name: 'NIFTY', value: 24768.50, change: 239.60),
    MarketData(name: 'BSE100', value: 24274.29, change: 189.11),
    MarketData(name: 'BSE200', value: 11441.71, change: 64.92),
    MarketData(name: 'BSE800', value: 3646.51, change: 107.41),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Markets Overview'),
      ),
      body: ListView.builder(
        itemCount: marketData.length,
        itemBuilder: (context, index) {
          final data = marketData[index];
          return Card(
            child: ListTile(
              title: Text(data.name),
              trailing: Text(
                '${data.value.toStringAsFixed(2)} (${data.change.toStringAsFixed(2)}%)',
                style: TextStyle(
                  color: data.change >= 0 ? Colors.green : Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Markets Overview',
    home: MarketsOverviewPage(),
  ));
}