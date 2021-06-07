import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/tabs/home_tab.dart';
import 'package:ecommerce_app/tabs/saved_tab.dart';
import 'package:ecommerce_app/tabs/search_tab.dart';
import 'package:ecommerce_app/widgets/bottom_tabs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
