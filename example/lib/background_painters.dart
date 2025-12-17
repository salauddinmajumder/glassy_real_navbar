import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

// =============================================================================
// 1. AURORA BOREALIS
// =============================================================================
class AuroraPainter extends CustomPainter {
  final double time;
  AuroraPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    // Dark starry background
    final Paint bg = Paint()..color = const Color(0xFF0B1026);
    canvas.drawRect(rect, bg);

    // Aurora ribbons
    for (int i = 0; i < 3; i++) {
      final double shift = i * 2.0;
      final Path path = Path();
      path.moveTo(0, size.height * 0.4 + math.sin(time + shift) * 50);
      
      for (double x = 0; x <= size.width; x += 10) {
        final double y = math.sin(x * 0.005 + time * 1.5 + shift) * 60 +
                         math.sin(x * 0.01 + time + shift) * 40;
        path.lineTo(x, size.height * (0.4 + i * 0.15) + y);
      }
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();

      final List<Color> colors = i == 0 
          ? [Colors.greenAccent.withOpacity(0.3), Colors.transparent] 
          : i == 1 
              ? [Colors.purpleAccent.withOpacity(0.2), Colors.transparent]
              : [Colors.cyanAccent.withOpacity(0.2), Colors.transparent];

      final Paint ribbon = Paint()
        ..shader = ui.Gradient.linear(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height),
          colors,
        )
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
      
      canvas.drawPath(path, ribbon);
    }
  }
  @override
  bool shouldRepaint(AuroraPainter oldDelegate) => oldDelegate.time != time;
}

// =============================================================================
// 2. CYBER GRID
// =============================================================================
class CyberGridPainter extends CustomPainter {
  final double time;
  CyberGridPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = ui.Gradient.linear(
          Offset(0, 0), Offset(0, size.height), [Colors.deepPurple.shade900, Colors.black]);
    canvas.drawRect(Offset.zero & size, bg);

    final Paint gridPaint = Paint()
      ..color = Colors.pinkAccent.withOpacity(0.5)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Horizon at 30% height
    final double horizonY = size.height * 0.3;
    final double centerX = size.width / 2;

    // Moving horizontal lines (Perspective)
    final double speed = (time * 100) % 50;
    for (double i = 0; i < size.height; i += 50) {
      final double y = horizonY + i + speed;
      if (y > size.height) continue;
      // Fade out near horizon
      final double opacity = ((y - horizonY) / (size.height - horizonY)).clamp(0.0, 1.0);
      gridPaint.color = Colors.pinkAccent.withOpacity(opacity * 0.8);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Vertical diverging lines
    for (double i = -1000; i <= 1000; i += 100) {
      final double xStart = centerX + i; // At bottom
      final double xEnd = centerX + (i * 0.1); // At horizon (converging)
       
      gridPaint.color = Colors.pinkAccent.withOpacity(0.5);
      canvas.drawLine(Offset(xEnd, horizonY), Offset(xStart, size.height), gridPaint);
    }
    
    // Sun
    final Paint sunPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, horizonY - 100), Offset(0, horizonY), 
        [Colors.yellowAccent, Colors.redAccent]
      );
    canvas.drawCircle(Offset(centerX, horizonY - 40), 60, sunPaint);
  }
  @override
  bool shouldRepaint(CyberGridPainter oldDelegate) => oldDelegate.time != time;
}

// =============================================================================
// 3. STAR FIELD
// =============================================================================
class StarFieldPainter extends CustomPainter {
  final double time;
  StarFieldPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.black, BlendMode.src);
    final math.Random random = math.Random(42); // Fixed seed for stability

    for (int i = 0; i < 200; i++) {
      final double z = (random.nextDouble() * 2.0 + 0.5); // Depth
      final double speed = (time * 50 / z) % size.width;
      final double x = (random.nextDouble() * size.width - speed) % size.width;
      final double y = random.nextDouble() * size.height;
      if (x < 0) continue; // Wrap handled by modulo but safety check

      final double radius = 1.5 / z;
      final double opacity = (1.0 / z).clamp(0.1, 1.0);
      
      canvas.drawCircle(
        Offset(x, y), 
        radius, 
        Paint()..color = Colors.white.withOpacity(opacity)
      );
    }
  }
  @override
  bool shouldRepaint(StarFieldPainter oldDelegate) => oldDelegate.time != time;
}

