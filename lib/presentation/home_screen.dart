import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:safemoon_faucet_mobile_flutter/constants/custom_colors.dart';
import 'package:safemoon_faucet_mobile_flutter/controllers/home_controller.dart';
import 'package:safemoon_faucet_mobile_flutter/presentation/widgets/header_widget.dart';

import '../ad_helper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (HomeController controller) {
        return Scaffold(
          body: Container(
            color: CustomColors.background,
            height: context.height,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Header(),
                    const SizedBox(height: 32),
                    Obx(
                      () => Visibility(
                        visible: controller.canClaim.isFalse,
                        child: Text(
                          controller.countdown.string,
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
                        () => controller.marketCap.value == ''
                            ? const CircularProgressIndicator()
                            : Text(
                                controller.canClaim.value
                                    ? 'You can now claim your SAFEMOON'
                                    : 'Next Payout',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: controller.canClaim.value
                                      ? 'Monsterrat Light'
                                      : 'Monsterrat',
                                  color: CustomColors.text,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Obx(
                      () => ElevatedButton(
                        onPressed: controller.canClaim.value
                            ? () async {
                                await controller.claimSafemoon();
                              }
                            : null,
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              controller.canClaim.value
                                  ? CustomColors.button
                                  : CustomColors.text_field),
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
                      () => controller.currentPrice.value == ''
                          ? const CircularProgressIndicator()
                          : Text(
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
                      () => controller.marketCap.value == ''
                          ? const CircularProgressIndicator()
                          : Text(
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
                    if (controller.isBannerAdReady)
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: controller.bannerAd.size.width.toDouble(),
                          height: controller.bannerAd.size.height.toDouble(),
                          child: AdWidget(ad: controller.bannerAd),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
