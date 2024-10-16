import 'package:binbear/backend/api_end_points.dart';
import 'package:binbear/backend/base_api_service.dart';
import 'package:binbear/ui/change_password/change_password_screen.dart';
import 'package:binbear/ui/onboardings/base_success_screen.dart';
import 'package:binbear/ui/onboardings/forgot_password/controller/forgot_password_controller.dart';
import 'package:binbear/ui/onboardings/otp_validation/model/otp_response.dart';
import 'package:binbear/ui/onboardings/signup/controller/signup_controller.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/get_storage.dart';
import 'package:binbear/utils/storage_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  RxBool isResendEnable = false.obs;

  callVerifyOtpApi() {
    Map<String, String> data = {
      "mobile_or_email": Get.find<SignUpController>().mobileController
          .text
          .trim()
          .replaceAll("(", "")
          .replaceAll(")", "")
          .replaceAll("-", "")
          .replaceAll(" ", ""),
      "verify_type": "mobile",
      "deviceType": "android",
      "deviceId": "device_id",
      "role": "1",
      "country_code": "+1",
      "otp": otpController.text.trim(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().verifyOtp, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        OtpResponse response = OtpResponse.fromJson(value?.data);
        if (response.success ?? false) {
          BaseStorage.write(StorageKeys.apiToken, response.data?.token ?? "");
          BaseStorage.write(StorageKeys.userName, response.data?.name ?? "");
          BaseStorage.write(StorageKeys.userId, response.data?.id ?? "");
          BaseStorage.write(StorageKeys.profilePhoto, response.data?.profile ?? "");
          Get.off(() => const BaseSuccessScreen());
        } else {
          showSnackBar(subtitle: response.message ?? "");
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  forgotPasswordVerifyOtpApi() {
    Map<String, String> data = {
      "mobile_or_email":
          Get.find<ForgotPasswordController>().emailController.text,
      "verify_type": "email",
      "deviceType": "android",
      "deviceId": "device_id",
      "role": "1",
      "country_code": "+1",
      "otp": otpController.text.trim(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().verifyOtp, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        OtpResponse response = OtpResponse.fromJson(value?.data);
        if (response.success ?? false) {
          Get.back();
          Get.off(() => const ChangePasswordScreen(
                previousPage: "forgotPassword",
              ));
          showSnackBar(
              title: "Success!",
              subtitle: response.message ?? "",
              isSuccess: true);
        } else {
          showSnackBar(subtitle: response.message ?? "");
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }
}
