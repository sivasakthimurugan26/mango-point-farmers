import 'dart:async';
import 'package:MangopointFarmers/localeString.dart';
import 'package:MangopointFarmers/screens/splashScreen.dart';
import 'package:MangopointFarmers/service/firstRunCheck.dart';
import 'package:MangopointFarmers/service/invoice_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreferences.firstRunCheck();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? connection;
  bool isoffline = false;

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }
  Future<void> initConnectivity() async {
    connection = await Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none)
      {
        setState(() {
          isoffline = true;
          print("No internet connection");
        });
      }else if(result == ConnectivityResult.mobile)
      {
        setState(() {
          isoffline = false;
          print("Internet connection is from Mobile data");
        });
      }
      else if(result == ConnectivityResult.wifi)
      {
        setState(() {
          isoffline = false;
          print("Internet connection is from wifi");
        });
      }else if(result == ConnectivityResult.ethernet)
      {
        setState(() {
          isoffline = false;
          print("Internet connection is from wired cable");
        });
      }else if(result == ConnectivityResult.bluetooth)
      {
        setState(() {
          isoffline = false;
          print("Internet connection is from bluethooth threatening");
        });
      }
    });
  }

  @override
  void initState() {
    initConnectivity();
    super.initState();
    initialization();

  }
  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InvoiceService()),
      ],
      child: GetMaterialApp(
        translations: LocalString(),
        locale: Locale('en','US'),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
