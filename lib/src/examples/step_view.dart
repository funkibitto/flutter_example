import 'package:flutter/material.dart';
import 'package:flutter_playboard/app/modules/widgets/step_indicator.dart';
import 'package:provider/provider.dart';

class StepViewExample extends StatefulWidget {
  const StepViewExample({Key? key}) : super(key: key);
  static const String routeName = '/examples/step_view_example';

  @override
  _StepViewExampleState createState() => _StepViewExampleState();
}

class _StepViewExampleState extends State<StepViewExample> {
  late PageController pageController;
  int pageIndex = 0;
  Passed passed = Passed();

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> stepList = [
    {'title': 'Step1', 'widget': const StepTestView(title: 'Step1 Page')},
    {'title': 'Step2', 'widget': const StepTestView(title: 'Step2 Page')},
    {'title': 'Step3', 'widget': const StepTestView(title: 'Step3 Page')},
    {'title': 'Step4', 'widget': const StepTestView(title: 'Step4 Page')},
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => passed,
      child: WillPopScope(
        onWillPop: () async {
          _onBackBtnTap();
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Step View Example'),
            ),
            body: Column(
              children: [
                SizedBox(height: 50, child: _buildStepIndicator()),
                Expanded(child: _buildPageView()),
                _buildPassButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Consumer<Passed>(
      builder: (context, value, child) {
        return StepIndicator(
          steps: stepList.map((_step) => _step["title"] as String).toList(),
          pageController: pageController,
          isPassed: passed.isPassed,
        );
      },
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stepList.length,
      itemBuilder: (context, index) {
        return stepList[index]["widget"];
      },
      onPageChanged: (index) {
        FocusScope.of(context).requestFocus(FocusNode());
        pageIndex = index;
        passed.passedCount = index;
      },
    );
  }

  Widget _buildPassButton() {
    return Consumer<Passed>(
      builder: (context, value, child) {
        final index = passed.passedCount;

        return OutlinedButton(
          style: OutlinedButton.styleFrom(
              primary: Colors.black,
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.all(10)),
          child: SizedBox(
              width: double.infinity,
              height: 40,
              child: Center(
                  child: Text(
                      index == (stepList.length - 1) ? "submit" : "next >"))),
          onPressed: _onNextBtnTap,
        );
      },
    );
  }

  _onNextBtnTap() {
    if (pageIndex == stepList.length - 1) return passed.isPassed = true;

    pageController.animateToPage(
      pageIndex + 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  _onBackBtnTap() {
    if (pageIndex == 0) return Navigator.of(context).pop();
    if (passed.isPassed == true) return passed.isPassed = false;

    pageController.animateToPage(
      pageIndex - 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }
}

class Passed extends ChangeNotifier {
  bool _isPassed = false;

  bool get isPassed => _isPassed;
  set isPassed(bool isSubmit) {
    _isPassed = isSubmit;
    notifyListeners();
  }

  int _passedCount = 0;
  int get passedCount => _passedCount;
  set passedCount(int pageCount) {
    _passedCount = pageCount;
    notifyListeners();
  }
}

class StepTestView extends StatelessWidget {
  const StepTestView({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(title),
      ),
    );
  }
}
