import 'package:flutter/material.dart';
import 'package:flutter_app/provider/networkHelper.dart';

class FOXNEWS extends StatefulWidget {
  final dynamic Function() getData;

  const FOXNEWS({Key key, this.getData}) : super(key: key);

  @override
  _FOXNEWSState createState() => _FOXNEWSState();
}

class _FOXNEWSState extends State<FOXNEWS> {
  dynamic data = [];
  List articles;

  fetchData() async {
    data = await NetworkHelper.getFoxNews();
    if (data != null) {
      if (mounted) {
        setState(() {
          articles = data['articles'];
        });
      }
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return articles != null
        ? ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 7),
                elevation: 2,
                borderOnForeground: true,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 7.0),
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Image.network(
                          articles[index]['urlToImage'],
                          fit: BoxFit.fill,
                          alignment: Alignment.topCenter,
                          width: 100,
                        ),
                      ),
                      Text(
                        articles[index]['title'],
                        softWrap: true,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(child: CircularProgressIndicator());
  }
}
