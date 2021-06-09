import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safemoon_faucet_mobile_flutter/constants/custom_colors.dart';
import 'package:safemoon_faucet_mobile_flutter/controllers/home_controller.dart';
import 'package:safemoon_faucet_mobile_flutter/presentation/widgets/header_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (HomeController controller) => Scaffold(
        body: Container(
          color: CustomColors.background,
          height: context.height,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Header(),
                  const SizedBox(height: 40),
                  Obx(
                    () => Visibility(
                      visible: controller.canClaim.isFalse,
                      child: Text(
                        '00:00:00',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 32,
                          fontFamily: 'Monsterrat SemiBold',
                          color: CustomColors.text,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Obx(
                      () => Text(
                        controller.canClaim.value
                            ? 'Next Payout'
                            : 'You can now claim your SAFEMOON',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: true ? 'Monsterrat Light' : 'Monsterrat',
                          color: CustomColors.text,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.claimSafemoon();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(CustomColors.button),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                      child: Text(
                        'CLAIM\nSAFEMOON',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Monsterrat Bold',
                          color: CustomColors.text,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {},
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                      child: Text(
                        'WITHDRAW',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Monsterrat Light',
                          color: CustomColors.text,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => Text(
                      controller.balance.string,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        fontFamily: 'Monsterrat SemiBold',
                        color: CustomColors.text,
                      ),
                    ),
                  ),
                  const Text(
                    'Current Balance',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Monsterrat Light',
                      color: CustomColors.text,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => Text(
                      '\$${controller.currentPrice.string}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        fontFamily: 'Monsterrat SemiBold',
                        color: CustomColors.text,
                      ),
                    ),
                  ),
                  const Text(
                    'Current Price',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Monsterrat Light',
                      color: CustomColors.text,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                        () => Text(
                          '\$${controller.marketCap.string}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        fontFamily: 'Monsterrat SemiBold',
                        color: CustomColors.text,
                      ),
                    ),
                  ),
                  const Text(
                    'Market Cap',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Monsterrat Light',
                      color: CustomColors.text,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
