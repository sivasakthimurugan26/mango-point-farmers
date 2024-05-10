import 'dart:convert';
import 'package:MangopointFarmers/screens/chooseLanguage.dart';
import 'package:MangopointFarmers/screens/loginPage.dart';
import 'package:MangopointFarmers/screens/userProfile.dart';
import 'package:MangopointFarmers/service/invoice_service.dart';
import 'package:MangopointFarmers/utils/utility.dart';
import 'package:MangopointFarmers/widgets/ApprovedInvoices.dart';
import 'package:MangopointFarmers/widgets/FinancedInvoices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  String data;
  Dashboard(this.data, {
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int toggleValue = 0;
  bool isprofilename = false;

  bool isLoading = true;

  void logOut() async {
    SharedPreferences userToken = await SharedPreferences.getInstance();

    userToken.clear();

  }

  stringToDate(String data) {
    var dayy = data.substring(8, 10);
    var month = data.substring(5, 7);
    var year = data.substring(0, 4);
    final intDay = int.parse(dayy);
    final intMonth = int.parse(month);
    final intYear = int.parse(year);
    final formattedDate = DateTime.utc(intYear, intMonth, intDay);
    //print('formattedDate:${formattedDate}');
    return formattedDate;
  }

  getProfile() async {
    SharedPreferences userToken = await SharedPreferences.getInstance();
    print('Token: ${userToken.get('token')}');
    var headers = {
      'Authorization': 'token ${userToken.get('token')}',
    };
    var request = http.Request('GET', Uri.parse(AppConfig.profileUrl));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      // print(result['data'][0]['display_name']);
      return result['data'][0];
    } else {
      print(response.reasonPhrase);
    }
  }

  int? tabMenu;

  @override
  void initState() {
    super.initState();
    print('userProfile lang:${widget.data}');
    print('Came here');
    InvoiceService().getApprovedInvoice();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InvoiceService>().approvedReload();
      context.read<InvoiceService>().financeReload();
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void refreshPage() {
    print('PageRefresh');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String isLocale=widget.data;
    print('object:$isLocale');
    var approvedServiceData = context.watch<InvoiceService>().approvedInvoice;
    var financedServiceData = context.watch<InvoiceService>().financedInvoice;

   // print('Dataaa: $data');
    print('approvedServiceData: ${approvedServiceData}');
    print('financedServiceData: $financedServiceData');

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppConfig.mainBg,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() =>  UserProfile(getProfile(),isLocale));

                              },
                              child: SvgPicture.asset(
                                'assets/images/avatar.svg',
                                height: 60,
                                width: 60,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                FutureBuilder(
                                    future: getProfile(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text('');
                                      }
                                      if (snapshot.hasData) {
                                        var displayName=snapshot.data['display_name'];
                                        return Text(displayName==null?'hi'.tr +',' :'hi ${displayName}'.tr.capitalize!,
                                          style: TextStyle(
                                              color: AppConfig.mainBg,
                                              fontFamily: 'Gilroy SemiBold',
                                              fontSize: 24),
                                        );
                                      } else {
                                        return const Text('');
                                      }
                                      //print('profileName:${snapshot.data}');
                                    }),

                                // const Text(
                                //   'ICICI Bank',
                                //   style: TextStyle(color: Color(0xff646464), fontFamily: 'Gilroy Regular', fontSize: 16),
                                // ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                logOut();
                                Get.to(() => ChooseLanguage());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    color: AppConfig.logoutIcon),
                                width: 33,
                                height: 33,
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/images/logoutIcon.svg',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                'logOut'.tr,
                                style: TextStyle(
                                    color: AppConfig.allBlack,
                                    fontFamily:
                                    (isLocale=='english') ? 'Gilroy Medium' : 'Tamil064',
                                    fontSize: 11),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * .07,
                        padding: const EdgeInsets.all(2.5),
                        color: AppConfig.mainSubtitleBg,
                        child: ToggleSwitch(
                          multiLineText: true,
                          centerText: true,
                          fontSize:(isLocale=='english')? 15:MediaQuery.of(context).size.width*.032,
                          minWidth: MediaQuery.of(context).size.width * .415,
                          cornerRadius: 15,
                          radiusStyle: true,
                          activeBgColor: [
                            AppConfig.allWhite,
                          ],
                          inactiveBgColor: AppConfig.mainSubtitleBg,
                          inactiveFgColor: AppConfig.loginTextDesc,
                          activeFgColor: AppConfig.toggleSwitch,
                          initialLabelIndex: toggleValue,
                          totalSwitches: 2,
                          labels: [
                            'approvedInvoices'.tr,
                            'paidInvoices'.tr,
                          ],
                          onToggle: (index) async {
                            setState(() {
                              toggleValue = index!;
                              tabMenu = index;
                            });
                            // print('switched to: $index');
                            if (toggleValue == 0) {
                              context.read<InvoiceService>().approvedInvoice;
                              setState(() {
                                approvedServiceData = context
                                    .read<InvoiceService>()
                                    .approvedInvoice;
                              });
                            } else {
                              context.read<InvoiceService>().financedInvoice;
                              context.read<InvoiceService>().financeReload();
                              setState(() {
                                financedServiceData = context
                                    .read<InvoiceService>()
                                    .financedInvoice;
                              });
                            }
                            // toggleValue == 0 ? approvedServiceData : financedServiceData;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        print('Working');
                        if (toggleValue == 0) {
                          await context.read<InvoiceService>().approvedReload();
                          setState(() {
                            approvedServiceData =
                                context.read<InvoiceService>().approvedInvoice;
                          });
                        } else {
                          await context.read<InvoiceService>().financeReload();
                          setState(() {
                            financedServiceData =
                                context.read<InvoiceService>().financedInvoice;
                          });
                        }
                      },
                      child: SingleChildScrollView(
                        child: toggleValue == 0
                            ? (approvedServiceData.isEmpty)
                                ? Padding(
                                    padding: const EdgeInsets.all(50),
                                    child: Text(
                                      'currentlyThereIsNoPendingInvoices'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Gilroy SemiBold',
                                        fontSize: 20,
                                        color: AppConfig.logoutIcon,
                                      ),
                                    ),
                                  )
                                : ApprovedInvoices(
                                    approvedData: approvedServiceData, isLocale:isLocale,)
                            : (financedServiceData.isEmpty)
                                ? Padding(
                                    padding: const EdgeInsets.all(50),
                                    child: Text(
                                      'currentlyThereIsNoPaidInvoices'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Gilroy SemiBold',
                                        fontSize: 20,
                                        color: AppConfig.logoutIcon,
                                      ),
                                    ),
                                  )
                                : FinancedInvoices(
                                    financedData: financedServiceData, data:isLocale, ),
                      ),
                    ),
                  ),

                  // Container(
                  //         color: Colors.yellow,
                  //         child: RefreshIndicator(
                  //           onRefresh: () async {
                  //             print('Working');
                  //             if (toggleValue == 0) {
                  //               await context.read<InvoiceService>().approvedReload();
                  //               setState(() {
                  //                 approvedServiceData = context.read<InvoiceService>().approvedInvoice;
                  //               });
                  //             } else {
                  //               await context.read<InvoiceService>().financeReload();
                  //               setState(() {
                  //                 financedServiceData = context.read<InvoiceService>().financedInvoice;
                  //               });
                  //             }
                  //           },
                  //           child: toggleValue == 0
                  //               ? (approvedServiceData.isEmpty)
                  //               ? Padding(
                  //             padding: const EdgeInsets.all(50),
                  //             child: Text(
                  //               'Currently there is no pending Invoices',
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                   fontFamily: 'Gilroy SemiBold',
                  //                   fontSize: 20,
                  //                   color: AppConfig.logoutIcon
                  //               ),
                  //             ),
                  //           )
                  //               : ApprovedInvoices(
                  //             approvedData: approvedServiceData,
                  //           )
                  //               : (financedServiceData.isEmpty)
                  //               ? Padding(
                  //             padding: const EdgeInsets.all(50),
                  //             child: Text(
                  //               'Currently there is no paid Invoices',
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                   fontFamily: 'Gilroy SemiBold',
                  //                   fontSize: 20,
                  //                   color: AppConfig.logoutIcon
                  //               ),
                  //             ),
                  //           )
                  //               : FinancedInvoices(
                  //             financedData: financedServiceData,
                  //           ),
                  //         ),
                  //
                  //       ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
