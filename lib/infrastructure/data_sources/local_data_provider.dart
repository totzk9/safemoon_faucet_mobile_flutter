import 'package:hive/hive.dart';
import 'package:safemoon_faucet_mobile_flutter/infrastructure/repository/db_repository.dart';

class LocalDataProvider {

  final Box<dynamic> _box = DBRepository().box;

  Future<int> fetchBalance() async {
    return _box.get('balance');
  }

  Future<void> saveBalance(int value) async {
    await _box.put('balance', value);
  }

  Future<DateTime> fetchPayoutDate() async {
    return _box.get('payout_date');
  }

  Future<void> saveNextPayoutDate(DateTime value) async {
    await _box.put('payout_date', value);
  }
}