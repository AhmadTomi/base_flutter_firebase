import 'package:base_flutter_firebase/page/pg_account.dart';
import 'package:base_flutter_firebase/page/pg_data.dart';
import 'package:base_flutter_firebase/page/pg_data_add.dart';
import 'package:base_flutter_firebase/page/pg_home.dart';
import 'package:base_flutter_firebase/page/pg_login.dart';
import 'package:base_flutter_firebase/page/pg_register.dart';

import 'page/pg_data_update.dart';
import 'page/pg_splash.dart';

routes(context) {
  return {
    '/': (context) => PageSplash(),
    '/home': (context) => PageHome(),
    '/login': (context) => PageLogin(),
    '/data': (context) => PageData(),
    '/data_add': (context) => PageDataAdd(),
    '/data_update': (context) => PageDataUpdate(),
    '/account': (context) => PageAccount(),
    '/register': (context) => PageRegister(),
  };
  }