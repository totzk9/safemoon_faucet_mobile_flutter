import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:safemoon_faucet_mobile_flutter/infrastructure/data_sources/local_data_provider.dart';
import 'package:safemoon_faucet_mobile_flutter/infrastructure/data_sources/remote_data_provider.dart';

class HomeController extends GetxController {
  static HomeController to = Get.find();

  RxInt balance = 0.obs;
  final LocalDataProvider _localDataProvider = LocalDataProvider();
  final RemoteDataProvider _remoteDataProvider = RemoteDataProvider();
  RxBool canClaim = false.obs;
  RxString marketCap = ''.obs;
  RxString currentPrice = ''.obs;
  Rx<DateTime> payoutDate = DateTime.now().obs;

  @override
  Future<void> onReady() async {
    //run every time auth state changes
    // Isolate.spawn((_) {
    //   checkPayoutDate();
    // }, null);
    await fetchCurrentBalance();
    await fetchNextPayout();
    await fetchSafemoonData();
    super.onReady();
  }

  @override
  void onClose() {
    // Isolate.current.kill();
    super.onClose();
  }

  Future<void> checkPayoutDate() async {
    print(DateTime.now().millisecondsSinceEpoch);
    print(payoutDate.value.millisecondsSinceEpoch);
    int newTime = DateTime.now()
        .subtract(
            Duration(milliseconds: payoutDate.value.millisecondsSinceEpoch))
        .millisecondsSinceEpoch;
    print(newTime);
  }

  Future<void> fetchCurrentBalance() async {
    balance.value = await _localDataProvider.fetchBalance() ?? 0;
  }

  Future<void> fetchNextPayout() async {
    payoutDate.value = await _localDataProvider.fetchPayoutDate();
    if (DateTime.now().isBefore(payoutDate.value ?? DateTime.now())) {
      canClaim.value = true;
    } else {
      canClaim.value = false;
    }
  }

  Future<void> claimSafemoon() async {
    final int newBalanceValue = balance.value + randomValue();
    print(newBalanceValue);
    balance.value = newBalanceValue;
    await _localDataProvider.saveBalance(newBalanceValue);
    await _localDataProvider.saveNextPayoutDate(getNewPayoutDate());
    checkPayoutDate();
  }

  DateTime getNewPayoutDate() {
    payoutDate.value = DateTime.now().add(const Duration(minutes: 10));
    // DateTime.now().add(const Duration(seconds: 5));
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
    marketCap.value = split[0];
  }

  void saveCurrentPrice(Map<String, dynamic> map) {
    final String price = map['price'];
    currentPrice.value = price.substring(0, 13);
  }
}
