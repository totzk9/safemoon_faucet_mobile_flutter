import 'package:hive/hive.dart';
import 'package:safemoon_faucet_mobile_flutter/infrastructure/models/safemoon_model.dart';
import 'package:safemoon_faucet_mobile_flutter/infrastructure/repository/db_repository.dart';

class LocalDataProvider {

  final Box<dynamic> _box = DBRepository().box;

  Future<int> fetchBalance() async {
    return await _box.get('balance') ?? 0;
  }

  Future<void> saveBalance(int value) async {
    await _box.put('balance', value);
  }

  Future<void> saveTransaction(Transaction transaction) async {
    await _box.add(transaction);
  }

  Future<DateTime> fetchPayoutDate() async {
    return await _box.get('payout_date') ?? DateTime.now();
  }

  Future<void> saveNextPayoutDate(DateTime value) async {
    await _box.put('payout_date', value);
  }
}