import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:safemoon_faucet_mobile_flutter/infrastructure/data_sources/local_data_provider.dart';
import 'package:safemoon_faucet_mobile_flutter/infrastructure/data_sources/remote_data_provider.dart';

class TransactionController extends GetxController {
  static TransactionController to = Get.find();

  final LocalDataProvider _localDataProvider = LocalDataProvider();

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
  }

  Future<void> withdrawSafemoon() async {
    await _localDataProvider.saveBalance(0);
  }

}
