import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/app_color.dart';
import 'gaim_view.dart';

/// Displays a list of SampleItems.
class SplashView extends StatefulWidget {
  const SplashView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void didChangeDependencies() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: AppColor.appColor));
    startTimer(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        body: Container(
            color: AppColor.appColor,
            child: Stack(children: [
              Align(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: Image.asset('assets/images/tictactoe.png'))),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height * 0.10),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('by : Zinon Software',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 167, 166, 166),
                                    fontSize: 10))
                          ])))
            ])));
  }

  void startTimer(BuildContext context) {
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const GaimView())));
  }
}
