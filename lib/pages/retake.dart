// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:math';

// class AnimatedSparklinePainter extends CustomPainter {
//   final List<double> dataPoints;
//   final double progress;
//   final Color lineColor;
//   final Color fillColor;
//   final double lineWidth;

//   AnimatedSparklinePainter({
//     required this.dataPoints,
//     required this.progress,
//     required this.lineColor,
//     required this.fillColor,
//     required this.lineWidth,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (dataPoints.isEmpty) return;

//     final paint = Paint()
//       ..color = lineColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = lineWidth
//       ..strokeCap = StrokeCap.round
//       ..strokeJoin = StrokeJoin.round
//       ..isAntiAlias = true;

//     final fillPaint = Paint()
//       ..color = fillColor
//       ..style = PaintingStyle.fill
//       ..isAntiAlias = true;

//     double minY = dataPoints.reduce(min);
//     double maxY = dataPoints.reduce(max);
//     double range = maxY - minY;

//     final padding = size.height * 0.1;
//     final chartHeight = size.height - (padding * 2);

//     final points = <Offset>[];
//     final stepX = size.width / (dataPoints.length - 1);

//     for (int i = 0; i < dataPoints.length; i++) {
//       double x = i * stepX;
//       double normalizedY = (dataPoints[i] - minY) / range;
//       double y = size.height - padding - (normalizedY * chartHeight);
//       points.add(Offset(x, y));
//     }

//     final progressPoints =
//         points.take((points.length * progress).round()).toList();
//     if (progressPoints.length < 2) return;

//     final path = Path();
//     final fillPath = Path();

//     path.moveTo(progressPoints.first.dx, progressPoints.first.dy);
//     fillPath.moveTo(progressPoints.first.dx, size.height);
//     fillPath.lineTo(progressPoints.first.dx, progressPoints.first.dy);

//     if (progressPoints.length == 2) {
//       path.lineTo(progressPoints.last.dx, progressPoints.last.dy);
//       fillPath.lineTo(progressPoints.last.dx, progressPoints.last.dy);
//     } else {
//       for (int i = 1; i < progressPoints.length - 2; i++) {
//         final p0 = progressPoints[i - 1];
//         final p1 = progressPoints[i];
//         final p2 = progressPoints[i + 1];
//         final p3 = progressPoints[i + 2];

//         final t = 0.5;
//         final nb1x = (p2.dx - p0.dx) * t;
//         final nb1y = (p2.dy - p0.dy) * t;
//         final nb2x = (p3.dx - p1.dx) * t;
//         final nb2y = (p3.dy - p1.dy) * t;

//         path.cubicTo(
//           p1.dx + nb1x * 0.15,
//           p1.dy + nb1y * 0.15,
//           p2.dx - nb2x * 0.15,
//           p2.dy - nb2y * 0.15,
//           p2.dx,
//           p2.dy,
//         );
//         fillPath.cubicTo(
//           p1.dx + nb1x * 0.15,
//           p1.dy + nb1y * 0.15,
//           p2.dx - nb2x * 0.15,
//           p2.dy - nb2y * 0.15,
//           p2.dx,
//           p2.dy,
//         );
//       }

//       final lastPoints =
//           progressPoints.skip(progressPoints.length - 2).toList();
//       path.lineTo(lastPoints.last.dx, lastPoints.last.dy);
//       fillPath.lineTo(lastPoints.last.dx, lastPoints.last.dy);
//     }

//     fillPath.lineTo(progressPoints.last.dx, size.height);
//     fillPath.close();

//     canvas.drawShadow(path, Colors.black.withOpacity(0.1), 4, true);
//     canvas.drawPath(fillPath, fillPaint);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(AnimatedSparklinePainter oldDelegate) {
//     return oldDelegate.progress != progress;
//   }
// }

// class RetakePage extends StatefulWidget {
//   const RetakePage({super.key});

//   @override
//   State<RetakePage> createState() => _RetakePageState();
// }

