import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:kyla_test/utilities.dart';

class NotificationWidget extends StatefulWidget {
  final BehaviorSubject<bool> swipeStream;

  const NotificationWidget({
    super.key,
    required this.swipeStream,
  });

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController expansionController;
  late AnimationController collapseController;
  late AnimationController _shadowBlinkingController;
  late Animation<double> _topPositionAnimation;
  late Animation<double> _expansionAnimation;
  late Animation<double> _shadowAnimation;
  late StreamSubscription<bool> _notificationSubscription;
  late Animation<double> _collapseAnimation;

  @override
  void initState() {
    _notificationSubscription = widget.swipeStream.stream.listen((bool hasNotification) {
      if (hasNotification) {
        showNotification();
      }
    });
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));
    expansionController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    collapseController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _shadowBlinkingController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _topPositionAnimation = Tween<double>(begin: 60, end: 140).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
    _expansionAnimation = Tween<double>(begin: 50, end: 200).animate(
      CurvedAnimation(parent: expansionController, curve: Curves.easeIn),
    );
    _collapseAnimation = Tween<double>(begin: 200, end: 1).animate(
      CurvedAnimation(parent: collapseController, curve: Curves.easeIn),
    );

    _shadowAnimation = Tween<double>(begin: 0, end: 16).animate(
      CurvedAnimation(parent: _shadowBlinkingController, curve: Curves.easeInCubic),
    );

    _controller.addListener(_handleController);
    expansionController.addStatusListener(_handleExpansionAnimationStatus);
    collapseController.addStatusListener(_handleCollapseAnimationStatus);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_handleController);
    expansionController.removeStatusListener(_handleExpansionAnimationStatus);
    collapseController.removeStatusListener(_handleCollapseAnimationStatus);

    _controller.dispose();
    expansionController.dispose();
    collapseController.dispose();
    _shadowBlinkingController.dispose();
    _notificationSubscription.cancel();

    super.dispose();
  }

  void _handleController() {
    if (_controller.value >= 0.6) {
      expansionController.forward();
    }
  }

  void _handleExpansionAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _shadowBlinkingController.repeat();
    }
  }

  void _handleCollapseAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _resetControllers();
    }
  }

  void _resetControllers() {
    widget.swipeStream.sink.add(false);

    _controller.reset();
    expansionController.reset();
    collapseController.reset();
    _shadowBlinkingController.reset();
  }

  void showNotification() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return AnimatedBuilder(
      animation: Listenable.merge(
        [_controller, expansionController, _shadowBlinkingController, collapseController],
      ),
      builder: (context, child) {
        double? leftPosition = collapseController.value == 0
            ? null
            : (screenWidth / 2 - _collapseAnimation.value / 2) * (1 - collapseController.value);

        double containerWidth = collapseController.value > 0
            ? _collapseAnimation.value
            : (_expansionAnimation.value + _shadowAnimation.value * 4).w(context);

        double opacityValue = collapseController.value > 0.5 ? 1 - collapseController.value : 1;

        double containerHeight = (50 + _shadowAnimation.value * 2).w(context);
        double innerContainerWidth = collapseController.value > 0
            ? _collapseAnimation.value
            : _expansionAnimation.value + _shadowAnimation.value * 2;
        return Positioned(
          left: leftPosition,
          top: _topPositionAnimation.value - _shadowAnimation.value,
          child: Opacity(
            opacity: opacityValue,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx.isNegative) {
                  _shadowBlinkingController.stop();
                  collapseController.forward();
                }
              },
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                children: [
                  Container(
                    width: containerWidth,
                    height: containerHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.w(context)),
                      color: Colors.red.withOpacity(0.2),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.all(10.w(context)),
                    alignment: Alignment.center,
                    width: innerContainerWidth,
                    height: 50.w(context),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(color: Colors.black, spreadRadius: 1, blurRadius: 6)
                      ],
                      borderRadius: BorderRadius.circular(25.w(context)),
                      color: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_expansionAnimation.value >= 100 && _collapseAnimation.value > 180)
                          const Icon(
                            Icons.local_fire_department_outlined,
                            color: Colors.white,
                          ),
                        if (_expansionAnimation.value >= 180 && _collapseAnimation.value > 130)
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 110.w(context),
                            ),
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              text: const TextSpan(
                                text: 'You are too close to the daily limit.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 8,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Only \$5.34 left',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (_expansionAnimation.value >= 100 && _collapseAnimation.value > 180)
                          Icon(
                            Icons.close,
                            color: Colors.black.withOpacity(0.1),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:kyla_test/utilities.dart';
//
// class NotificationWidget extends StatefulWidget {
//   final StreamController<bool> streamController;
//
//   const NotificationWidget({
//     super.key,
//     required this.streamController,
//   });
//
//   @override
//   State<NotificationWidget> createState() => _NotificationWidgetState();
// }
//
// class _NotificationWidgetState extends State<NotificationWidget> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late AnimationController expansionController;
//   late AnimationController collapseController;
//   late AnimationController _shadowBlinkingController;
//   late Animation<double> _topPositionAnimation;
//   late Animation<double> _expansionAnimation;
//   late Animation<double> _collapseAnimation;
//   late Animation<double> _shadowAnimation;
//   late StreamSubscription<bool> _notificationSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _notificationSubscription = widget.streamController.stream.listen((bool hasNotification) {
//       if (hasNotification) {
//         showNotification();
//       }
//     });
//
//     _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1300));
//     expansionController =
//         AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
//     collapseController =
//         AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
//     _shadowBlinkingController =
//         AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
//
//     _topPositionAnimation = Tween<double>(begin: 60, end: 140).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
//     );
//     _expansionAnimation = Tween<double>(begin: 50, end: 200).animate(
//       CurvedAnimation(parent: expansionController, curve: Curves.easeIn),
//     );
//     _collapseAnimation = Tween<double>(begin: 200, end: 1).animate(
//       CurvedAnimation(parent: collapseController, curve: Curves.easeIn),
//     );
//     _shadowAnimation = Tween<double>(begin: 0, end: 16).animate(
//       CurvedAnimation(parent: _shadowBlinkingController, curve: Curves.easeInCubic),
//     );
//
//     _controller.addListener(_handleController);
//     expansionController.addStatusListener(_handleExpansionAnimationStatus);
//     collapseController.addStatusListener(_handleCollapseAnimationStatus);
//   }
//
//   @override
//   void dispose() {
//     _controller.removeListener(_handleController);
//     expansionController.removeStatusListener(_handleExpansionAnimationStatus);
//     collapseController.removeStatusListener(_handleCollapseAnimationStatus);
//
//     _controller.dispose();
//     expansionController.dispose();
//     collapseController.dispose();
//     _shadowBlinkingController.dispose();
//     _notificationSubscription.cancel();
//
//     super.dispose();
//   }
//
//   void _handleController() {
//     if (_controller.value >= 0.6) {
//       expansionController.forward();
//     }
//   }
//
//   void _handleExpansionAnimationStatus(AnimationStatus status) {
//     if (status == AnimationStatus.completed) {
//       _shadowBlinkingController.repeat();
//     }
//   }
//
//   void _handleCollapseAnimationStatus(AnimationStatus status) {
//     if (status == AnimationStatus.completed) {
//       _resetControllers();
//     }
//   }
//
//   void _resetControllers() {
//     _controller.reset();
//     expansionController.reset();
//     collapseController.reset();
//     _shadowBlinkingController.reset();
//   }
//
//   void showNotification() {
//     _controller.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//
//     double? leftPosition = collapseController.value == 0
//         ? null
//         : (screenWidth / 2 - _collapseAnimation.value / 2) * (1 - collapseController.value);
//
//     double containerWidth = collapseController.value > 0
//         ? _collapseAnimation.value
//         : (_expansionAnimation.value + _shadowAnimation.value * 4).w(context);
//
//     double opacityValue = collapseController.value > 0.5 ? 1 - collapseController.value : 1;
//
//     double containerHeight = (50 + _shadowAnimation.value * 2).w(context);
//     double innerContainerWidth = collapseController.value > 0
//         ? _collapseAnimation.value
//         : _expansionAnimation.value + _shadowAnimation.value * 2;
//
//     return AnimatedBuilder(
//       animation: Listenable.merge(
//         [_controller, expansionController, _shadowBlinkingController, collapseController],
//       ),
//       builder: (context, child) {
//         return Positioned(
//           left: leftPosition,
//           top: _topPositionAnimation.value - _shadowAnimation.value,
//           child: Opacity(
//             opacity: opacityValue,
//             child: GestureDetector(
//               onHorizontalDragUpdate: (details) {
//                 if (details.delta.dx.isNegative) {
//                   _shadowBlinkingController.stop();
//                   collapseController.forward();
//                 }
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 clipBehavior: Clip.hardEdge,
//                 children: [
//                   Container(
//                     width: containerWidth,
//                     height: containerHeight,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50.w(context)),
//                       color: Colors.red.withOpacity(0.2),
//                     ),
//                   ),
//                   Container(
//                     clipBehavior: Clip.hardEdge,
//                     padding: EdgeInsets.all(10.w(context)),
//                     alignment: Alignment.center,
//                     width: innerContainerWidth,
//                     height: 50.w(context),
//                     decoration: BoxDecoration(
//                       boxShadow: const [
//                         BoxShadow(color: Colors.black, spreadRadius: 1, blurRadius: 6)
//                       ],
//                       borderRadius: BorderRadius.circular(25.w(context)),
//                       color: Colors.red,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (_expansionAnimation.value >= 100 && _collapseAnimation.value > 180)
//                           const Icon(
//                             Icons.local_fire_department_outlined,
//                             color: Colors.white,
//                           ),
//                         if (_expansionAnimation.value >= 180 && _collapseAnimation.value > 130)
//                           ConstrainedBox(
//                             constraints: BoxConstraints(
//                               maxWidth: 110.w(context),
//                             ),
//                             child: RichText(
//                               maxLines: 2,
//                               overflow: TextOverflow.fade,
//                               text: const TextSpan(
//                                 text: 'You are too close to the daily limit.',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w300,
//                                   fontSize: 8,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                     text: ' Only \$5.34 left',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 8,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         if (_expansionAnimation.value >= 100 && _collapseAnimation.value > 180)
//                           Icon(
//                             Icons.close,
//                             color: Colors.black.withOpacity(0.1),
//                           )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
