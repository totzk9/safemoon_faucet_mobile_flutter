import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safemoon_faucet_mobile_flutter/constants/custom_colors.dart';

class Header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
            'images/safemoon.svg',
            width: 40,
            height: 40,
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'SAFEMOON',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'aAtmospheric',
              color: CustomColors.text,
            ),
          ),
        ),
      ),
    ]);
  }
}
