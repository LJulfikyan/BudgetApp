import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kyla_test/models/expenditure_model.dart';
import 'package:kyla_test/utilities.dart';
import 'package:kyla_test/widgets/more_widget.dart';
import 'package:rxdart/rxdart.dart';

class ExpenditureWidget extends StatefulWidget {
  final Expenditure expenditure;
  final Function onItemSwiped;
  final BehaviorSubject<bool> swipeStream;
  const ExpenditureWidget(
      {super.key,
      required this.expenditure,
      required this.onItemSwiped,
      required this.swipeStream});

  @override
  State<ExpenditureWidget> createState() => _ExpenditureWidgetState();
}

class _ExpenditureWidgetState extends State<ExpenditureWidget> with SingleTickerProviderStateMixin {
  bool isSwipedLeft = false;
  late AnimationController _controller;
  bool isNotified = false;

  @override
  void initState() {
    widget.swipeStream.stream.listen((onData) {
      if (isSwipedLeft && !onData) {
        isSwipedLeft = onData;
        setState(() {});
        _controller.reverse();
      }
    });
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    super.initState();
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (details.delta.dx.isNegative && !isSwipedLeft) {
      isSwipedLeft = true;
      _controller.forward();
      if (!isNotified) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          isNotified = true;
          widget.onItemSwiped();
        });
      }
      setState(() {});
    } else if (!details.delta.dx.isNegative && isSwipedLeft) {
      isSwipedLeft = false;
      isNotified = false;
      setState(() {});
      Future.delayed(const Duration(milliseconds: 100), () {
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedGreenActionWidget(
          isSwipedLeft: isSwipedLeft,
        ),
        AnimatedBuilder(
          builder: (context, child) {
            return Positioned(
              left: MediaQuery.of(context).size.width * 0.9 * _controller.value / -2,
              child: GestureDetector(
                onHorizontalDragUpdate: onDragUpdate,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 100.w(context),
                  padding: EdgeInsets.all(16.w(context)),
                  decoration: BoxDecoration(
                    color: const Color(0xFF29305A),
                    // color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100.w(context)),
                      bottomRight: Radius.circular(100.w(context)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50.w(context),
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF435297).withOpacity(0.5),
                            width: 0.5,
                          ),
                        ),
                        child: Icon(
                          widget.expenditure.type!.getIcon(),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20.w(context),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '- \$ ${widget.expenditure.amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFDD1D5A),
                            ),
                          ),
                          Text(
                            widget.expenditure.name!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: const Color(0xFF435297),
                                size: 12.w(context),
                              ),
                              Text(
                                widget.expenditure.address!,
                                style: TextStyle(
                                  overflow: TextOverflow.fade,
                                  fontSize: 10.w(context),
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xFF435297),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        widget.expenditure.time.format(context).toString(),
                        style: TextStyle(
                          fontSize: 10.w(context),
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF435297),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          animation: _controller,
        ),
      ],
    );
  }
}
