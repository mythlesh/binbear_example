import 'dart:math';

import 'package:binbear/backend/api_end_points.dart';
import 'package:binbear/backend/base_api_service.dart';
import 'package:binbear/ui/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:binbear/ui/onboardings/login/model/login_response.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/get_storage.dart';
import 'package:binbear/utils/storage_keys.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  getResponse() async {
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("FCM Token -> ${token??""}");
    Map<String, String> data = {
      "email":emailController.text.trim(),
      "password":passwordController.text.trim(),
      "device_token":token??"xxxxxx",
      "role_id":"1",
    };
    BaseApiService().post(apiEndPoint: ApiEndPoints().login, data: data).then((value){
      if (value?.statusCode ==  200) {
        LoginResponse response = LoginResponse.fromJson(value?.data);
        if (response.success??false) {
          BaseStorage.write(StorageKeys.apiToken, response.data?.token??"");
          BaseStorage.write(StorageKeys.userName, response.data?.name??"");
          BaseStorage.write(StorageKeys.profilePhoto, response.data?.profile??"");
          BaseStorage.write(StorageKeys.userId, response.data?.id ?? "");
          Get.offAll(() => const DashBoardScreen());
        }else{
          showSnackBar(subtitle: response.message??"");
        }
      }else{
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }
}