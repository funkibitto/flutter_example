import 'package:flutter/material.dart';
import 'package:flutter_playboard/app/example/list_weel_scroll.dart';
import 'package:flutter_playboard/app/example/step_view.dart';
import 'package:flutter_playboard/app/example/page_view_selected.dart';
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

final examplesMap = Map.fromEntries(
    examples.map((MyRouts item) => MapEntry(item.route, item.builder)));

final allRoutes = <String, WidgetBuilder>{
  ...examplesMap,
};

final examples = [
  MyRouts(
    name: 'Step View  Example',
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
