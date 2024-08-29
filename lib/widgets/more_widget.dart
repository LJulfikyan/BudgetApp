import 'package:flutter/material.dart';

class AnimatedGreenActionWidget extends StatefulWidget {
  final bool isSwipedLeft;

  const AnimatedGreenActionWidget({super.key, required this.isSwipedLeft});

  @override
  State<AnimatedGreenActionWidget> createState() => _AnimatedGreenActionWidgetState();
}

class _AnimatedGreenActionWidgetState extends State<AnimatedGreenActionWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _widthAnimationController;
  late Animation<double> _widthAnimation;
  late Animation<double> _heightAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      reverseDuration: const Duration(milliseconds: 150),
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _widthAnimationController = AnimationController(
      reverseDuration: const Duration(milliseconds: 150),
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _widthAnimation = Tween<double>(begin: 0, end: 160).animate(
      CurvedAnimation(parent: _widthAnimationController, curve: Curves.easeInOut),
    );

    _heightAnimation = Tween<double>(begin: 0, end: 60).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _colorAnimation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.transparent, end: const Color(0xFF91b81d)),
          weight: 100,
        ),
      ],
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isSwipedLeft) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _controller.forward();
        _widthAnimationController.forward();
      });
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedGreenActionWidget oldWidget) {
    if (widget.isSwipedLeft != oldWidget.isSwipedLeft) {
      if (widget.isSwipedLeft) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _controller.forward();
          _widthAnimationController.forward();
        });
      } else {
        _widthAnimationController.reverse();
        _widthAnimationController.addListener(widthAnimationControllerListener);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _widthAnimationController.removeListener(widthAnimationControllerListener);
    _controller.dispose();
    _widthAnimationController.dispose();
    super.dispose();
  }

  void widthAnimationControllerListener() {
    if (_widthAnimationController.value <= 0.75) {
      _controller.reverse();
      _widthAnimationController.removeListener(widthAnimationControllerListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.95 - MediaQuery.of(context).size.width * 0.9 / 2,
      right: 0,
      top: 10,
      bottom: 10,
      child: Center(
        child: AnimatedBuilder(
          animation: _widthAnimationController,
          builder: (context, child) {
            double currentWidth = _widthAnimation.value;
            return Container(
              width: currentWidth,
              height: _heightAnimation.value,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.circular(
                  _heightAnimation.value / 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_widthAnimation.value > 100)
                    Icon(
                      Icons.send,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  if (_widthAnimation.value > 100)
                    VerticalDivider(
                      color: Colors.black.withOpacity(0.2),
                      thickness: 1,
                      width: 10,
                      indent: 10,
                      endIndent: 10,
                    ),
                  if (_widthAnimation.value > 60)
                    Icon(
                      Icons.edit,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  if (_widthAnimation.value > 100)
                    VerticalDivider(
                      color: Colors.black.withOpacity(0.2),
                      thickness: 1,
                      width: 10,
                      indent: 10,
                      endIndent: 10,
                    ),
                  if (_widthAnimation.value > 100)
                    Icon(
                      Icons.delete,
                      color: Colors.white.withOpacity(0.5),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