// double getScreenWidth(BuildContext context) {
//   return MediaQuery.of(context).size.width;
// }

// double getScreenHeight(BuildContext context) {
//   return MediaQuery.of(context).size.height;
// }

// const Map<String, Map<String, List<double>>> sensexGraphData = {
//   'Sensex': {
//     '1D': [
//       85300.72,
//       98000.12,
//       92000.34,
//       100000.45,
//       96500.23,
//       105000.89,
//       93000.15,
//       98000.98
//     ],
//     '1W': [
//       110000.85,
//       103500.45,
//       106000.67,
//       112500.56,
//       110000.2,
//       108500.7,
//       114000.74,
//       115500.65
//     ],
//     '1M': [
//       120000.9,
//       113000.72,
//       117000.45,
//       118500.8,
//       115000.91,
//       116000.8,
//       121000.45,
//       119000.15
//     ],
//     'YTD': [
//       130000.5,
//       125000.75,
//       128500.15,
//       127500.85,
//       129500.35,
//       130500.25,
//       132000.55,
//       133500.45
//     ],
//     '1Y': [
//       135000.0,
//       130000.25,
//       133750.85,
//       134500.55,
//       132000.9,
//       131250.75,
//       130500.65,
//       133000.35
//     ],
//     '3Y': [
//       140000.0,
//       145000.45,
//       150000.5,
//       148500.6,
//       146500.45,
//       147000.6,
//       151000.35,
//       146000.2
//     ],
//   },
//   'Nifty 50': {
//     '1D': [
//       26500.15,
//       30000.25,
//       28550.3,
//       31000.45,
//       29520.5,
//       30080.3,
//       29060.6,
//       30540.4
//     ],
//     // ... (keep all other Nifty 50 data)
//   },
//   'BSE100': {
//     '1D': [
//       45500.85,
//       47000.65,
//       46280.4,
//       46000.1,
//       45350.6,
//       46650.7,
//       46040.8,
//       46400.2
//     ],
//     // ... (keep all other BSE100 data)
//   },
// };

// class RetakePage extends StatefulWidget {
//   const RetakePage({super.key});

//   @override
//   State<RetakePage> createState() => _RetakePageState();
// }