// =============================================================================
// 4. DEEP OCEAN
// =============================================================================
class DeepOceanPainter extends CustomPainter {
  final double time;
  DeepOceanPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    // Deep Blue Gradient
    final Rect rect = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero, Offset(0, size.height), 
        [Color(0xFF001E3C), Color(0xFF000814)]
      );
    canvas.drawRect(rect, bg);

    // Light Rays
    canvas.save();
    canvas.translate(size.width / 2, -100);
    canvas.rotate(0.2);
    for (int i = 0; i < 5; i++) {
        final double opacity = (math.sin(time + i) * 0.1 + 0.15).clamp(0.0, 1.0);
        final Paint rayPaint = Paint()
           ..shader = ui.Gradient.linear(
             Offset(0, 0), Offset(0, size.height * 1.5),
             [Colors.white.withOpacity(opacity), Colors.transparent]
           );
        
        final double width = 50.0 + i * 20;
        final double x = (i - 2) * 100.0;
        canvas.drawRect(Rect.fromLTWH(x, 0, width, size.height * 1.5), rayPaint);
    }
    canvas.restore();

    // Caustics / Bubbles
    final math.Random rnd = math.Random(123);
    for (int i = 0; i < 20; i++) {
      final double t = time * (0.5 + rnd.nextDouble());
      final double y = (size.height - (t * 50 + rnd.nextDouble() * size.height) % (size.height + 50));
      final double x = rnd.nextDouble() * size.width + math.sin(y * 0.01 + t) * 20;
      
      canvas.drawCircle(
        Offset(x, y), 
        rnd.nextDouble() * 5 + 1, 
        Paint()..color = Colors.white.withOpacity(0.1)
      );
    }
  }
  @override
  bool shouldRepaint(DeepOceanPainter oldDelegate) => oldDelegate.time != time;
}

// =============================================================================
// 5. MESH GRADIENT
// =============================================================================
class MeshGradientPainter extends CustomPainter {
  final double time;
  MeshGradientPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    // Moving blobs
    void drawBlob(double xSeed, double ySeed, Color color, double scale) {
      final double x = size.width * (0.5 + 0.4 * math.sin(time * 0.5 + xSeed));
      final double y = size.height * (0.5 + 0.4 * math.cos(time * 0.3 + ySeed));
      final double radius = size.width * scale;
      
      final Paint p = Paint()
        ..color = color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
      canvas.drawCircle(Offset(x, y), radius, p);
    }
    
    canvas.drawColor(Colors.white, BlendMode.src);
    drawBlob(0, 1, Colors.pinkAccent.withOpacity(0.6), 0.6);
    drawBlob(2, 3, Colors.blueAccent.withOpacity(0.6), 0.7);
    drawBlob(4, 5, Colors.yellowAccent.withOpacity(0.4), 0.8);
    drawBlob(1, 6, Colors.purpleAccent.withOpacity(0.5), 0.5);
  }
  @override
  bool shouldRepaint(MeshGradientPainter oldDelegate) => true;
}

// =============================================================================
// 6. HEX HIVE
// =============================================================================
class HexHivePainter extends CustomPainter {
  final double time;
  HexHivePainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(const Color(0xFF111111), BlendMode.src);
    final double hexSize = 40.0;
    final double w = math.sqrt(3) * hexSize;
    final double h = 2 * hexSize;
    
    final Paint paint = Paint()
      ..style = PaintingStyle.fill;

    for (double y = -h; y < size.height + h; y += h * 0.75) {
      bool offset = ((y / (h * 0.75)).floor() % 2) != 0;
      for (double x = -w; x < size.width + w; x += w) {
        final double dx = offset ? x + w / 2 : x;
        
        final double dist = math.sqrt((dx - size.width/2)*(dx - size.width/2) + (y - size.height/2)*(y - size.height/2));
        final double wave = math.sin(dist * 0.01 - time * 2);
        
        // Only draw if wave peak
        if (wave > 0.0) {
          paint.color = Color.lerp(Colors.orange.shade900, Colors.amber, wave)!.withOpacity(wave * 0.5);
          _drawHex(canvas, Offset(dx, y), hexSize * 0.9, paint);
        }
      }
    }
  }

  void _drawHex(Canvas canvas, Offset center, double size, Paint paint) {
    final Path path = Path();
    for (int i = 0; i < 6; i++) {
      final double angle = (60 * i + 30) * math.pi / 180;
      final double x = center.dx + size * math.cos(angle);
      final double y = center.dy + size * math.sin(angle);
      if (i == 0) path.moveTo(x, y);
      else path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HexHivePainter oldDelegate) => true;
}

// =============================================================================
// 7. RAINY GLASS
// =============================================================================
class RainyGlassPainter extends CustomPainter {
  final double time;
  RainyGlassPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    // Dark animated background
    final Paint bg = Paint()..shader = ui.Gradient.linear(
       Offset(0,0), Offset(size.width, size.height), 
       [Colors.blueGrey.shade900, Colors.black]
    );
    canvas.drawRect(Offset.zero & size, bg);

