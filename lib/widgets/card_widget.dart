// import 'package:carousel_cards/circular_design.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

class CardWidget extends StatefulWidget {
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late Map<String, dynamic> apiData;
  bool isLoading = true;
  String selectedTab = "T1";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Dummy JSON data
    String jsonData = '''
    {
      "entrySide": "Entry Side",
      "date": "09 Aug,2024",
      "maxPAXShowUp": "180-210 mins",
      "totalPAX": 3340,
      "successRate": 80,
      "errorRate": 20,
      "successPAX": 3027,
      "digiYatra": 1515,
      "nonDigiYatra": 1512
    }
    ''';

    await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
    setState(() {
      apiData = json.decode(jsonData);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entry Card'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 310,
                child: Card(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      apiData['entrySide'],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(42, 42, 42, 1)),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: SvgPicture.asset(
                                          'assets/icons/Vector.svg',
                                          height: 14,
                                          width: 14,
                                        ))
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  apiData['date'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(74, 74, 74, 1),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTab = "T1";
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: selectedTab == "T1"
                                            ? Colors.purple
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "T1",
                                        style: TextStyle(
                                          color: selectedTab == "T1"
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTab = "T2";
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: selectedTab == "T2"
                                            ? Colors.purple
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "T2",
                                        style: TextStyle(
                                          color: selectedTab == "T2"
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/people.svg',
                                        height: 18,
                                        width: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Max PAX Show Up",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    74, 74, 74, 1)),
                                          ),
                                          // const SizedBox(height: 5),
                                          Text(
                                            apiData['maxPAXShowUp'],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color.fromRGBO(29, 29, 29, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    // height: 95,
                                    child: Center(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          // Circular background
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          // Circular progress arcs
                                          CustomPaint(
                                            size: Size(80, 80),
                                            painter:
                                                CircularProgressPainterWithGap(),
                                          ),
                                          // Centered text
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '3340',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Total PAX',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(110, 110, 110, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 177, 107, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Success Rate",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: Color.fromRGBO(
                                                      110, 110, 110, 1),
                                                ),
                                              ),
                                              Text(
                                                "${apiData['successRate']}%",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromRGBO(42, 42, 42, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(220, 69, 84, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Error Rate",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: Color.fromRGBO(
                                                      110, 110, 110, 1),
                                                ),
                                              ),
                                              Text(
                                                "${apiData['errorRate']}%",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromRGBO(42, 42, 42, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 1, 
                              height: 145, 
                              child: CustomPaint(
                                painter: DashedLinePainter(),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/user-tick.svg',
                                        height: 20,
                                        width: 19,
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Success PAX",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    74, 74, 74, 1)),
                                          ),
                                          Text(
                                            "${apiData['successPAX']}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color.fromRGBO(29, 29, 29, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  //column bar
                                  Container(
                                    // height: 80,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    108, 128, 189, 1),
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(8),
                                                  bottom: Radius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 14),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    244, 202, 224, 1),
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(8),
                                                  bottom: Radius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  108, 128, 189, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "DigiYatra",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: Color.fromRGBO(
                                                      110, 110, 110, 1),
                                                ),
                                              ),
                                              Text(
                                                "${apiData['digiYatra']}",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromRGBO(42, 42, 42, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      // Non-DigiYatra Column
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  244, 202, 224, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Non-DigiYatra",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: Color.fromRGBO(
                                                      110, 110, 110, 1),
                                                ),
                                              ),
                                              Text(
                                                "${apiData['nonDigiYatra']}",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromRGBO(42, 42, 42, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class CircularProgressPainterWithGap extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    // Green arc (77% of the circle with a gap)
    paint.color = Color.fromRGBO(0, 177, 107, 1);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.1, // Start angle in radians
      2 * 3.14159265 * 0.70,
      false,
      paint,
    );

    // Red arc (20% of the circle with a gap)
    paint.color = Color.fromRGBO(220, 69, 84, 1);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.1 + 2 * 3.14159265 * 0.75 + 0.05, // Start after green + gap
      2 * 3.14159265 * 0.20, // Sweep angle for 20%
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromRGBO(234, 236, 240, 1) 
      ..strokeWidth = size.width 
      ..style = PaintingStyle.stroke;

    double dashHeight = 5; 
    double dashSpace = 3; 
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
