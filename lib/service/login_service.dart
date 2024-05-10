import 'dart:convert';

import 'package:MangopointFarmers/screens/dashboard.dart';
import 'package:MangopointFarmers/screens/userProfile.dart';
import 'package:MangopointFarmers/service/firstRunCheck.dart';
import 'package:MangopointFarmers/utils/utility.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  LoginService();


  Future<String> loginOtp(String mobile) async {
     //print('MobileL; $mobile');

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(AppConfig.authUrl));
    request.body = json.encode({"data": mobile});
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    //print('res: ${response.body}');
    if (response.statusCode == 203 || response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      // print('jsonDecode: ${response.body}');
      return result['data'];
    } else {
      return response.reasonPhrase.toString();
    }
  }

  Future<String> verifyOtp(String mobileNumber, String otp, String data) async {
    print('mobile: $data, otp: $otp');
    SharedPreferences userToken = await SharedPreferences.getInstance();
    SharedPreferences userId = await SharedPreferences.getInstance();

    // bool isLoggedIn = false;
    // MySharedPreferences.instance
    //     .getBooleanValue("isfirstRun")
    //     .then((value) {
    //   isLoggedIn = value;
    // });

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${AppConfig.verifyAuthUrl}?data=$mobileNumber'));
    request.body = json.encode({"otp": otp});
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 203) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      print('Result: $result');
      if (result['status'] == 'success') {
        userToken.setString('token', result['data']['token']);
        userId.setInt('Id', result['data']['party_id']);
        print('idddd:${userId.getInt('Id')}');

        // isLoggedIn?
        // Get.to(() => const UserProfile(null)):
        Get.to(() => Dashboard(data));
      }
      return result['status'];
    } else {
      return response.reasonPhrase.toString();
    }
  }
}
