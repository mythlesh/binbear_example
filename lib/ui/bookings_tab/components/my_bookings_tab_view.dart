import 'package:binbear/ui/base_components/animated_list_builder.dart';
import 'package:binbear/ui/base_components/base_no_data.dart';
import 'package:binbear/ui/base_components/bookings_tile.dart';
import 'package:binbear/ui/base_components/smart_refresher_base_header.dart';
import 'package:binbear/ui/booking_details/bookings_detail_screen.dart';
import 'package:binbear/ui/bookings_tab/components/my_bookings_shimmer.dart';
import 'package:binbear/ui/bookings_tab/controller/bookings_controller.dart';
import 'package:binbear/ui/chat_tab/message_scrren.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/base_variables.dart';
import 'package:binbear/utils/get_storage.dart';
import 'package:binbear/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyBookingsTabView extends StatelessWidget {
  const MyBookingsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingsController controller = Get.find<BookingsController>();
    return AnimationLimiter(
      child: Obx(()=> SmartRefresher(
        controller: (controller.tabController.index == 0) ? controller.upcomingRefreshController : controller.pastRefreshController,
        header: const SmartRefresherBaseHeader(),
        onRefresh: (){
          controller.getMyBookingsApi();
        },
        child: controller.isLoading.value ? const MyBookingsShimmer() : (controller.list?.length??0) == 0 ? const BaseNoData() :  ListView.builder(
          shrinkWrap: true,
          itemCount: controller.list?.length??0,
          padding: const EdgeInsets.only(right: horizontalScreenPadding, left: horizontalScreenPadding, bottom: 80),
          itemBuilder: (context, index){
            return AnimatedListBuilder(
              index: index,
              child: BookingListTile(
                bottomMargin: 18,
                isPastBooking: controller.tabController.index == 1,
                location: "${controller.list?[index].pickupAddress?.flatNo ?? ""}, ${controller.list?[index].pickupAddress?.fullAddress ?? ""}",
                date: formatBackendDate(controller.list?[index].createdAt??""),
                showChatIcon: (controller.list?[index].roomId?.toString()??"0") != "0" && (controller.list?[index].roomId?.toString()??"").isNotEmpty,
                time: controller.list?[index].time??"",
                distance: controller.list?[index].distance?.toString()??"",
                onTap: (){
                  Get.to(() => BookingsDetailScreen(isPastBooking: controller.tabController.index == 1, bookingId: controller.list?[index].id?.toString()??""));
                },
                onChatTap: (){
                  Get.to(() => MessageScreen(
                    name: controller.list?[index].userData?.name??"",
                    convenienceId: controller.list?[index].roomId?.toString()??"0",
                    senderId: BaseStorage.read(StorageKeys.userId)?.toString()??"",
                    bookingId: controller.list?[index].id?.toString()??"",
                  ));
                },
              ),
            );
          },
        ),
      ),
      ),
    );
  }
}
