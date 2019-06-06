import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget rootWidget;
  final bool isLoading;
  final bool cover;

  const LoadingContainer(
      {Key key,
      @required this.rootWidget,
      @required this.isLoading,
      this.cover = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !isLoading ? rootWidget : _loadingView
        : Stack(
            children: <Widget>[rootWidget, isLoading ? _loadingView : null],
          );
  }

  Widget get _loadingView {
    return Center(child: CircularProgressIndicator());
  }
}
