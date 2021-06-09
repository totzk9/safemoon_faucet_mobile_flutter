import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

class DBRepository {
  factory DBRepository() {
    return _instance;
  }

  DBRepository._internal();

  static final DBRepository _instance = DBRepository._internal();

  Box<dynamic> box;

  Future<void> init() async {
    final Directory appDocDirectory = await getApplicationDocumentsDirectory();
    await Directory(appDocDirectory.path + '/' + 'dir')
        .create(recursive: true)
        .then((Directory directory) async {
      print(directory.path);
      Hive.init(directory.path);
      box = await Hive.openBox('safemoon_faucet');
    });
  }
}
