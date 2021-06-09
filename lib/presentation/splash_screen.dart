import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safemoon_faucet_mobile_flutter/constants/custom_colors.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    redirectHome();
    return Scaffold(
      body: Container(
        color: CustomColors.background,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset(
              'images/safemoon.gif',
              height: 240,
              width: 240,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'SAFEMOON',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'aAtmospheric',
                color: CustomColors.text,
              ),
            ),
            const Text(
              'Faucet & Airdrops',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Monsterrat',
                color: CustomColors.text,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> redirectHome() async {
  await Future<void>.delayed(
      const Duration(milliseconds: 4600), () => Get.to(() => HomeScreen()));
}
