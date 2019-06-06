import 'package:flutter/material.dart';

///搜索模块的类型
enum SearchBarType { home, normal, homeLight }

///搜索模块封装
class SearchBar extends StatefulWidget {
//
  final bool enabled;

//  是否隐藏左边的按钮
  final bool hideLeft;

//  输入总承类型
  final SearchBarType searchBarType;

//  提示
  final String hint;

//  默认文字
  final String defaultText;

//  左边按钮点击
  final void Function() leftButtonClick;

//  右边按钮点击
  final void Function() rightButtonClick;

//  语音按钮点击
  final void Function() speakClick;

//  输入框点击
  final void Function() inputBoxClick;

//  输入文字变化监听
  final ValueChanged<String> onChanged;

  const SearchBar(
      {Key key,
      this.enabled = true,
      this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      this.hint,
      this.defaultText,
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakClick,
      this.inputBoxClick,
      this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    输入框view
    return _typeWidget;
  }

//  根据不同类型返回输入框样式
  Widget get _typeWidget {
    Widget view;
    switch (widget.searchBarType) {
      case SearchBarType.home:
        view = __getHomeSearch;
        break;
      case SearchBarType.normal:
        view = __getNormalSearch;
        break;
      case SearchBarType.homeLight:
        view = __getHomeSearch;
        break;
    }
    return view;
  }

  Widget get __getHomeSearch => Container(
//    横向排列
        child: Row(
          children: <Widget>[
            _warpGesture(
                Container(
                  padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
                  //            是否隐藏左边按钮
                  child: Row(
                    children: <Widget>[
                      Text(
                        '上海',
                        style: TextStyle(fontSize: 14, color: _homeFontColor),
                      ),
                      Icon(
                        Icons.expand_more,
                        color: _homeFontColor,
                        size: 22,
                      )
                    ],
                  ),
                ),
                widget.leftButtonClick),
//            中间输入框
            Expanded(flex: 1, child: _inputBox),
//            右边按钮
            Container(
              padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
              child: _warpGesture(
                  Container(
                    child: Icon(
                      Icons.comment,
                      color: _homeFontColor,
                      size: 26,
                    ),
                  ),
                  widget.leftButtonClick),
            ),
          ],
        ),
      );

  Widget get __getNormalSearch => Container(
//    横向排列
        child: Row(
          children: <Widget>[
            _warpGesture(
                Container(
                  padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                  //            是否隐藏左边按钮
                  child: widget?.hideLeft ?? false
                      ? null
                      : Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey,
                          size: 26,
                        ),
                ),
                widget.leftButtonClick),
//            中间输入框
            Expanded(flex: 1, child: _inputBox),
//            右边按钮
            _warpGesture(
                Text(
                  '搜索',
                  style: TextStyle(fontSize: 17, color: Colors.lightBlue),
                ),
                widget.leftButtonClick)
          ],
        ),
      );

  /// 输入框
  get _inputBox {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffededed'));
    }
    return Container(
      height: 30,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: inputBoxColor,
          borderRadius: BorderRadius.circular(
              widget.searchBarType == SearchBarType.normal ? 5 : 15)),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            color: widget.searchBarType == SearchBarType.normal
                ? Color(0xffa9a9a9)
                : Colors.lightBlue,
            size: 20,
          ),
          Expanded(
              flex: 1,
              child: widget.searchBarType == SearchBarType.normal
                  ? TextField(
                      controller: _controller,
                      onChanged: _onChanged,
                      autofocus: true,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
//                输入框样式
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5, right: 5),
                          border: InputBorder.none,
                          hintText: widget.hint ?? "",
                          hintStyle: TextStyle(fontSize: 13)),
                    )
                  : _warpGesture(
                      Container(
                        child: Text(
                          widget.defaultText,
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      widget.inputBoxClick == null
                          ? () {}
                          : widget.inputBoxClick)),
          showClear
              ? _warpGesture(
                  Icon(
                    Icons.clear,
                    color: widget.searchBarType == SearchBarType.normal
                        ? Color(0xffa9a9a9)
                        : Colors.lightBlue,
                    size: 20,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
                })
              : _warpGesture(
                  Icon(
                    Icons.mic,
                    color: widget.searchBarType == SearchBarType.normal
                        ? Color(0xffa9a9a9)
                        : Colors.lightBlue,
                    size: 20,
                  ),
                  widget.speakClick)
        ],
      ),
    );
  }

  _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }

//  点击事件的包裹
  _warpGesture(Widget widget, void Function() callBack) {
    return GestureDetector(
      onTap: () {
        callBack();
      },
      child: widget,
    );
  }

  Color get _homeFontColor {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