// class _RetakePageState extends State<RetakePage> with TickerProviderStateMixin {
//   String selectedDuration = "1D";
//   String selectedMarket = "Sensex";
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     selectedMarket = sensexGraphData.keys.first;
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOutCubic,
//     );
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void updateDuration(String duration) {
//     setState(() {
//       selectedDuration = duration;
//       _animationController.reset();
//       _animationController.forward();
//     });
//   }

//   void updateMarket(String market) {
//     setState(() {
//       selectedMarket = market;
//       _animationController.reset();
//       _animationController.forward();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = getScreenWidth(context);
//     final screenHeight = getScreenHeight(context);
//     final padding = screenWidth * 0.04;

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(screenHeight * 0.08),
//         child: AppBar(
//           title: Text(
//             'MarketsMojo',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: screenWidth * 0.06,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.cyan,
//           elevation: 1,
//           leading: Container(
//             alignment: Alignment.center,
//             margin: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 color: const Color(0xff9DCEFF),
//                 borderRadius: BorderRadius.circular(25)),
//             child: SvgPicture.asset(
//               'assets/icons/cross-close.svg',
//               height: 18,
//               width: 18,
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: screenHeight * 0.02),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: padding),
//               child: Text(
//                 'Indian Indices',
//                 style: TextStyle(
//                   fontSize: screenWidth * 0.05,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: padding),
//               child: _buildDurationButtons(screenWidth),
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             Center(
//               child: _buildMarketIndicesTable(screenWidth),
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: padding),
//               child: _buildMarketChart(screenWidth, screenHeight),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDurationButtons(double screenWidth) {
//     return Container(
//       width: screenWidth,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: ["1D", "1W", "1M", "YTD", "1Y", "3Y"].map((duration) {
//           return Expanded(
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 4),
//               child: _buildDurationButton(duration, screenWidth),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildDurationButton(String duration, double screenWidth) {
//     return SizedBox(
//       height: screenWidth * 0.08,
//       child: TextButton(
//         onPressed: () => updateDuration(duration),
//         style: TextButton.styleFrom(
//           backgroundColor:
//               selectedDuration == duration ? Colors.cyan : Colors.grey.shade200,
//           foregroundColor:
//               selectedDuration == duration ? Colors.white : Colors.black,
//           padding: EdgeInsets.zero,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(3),
//           ),
//         ),
//         child: Center(
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Text(
//               duration,
//               style: TextStyle(
//                 fontSize: screenWidth * 0.035,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMarketIndicesTable(double screenWidth) {
//     return Container(
//       width: screenWidth * 0.9,
//       child: SingleChildScrollView(
//         child: DataTable(
//           columnSpacing: screenWidth * 0.05,
//           horizontalMargin: screenWidth * 0.03,
//           dataRowHeight: screenWidth * 0.12,
//           headingRowHeight: screenWidth * 0.12,
//           showCheckboxColumn: false,
//           border: TableBorder.all(
//             color: Colors.grey.shade300,
//             width: 1,
//           ),
//           columns: ['Market', 'Price', 'Change']
//               .map((String column) => DataColumn(
//                     label: Container(
//                       width: screenWidth * 0.25,
//                       child: Text(
//                         column,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: screenWidth * 0.035,
//                         ),
//                       ),
//                     ),
//                   ))
//               .toList(),
//           rows: sensexGraphData.keys.map((market) {
//             final latestValue = sensexGraphData[market]?['1D']?.last ?? 0.0;
//             final previousValue = sensexGraphData[market]?['1D']?.first ?? 0.0;
//             final change = ((latestValue - previousValue) / previousValue * 100)
//                 .toStringAsFixed(2);
//             final isPositive = latestValue > previousValue;

//             return _buildMarketRow(
//                 market,
//                 latestValue.toStringAsFixed(2),
//                 '${isPositive ? '+' : ''}$change%',
//                 isPositive ? Colors.green : Colors.red,
//                 screenWidth);
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   DataRow _buildMarketRow(String market, String price, String change,
//       Color changeColor, double screenWidth) {
//     TextStyle cellStyle = TextStyle(fontSize: screenWidth * 0.035);

//     return DataRow(
//       selected: selectedMarket == market,
//       onSelectChanged: (_) => updateMarket(market),
//       color: MaterialStateProperty.resolveWith<Color>(
//         (Set<MaterialState> states) {
//           if (selectedMarket == market) {
//             return Colors.cyan.withOpacity(0.1);
//           }
//           return Colors.transparent;
//         },
//       ),
//       cells: [
//         DataCell(
//           Container(
//             width: screenWidth * 0.25,
//             child: Text(market, style: cellStyle),
//           ),
//         ),
//         DataCell(
//           Container(
//             width: screenWidth * 0.25,
//             child: Text(price, style: cellStyle),
//           ),
//         ),
//         DataCell(
//           Container(
//             width: screenWidth * 0.25,
//             child: Text(
//               change,
//               style: cellStyle.copyWith(color: changeColor),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMarketChart(double screenWidth, double screenHeight) {
//     final List<double> dataPoints =
//         sensexGraphData[selectedMarket]?[selectedDuration] ?? [];

//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Container(
//           height: screenHeight * 0.25,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 spreadRadius: 0,
//               ),
//             ],
//           ),
//           child: CustomPaint(
//             size: Size(screenWidth, screenHeight * 0.25),
//             painter: AnimatedSparklinePainter(
//               dataPoints: dataPoints,
//               progress: _animation.value,
//               lineColor: const Color.fromARGB(184, 66, 129, 32),
//               fillColor: Colors.green.withOpacity(0.1),
//               lineWidth: screenWidth * 0.003,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
