import 'package:MangopointFarmers/screens/invoiceDetails.dart';
import 'package:MangopointFarmers/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FinancedInvoices extends StatelessWidget {
  var financedData;
  // final Function refreshPage;
  String data;
  FinancedInvoices({
    Key? key,
    required this.financedData, required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('fin:$data');
    stringToDate(String data) {
      var day = data.substring(8, 10);
      var month = data.substring(5, 7);
      var year = data.substring(0, 4);
      final intDay = int.parse(day);
      final intMonth = int.parse(month);
      final intYear = int.parse(year);
      final formattedDate = DateTime.utc(intYear, intMonth, intDay);
      // print("formattedDate:${formattedDate}");
      return formattedDate;
    }

    //print('inside financed:${financedData.approvedAmount}');
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .70,
        child: ListView.builder(
            itemCount: financedData.length,
            itemBuilder: (context, index) {
               print('Financed:${financedData[index].interestAmount}');
              return GestureDetector(
                onTap: () {
                  print('inde finanved invoice: ${financedData[index].approvedAmount}');
                  Get.to(() => InvoiceDetails(financedData[index], false,data) );
                },
                child: Column(
                  children: [
                    Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .30,
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
                                              fontFamily: 'Gilroy Regular',
                                              fontSize:(data=='english')?12:MediaQuery.of(context).size.width*0.028),
                                        ),
                                      ),
                                      Text(
                                        '${financedData[index].fromPartyName}',
                                        style: TextStyle(color: AppConfig.allBlack, fontFamily: 'Gilroy SemiBold', fontSize: 20),
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
                                              'PAYMENT DATE',//payment date
                                              style: TextStyle(color: AppConfig.loginTextDesc,
                                                  fontFamily: 'Gilroy Regular',
                                                  fontSize: (data=='english')?12:MediaQuery.of(context).size.width*0.028),
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
                                                  financedData[index].financeDate == null ?'-':DateFormat.yMd().format(stringToDate(financedData[index].financeDate)),
                                                  style: TextStyle(color: AppConfig.allBlack, fontFamily: 'Gilroy Medium', fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:(data=='english')?EdgeInsets.only(left: 50):EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 5),
                                              child: Text(
                                                'DUEDATE'.tr,
                                                style: TextStyle(color: AppConfig.loginTextDesc,
                                                    fontFamily: 'Gilroy Regular',
                                                    fontSize: (data=='english')?12:MediaQuery.of(context).size.width*0.028),
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
                                                    financedData[index].dueDate == null ?'-':DateFormat.yMd().format(stringToDate(financedData[index].dueDate)),
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
                                          style: TextStyle(color: AppConfig.loginTextDesc, fontFamily: 'Gilroy Regular',
                                              fontSize: (data=='english')?12:MediaQuery.of(context).size.width*0.028),
                                        ),
                                      ),
                                      Text(
                                        financedData[index].financedAmount == null ? 'INR 0.0' : 'INR ${financedData[index].financedAmount}',
                                        style: TextStyle(color: AppConfig.allBlack, fontFamily: 'Gilroy Medium', fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
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
