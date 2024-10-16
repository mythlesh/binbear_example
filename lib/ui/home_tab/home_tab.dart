import 'package:animate_do/animate_do.dart';
import 'package:binbear/ui/base_components/animated_column.dart';
import 'package:binbear/ui/base_components/base_app_bar.dart';
import 'package:binbear/ui/base_components/base_button.dart';
import 'package:binbear/ui/base_components/base_container.dart';
import 'package:binbear/ui/base_components/base_image_loader.dart';
import 'package:binbear/ui/base_components/base_text.dart';
import 'package:binbear/ui/base_components/base_text_button.dart';
import 'package:binbear/ui/base_components/bookings_tile.dart';
import 'package:binbear/ui/booking_details/bookings_detail_screen.dart';
import 'package:binbear/ui/chat_tab/controller/message_controller.dart';
import 'package:binbear/ui/chat_tab/message_scrren.dart';
import 'package:binbear/ui/dashboard_module/dashboard_screen/controller/dashboard_controller.dart';
import 'package:binbear/ui/home_tab/components/home_banner_shimmer.dart';
import 'package:binbear/ui/home_tab/components/home_bookings_shimmer.dart';
import 'package:binbear/ui/home_tab/controller/home_controller.dart';
import 'package:binbear/ui/load_size_selection_screen.dart';
import 'package:binbear/ui/month_trash_cleaning_confirm_screen.dart';
import 'package:binbear/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbear/ui/select_service/select_service_screen.dart';
import 'package:binbear/ui/week_or_month_selection_screen.dart';
import 'package:binbear/utils/base_assets.dart';
import 'package:binbear/utils/base_colors.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/base_variables.dart';
import 'package:binbear/utils/get_storage.dart';
import 'package:binbear/utils/storage_keys.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:binbear/ui/home_tab/components/home_service_shimmer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  HomeController controller = Get.put(HomeController());
  MessageController messageController = Get.put(MessageController());
  DashboardController dashboardController = Get.find<DashboardController>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  BaseController baseController = Get.find<BaseController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Hello ${BaseStorage.read(StorageKeys.userName).toString().split(" ").first}",
        titleSize: 13,
        showNotification: true,
        showDrawerIcon: true,
        showDefaultAddress: true,
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        header: const WaterDropHeader(waterDropColor: BaseColors.primaryColor),
        onRefresh: (){
          controller.getHomeData();
        },
        child: SingleChildScrollView(
          child: AnimatedColumn(
            milliseconds: 200,
            rightPadding: 0,
            leftPadding: 0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.isHomeLoading.value && controller.isBannerImageLoading.value) {
                  return const HomeBannerShimmer();
                }else{
                  return Visibility(
                    visible: (controller.banners?.length??0) != 0,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.1,
                        viewportFraction: 0.9,
                        enableInfiniteScroll: true,
                      ),
                      items: controller.banners?.map((data) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: BaseImageLoader(imageUrl: data?.image??"")
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  );
                }
              },
              ),
              const BaseText(
                topMargin: 13,
                bottomMargin: 11,
                leftMargin: horizontalScreenPadding,
                value: "Services",
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              Obx(()=> controller.isHomeLoading.value ? const HomeServiceShimmer() : (controller.services?.length??0) == 0 ? Center(
                child: BaseText(
                  topMargin: 4,
                  value: "No Service Found!",
                  fontSize: 16,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400,
                ),
              ) : SizedBox(
                  height: 110,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: horizontalScreenPadding),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.services?.length??0,
                    itemBuilder: (context, index){
                      return GestureDetector(
                         onTap: () {
                                    triggerHapticFeedback();
                                    switch (index) {
                                      /// Can 2 Curb Service
                                      case 0:
                                        {
                                          baseController
                                              .homeTabServiceIndex.value = 0;
                                         
                                          Get.to(() =>
                                              const WeekOrMonthSelectionScreen());
                                          break;
                                        }

                                      /// Bulk Trash Pickup
                                      case 1:
                                        {
                                          baseController
                                              .homeTabServiceIndex.value = 1;
                                          Get.to(() =>
                                              const SelectLoadSizeScreen());
                                          break;
                                        }

                                      /// Trash Can Cleaning
                                      case 2:
                                        {
                                          baseController
                                              .homeTabServiceIndex.value = 2;
                                          Get.to(() =>
                                              MonthTrashCleaningConfirmScreen(
                                                  selectedLoadSizePrice:
                                                      controller.services?[2]
                                                              ?.price
                                                              ?.toString() ??
                                                          ""));
                                          break;
                                        }
                                      default:
                                        print(' invalid entry');
                                    }
                                  },
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              width: 100,
                              margin: const EdgeInsets.only(right: 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(
                                    controller.services?[index]?.image??"",
                                    width: 40,
                                    height: 33,
                                  ),
                                  BaseText(
                                    topMargin: 14,
                                    textAlign: TextAlign.center,
                                    value: controller.services?[index]?.title??"",
                                    fontSize: 11.5,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: index == 0,
                              child: Positioned(
                                right: 20,
                                top: 6,
                                child: RotationTransition(
                                  turns: const AlwaysStoppedAnimation(-40 / 360),
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: BaseColors.secondaryColor,
                                    height: 15,
                                    width: 150,
                                    child: const BaseText(
                                      value: "Most Popular",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      fontSize: 5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 5,
                      child: BaseText(
                        value: "Upcoming Bookings",
                        fontSize: 19,
                        leftMargin: horizontalScreenPadding,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Obx(()=> FadeInRight(
                          duration: const Duration(milliseconds: 200),
                          animate: ((controller.bookings?.length ?? 0) != 0) && controller.isHomeLoading.value == false,
                          child: BaseTextButton(
                            title: "See All",
                            fontSize: 15,
                            rightMargin: 0,
                            fontWeight: FontWeight.w700,
                            onPressed: (){
                              dashboardController.changeTab(1);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(()=> controller.isHomeLoading.value ? const HomeBookingsShimmer() : (controller.bookings?.length??0) == 0 ?
              Center(
                child: BaseText(
                  topMargin: 4,
                  value: "No Booking Found!",
                  fontSize: 16,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400,
                ),
              ) : SizedBox(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.bookings?.length??0,
                    padding: const EdgeInsets.only(left: horizontalScreenPadding),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return BookingListTile(
                        isPastBooking: false,
                        rightMargin: 6,
                        location: "${controller.bookings?[index]?.pickupAddress?.flatNo ?? ""}, ${controller.bookings?[index]?.pickupAddress?.fullAddress ?? ""}",
                        date: formatBackendDate(controller.bookings?[index]?.createdAt??""),
                        time: controller.bookings?[index]?.time??"",
                        distance: controller.bookings?[index]?.distance?.toString()??"",
                        showChatIcon: (controller.bookings?[index]?.roomId?.toString()??"0") != "0" && (controller.bookings?[index]?.roomId?.toString()??"").isNotEmpty,
                        onTap: (){
                          Get.to(() => BookingsDetailScreen(isPastBooking: false, bookingId: controller.bookings?[index]?.id?.toString()??""));
                        },
                        onChatTap: (){
                          Get.to(() => MessageScreen(
                            name: controller.bookings?[index]?.userData?.name??"",
                            convenienceId: controller.bookings?[index]?.roomId?.toString()??"0",
                            senderId: BaseStorage.read(StorageKeys.userId).toString(),
                            bookingId: controller.bookings?[index]?.id?.toString()??"",
                          ));
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 3),
              BaseContainer(
                topMargin: 24,
                bottomMargin: 50,
                rightMargin: horizontalScreenPadding,
                leftMargin: horizontalScreenPadding,
                topPadding: 13,
                rightPadding: horizontalScreenPadding,
                leftPadding: horizontalScreenPadding,
                borderRadius: 15,
                child: Column(
                  children: [
                    const BaseText(
                      value: "Schedule Pick-up",
                      fontSize: 17,
                      bottomMargin: 3,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    Image.asset(
                      BaseAssets.binBearTextLogo,
                      height: 30,
                    ),
                    BaseButton(
                      topMargin: 18,
                      title: "Book Now",
                      onPressed: (){
                         baseController.isHomeTabBookNowTapped.value = true;
                        Get.to(() => const SelectServiceScreen());
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
