import 'package:get/get.dart';

import 'presentation/home_screen.dart';
import 'presentation/splash_screen.dart';
import 'presentation/transaction_screen.dart';

class AppRoutes {
  AppRoutes._();
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(name: '/', page: () => SplashScreen()),
    GetPage<dynamic>(name: '/home', page: () => HomeScreen()),
    GetPage<dynamic>(name: '/transaction', page: () => TransactionScreen()),
  ];
}
