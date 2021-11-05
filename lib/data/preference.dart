import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const defaultKosong ="-";
// const defaultKosong ="kosong";
Future setIsLogin(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLogin', value);
}

Future isLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLogin') ?? false;
}

Future setIsFirst(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirst', value);
}

Future isFirst() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isFirst') ?? true;
}

Future setSession(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('session', value);
}

Future getSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('session') ?? defaultKosong;
}

Future setToken(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', value);
}

Future getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? defaultKosong;
}

Future setUser(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', value);
}

Future getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user') ?? defaultKosong;
}

Future setRole(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('role', value);
}

Future getRole() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('role') ?? defaultKosong;
}

logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future getIdUser() async {
  var sessi = await getSession();
  var data = jsonDecode(sessi);
  return data['id'];
}
