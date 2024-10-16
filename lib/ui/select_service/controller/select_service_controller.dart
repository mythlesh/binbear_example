import 'dart:developer';

import 'package:binbear/backend/api_end_points.dart';
import 'package:binbear/backend/base_api_service.dart';
import 'package:binbear/ui/select_service/model/service_list_response.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SelectServiceController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    getServiceList();
  }

  RefreshController refreshController = RefreshController(initialRefresh: false);
  RxList<ServiceListData?>? serviceList = <ServiceListData>[].obs;
  RxInt selectedServiceIndex = 0.obs;

  getServiceList() async {
    try {
      await BaseApiService().get(apiEndPoint: ApiEndPoints().serviceList).then((value){
        refreshController.refreshCompleted();
        if (value?.statusCode ==  200) {
          ServiceListResponse response = ServiceListResponse.fromJson(value?.data);
          if (response.success??false) {
            serviceList?.value = response.data??[];
          }else{
            showSnackBar(subtitle: response.message??"");
          }
        }else{
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      refreshController.refreshCompleted();
      log(e.toString());
    }
  }
}