import 'package:flutter/material.dart';
import 'package:flutter_qunar/widget/search_bar.dart';

// 搜索页面
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SearchBar(
            enabled: true,
            hideLeft: true,
            defaultText: '哈哈',
            hint: '请问',
            leftButtonClick: () {
              Navigator.pop(context);
            },
            onChanged: _onTextChange,
          )
        ],
      ),
    );
  }

  _onTextChange(String text) {}
}
