import 'dart:convert';
import 'package:MangopointFarmers/screens/dashboard.dart';
import 'package:MangopointFarmers/service/login_service.dart';
import 'package:MangopointFarmers/utils/utility.dart';
import 'package:MangopointFarmers/widgets/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  final String? mobileNumber;
  String data;
   OtpScreen(this.mobileNumber,this.data , {Key? key}) : super(key: key);
  // const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  bool isLoggedIn = false;
  bool isLoading = false;
  OtpFieldController otpController = OtpFieldController();
  String otpValue = '';
  // String pin = '';
  @override
  void initState() {
    super.initState();
    //print('object:$data');
  }

  @override
  Widget build(BuildContext context) {
    String isLocale=widget.data;
    return Scaffold(
      backgroundColor: AppConfig.mainBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.17,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      AppConfig.loginLogo,
                      height: 60,
                      // width: 163,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    decoration: BoxDecoration(color: AppConfig.mainSubtitleBg, borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                      child: Text(
                        'farmers'.tr,
                        style: TextStyle(color: AppConfig.mainSubtitle, fontFamily:(isLocale=='english')? 'Gilroy SemiBold':'Tamil064', fontSize:(isLocale=='english')? 18:MediaQuery.of(context).size.width*0.04),
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
                            'otp'.tr,
                            style: TextStyle(color: AppConfig.mainBg, fontFamily:'Gilroy SemiBold', fontSize: 30),
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "a6-digitOTPCodeWasSuccessfullySentToYourEmail&MobileNumber".tr,
                            style: TextStyle(color: AppConfig.loginTextDesc,
                                fontFamily: 'Gilroy Regular', fontSize:(isLocale=='english')?17.5:MediaQuery.of(context).size.width*0.044, height: 1.75),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        OTPTextField(
                          controller: otpController,
                          otpFieldStyle: OtpFieldStyle(borderColor: const Color(0xffB0B0B0), focusBorderColor: const Color(0xff006666)),
                          length: 6,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: MediaQuery.of(context).size.width * 0.12,
                          style: const TextStyle(fontFamily: 'Gilroy Regular', fontSize: 20),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.underline,
                          keyboardType: TextInputType.number,
                          onChanged: (pin) {
                            // setState(() {
                            //   pin = pin;
                            // });
                            // print("CHanged:  + ${pin.length}");
                          },
                          onCompleted: (pin) {
                            setState(() {
                              otpValue = pin;
                            });
                            // print("Completed: " + pin);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(
                                "didn'tReceiveOTP".tr,
                                style: TextStyle(color: AppConfig.loginTextDesc, fontFamily:'Gilroy Regular',
                                    fontSize:(isLocale=='english')? 16:MediaQuery.of(context).size.width*0.035),
                              ),
                              TextButton(
                                onPressed: () {
                                  otpController.clear();
                                  final authService = LoginService();
                                  authService.loginOtp(widget.mobileNumber!);
                                  CustomToast.show('oTPSentSuccessfully'.tr, context);
                                },
                                child: Text(
                                  'resendOTP'.tr,
                                  style: TextStyle(color: AppConfig.allBlack, fontFamily:'Gilroy Bold',
                                      fontSize:(isLocale=='english')? 16:MediaQuery.of(context).size.width*0.035),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            // Get.to(() => const Dashboard());

                            // print('widget.mobileNumber: ${widget.mobileNumber}');
                            if (otpValue.isEmpty) {
                              CustomToast.show('pleaseEnterThe6-digitOTP'.tr, context);
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                final authService = LoginService();
                                final result = await authService.verifyOtp(widget.mobileNumber!, otpValue,isLocale);
                                setState(() {
                                  isLoading = false;
                                });
                                if (result == 'success') {
                                  CustomToast.show('oTPValidatedSuccessfully'.tr, context);
                                } else if (result == 'failure') {
                                  CustomToast.show('pleaseEnterValidOTP'.tr, context);
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
                                borderRadius: const BorderRadius.all(Radius.circular(7)),
                              ),
                              height: 52,
                              child: Center(
                                  child: isLoading
                                      ? LoadingAnimationWidget.discreteCircle(color: AppConfig.toggleSwitch, size: 30)
                                      : Text('submit'.tr, style: TextStyle(color: Color(0xffFFFFFF), fontFamily:(isLocale=='english')? 'Gilroy Medium':'Tamil064',
                                      fontSize: (isLocale=='english')?18:MediaQuery.of(context).size.width*0.045)))),
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
    );
  }
}
