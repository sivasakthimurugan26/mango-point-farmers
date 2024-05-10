import 'dart:convert';
import 'package:MangopointFarmers/screens/dashboard.dart';
import 'package:MangopointFarmers/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  final profile;
String data;
UserProfile(
    this.profile, this.data, {
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic> _profileData = {};

  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  var Name;
  bool isError = false;
  String error = '';
  String? isLocale;


  updateProfile(
    String name,
    String city,
    String address,
    String state,
    String pincode,
    String pancard,
    String aadhar,
  ) async {
    SharedPreferences userId = await SharedPreferences.getInstance();
    SharedPreferences userToken = await SharedPreferences.getInstance();
    final id = userId.getInt('Id');
    var headers = {
      'Authorization': 'token ${userToken.get('token')}',
    };
    var request = http.MultipartRequest(
        'PUT', Uri.parse('${AppConfig.updateProfileUrl}${id}/'));
    request.fields.addAll({
      'name': name,
      'state': state,
      'city': city,
      'zipcode': pincode,
      'address_line': address,
      'account_number': pancard,
      'customer_id': aadhar,
      'country_code': '95',
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
stringCapitialize(String data){
     return data.capitalizeFirst!;
}
  @override
  void initState() {
    isLocale=widget.data;
    super.initState();
  }

  // getProfileData() async{
  //   var result  = await widget.profileData;
  //   return result;
  // }

  @override
  Widget build(BuildContext context) {
    bool isProfileData = false;
    // print(getProfileData);
    // var profileData = widget.profileData;
    // if (profileData == null) {
    //   isProfileData = true;
    // }
    // else{
    //   nameController.text=profileData['name'];
    //   countryController.text=profileData['country_code'];
    //   stateController.text=profileData['state'];
    //
    //   cityController.text=profileData['city'];
    //
    //   if(profileData['account_number'] == null){
    //     panController.text='';
    //   }
    //   else{
    //     panController.text=profileData['account_number'];
    //   }
    //   if(profileData['customer_id'] == null){
    //     aadharController.text='';
    //   }
    //   else{
    //     aadharController.text=profileData['customer_id'];
    //   }
    //   pincodeController.text=profileData['zipcode'];
    //   addressController.text =profileData['address_line'];
    //
    // }
    // print('profiledate:${widget.profileData}');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppConfig.mainBg,
          ),
          onPressed: () {
           Get.to(Dashboard(isLocale!));
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'userProfile'.tr,
          style: TextStyle(
              color: AppConfig.mainBg,
              fontFamily: 'Gilroy SemiBold',
              fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: widget.profile,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                isProfileData = true;
              }
              if (snapshot.data != null) {
                isProfileData = false;
                final profileData = snapshot.data
                    as Map<String, dynamic>; // cast to Map<String, dynamic>
                final displayName = profileData['display_name'];

                // print('profileData: ${profileData['party_details'][0]}');
                print('DisplayName: $displayName');
                if (displayName == null) {
                  nameController.text = '-';
                }
                else {
                  nameController.text = stringCapitialize(displayName);
                }
                //nameController.text = stringCapitialize(profileData['display_name']);
                final pancard =
                    profileData['party_details'][0]['account_number'];
                final aadharcard =
                    profileData['party_details'][0]['customer_id'];
                final country =
                    profileData['party_details'][0]['country_code_id'];
                // print('object:${country}');
                // print('object:${country.runtimeType}');
                final state= stringCapitialize(profileData['party_details'][0]['state']);
                final city = stringCapitialize(profileData['party_details'][0]['city']);
                // pincodeController.text = profileData['party_details'][0]['zipcode'];
                final address =
                    stringCapitialize(profileData['party_details'][0]['address_line']);
                if (state == null) {
                  stateController.text = '-';
                } else {
                  stateController.text = state;
                }
                if (city == null) {
                  cityController.text = '-';
                } else {
                  cityController.text = city;
                }
                if (address == null) {
                  addressController.text = '-';
                } else {
                  addressController.text = address;
                }
                if (country == 95) {
                  countryController.text = 'India';
                }
                if (pancard == null) {
                  panController.text = '-';
                } else {
                  panController.text = pancard;
                }
                if (aadharcard == null) {
                  aadharController.text = '-';
                } else {
                  aadharController.text = aadharcard;
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Stack(
                          //   children: [
                          //     CircleAvatar(
                          //       backgroundColor: Colors.transparent,
                          //       radius: 90,
                          //       child: SvgPicture.asset('assets/images/avatar.svg',
                          //         width: 110,
                          //       ),
                          //     ),
                          //     Positioned(
                          //       right: 17,
                          //       bottom: 22,
                          //       child: TextButton(
                          //         style: TextButton.styleFrom(
                          //           backgroundColor: AppConfig.allWhite,
                          //           shape: const CircleBorder(),
                          //         ),
                          //         child: SvgPicture.asset(
                          //           'assets/images/editAvatarIcon.svg',
                          //           width: 15,
                          //         ),
                          //         onPressed: () {
                          //
                          //         },
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'chooseLanguage'.tr,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: 'Gilroy Medium',
                                  fontSize: 18),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                child: Container(
                                  width:150,
                                  color: Color(0xffF4F4F4),
                                  child: RadioListTile(
                                    activeColor:AppConfig.logoutIcon,
                                    contentPadding: EdgeInsets.all(5),
                                    title: Text("tamil".tr),
                                    value:'tamil',
                                    groupValue: isLocale,
                                    onChanged: (value){
                                      setState(()  async {
                                        isLocale = value.toString();
                                        final locale=Locale('ta');
                                        Get.updateLocale(locale);
                                        SharedPreferences islocale = await SharedPreferences.getInstance();
                                        islocale.setString('islocal',isLocale!);
                                        print('tamil selected:$isLocale');
                                      });
                                    },
                                  ),
                                ),
                              ),

                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                child: Container(
                                  width:150,
                                  color: Color(0xffF4F4F4),
                                  child: RadioListTile(
                                    activeColor:AppConfig.logoutIcon,
                                    contentPadding: EdgeInsets.all(5),
                                    title: Text("English"),
                                    value: 'english',
                                    groupValue: isLocale,
                                    onChanged: (value){
                                      setState(() async {
                                        isLocale = value.toString();
                                        final locale=Locale('en','US');
                                        Get.updateLocale(locale);
                                        SharedPreferences islocale = await SharedPreferences.getInstance();
                                        islocale.setString('islocal',isLocale!);
                                        print('english selected:$isLocale');
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'name'.tr,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: 'Gilroy Medium',
                                  fontSize: 18),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: Container(
                              color: Color(0xffF4F4F4),
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(

                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'country'.tr,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: 'Gilroy Medium',
                                  fontSize: 18),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: Container(
                              color: Color(0xffF4F4F4),
                              child: TextFormField(
                                controller: countryController,
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'state'.tr,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: 'Gilroy Medium',
                                  fontSize: 18),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: Container(
                              color: Color(0xffF4F4F4),
                              child: TextFormField(
                                controller: stateController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'city'.tr,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: 'Gilroy Medium',
                                  fontSize: 18),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: Container(
                              color: Color(0xffF4F4F4),
                              child: TextFormField(
                                controller: cityController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'pINCode'.tr,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: 'Gilroy Medium',
                                  fontSize: 18),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: Container(
                              color: Color(0xffF4F4F4),
                              child: TextFormField(
                                controller: pincodeController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'address'.tr,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: 'Gilroy Medium',
                                  fontSize: 18),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: Container(
                              height: 122,
                              color: Color(0xffF4F4F4),
                              child: TextFormField(
                                controller: addressController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'panCard'.tr,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: 'Gilroy Medium',
                                  fontSize: 18),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: Container(
                              color: Color(0xffF4F4F4),
                              child: TextFormField(
                                controller: panController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'aadharCard'.tr,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: 'Gilroy Medium',
                                  fontSize: 18),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: Container(
                              color: Color(0xffF4F4F4),
                              child: TextFormField(
                                controller: aadharController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Center(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              child: Container(
                                width: 368,
                                height: 52,
                                child:
                                    // isProfileData ?
                                    // ElevatedButton(
                                    //     onPressed: () {
                                    //
                                    //       Navigator.push(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //             builder: (context) => Dashboard(),
                                    //           ));
                                    //     },
                                    //     style: ElevatedButton.styleFrom(backgroundColor: Color(0xff006666)),
                                    //     child: Text('Submit', style: TextStyle(color: Color(0xffFFFFFF), fontFamily: 'Gilroy Medium', fontSize: 18))
                                    // )
                                    //     :
                                    ElevatedButton(
                                        onPressed: () {
                                          print(
                                              'address:${addressController.text}');
                                          updateProfile(
                                              nameController.text,
                                              stateController.text,
                                              cityController.text,
                                              pincodeController.text,
                                              addressController.text,
                                              panController.text,
                                              aadharController.text);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppConfig.mainBg),
                                        child: Text('update'.tr,
                                            style: TextStyle(
                                                color: Color(0xffFFFFFF),
                                                fontFamily: 'Gilroy Medium',
                                                fontSize: 18))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: TextButton(
                                  onPressed: () {

                                  },
                                  child: Text('cancel'.tr,
                                      style: TextStyle(
                                          color: AppConfig.mainBg,
                                          fontFamily: 'Gilroy Medium',
                                          fontSize: 18))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // isProfileData = false;
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
