import 'package:flutter/material.dart';

class HeaderWave extends StatelessWidget {
  const HeaderWave({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      // color: Colors.red,
      child: CustomPaint(
        painter: _HeaderWavePainter(),
      ),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  // Gradient
  final Rect rect = Rect.fromCircle(center: const Offset(155, 0), radius: 180);
  final Gradient gradiente = const LinearGradient(
    colors: [
      //  Colors.green,
      Color.fromRGBO(93, 240, 152, 1),
      Color.fromRGBO(26, 202, 99, 1)
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.7, 1],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = gradiente.createShader(rect)
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final path = Path();

    path.moveTo(size.width * 0.2, 0);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.38,
        size.width * 0.45, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.1,
        size.width * 0.85, size.height * 0.7);
    path.quadraticBezierTo(
        size.width * 0.90, size.height * 1.1, size.width, size.height);

    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class FooterWave extends StatelessWidget {
  const FooterWave({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      // color: Colors.red,
      child: CustomPaint(
        painter: _FooterWavePainter(),
      ),
    );
  }
}

class _FooterWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Gradient
    final Rect rect =
        Rect.fromCircle(center: const Offset(155, 0), radius: 180);
    const Gradient gradiente = LinearGradient(
      colors: [
        //  Colors.green,
        Color.fromRGBO(93, 240, 152, 1),
        Color.fromRGBO(26, 202, 99, 1)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.5, 1],
    );

    final paint = Paint()
      ..shader = gradiente.createShader(rect)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final path = Path();

    path.lineTo(0, size.height * 0.3);
    path.quadraticBezierTo(
        size.width * 0.15, 0, size.width * 0.3, size.height * 0.2);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.5, size.width * 0.5, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
