import 'dart:math';

import 'package:flutter/material.dart';

class ListWheelScrollExample extends StatefulWidget {
  static const String routeName = '/example/list_wheel_scroll_example';
  const ListWheelScrollExample({Key? key}) : super(key: key);

  @override
  _ListWeelScrollExampleState createState() => _ListWeelScrollExampleState();
}

class _ListWeelScrollExampleState extends State<ListWheelScrollExample> {
  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController();

  final List<Card> _items = List<Card>.generate(
      30,
      (i) => Card(
            id: i,
            color: Color(Random().nextInt(0xffffffff)),
          ));
  int nowIndex = 0;

  changeNowIndex(value) {
    setState(() {
      nowIndex = value;
    });
  }

  @override
  void initState() {
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
                  child: _renderListItem(_items[nowIndex]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderListView(double itemExtent) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: _handleScrollNotification,
      child: RotatedBox(
        quarterTurns: 3,
        child: ListWheelScrollView(
          controller: _scrollController,
          physics: const FixedExtentScrollPhysics(),
          itemExtent: itemExtent,
          onSelectedItemChanged: changeNowIndex,
          offAxisFraction: 0,
          diameterRatio: 50,
          children: List.generate(
              _items.length, (i) => _renderListItem(_items[i], isRotate: true)),
        ),
      ),
    );
  }

  Widget _renderListItem(Card card, {bool isRotate = false}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RotatedBox(
        quarterTurns: isRotate == true ? 1 : 0,
        child: InkWell(
            child: Container(
              width: isRotate == true ? 100 : 200,
              color: card.color,
              padding: const EdgeInsets.all(40),
              child: Text(
                card.id.toString(),
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () => _scrollAnimation(card.id)),
      ),
    );
  }

  void _scrollAnimation(int index) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _scrollController.animateToItem(index,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    });
  }

  bool _handleScrollNotification(ScrollEndNotification notification) {
    if (notification is ScrollEndNotification == false) return true;
    print(nowIndex);
    // _scrollAnimation(nowIndex);
    return true;
  }
}

class Card {
  final int id;
  final Color color;

  const Card({
    required this.id,
    required this.color,
  });
}
