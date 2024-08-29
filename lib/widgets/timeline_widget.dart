import 'package:flutter/material.dart';
import 'package:kyla_test/models/expenditure_model.dart';
import 'package:kyla_test/utilities.dart';

class TimelineWidget extends StatefulWidget {
  final List<Expenditure> expenditureData;
  const TimelineWidget({super.key, required this.expenditureData});

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  late ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      _controller.animateTo(
          (DateTime.now().hour * 60 + DateTime.now().minute).toDouble() -
              MediaQuery.of(context).size.width / 2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInBack);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.w(context),
      ),
      height: 120,
      foregroundDecoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(MediaQuery.of(context).size.width - 20, 0),
            blurRadius: 100,
            spreadRadius: 20,
            blurStyle: BlurStyle.normal,
            color: const Color(0xFF21264C),
          ),
          BoxShadow(
            offset: Offset(MediaQuery.of(context).size.width / -1.1, 0),
            blurRadius: 100,
            spreadRadius: 20,
            blurStyle: BlurStyle.normal,
            color: const Color(0xFF21264C),
          ),
        ],
      ),
      child: SingleChildScrollView(
        controller: _controller,
        padding: EdgeInsets.only(left: 20.w(context), top: 40.w(context)),
        scrollDirection: Axis.horizontal,
        child: CustomPaint(
          size: const Size(1440, 100),
          painter: TimelinePainter(
              context: context,
              startTime: const TimeOfDay(hour: 0, minute: 0),
              expenditureData: widget.expenditureData,
              totalWidth: 1440),
        ),
      ),
    );
  }
}

class TimelinePainter extends CustomPainter {
  final BuildContext context;
  final TimeOfDay startTime;
  final List<Expenditure> expenditureData;
  final double totalWidth;

  TimelinePainter({
    required this.context,
    required this.startTime,
    required this.expenditureData,
    required this.totalWidth,
  });

  double _timeToXPosition(TimeOfDay time, double width) {
    final int startMinutes = startTime.hour * 60 + startTime.minute;
    final int eventMinutes = time.hour * 60 + time.minute;
    final int minutesFromStart = eventMinutes - startMinutes;

    final double minutesPerPixel = totalWidth / (24 * 60);
    return minutesFromStart * minutesPerPixel;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 2.0;

    final baselineY = size.height - 30;
    paint.color = Colors.blueGrey.withOpacity(0.1);
    canvas.drawLine(
      Offset(0, baselineY),
      Offset(size.width, baselineY),
      paint,
    );

    _drawTimeLabels(canvas, size, context);

    List<double> amounts = [];
    for (var element in expenditureData) {
      amounts.add(element.amount);
    }
    double maxAmount = 0;

    for (double amount in amounts) {
      if (amount > maxAmount) {
        maxAmount = amount;
      }
    }
    for (var element in expenditureData) {
      final double xPosition = _timeToXPosition(element.time, size.width);
      final double lineHeight = (element.amount / maxAmount * size.height);

      canvas.drawLine(
        Offset(xPosition, baselineY),
        Offset(xPosition, baselineY - lineHeight),
        paint..color = const Color(0xFFDD1D5A),
      );
    }
  }

  void _drawTimeLabels(Canvas canvas, Size size, BuildContext context) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    final paint = Paint()
      ..color = Colors.blueGrey.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (int hour = 0; hour <= 24; hour += 1) {
      final timeLabel = TimeOfDay(hour: (startTime.hour + hour) % 24, minute: 0);
      final textSpan = TextSpan(
        text: timeLabel.format(context),
        style: const TextStyle(
          color: Color(0xFF435297),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );

      textPainter.text = textSpan;
      textPainter.layout();

      final xPosition = _timeToXPosition(
        TimeOfDay(hour: (startTime.hour + hour) % 24, minute: 0),
        size.width,
      );

      canvas.drawCircle(Offset(xPosition, size.height - 30), 2, paint);

      textPainter.paint(
        canvas,
        Offset(xPosition - textPainter.width / 2, size.height - 20),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
