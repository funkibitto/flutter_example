import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class AnimatedCardWidget extends StatefulWidget {
  const AnimatedCardWidget({Key? key}) : super(key: key);
  static const String routeName = '/examples/animated_card_widget';

  @override
  _AnimatedCardWidgetState createState() => _AnimatedCardWidgetState();
}

class _AnimatedCardWidgetState extends State<AnimatedCardWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late SequenceAnimation sequenceAnimation;
  int multiplier = 5;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500 * multiplier),
    );

    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween<double>(begin: 1.0, end: 0.55),
          from: const Duration(milliseconds: 0),
          to: Duration(milliseconds: 160 * multiplier),
          tag: 'scale',
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0, end: pi / 2),
          from: Duration(milliseconds: 160 * multiplier),
          to: Duration(milliseconds: 200 * multiplier),
          tag: 'rotate',
        )
        .addAnimatable(
          animatable: Tween<Offset>(
              begin: const Offset(0.0, 0.0), end: const Offset(-400, 0)),
          from: Duration(milliseconds: 200 * multiplier),
          to: Duration(milliseconds: 600 * multiplier),
          curve: Curves.elasticOut,
          tag: 'translate',
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0.9, end: 1.0),
          from: Duration(milliseconds: 600 * multiplier),
          to: Duration(milliseconds: 900 * multiplier),
          curve: Curves.elasticOut,
          tag: 'bouncing',
        )
        .animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedCardWidget'),
      ),
      body: AnimatedBuilder(animation: controller, builder: _buildAnimation),
    );
  }

  void _handleAnimation() {
    if (controller.isCompleted) {
      controller.reset();
    } else {
      controller.forward();
    }
  }

  Widget _buildCard({required onClicked}) {
    return GestureDetector(
      child: RotatedBox(
        quarterTurns: 3,
        child: Image.asset(
          'assets/images/visa_card.png',
        ),
      ),
      onTap: onClicked,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Transform.scale(
        scale: sequenceAnimation['scale'].value,
        child: Transform.rotate(
          angle: sequenceAnimation['rotate'].value,
          child: Transform.translate(
            offset: sequenceAnimation['translate'].value,
            child: Transform.scale(
              scale: sequenceAnimation['bouncing'].value,
              child: _buildCard(onClicked: _handleAnimation),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildAnimation(BuildContext context, Widget? child) {
  //   return ScaleTransition(
  //           scale: sequenceAnimation['scale'].value,
  //           child: RotationTransition(
  //             turns: sequenceAnimation['rotate'].value,
  //             child: ScaleTransition(
  //                 scale: sequenceAnimation['bouncing'].value,
  //                 child: _buildCard(onClicked: _handleAnimation),),
  //           ),
  //         );

  // }
}
