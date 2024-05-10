import 'package:MangopointFarmers/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InvoiceDetails extends StatelessWidget {
  var invoiceData;
  bool? approvedInvoice;
  String isLocale;
  InvoiceDetails(this.invoiceData, this.approvedInvoice, this.isLocale, {Key? key})
      : super(key: key);
  // invoiceDetails({Key? key}) : super(key: key);

  var token;

  @override
Widget build(BuildContext context) {
  print('interest:${invoiceData.interestAmount}');
  print('bool app:$approvedInvoice');

  print('dataaa:$isLocale');
  print('InterestAmountStatus: ${invoiceData.interestAmountStatus}');
  stringToDate(String data) {
    var dayy = data.substring(8, 10);
    var month = data.substring(5, 7);
    var year = data.substring(0, 4);
    final intDay = int.parse(dayy);
    final intMonth = int.parse(month);
    final intYear = int.parse(year);
    final formattedDate = DateTime.utc(intYear, intMonth, intDay);
    // print("formattedDate:${formattedDate}");
    return formattedDate;
  }
  // print('object:${data['record_datas']['values'][0]['fields']['invoice_no']}');

  var interimState=invoiceData.interimState;
  var status=(interimState.split('_'));
  // print('status:${status[0]}');
  return Scaffold(
    backgroundColor: AppConfig.mainBg,
    body: SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .92,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: AppConfig.mainBg,
                          size: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.fromLTRB(40, 26, 0, 0),
                      child: Center(
                        child: Text(
                          'invoiceDetails'.tr,
                          style: TextStyle(color: AppConfig.mainBg, fontFamily:isLocale=='english'? 'Gilroy SemiBold':'Tamil064', fontSize:isLocale=='english'?25:MediaQuery.of(context).size.width*0.049),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'buyerName'.tr,
                            style: TextStyle(color: AppConfig.mainBg, fontFamily:isLocale=='english'? 'Gilroy SemiBold':'Tamil064', fontSize: isLocale=='english'?18:MediaQuery.of(context).size.width*0.042),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'invoiceNumber'.tr,
                            style: TextStyle(color: AppConfig.mainBg, fontFamily:isLocale=='english'? 'Gilroy SemiBold':'Tamil064', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'date'.tr,
                            style: TextStyle(color: AppConfig.mainBg, fontFamily:isLocale=='english'? 'Gilroy SemiBold':'Tamil064', fontSize: isLocale=='english'?18:MediaQuery.of(context).size.width*0.042),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          approvedInvoice!?Text(
                            'invoiceAmount'.tr,
                            style: TextStyle(
                                color: AppConfig.mainBg, fontFamily:isLocale=='english'? 'Gilroy SemiBold':'Tamil064', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                          ):Text(
                            'financeAmount'.tr,
                            style: TextStyle(
                                color: AppConfig.mainBg, fontFamily:isLocale=='english'? 'Gilroy SemiBold':'Tamil064', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width:MediaQuery.of(context).size.width/2,
                            child: Text(
                              'dueDate'.tr,
                              // maxLines: 2,
                              style: TextStyle(color: AppConfig.mainBg, fontFamily: isLocale=='english'?'Gilroy SemiBold':'Tamil064', fontSize: isLocale=='english'?18:MediaQuery.of(context).size.width*0.042),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width:MediaQuery.of(context).size.width/2,
                            child: Text(
                              'status'.tr,
                              //maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: AppConfig.mainBg, fontFamily:isLocale=='english'? 'Gilroy SemiBold':'Tamil064', fontSize: isLocale=='english'?18:MediaQuery.of(context).size.width*0.042),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: !approvedInvoice! && invoiceData.interestAmountStatus,
                            child: Text(
                              'interestAmount'.tr,
                              style: TextStyle(color: AppConfig.mainBg, fontFamily:isLocale=='english'? 'Gilroy SemiBold':'Tamil064', fontSize: isLocale=='english'?18:MediaQuery.of(context).size.width*0.042),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: !approvedInvoice! && invoiceData.interestAmountStatus,
                            child: Text(
                              'interestRate'.tr,
                              style: TextStyle(color: AppConfig.mainBg, fontFamily:isLocale=='english'? 'Gilroy SemiBold':'Tamil064', fontSize: isLocale=='english'?18:MediaQuery.of(context).size.width*0.042),
                            ),
                          ),


                        ],
                      ),
                      Padding(
                        padding:EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              invoiceData.fromPartyName,
                              style: TextStyle(color: AppConfig.invoiceText, fontFamily: 'Gilroy Medium', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              invoiceData.invoiceNo ?? '-',
                              style: TextStyle(color: AppConfig.invoiceText, fontFamily: 'Gilroy Medium', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              DateFormat.yMd().format(stringToDate(invoiceData.invoiceDate)),
                              style: TextStyle(color: AppConfig.invoiceText, fontFamily: 'Gilroy Medium', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            approvedInvoice!?Text(
                              '₹ ${approvedInvoice! ? invoiceData.approvedAmount : invoiceData.invoiceAmount}',
                              style: TextStyle(color: AppConfig.invoiceText, fontFamily: 'Gilroy Medium', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                            ):Text(
                              '₹ ${approvedInvoice! ? invoiceData.approvedAmount : invoiceData.financedAmount}',
                              style: TextStyle(color: AppConfig.invoiceText, fontFamily: 'Gilroy Medium', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                            ),
                            const SizedBox(
                              height: 20,
                            ),


                            Text(
                              DateFormat.yMd().format(stringToDate(invoiceData.dueDate)),
                              maxLines: 2,
                              style: TextStyle(color: AppConfig.invoiceText, fontFamily: 'Gilroy Medium', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${status[0]}',
                              maxLines: 2,
                              style: TextStyle(color: AppConfig.invoiceText, fontFamily: 'Gilroy Medium', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Visibility(
                              visible: !approvedInvoice! && invoiceData.interestAmountStatus,
                              child: Text(
                                '₹${invoiceData.interestAmount} ',
                                style: TextStyle(color: AppConfig.invoiceText, fontFamily: 'Gilroy Medium', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Visibility(
                              visible: !approvedInvoice! && invoiceData.interestAmountStatus,
                              child: Text(
                                '${invoiceData.interestRate} %',
                                style: TextStyle(color: AppConfig.invoiceText, fontFamily: 'Gilroy Medium', fontSize:isLocale=='english'? 18:MediaQuery.of(context).size.width*0.042),
                              ),
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
      ]),
    ),
  );
}

}

