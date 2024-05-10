import 'package:MangopointFarmers/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static FToast? fToast;

  static void show(String message, BuildContext context) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppConfig.logoutIcon
      ),
      child: Text(
        message,
        style: TextStyle(color: AppConfig.allWhite, fontSize: 18, fontFamily: 'Gilroy Light'),
      ),
    );

    fToast?.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
    );
  }

  static void init(BuildContext context) {
    fToast = FToast();
    fToast!.init(context);
  }
}