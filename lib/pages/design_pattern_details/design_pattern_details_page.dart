import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import '../../data/models/design_pattern.dart';
import '../../data/repositories/markdown_repository.dart';
import '../../widgets/platform_specific/platform_back_button.dart';

class DesignPatternDetailsPage extends StatefulWidget {
  final DesignPattern designPattern;
  final Widget example;

  const DesignPatternDetailsPage({
    required this.designPattern,
    required this.example,
  });

  @override
  _DesignPatternDetailsPageState createState() =>
      _DesignPatternDetailsPageState();
}

class _DesignPatternDetailsPageState extends State<DesignPatternDetailsPage>
    with TickerProviderStateMixin {
  final repository = MarkdownRepository();

  late final AnimationController _fadeSlideAnimationController;
  late final ScrollController _scrollController;
  late final TabController _tabController;

  double _appBarElevation = 0.0;
  double _bottomNavigationBarElevation = 4.0;

  @override
  void initState() {
    super.initState();

    _fadeSlideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _appBarElevation =
              _scrollController.offset > _scrollController.initialScrollOffset
                  ? 4.0
                  : 0.0;
          _bottomNavigationBarElevation = _scrollController.offset ==
                  _scrollController.position.maxScrollExtent
              ? 0.0
              : 4.0;
        });
      });

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fadeSlideAnimationController.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void onBottomNavigationBarItemTap(int index) {
    setState(() {
      _appBarElevation = 0.0;
      _bottomNavigationBarElevation = 4.0;
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        backgroundColor: lightBackgroundColor,
        elevation: _bottomNavigationBarElevation,
        selectedIconTheme: const IconThemeData(size: 20.0),
        selectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(size: 20.0),
        unselectedItemColor: Colors.black45,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Description',
            icon: Icon(FontAwesomeIcons.fileAlt),
          ),
          BottomNavigationBarItem(
            label: 'Example',
            icon: Icon(FontAwesomeIcons.lightbulb),
          ),
        ],
        onTap: onBottomNavigationBarItemTap,
      ),
      body: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.designPattern.title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: lightBackgroundColor,
          elevation: _appBarElevation,
          // leading: const PlatformBackButton(
          //   color: Colors.black,
          // ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(
                  paddingL,
                  paddingL,
                  paddingL,
                  paddingXL,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.designPattern.description,
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 99,
                    ),
                    const SizedBox(height: spaceL),
                    FutureBuilder(
                      future: repository.get(widget.designPattern.id),
                      initialData: '',
                      builder: (_, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return MarkdownBody(
                            data: snapshot.data!,
                            fitContent: false,
                            selectable: true,
                          );
                        }

                        return CircularProgressIndicator(
                          backgroundColor: lightBackgroundColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black.withOpacity(0.65),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            widget.example,
          ],
        ),
      ),
    );
  }
}
