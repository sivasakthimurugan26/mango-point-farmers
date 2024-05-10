import 'dart:async';
import 'package:MangopointFarmers/screens/chooseLanguage.dart';
import 'package:MangopointFarmers/screens/dashboard.dart';
import 'package:MangopointFarmers/service/invoice_service.dart';
import 'package:MangopointFarmers/utils/utility.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // StreamSubscription? connection;
  // bool isoffline = false;
  bool _isLoggedIn = false;
  String checkLanguage='english';


  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null;
  }

  Future <String> checkLang() async {
    SharedPreferences islocale = await SharedPreferences.getInstance();
   String lang=islocale.getString('islocal')!;
   print('lang:$lang');
   return lang;
  }
  fetchData(){
    context.read<InvoiceService>().getApprovedInvoice();
    context.read<InvoiceService>().getFinancedInvoice();
  }

  @override
  void initState() {
    // connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   if(result == ConnectivityResult.none)
    //   {
    //     setState(() {
    //       isoffline = true;
    //       print("No internet connection");
    //     });
    //   }else if(result == ConnectivityResult.mobile)
    //   {
    //     setState(() {
    //       isoffline = false;
    //       print("Internet connection is from Mobile data");
    //     });
    //   }
    //   else if(result == ConnectivityResult.wifi)
    //   {
    //     setState(() {
    //       isoffline = false;
    //       print("Internet connection is from wifi");
    //     });
    //   }else if(result == ConnectivityResult.ethernet)
    //   {
    //     setState(() {
    //       isoffline = false;
    //       print("Internet connection is from wired cable");
    //     });
    //   }else if(result == ConnectivityResult.bluetooth)
    //   {
    //     setState(() {
    //       isoffline = false;
    //       print("Internet connection is from bluethooth threatening");
    //     });
    //   }
    // });
    super.initState();
    fetchData();

    isLoggedIn().then((isLoggedIn) {
      setState(() {
        _isLoggedIn = isLoggedIn;
        print('_isLoggedIn:$_isLoggedIn');
      });
    });
    checkLang().then((checkLang) {
      setState(() {
        checkLanguage = checkLang;
        if(checkLanguage == 'english'){
          var locale =Locale('en','US');
          Get.updateLocale(locale);
        }
        if(checkLanguage == 'tamil'){
          var locale =Locale('ta');
          Get.updateLocale(locale);
        }


        print('checkLanguage:$checkLanguage');
      });
    });
    //print('checkLanguage1:$checkLanguage');
    Timer(const Duration(seconds: 3), () => _isLoggedIn ? Get.to(() => Dashboard(checkLanguage)) : Get.to(() => const ChooseLanguage()));
  }
  // @override
  // void dispose() {
  //   connection!.cancel();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
          color: Colors.transparent,
          child: SvgPicture.asset(AppConfig.logoImage),
        ),
      ),
    );
  }
}
