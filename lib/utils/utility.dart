import 'package:flutter/material.dart';

class AppConfig {
  //App colors.
  static Color mainBg = const Color(0xffe28420);
  static Color mainSubtitle = const Color(0xff399936);
  static Color mainSubtitleBg = const Color(0xffF4F4F4);
  static Color loginTextDesc = const Color(0xff646464);
  static Color allBlack = const Color(0xff000000);
  static Color languageDesc = const Color(0xff2F2F2F);
  static Color logoutIcon = const Color(0xff006666);
  static Color homeCardBg = const Color(0xfff1ebe3);
  static Color allWhite = const Color(0xffffffff);
  static Color toggleSwitch = const Color(0xfff58b2a);
  static Color cardCalIcon = const Color(0xff0EA78A);
  static Color cardBg = const Color(0xfff3f0ec);
  static Color invoiceText = const Color(0xff494949);


  //Api Link
  static String url = 'https://mangopoint-poc-43qi3.ondigitalocean.app';
  // static String url = 'https://mangopoint.up.railway.app/';
  static String authUrl = '$url/api-auth/otp/';
  static String verifyAuthUrl = '$url/api-auth/otp-v/';
  static String profileUrl = '$url/api-auth/user/profile/';
  static String updateProfileUrl = '$url/api-auth/party/';
  static String approvedInvoiceUrl = '$url/api/message/inbox/?record_type=APPROVED_INVOICE';
  static String financedInvoiceUrl = '$url/api/message/inbox/?record_type=FINANCED_INVOICE';
  static String earlyPaymentUrl = '$url/api/resource/action/status/';
  static String requestEarlyPaymentUrl = '$url/finflo/transition/';


  //Images & SVG
  static String loginLogo = 'assets/images/logo.svg';
  static String logoImage = 'assets/images/logoImage.svg';
}
