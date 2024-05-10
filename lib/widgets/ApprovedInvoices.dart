

import 'dart:ui';

import 'package:MangopointFarmers/screens/invoiceDetails.dart';
import 'package:MangopointFarmers/service/earlyPayment_service.dart';
import 'package:MangopointFarmers/service/invoice_service.dart';
import 'package:MangopointFarmers/utils/utility.dart';
import 'package:MangopointFarmers/widgets/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ApprovedInvoices extends StatelessWidget {
  var approvedData;
   String isLocale;
  ApprovedInvoices({
    Key? key,
    required this.approvedData, required this.isLocale, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    stringToDate(String data) {
      var day = data.substring(8, 10);
      var month = data.substring(5, 7);
      var year = data.substring(0, 4);
      final intDay = int.parse(day);
      final intMonth = int.parse(month);
      final intYear = int.parse(year);
      final formattedDate = DateTime.utc(intYear, intMonth, intDay);
      //print("formattedDate:${formattedDate}");
      return formattedDate;
    }
    _showDialog(int id,String model){
      print('id:$id');
      DateTime now = DateTime.now();
      String time = DateFormat.H().format(now);
      final requestTime =int.parse(time);

      showDialog(barrierDismissible: false,context: context, builder: (BuildContext context){
        return BackdropFilter(filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
          child: AlertDialog(

              title:Text((requestTime < 18)?'Payment request received before cut-off time of 6:00 p.m. will be credited today before 8:00 p.m. '
                  :'Payment request received after cut-off time of 6:00 p.m. will be credited tomorrow.',style:TextStyle(fontFamily: 'Gilroy Medium') ) ,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed:() async {
                      Get.back();
                    }, child: Text('cancel'.tr,style: TextStyle(fontFamily: 'Gilroy Medium',color: AppConfig.cardCalIcon),)),
                    TextButton(onPressed:() async {

                      final paymentService = EarlyPaymentService();
                      final result = await paymentService.getEarlyPayment(id, model);
                      context.read<InvoiceService>().getApprovedInvoice();
                      CustomToast.show('requestEarlyPaymentSubmittedSuccesfully'.tr, context);



                    }, child: Text('ok'.tr,style: TextStyle(fontFamily: 'Gilroy Medium',color: AppConfig.cardCalIcon),)),
                  ],
                )]),);
      });

    }


    print('inside approved:$isLocale');

    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .70,
        child: ListView.builder(
            itemCount: approvedData.length,
            itemBuilder: (context, index) {
              // print('Approved:${approvedData[index].fromPartyName}');
              return GestureDetector(
                onTap: () {
                  print('inde: ${approvedData[index]}');
                  Get.to(() => InvoiceDetails(approvedData[index],true,isLocale),);
                },
                child: Column(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .34,
                          width: MediaQuery.of(context).size.width * 0.85,
                          color: AppConfig.mainBg.withOpacity(0.07),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'from'.tr,
                                        style: TextStyle(color: AppConfig.loginTextDesc,
                                            fontFamily:(isLocale=='english')? 'Gilroy Regular':'Tamil064',
                                            fontSize:(isLocale=='english')?12:MediaQuery.of(context).size.width*0.028),
                                      ),
                                    ),
                                    Text(
                                      '${approvedData[index].fromPartyName}',
                                      style: TextStyle(color: AppConfig.allBlack,
                                          fontFamily: 'Gilroy SemiBold', fontSize: 20),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            'DATE'.tr,//Invoice date
                                            style: TextStyle(color: AppConfig.loginTextDesc,
                                                fontFamily: (isLocale=='english')?'Gilroy Regular':'Tamil064',
                                                fontSize:(isLocale=='english')?12:MediaQuery.of(context).size.width*0.028),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/calender.svg',
                                              height: 18,
                                              width: 16,
                                              color: AppConfig.cardCalIcon,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: Text(
                                                DateFormat.yMd().format(stringToDate(approvedData[index].invoiceDate)),
                                                style: TextStyle(color: AppConfig.allBlack, fontFamily: 'Gilroy Medium', fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:(isLocale=='english')?EdgeInsets.only(left: 50):EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              'DUEDATE'.tr,
                                              style: TextStyle(color: AppConfig.loginTextDesc,
                                                  fontFamily: (isLocale=='english')?'Gilroy Regular':'Tamil064',
                                                  fontSize:(isLocale=='english')?12:MediaQuery.of(context).size.width*0.028),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/calender.svg',
                                                height: 18,
                                                width: 16,
                                                color: AppConfig.cardCalIcon,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8),
                                                child: Text(
                                                  DateFormat.yMd().format(stringToDate(approvedData[index].dueDate)),
                                                  style: TextStyle(color: AppConfig.allBlack, fontFamily: 'Gilroy Medium', fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'amount'.tr,
                                        style: TextStyle(color: AppConfig.loginTextDesc,
                                            fontFamily:(isLocale=='english')? 'Gilroy Regular':'Tamil064',
                                            fontSize: (isLocale=='english')?12:MediaQuery.of(context).size.width*0.028),
                                      ),
                                    ),
                                    Text(
                                      approvedData[index].approvedAmount == null ? 'INR 0.0' : 'INR ${approvedData[index].approvedAmount}',
                                      style: TextStyle(color: AppConfig.allBlack, fontFamily: 'Gilroy Medium', fontSize: 16),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:(isLocale=='english')?EdgeInsets.only(left: 40):EdgeInsets.only(left: 80),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
                                          backgroundColor: AppConfig.mainBg),
                                      onPressed: () async {
                                        final id = approvedData[index].tId;
                                        final model = approvedData[index].modelType;

                                        _showDialog(id,model);

                                        //print('result:${result}');
                                      },
                                      child:Text(
                                        'requestEarlyPayment'.tr,
                                        style: TextStyle(color: Color(0xffffffff), fontFamily: 'Gilroy Medium',
                                            fontSize: (isLocale=='english')?16:MediaQuery.of(context).size.width*0.039),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
