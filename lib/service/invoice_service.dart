import 'dart:convert';

import 'package:MangopointFarmers/model/invoice_model.dart';
import 'package:MangopointFarmers/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InvoiceService extends ChangeNotifier {
  List<InvoiceModel> _approvedInvoice = [];
  List<InvoiceModel> get approvedInvoice => _approvedInvoice;

  List<InvoiceModel> _financedInvoice = [];
  List<InvoiceModel> get financedInvoice => _financedInvoice;

  Future<void> getApprovedInvoice() async {
    SharedPreferences userToken = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'token ${userToken.get('token')}',
    };
    var request = http.Request('GET', Uri.parse(AppConfig.approvedInvoiceUrl));
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final invoicesData = data['data'];
      _approvedInvoice = invoicesData.map<InvoiceModel>((json) => InvoiceModel.fromJson(json)).toList();
      print('Approved: $_approvedInvoice');

      notifyListeners();

    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> getFinancedInvoice() async {
    SharedPreferences userToken = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'token ${userToken.get('token')}',
    };
    var request = http.Request('GET', Uri.parse(AppConfig.financedInvoiceUrl));
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final invoicesData = data['data'];
      _financedInvoice = invoicesData.map<InvoiceModel>((json) => InvoiceModel.fromJson(json)).toList();
       print('FinancedData: ${_financedInvoice}');

      notifyListeners();
      // notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  approvedReload() async{
    approvedInvoice.clear();
    notifyListeners();
    getApprovedInvoice();

  }

  financeReload() async{
    financedInvoice.clear();
    notifyListeners();
    getFinancedInvoice();
  }
}
