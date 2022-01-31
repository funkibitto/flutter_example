import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PageViewSelected extends StatefulWidget {
  const PageViewSelected({Key? key}) : super(key: key);
  static const String routeName = '/example/page_view_selected_example';

  @override
  _PageViewSelectedState createState() => _PageViewSelectedState();
}

class _PageViewSelectedState extends State<PageViewSelected> {
  final PageController controller =
      PageController(initialPage: 0, viewportFraction: 0.5);

  late List<Widget> _items;
  int nowIndex = 0;

  changeNowIndex(value) {
    setState(() {
      nowIndex = value;
    });
  }

  @override
  void initState() {
    _items = _buildTestData(10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List Wheel Scroll Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 130,
                child: _renderListView(220),
              ),
              Expanded(
                child: Center(
                  child: _items[nowIndex],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTestData(int count) {
    return List.generate(
      count,
      (index) => Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
                color: Color(Random().nextInt(0xffffffff)),
                border: Border.all(color: Colors.black, width: 1)),
            padding: const EdgeInsets.all(40),
            child: Text(
              index.toString(),
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ).toList();
  }

  Widget _renderListView(double itemExtent) {
    return PageView.builder(
      // physics: const CustomPageViewScrollPhysics(),
      controller: controller,
      pageSnapping: true,
      scrollDirection: Axis.horizontal,
      onPageChanged: changeNowIndex,
      itemBuilder: (BuildContext context, int itemIndex) {
        return _items[itemIndex];
      },
      itemCount: _items.length,
    );
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 100,
        damping: 0.5,
      );
}
