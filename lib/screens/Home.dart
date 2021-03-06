import 'package:flutter/material.dart';
import 'package:flutter_app/configs/tabList.dart';
import 'package:flutter_app/services/networkHelper.dart';
import 'package:flutter_app/widgets/newsChannels.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  dynamic data1, data2, data3, data4, data5, data6 = [];
  List ch1, ch2, ch3, ch4, ch5, ch6;

  fetchData() async {
    data1 = await NetworkHelper.getNews(NetworkHelper.bbc);
    data2 = await NetworkHelper.getNews(NetworkHelper.timesofindia);
    data3 = await NetworkHelper.getNews(NetworkHelper.theHindu);
    data4 = await NetworkHelper.getNews(NetworkHelper.espn);
    data5 = await NetworkHelper.getNews(NetworkHelper.foxnews);
    data6 = await NetworkHelper.getNews(NetworkHelper.timeNews);
    if (mounted) {
      setState(() {
        ch1 = data1['articles'];
        ch2 = data2['articles'];
        ch3 = data3['articles'];
        ch4 = data4['articles'];
        ch5 = data5['articles'];
        ch6 = data6['articles'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              tooltip: 'Refresh',
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  fetchData();
                });
              }),
        ],
        title: Text(
          'News App',
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          indicatorColor: Colors.black,
          controller: _tabController,
          isScrollable: true,
          tabs: tabs.map<Widget>((tabs) {
            return Tab(
              child: Text(
                '${tabs.title}',
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ch1 != null
              ? NewsChannels(articles: ch1)
              : Center(child: CircularProgressIndicator()),
          ch2 != null
              ? NewsChannels(articles: ch2)
              : Center(child: CircularProgressIndicator()),
          ch3 != null
              ? NewsChannels(articles: ch3)
              : Center(child: CircularProgressIndicator()),
          ch4 != null
              ? NewsChannels(articles: ch4)
              : Center(child: CircularProgressIndicator()),
          ch5 != null
              ? NewsChannels(articles: ch5)
              : Center(child: CircularProgressIndicator()),
          ch6 != null
              ? NewsChannels(articles: ch6)
              : Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
