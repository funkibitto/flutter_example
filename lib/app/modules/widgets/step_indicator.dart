import 'package:flutter/material.dart';

class StepIndicator extends StatefulWidget {
  StepIndicator({
    Key? key,
    required this.steps,
    required this.pageController,
    this.isPassed = false,
    this.indicatorColor = const Color(0xFFC8E6C9),
    this.padding = 10.0,
  }) : super(key: key);

  final List<String> steps;
  final PageController pageController;
  bool isPassed;
  Color indicatorColor;
  double padding;

  @override
  _StepIndicatorState createState() => _StepIndicatorState();
}

class _StepIndicatorState extends State<StepIndicator> {
  int _maxCount = 0;
  double _scrollPercent = 0.0;

  _initStep() {
    _maxCount = widget.steps.length;
    final initialPage = widget.pageController.initialPage;
    _scrollPercent = (1.0 / (_maxCount - 1)) * initialPage;
  }

  _setPagePosition() {
    final offset = widget.pageController.offset;
    final max = widget.pageController.position.maxScrollExtent;
    final percent = offset / max;

    setState(() {
      _scrollPercent = percent;
    });
  }

  Widget _buildLayoutWidget(BuildContext context, BoxConstraints constraints) {
    final maxWidth = constraints.maxWidth;
    final width = maxWidth / _maxCount;
    final left = (maxWidth - width) * _scrollPercent;
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            right: widget.isPassed ? 0 : null,
            child: _buildStepPercent(width + left),
          ),
          Positioned.fill(child: _buildStepList()),
        ],
      ),
    );
  }

  Widget _buildStepPercent(double width) {
    Color _color = widget.indicatorColor;
    if (widget.isPassed) {
      return Container(width: double.infinity, color: _color);
    }

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
    );
  }

  Widget _buildStepList() {
    final _steps = widget.steps;
    return SizedBox(
      height: 50,
      child: Row(
          children: _steps
              .map((_step) => Expanded(
                      child: Column(
                    children: [
                      Expanded(
                          child: Center(
                        child: _buildStep(_step),
                      )),
                      Container(height: 2, color: Colors.transparent)
                    ],
                  )))
              .toList()),
    );
  }

  Widget _buildStep(String title) {
    return Container(
      height: double.infinity,
      alignment: Alignment.center,
      child: Text(title,
          style: const TextStyle(fontSize: 14, color: Color(0x8A000000))),
    );
  }

  @override
  void initState() {
    _initStep();
    widget.pageController.addListener(_setPagePosition);
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_setPagePosition);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: widget.padding, color: widget.indicatorColor),
        Expanded(child: LayoutBuilder(builder: _buildLayoutWidget)),
        Container(
          width: widget.padding,
          height: double.infinity,
          color: widget.isPassed ? widget.indicatorColor : Colors.transparent,
        ),
      ],
    );
  }
}
