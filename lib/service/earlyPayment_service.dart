import 'dart:convert';

import 'package:MangopointFarmers/service/invoice_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MangopointFarmers/utils/utility.dart';

class EarlyPaymentService{

  Future getEarlyPayment(int id,String model) async {
    print('id: $id');
    print('model: $model');
    SharedPreferences userToken = await SharedPreferences.getInstance();
    print('Token: ${userToken.get('token')}');
    var headers = {
      'Authorization': 'token ${userToken.get('token')}',
    };

    var request1 = http.Request('GET', Uri.parse('${AppConfig.earlyPaymentUrl}?action=REQUEST FINANCE&type=$model&t_id=$id'));
    request1.headers.addAll(headers);
    var streamedResponse = await request1.send();
    var response1 = await http.Response.fromStream(streamedResponse);
    print('statusCode: ${response1.statusCode}');
    if (response1.statusCode == 200) {
      final result = jsonDecode(response1.body) as Map<String, dynamic>;
      print('jsonDecode: ${result['data']}');
      final fromParty =result['data']['from_party'];
      final toParty=result['data']['to_party'];
      print('obj:${fromParty},${toParty},${model},${id}');

      var headers = {
        'Authorization': 'token ${userToken.get('token')}',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${AppConfig.requestEarlyPaymentUrl}'));
      request.body = json.encode({
        "type": '$model',
        "action": "REQUEST FINANCE",
        "t_id": "$id",
        "from_party": "$fromParty",
        "to_party": "$toParty"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        InvoiceService().getApprovedInvoice();
        print('DataOP: ${await response.stream.bytesToString()}');
      }
      else {
        print(response.reasonPhrase);
      }


      return result['data'];
    } else {
      return response1.reasonPhrase.toString();
    }
  }
}