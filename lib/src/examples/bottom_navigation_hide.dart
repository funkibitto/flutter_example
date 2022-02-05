import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_playboard/app/modules/widgets/scroll_to_hide_widget.dart';

class BottomNavigationHide extends StatefulWidget {
  const BottomNavigationHide({Key? key}) : super(key: key);
  static const String routeName = '/examples/bottom_navigation_hide_example';

  @override
  _BottomNavigationHideState createState() => _BottomNavigationHideState();
}

class _BottomNavigationHideState extends State<BottomNavigationHide> {
  int _selectedIndex = 0;

  final List<Widget> _items = List<Widget>.generate(
      30,
      (index) => Container(
            color: Color(Random().nextInt(0xffffffff)),
            padding: const EdgeInsets.all(40),
            margin: const EdgeInsets.all(8),
            child: Text(
              index.toString(),
              style: const TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          key: const PageStorageKey('bottom_navigation_hide'),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return _items[index];
          },
        ),
        bottomNavigationBar: ScrollToHideWidget(
          controller: PrimaryScrollController.of(context)!,
          child: BottomNavigationBar(
            backgroundColor: Colors.grey,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            currentIndex: _selectedIndex, //현재 선택된 Index
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                label: 'Products',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
