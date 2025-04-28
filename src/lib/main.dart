import 'package:flutter/material.dart';

class RelaxPage extends StatefulWidget {
  const RelaxPage({Key? key}) : super(key: key);

  @override
  State<RelaxPage> createState() => _RelaxPageState();
}

class _RelaxPageState extends State<RelaxPage> {
  final int _totalPages = 3;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F0E7), // Cream background color
      body: SafeArea(
        child: Column(
          children: [
            // Back and Skip buttons
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                    onPressed: () {
                      // Handle back button press
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle skip button press
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Title
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Relax',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Lorem ipsum text
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Main illustration
                    Expanded(
                      child: Center(
                        child: RelaxIllustration(),
                      ),
                    ),

                    // Page indicator dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _totalPages,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? const Color(0xFF1E293B)
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Next button
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF1E293B),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentPage = (_currentPage + 1) % _totalPages;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget for the relaxation illustration
class RelaxIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 300),
      painter: RelaxScenePainter(),
    );
  }
}

// Custom painter to draw the relaxation scene
class RelaxScenePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    // Draw sofa/couch (main area)
    paint.color = const Color(0xFFFF9B6B); // Orange couch color
    final RRect couch = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.1, size.height * 0.4, size.width * 0.8,
          size.height * 0.25),
      const Radius.circular(15),
    );
    canvas.drawRRect(couch, paint);

    // Draw coffee table
    paint.color = const Color(0xFFD2915B); // Wooden table color
    final RRect table = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.25, size.height * 0.7, size.width * 0.5,
          size.height * 0.1),
      const Radius.circular(10),
    );
    canvas.drawRRect(table, paint);

    // Draw person
    paint.color = const Color(0xFFFF9CAE); // Skin tone
    final Rect personBody = Rect.fromLTWH(size.width * 0.3, size.height * 0.3,
        size.width * 0.4, size.height * 0.2);
    canvas.drawOval(personBody, paint);

    // Draw head
    final Rect head = Rect.fromLTWH(size.width * 0.45, size.height * 0.2,
        size.width * 0.1, size.height * 0.1);
    canvas.drawOval(head, paint);

    // Draw plant
    paint.color = const Color(0xFF4CAF50); // Green
    final Rect plantTop = Rect.fromLTWH(size.width * 0.1, size.height * 0.2,
        size.width * 0.1, size.height * 0.1);
    canvas.drawOval(plantTop, paint);

    // Draw plant pot
    paint.color = const Color(0xFFBF8A6B); // Pot color
    final Rect plantPot = Rect.fromLTWH(size.width * 0.1, size.height * 0.3,
        size.width * 0.1, size.height * 0.1);
    canvas.drawRect(plantPot, paint);

    // Draw side table
    paint.color = const Color(0xFFD2915B); // Wooden table color
    final Rect sideTable = Rect.fromLTWH(size.width * 0.7, size.height * 0.3,
        size.width * 0.2, size.height * 0.2);
    canvas.drawRect(sideTable, paint);

    // Draw book/objects on side table
    paint.color = Colors.blue.shade200;
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.75, size.height * 0.32, size.width * 0.1,
            size.height * 0.03),
        paint);
    paint.color = Colors.red.shade200;
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.75, size.height * 0.36, size.width * 0.1,
            size.height * 0.03),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Usage example
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RelaxPage(),
  ));
}