    final math.Random rnd = math.Random(999);
    
    // Streaks
    final Paint streakPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 50; i++) {
      final double x = rnd.nextDouble() * size.width;
      final double speed = rnd.nextDouble() * 20 + 10;
      final double y = (time * speed + rnd.nextDouble() * size.height) % (size.height + 100);
      
      canvas.drawLine(Offset(x, y), Offset(x, y - 20), streakPaint);
    }
  }
  @override
  bool shouldRepaint(RainyGlassPainter oldDelegate) => true;
}

// =============================================================================
// 8. BOKEH NIGHT
// =============================================================================
class BokehNightPainter extends CustomPainter {
  final double time;
  BokehNightPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(const Color(0xFF050510), BlendMode.src);
    
    final rnd = math.Random(101);
    for (int i = 0; i < 30; i++) {
       final double cx = rnd.nextDouble() * size.width;
       final double cy = rnd.nextDouble() * size.height;
       final double radius = rnd.nextDouble() * 50 + 20;
       
       final double opacityBase = rnd.nextDouble() * 0.3;
       final double pulse = math.sin(time + i) * 0.1;
       
       final Color c = i % 2 == 0 ? Colors.purple : Colors.blue;
       
       canvas.drawCircle(Offset(cx, cy), radius, Paint()..color = c.withOpacity((opacityBase + pulse).clamp(0.0, 1.0))..maskFilter = MaskFilter.blur(BlurStyle.normal, 20));
    }
  }
  @override
  bool shouldRepaint(BokehNightPainter oldDelegate) => true;
}

// =============================================================================
// 9. MATRIX RAIN
// =============================================================================
class MatrixRainPainter extends CustomPainter {
  final double time;
  MatrixRainPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.black, BlendMode.src);
    final textStyle = TextStyle(color: Colors.greenAccent, fontSize: 14, fontFamily: 'Monospace');
    final textSpan = TextSpan(text: '1 0 1 0 0 1', style: textStyle);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    
    final rnd = math.Random(555);
    final int cols = (size.width / 20).floor();
    
    for (int i = 0; i < cols; i++) {
       final double speed = rnd.nextDouble() * 50 + 50;
       final double y = (time * speed + rnd.nextDouble() * size.height) % size.height;
       
       textPainter.text = TextSpan(
           text: String.fromCharCode(rnd.nextInt(2) == 0 ? 48 : 49), // 0 or 1
           style: TextStyle(color: Colors.greenAccent.withOpacity(rnd.nextDouble()), fontSize: 14));
       textPainter.layout();
       
       // Draw trail
       for (int k = 0; k < 10; k++) {
          textPainter.paint(canvas, Offset(i * 20.0, y - k * 14));
       }
    }
  }
  @override
  bool shouldRepaint(MatrixRainPainter oldDelegate) => true;
}

// =============================================================================
// 10. GEOMETRIC ABSTRACT
// =============================================================================
class GeometricAbstractPainter extends CustomPainter {
  final double time;
  GeometricAbstractPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.white, BlendMode.src);
    
    final Paint p = Paint()..style = PaintingStyle.fill;
    
    canvas.save();
    canvas.translate(size.width/2, size.height/2);
    
    for (int i = 0; i < 10; i++) {
       canvas.save();
       canvas.rotate(time * (0.1 + i * 0.05));
       final double s = 200.0 - i * 15;
       p.color = (i % 2 == 0 ? Colors.black : Colors.white).withOpacity(0.1);
       if (i%3==0) p.color = Colors.orangeAccent.withOpacity(0.5);
       
       canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: s, height: s), p);
       canvas.restore();
    }
    
    canvas.restore();
  }
  @override
  bool shouldRepaint(GeometricAbstractPainter oldDelegate) => true;
}

// =============================================================================
// 11. NOISE GRAIN
// =============================================================================
class NoiseGrainPainter extends CustomPainter {
  final double time;
  NoiseGrainPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.grey.shade300, BlendMode.src);
    final rnd = math.Random();
    
    final Paint p = Paint()..color = Colors.black.withOpacity(0.1)..strokeWidth=1;
    
    // Draw simplified noise (too many points is slow, just sparse noise)
    for (int i = 0; i < 2000; i++) {
        canvas.drawPoints(ui.PointMode.points, [Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height)], p);
    }
  }
  @override
  bool shouldRepaint(NoiseGrainPainter oldDelegate) => true;
}
