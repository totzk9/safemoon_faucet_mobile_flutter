import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:safemoon_faucet_mobile_flutter/infrastructure/data_sources/local_data_provider.dart';
import 'package:safemoon_faucet_mobile_flutter/infrastructure/data_sources/remote_data_provider.dart';

import '../ad_helper.dart';

class HomeController extends GetxController {
  // static HomeController to = Get.find();

  RxInt balance = 0.obs;
  final LocalDataProvider _localDataProvider = LocalDataProvider();
  final RemoteDataProvider _remoteDataProvider = RemoteDataProvider();
  RxBool canClaim = false.obs;
  RxString marketCap = ''.obs;
  RxString currentPrice = ''.obs;
  RxString countdown = ''.obs;
  DateTime payoutDate = DateTime.now();
  late Timer _timer;
  bool enableTimer = true;

  late BannerAd bannerAd;
  bool isBannerAdReady = false;
  late InterstitialAd interstitialAd;
  bool isInterstitialAdReady = false;

  @override
  Future<void> onReady() async {
    await fetchCurrentBalance();
    await fetchNextPayout();
    await fetchSafemoonData();
    _timer = Timer(const Duration(milliseconds: 0), checkPayoutDate);

    //ads
    bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: AdListener(
        onAdLoaded: (_) {
          isBannerAdReady = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError err) {
          print('Failed to load a banner ad: ${err.message}');
          isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    bannerAd.load();
    interstitialAd = InterstitialAd(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      listener: AdListener(
        onAdLoaded: (_) {
          isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError err) {
          print('Failed to load an interstitial ad: ${err.message}');
          isInterstitialAdReady = false;
          ad.dispose();
        },
        onAdClosed: (_) {},
      ),
    );

    super.onReady();
  }

  @override
  void onClose() {
    bannerAd.dispose();
    interstitialAd.dispose();
    super.onClose();
  }

  Future<void> checkPayoutDate() async {
    try {
      if (DateTime.now().millisecondsSinceEpoch >
          payoutDate.millisecondsSinceEpoch) {
        canClaim.value = true;
      } else {
        final DateTime newTime = payoutDate.subtract(
            Duration(milliseconds: DateTime.now().millisecondsSinceEpoch));
        countdown.value =
            '00:${newTime.minute.toString().padLeft(2, '0')}:${newTime.second.toString().padLeft(2, '0')}';
        canClaim.value = false;
      }
    } finally {
      final Timer timer = Timer(
        const Duration(milliseconds: 1000),
        checkPayoutDate,
      );

      if (canClaim.value) {
        _timer.cancel();
        timer.cancel();
      }
    }
  }

  Future<void> fetchCurrentBalance() async {
    balance.value = await _localDataProvider.fetchBalance();
  }

  Future<void> fetchNextPayout() async {
    payoutDate = await _localDataProvider.fetchPayoutDate();
  }

  Future<void> claimSafemoon() async {
    if (isInterstitialAdReady) {
      interstitialAd.show();
    }
    final int newBalanceValue = balance.value + randomValue();
    balance.value = newBalanceValue;
    await _localDataProvider.saveBalance(newBalanceValue);
    await _localDataProvider.saveNextPayoutDate(getNewPayoutDate());
    _timer = Timer(const Duration(milliseconds: 0), checkPayoutDate);
  }

  DateTime getNewPayoutDate() {
    payoutDate = DateTime.now().add(const Duration(seconds: 5));
    return payoutDate;
  }

  int randomValue() {
    final Random rn = Random();
    return 49000 + rn.nextInt(150000 - 39000);
  }

  Future<void> fetchSafemoonData() async {
    final Map<String, dynamic> map =
        await _remoteDataProvider.getSafemoonData();
    saveNewMarketCap(map);
    saveCurrentPrice(map);
  }

  void saveNewMarketCap(Map<String, dynamic> map) {
    final String cap = map['marketCap'];
    final List<String> split = cap.split('.');
    marketCap.value = split[0].replaceAll(
      split[0],
      split[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      ),
    );
  }

  void saveCurrentPrice(Map<String, dynamic> map) {
    final String price = map['price'];
    currentPrice.value = price.substring(0, 13);
  }
}
