import 'package:flutter/material.dart';

class CustomSliverAppBarStatus extends StatefulWidget {
  const CustomSliverAppBarStatus({Key? key}) : super(key: key);
  static const String routeName = '/examples/sliver_app_bar';

  @override
  _CustomSliverAppBarStatusState createState() =>
      _CustomSliverAppBarStatusState();
}

class _CustomSliverAppBarStatusState extends State<CustomSliverAppBarStatus> {
  late ScrollController _scrollController;
  Color _textColor = Colors.black;

  bool _isShowTopContents = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _updateIsShowTopContents(bool isShowTopContents) {
    setState(() {
      _isShowTopContents = isShowTopContents;
    });
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = PrimaryScrollController.of(context)!
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded ? Colors.white : Colors.blue;
        });
      });
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return _updateIsShowTopContents(true);
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            if (_isShowTopContents) ...[
              SliverToBoxAdapter(
                child: Container(
                  height: 100.0,
                  width: double.infinity,
                  color: Colors.red,
                ),
              ),
            ],
            SliverAppBar(
              pinned: false,
              snap: true,
              floating: true,
              backgroundColor: Colors.transparent,
              expandedHeight: 80.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Goa',
                  //textScaleFactor: 1,
                  style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                stretchModes: [StretchMode.zoomBackground],
              ),
              //collapsedHeight: 100,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, int index) {
                  return ListTile(
                    leading: Container(
                        padding: EdgeInsets.all(8),
                        width: 100,
                        child: Placeholder()),
                    title: Text('Place ${index + 1}', textScaleFactor: 2),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
