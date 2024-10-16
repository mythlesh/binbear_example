import 'package:binbear/backend/api_end_points.dart';
import 'package:binbear/backend/base_api_service.dart';
import 'package:binbear/backend/base_responses/base_success_response.dart';
import 'package:binbear/ui/change_password/controller/change_password_controller.dart';
import 'package:binbear/ui/onboardings/forgot_password/model/forgot_password_response.dart';
import 'package:binbear/ui/onboardings/otp_validation/otp_screen.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/get_storage.dart';
import 'package:binbear/utils/storage_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  bool obscureNewPassword = false;
  bool obscureConfirmPassword = false;
  sendOtpForgotPassword() {
    Map<String, String> data = {
      "email": emailController.text.trim(),
    };

    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().forgotPassword, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        ForgotPasswordResponse response = ForgotPasswordResponse.fromJson(value?.data);
        if (response.success ?? false) {
          BaseStorage.write(StorageKeys.apiToken, response.data?.token ?? "");
          BaseStorage.write(StorageKeys.userId, response.data?.id ?? "");
          showSnackBar(
              title: "Success!",
              subtitle: response.message ?? "",
              isSuccess: true);
          Get.to(() => const OtpScreen(
                previousPage: "forgotPassword",
              ));
        } else {
          showSnackBar(subtitle: response.message ?? "");
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  resetPassword() {
    Map<String, String> data = {
      "password": Get.find<ChangePasswordController>()
          .newPasswordController
          .text
          .trim(),
      "confirm_password": Get.find<ChangePasswordController>()
          .confirmPasswordController
          .text
          .trim(),
    };
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().resetPassword, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        BaseSuccessResponse response =
            BaseSuccessResponse.fromJson(value?.data);
        if (response.success ?? false) {
          triggerHapticFeedback();
          Get.back();
          showSnackBar(subtitle: response.message ?? "", isSuccess: true);
        } else {
          showSnackBar(subtitle: response.message ?? "");
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }
}
