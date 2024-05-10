import 'package:MangopointFarmers/screens/otpScreen.dart';
import 'package:MangopointFarmers/service/login_service.dart';
import 'package:MangopointFarmers/utils/utility.dart';
import 'package:MangopointFarmers/widgets/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  String isLocale;
  LoginPage(this.isLocale, {Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  String error = '';
  bool isError = false;
  bool isLoading = false;

  FocusNode mobileFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    CustomToast.init(context);

    //print('object:$data');
    //  print('object:$')
  }

  @override
  Widget build(BuildContext context) {
    String isLocale = widget.isLocale;
    print('$isLocale');
    return Scaffold(
      backgroundColor: AppConfig.mainBg,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.17),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.17,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    SvgPicture.asset(
                      AppConfig.loginLogo,
                      height: 60,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppConfig.mainSubtitleBg,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 15),
                        child: Text(
                          'farmers'.tr,
                          style: TextStyle(
                              color: AppConfig.mainSubtitle,
                              fontFamily: (isLocale == 'english')
                                  ? 'Gilroy SemiBold'
                                  : 'Tamil064',
                              fontSize: (isLocale == 'english')
                                  ? 18
                                  : MediaQuery.of(context).size.width * 0.04),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 60, bottom: 15),
                            child: Text(
                              'login'.tr,
                              style: TextStyle(
                                  color: AppConfig.mainBg,
                                  fontFamily: (isLocale == 'english')
                                      ? 'Gilroy SemiBold'
                                      : 'Tamil064',
                                  fontSize: (isLocale == 'english')
                                      ? 30
                                      : MediaQuery.of(context).size.width *
                                          0.06),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'itsNiceToSeeYouAgain'.tr,
                              style: TextStyle(
                                color: AppConfig.loginTextDesc,
                                fontFamily: (isLocale == 'english')
                                    ? 'Gilroy Regular'
                                    : 'Tamil064',
                                fontSize: (isLocale == 'english')
                                    ? 18
                                    : MediaQuery.of(context).size.width * 0.039,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Text(
                              'loginToContinueToYourAccount'.tr,
                              style: TextStyle(
                                  color: AppConfig.loginTextDesc,
                                  fontFamily: (isLocale == 'english')
                                      ? 'Gilroy Regular'
                                      : 'Tamil064',
                                  fontSize: (isLocale == 'english')
                                      ? 18
                                      : MediaQuery.of(context).size.width *
                                          0.039),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              'mobile'.tr,
                              style: TextStyle(
                                  color: AppConfig.allBlack,
                                  fontFamily: (isLocale == 'english')
                                      ? 'Gilroy Medium'
                                      : 'Tamil064',
                                  fontSize: (isLocale == 'english')
                                      ? 18
                                      : MediaQuery.of(context).size.width *
                                          0.042),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 45),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7)),
                              child: Container(
                                color: const Color(0xffF4F4F4),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    hintText: 'mobile'.tr,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              // Get.to(() => OtpScreen());
                              // print('phone:${phoneController.text}');
                              if (phoneController.text.isEmpty) {
                                CustomToast.show(
                                    'pleaseEnterTheMobileNumber'.tr, context);
                              } else if (phoneController.text.length < 10) {
                                CustomToast.show(
                                    'pleaseEnterValidMobileNumber'.tr, context);
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  final authService = LoginService();
                                  final result = await authService
                                      .loginOtp(phoneController.text);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  //print('Came here: ${result}');
                                  if (result ==
                                      'Unable to find matching email / phone number , please try again') {
                                    CustomToast.show(
                                        'mobileNumberisnotRegistered'.tr,
                                        context);
                                  } else if (result ==
                                      'otp has been successfully sent to your phone and email') {
                                    CustomToast.show(
                                        'oTPSentSuccessfully'.tr, context);
                                    Get.to(() => OtpScreen(
                                        phoneController.text, isLocale));
                                  }
                                } on Exception catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  CustomToast.show(e.toString(), context);
                                }
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: AppConfig.mainBg,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7)),
                                ),
                                height: 52,
                                child: Center(
                                    child: isLoading
                                        ? LoadingAnimationWidget.discreteCircle(
                                            color: Colors.white, size: 30)
                                        : Text('getOTP'.tr,
                                            style: TextStyle(
                                                color: Color(0xffFFFFFF),
                                                fontFamily: 'Gilroy Medium',
                                                fontSize:
                                                    (isLocale == 'english')
                                                        ? 18
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.045)))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
