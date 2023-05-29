import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Utils/app_colors.dart';

class CustomScaffold extends StatefulWidget {
  final Widget? body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final Color statusBarColor;
  final Brightness statusBarIconBrightness;
  final Color? backgroundColor;
  const CustomScaffold(
      {Key? key,
      this.body,
      this.appBar,
      this.floatingActionButton,
      this.statusBarColor = AppColors.white,
      this.statusBarIconBrightness = Brightness.light,
      this.backgroundColor})
      : super(key: key);

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: widget.statusBarColor,
        statusBarIconBrightness: widget.statusBarIconBrightness,
      ),
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: widget.appBar,
        body: widget.body,
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }
}
