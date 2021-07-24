import 'package:ecommerce_app/tabs/home_tab.dart';
import 'package:ecommerce_app/tabs/saved_tab.dart';
import 'package:ecommerce_app/tabs/search_tab.dart';
import 'package:ecommerce_app/tabs/user_tab.dart';
import 'package:ecommerce_app/widgets/bottom_tabs.dart';
import 'package:ecommerce_app/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _tabPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabPageController.dispose();
    super.dispose();
  }

  String tabName(int selectedTab) {
    List<String> _tabNames = ['Home', 'Search', 'Saved', 'User'];

    return _tabNames[selectedTab];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomActionBar(
            title: tabName(_selectedTab),
          ),
          Expanded(
            child: PageView(
              controller: _tabPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SavedTab(),
                UserTab(),
              ],
            ),
          ),
          Container(
            child: BottomTabs(
              selectedTab: _selectedTab,
              tabPressed: (num) {
                setState(
                  () {
                    _tabPageController.animateToPage(num,
                        duration: Duration(microseconds: 1),
                        curve: Curves.ease);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
