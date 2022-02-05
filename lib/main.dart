import 'package:flutter/material.dart';
import 'package:flutter_playboard/src/basics/01_animated_container.dart';
import 'package:flutter_playboard/src/basics/02_page_route_builder.dart';
import 'package:flutter_playboard/src/basics/03_animation_controller.dart';
import 'package:flutter_playboard/src/basics/04_tweens.dart';
import 'package:flutter_playboard/src/examples/animated_card_widget.dart';
import 'package:flutter_playboard/src/examples/bottom_navigation_hide.dart';
import 'package:flutter_playboard/src/examples/custom_sliver_app_bar.dart';
import 'package:flutter_playboard/src/examples/list_weel_scroll.dart';
import 'package:flutter_playboard/src/examples/page_view_selected.dart';
import 'package:flutter_playboard/src/examples/step_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      home: const HomeView(),
      routes: allRoutes,
    ),
  );
}

class MyRouts {
  final String name;
  final String route;
  final WidgetBuilder builder;

  const MyRouts({
    required this.name,
    required this.route,
    required this.builder,
  });
}

final basics = [
  MyRouts(
    name: 'Tweens',
    route: TweenDemo.routeName,
    builder: (context) => const TweenDemo(),
  ),
  MyRouts(
    name: 'Animation Controller',
    route: AnimationControllerDemo.routeName,
    builder: (context) => const AnimationControllerDemo(),
  ),
  MyRouts(
    name: 'PageRouteBuilder',
    route: PageRouteBuilderDemo.routeName,
    builder: (context) => const PageRouteBuilderDemo(),
  ),
  MyRouts(
    name: 'AnimatedContainer',
    route: AnimatedContainerDemo.routeName,
    builder: (context) => const AnimatedContainerDemo(),
  ),
];

final examples = [
  MyRouts(
    name: 'AnimatedCardWidget',
    route: AnimatedCardWidget.routeName,
    builder: (context) => const AnimatedCardWidget(),
  ),
  MyRouts(
    name: 'BottomNavigationHide',
    route: BottomNavigationHide.routeName,
    builder: (context) => const BottomNavigationHide(),
  ),
  MyRouts(
    name: 'Sliver App Bar Example',
    route: CustomSliverAppBarStatus.routeName,
    builder: (context) => const CustomSliverAppBarStatus(),
  ),
  MyRouts(
    name: 'Step View Example',
    route: StepViewExample.routeName,
    builder: (context) => const StepViewExample(),
  ),
  MyRouts(
    name: 'List Wheel Scroll Example',
    route: ListWheelScrollExample.routeName,
    builder: (context) => const ListWheelScrollExample(),
  ),
  MyRouts(
    name: 'Page View Selected Example',
    route: PageViewSelected.routeName,
    builder: (context) => const PageViewSelected(),
  ),
];

final basicMaps =
    Map.fromEntries(basics.map((d) => MapEntry(d.route, d.builder)));

final exampleMaps = Map.fromEntries(
    examples.map((MyRouts item) => MapEntry(item.route, item.builder)));

final allRoutes = <String, WidgetBuilder>{
  ...exampleMaps,
  ...basicMaps,
};

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Playboard'),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        children: [
          const ListTile(title: Text('Basics', style: headerStyle)),
          ...basics.map((d) => DemoTile(d)),
          const ListTile(title: Text('Examples', style: headerStyle)),
          ...examples.map((d) => DemoTile(d)),
        ],
      ),
    );
  }
}

class DemoTile extends StatelessWidget {
  final MyRouts demo;

  const DemoTile(this.demo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        demo.name,
        style: const TextStyle(fontSize: 15),
      ),
      onTap: () {
        Navigator.pushNamed(context, demo.route);
      },
    );
  }
}
