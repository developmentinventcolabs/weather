import 'dart:async';

import 'package:flutter/material.dart';

import '../../Common Widgets/custom_scaffold.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../Selection/selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SelectionScreen(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      statusBarIconBrightness: Brightness.dark,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: AppColors.white),
        child: Center(
          child: SizedBox(
            width: deviceWidth(context) * 0.60,
            height: deviceHeight(context) * 0.30,
            child: Image.asset(AppImages.splashLogo),
          ),
        ),
      ),
    );
  }
}
