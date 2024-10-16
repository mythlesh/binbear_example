import 'dart:developer';
import 'dart:io';

import 'package:binbear/backend/api_end_points.dart';
import 'package:binbear/backend/base_api_service.dart';
import 'package:binbear/backend/base_responses/base_success_response.dart';
import 'package:binbear/ui/profile_tab/model/profile_response.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/get_storage.dart';
import 'package:binbear/utils/storage_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart' as dio;

class ProfileController extends GetxController{
  RxString selectedGender = "Male".obs;
  File? imageFile;
  Rx<ProfileData?>? profileData = ProfileData().obs;
  RxBool isProfileLoading = false.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  Rx<File?>? selectedImage = File("").obs;

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }

  setData(){
    nameController.text = profileData?.value?.name?.toString()??"";
    emailController.text = profileData?.value?.email?.toString()??"";
    mobileController.text = MaskTextInputFormatter().updateMask(mask: '(###) ###-####', newValue: TextEditingValue(text: profileData?.value?.mobile?.toString()??"")).text;
    selectedGender.value = (profileData?.value?.gender?.toString().toLowerCase()??"male").contains("female") ? "Female" : "Male";
  }

  updateProfile() async {
    // Map<String, String> data = {
    //   "name":nameController.text.trim(),
    //   "gender":selectedGender.value,
    // };
    dio.FormData data = dio.FormData.fromMap({
      "name":nameController.text.trim(),
      "gender":selectedGender.value,

    });
    if((selectedImage?.value?.path??'').isNotEmpty){
      data.files.add(MapEntry("profile",
          await dio.MultipartFile.fromFile(selectedImage!.value!.path, filename: selectedImage!.value!.path.split("/").last)));
    }



    await BaseApiService().post(apiEndPoint: ApiEndPoints().editUserProfile, data: data).then((value){
      isProfileLoading.value = false;
      refreshController.refreshCompleted();
      if (value?.statusCode ==  200) {
        BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
        if (response.success??false) {
          triggerHapticFeedback();
          Get.back();
          showSnackBar(isSuccess: true, subtitle: response.message??"");
          getProfileData();
        }else{
          showSnackBar(subtitle: response.message??"");
        }
      }else{
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  getProfileData() async {
    isProfileLoading.value = true;
    try {
      await BaseApiService().get(apiEndPoint: ApiEndPoints().getUserProfile, showLoader: false).then((value){
        isProfileLoading.value = false;
        refreshController.refreshCompleted();
        if (value?.statusCode ==  200) {
          ProfileResponse response = ProfileResponse.fromJson(value?.data);
          log("response ${response.toJson()}");
          if (response.success??false) {
            BaseStorage.write(StorageKeys.profilePhoto, response.data?.profile??"");
            BaseStorage.write(StorageKeys.userName, response.data?.name??"");
            profileData?.value = response.data;
          }else{
            showSnackBar(subtitle: response.message??"");
          }
        }else{
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      isProfileLoading.value = false;
      refreshController.refreshCompleted();
    }
  }
}
