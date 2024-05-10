import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utility.dart';
import 'loginPage.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  bool EnglishSelected = true;
  bool TamilSelected = false;
  var locale;
  String isLocale= 'english';



  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
    setState(() {
      locale=Locale('en','US');
      Get.updateLocale(locale);
    });
    });
    //print('object:$data');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin:EdgeInsets.symmetric(horizontal:30) ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'chooseYourPerferredLanguage'.tr,
                      style: TextStyle(
                        height: 1.6,
                          color:AppConfig.mainBg,
                          fontFamily:(isLocale=='english')?'Gilroy SemiBold':'Tamil064',
                         fontSize: (isLocale=='english')?25:MediaQuery.of(context).size.width*0.05),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    // Text(
                    //   'pleaseSelectYourLanguage'.tr,
                    //   style: TextStyle(
                    //       color: AppConfig.languageDesc,
                    //       fontFamily: (isLocale=='english')?'Gilroy Regular':'Tamil064',
                    //       fontSize: (isLocale=='english')?16:MediaQuery.of(context).size.width*0.035),
                    // ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(()  {
                          EnglishSelected = true;
                          TamilSelected=false;
                          isLocale ='english';
                           locale =Locale('en','US');
                          Get.updateLocale(locale);
                          print('selection:${EnglishSelected}');
                        });
                      },
                      child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              width: 310,
                              height: 65,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                // border: Border.all(color: Colors.black12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    spreadRadius: 0,
                                    offset: Offset(.5, .5),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 23, horizontal: 25),
                                    child: Text('English',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Gilroy Medium',
                                          fontSize: 16,
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(150, 10, 0, 10),
                                    child: Visibility(
                                      visible: EnglishSelected,
                                      child: SvgPicture.asset(
                                          'assets/images/selectedIcon.svg'),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(()  {
                      EnglishSelected = false;
                      TamilSelected = true;
                      isLocale ='tamil';
                      locale =Locale('ta');
                      Get.updateLocale(locale);

                    });
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          width: 310,
                          height: 65,
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            // border: Border.all(color: Colors.black12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 0,
                                offset: Offset(.5, .5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 23, horizontal: 25),
                                child: Text('tamil'.tr,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Gilroy Medium',
                                      fontSize: 16,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(170, 10, 0, 10),
                                child: Visibility(
                                  visible: TamilSelected,
                                  child: SvgPicture.asset(
                                      'assets/images/selectedIcon.svg'),
                                ),
                              ),
                            ],
                          ),

                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences islocale = await SharedPreferences.getInstance();
          islocale.setString('islocal',isLocale);
          print('local:${islocale.getString('islocal')}');
          Get.to(() =>  LoginPage(isLocale));

        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
