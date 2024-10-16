import 'dart:developer';

import 'package:binbear/backend/api_end_points.dart';
import 'package:binbear/backend/base_api_service.dart';
import 'package:binbear/ui/home_tab/model/home_response.dart';
import 'package:binbear/ui/select_service/model/sub_service_list_response.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController{
  RxBool isHomeLoading = true.obs;
  RxBool isBannerImageLoading = true.obs;
  List<HomeBanners?>? banners = <HomeBanners?>[];
  RxList<HomeServices?>? services = <HomeServices?>[].obs;
  RxList<HomeBookings?>? bookings = <HomeBookings?>[].obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  RefreshController serviceRefreshController = RefreshController(initialRefresh: false);
  Rx<Useraddress>? userAddress = Useraddress().obs;
  RxList<SubServiceListData?>? subServiceList = <SubServiceListData>[].obs;
  @override
  void onInit() {
    getHomeData();
    super.onInit();
  }

  getHomeData() async {
    isHomeLoading.value = true;
    isBannerImageLoading.value = true;
    try {
      await BaseApiService().get(apiEndPoint: ApiEndPoints().getHomeData, showLoader: false).then((value){
        refreshController.refreshCompleted();
        isHomeLoading.value = false;
        if (value?.statusCode ==  200) {
          HomeResponse response = HomeResponse.fromJson(value?.data);
          if (response.success??false) {
            log("response ${response.toJson()}");
            banners = response.data?.banners??[];
            services?.value = response.data?.services??[];
            bookings?.value = response.data?.bookings??[];
            userAddress?.value = response.data?.userdetail?.first.useraddress??Useraddress();
            update();
          }else{
            showSnackBar(subtitle: response.message??"");
          }
        }else{
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      isHomeLoading.value = false;
      refreshController.refreshCompleted();
    }
  }

  getSubServiceList({required String serviceId}) async {
    Map<String, String> data = {
      "category_id": serviceId
    };
    try {
      subServiceList?.clear();
      await BaseApiService().post(apiEndPoint: ApiEndPoints().subServices, data: data).then((value){
        serviceRefreshController.refreshCompleted();
        if (value?.statusCode ==  200) {
          SubServiceListResponse response = SubServiceListResponse.fromJson(value?.data);
          if (response.success??false) {
            subServiceList?.value = response.data??[];
          }else{
            showSnackBar(subtitle: response.message??"");
          }
        }else{
          showSnackBar(subtitle: "Something went wrong, please try again");
        }
      });
    } on Exception catch (e) {
      serviceRefreshController.refreshCompleted();
      log(e.toString());
    }
  }
}