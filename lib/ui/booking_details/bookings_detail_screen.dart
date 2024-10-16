import 'package:binbear/ui/base_components/base_app_bar.dart';
import 'package:binbear/ui/base_components/base_button.dart';
import 'package:binbear/ui/base_components/base_container.dart';
import 'package:binbear/ui/base_components/base_outlined_button.dart';
import 'package:binbear/ui/base_components/base_scaffold_background.dart';
import 'package:binbear/ui/base_components/base_shimmer.dart';
import 'package:binbear/ui/base_components/base_text.dart';
import 'package:binbear/ui/base_components/base_text_button.dart';
import 'package:binbear/ui/base_components/smart_refresher_base_header.dart';
import 'package:binbear/ui/booking_details/controller/booking_details_controller.dart';
import 'package:binbear/ui/booking_details/rating_bottom_sheet.dart';
import 'package:binbear/ui/chat_tab/message_scrren.dart';
import 'package:binbear/ui/select_service/select_service_screen.dart';
import 'package:binbear/utils/base_assets.dart';
import 'package:binbear/utils/base_colors.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/base_variables.dart';
import 'package:binbear/utils/get_storage.dart';
import 'package:binbear/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookingsDetailScreen extends StatefulWidget {
  final bool isPastBooking;
  final String bookingId;

  const BookingsDetailScreen(
      {super.key, required this.isPastBooking, required this.bookingId});

  @override
  State<BookingsDetailScreen> createState() => _BookingsDetailScreenState();
}

class _BookingsDetailScreenState extends State<BookingsDetailScreen> {
  BookingDetailsController controller = Get.put(BookingDetailsController());

  @override
  void initState() {
    super.initState();
    controller.getBookingDetails(bookingId: widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: const BaseAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 75),
          child: SmartRefresher(
            controller: controller.refreshController,
            header: const SmartRefresherBaseHeader(),
            onRefresh: () {
              controller.getBookingDetails(bookingId: widget.bookingId);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: horizontalScreenPadding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BaseText(
                      topMargin: 0,
                      value: "Booking Detail",
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    bookingDetailsTile(children: [
                      const BaseText(
                        value: "Service",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const BaseShimmer(
                            width: double.infinity,
                            height: 27,
                            rightMargin: 40,
                          );
                        } else {
                          return BaseText(
                            value: controller
                                    .bookingDetailsData?.value?.categoryData?.title ??
                                "",
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          );
                        }
                      }),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const BaseShimmer(
                            topMargin: 3,
                            width: double.infinity,
                            height: 22,
                            rightMargin: 180,
                          );
                        } else {
                          return BaseText(
                            value:
                                "${controller.bookingDetailsData?.value?.subCategoryData?.title ?? ""} Service",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          );
                        }
                      }),
                    ]),
                    bookingDetailsTile(children: [
                      const BaseText(
                        value: "Time",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BaseShimmer(
                                topMargin: 3,
                                width: double.infinity,
                                height: 18,
                              ),
                              BaseShimmer(
                                topMargin: 3,
                                width: double.infinity,
                                height: 18,
                                rightMargin: 180,
                              ),
                            ],
                          );
                        } else {
                          return BaseText(
                            value: controller.bookingDetailsData?.value?.time ?? "",
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          );
                        }
                      }),
                      Obx(() {
                          return Visibility(
                            visible: (controller.bookingDetailsData?.value?.noOfCane
                                        ?.toString() ??
                                    "")
                                .isNotEmpty,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BaseText(
                                  topMargin: 8,
                                  value: "No. of Cans",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                controller.isLoading.value
                                    ? const BaseShimmer(
                                        topMargin: 3,
                                        width: 12,
                                        height: 20,
                                      )
                                    : BaseText(
                                        value: controller
                                                .bookingDetailsData?.value?.noOfCane
                                                ?.toString() ??
                                            "",
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      )
                              ],
                            ),
                          );
                        }
                      ),
                    ]),
                    bookingDetailsTile(children: [
                      const BaseText(
                        value: "Pick-up Location",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const BaseShimmer(
                            topMargin: 2,
                            width: double.infinity,
                            height: 21,
                            rightMargin: 130,
                          );
                        } else {
                          return BaseText(
                            value:
                                "${controller.bookingDetailsData?.value?.pickupAddress?.flatNo ?? ""}, ${controller.bookingDetailsData?.value?.pickupAddress?.fullAddress ?? ""}",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          );
                        }
                      }),
                    ]),
                    bookingDetailsTile(children: [
                      const BaseText(
                        value: "Paid Amount",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const BaseShimmer(
                            topMargin: 3,
                            width: double.infinity,
                            height: 41,
                            rightMargin: 200,
                          );
                        } else {
                          return BaseText(
                            topMargin: 4,
                            value:
                                "\$${controller.bookingDetailsData?.value?.price?.toString() ?? ""}",
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          );
                        }
                      }),
                    ]),
                    (widget.isPastBooking)
                        ? BaseTextButton(
                            topMargin: 10,
                            onPressed: () {
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(BaseAssets.icInvoice),
                                const BaseText(
                                  leftMargin: 8,
                                  value: "Download Invoice",
                                  fontSize: 13,
                                  color: Color(0xffFBE6D3),
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          )
                        : Obx(() {
                            if (controller.isLoading.value) {
                              return const BaseShimmer(
                                topMargin: 3,
                                width: double.infinity,
                                height: 41,
                                rightMargin: 200,
                              );
                            } else {
                              return BaseOutlinedButton(
                                topMargin: 10,
                                title: getBookingDetailsStatusTitle(
                                  bookingDetailStatusNumber: controller
                                          .bookingDetailsData?.value?.serviceStatus
                                          ?.toString() ??
                                      "0",
                                ),
                                titleColor: BaseColors.primaryColor,
                                btnLeftPadding: 10,
                                btnRightPadding: 10,
                                btnBottomPadding: 5,
                                btnTopPadding: 5,
                                bottomMargin: 6,
                              );
                            }
                          }),
                    Visibility(
                      visible: !(widget.isPastBooking),
                      child: GetBuilder<BookingDetailsController>(
                        builder: (BookingDetailsController controller) {
                          print("Widget Rebuild");
                          return IgnorePointer(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                height: 150,
                                width: Get.width,
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition:
                                      controller.getInitialCameraPosition(
                                          lat: double.parse(controller.bookingDetailsData?.value?.pickupAddress
                                                  ?.lat
                                                  ?.toString() ??
                                              "0.0"),
                                          long: double.parse(controller
                                                  .bookingDetailsData?.value
                                                  ?.pickupAddress
                                                  ?.lng
                                                  ?.toString() ??
                                              "0.0")),
                                  markers: Set<Marker>.of(controller.markers),
                                  zoomControlsEnabled: false,
                                  compassEnabled: false,
                                  myLocationButtonEnabled: false,
                                  onMapCreated: (GoogleMapController
                                      googleMapController) {
                                    if (!controller.mapController.isCompleted) {
                                      controller.mapController
                                          .complete(googleMapController);
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(
              right: horizontalScreenPadding,
              left: horizontalScreenPadding,
              top: 16,
              bottom: 10),
          color: Colors.white,
          child: widget.isPastBooking
              ? Row(
                  children: [
                    Expanded(
                        child: BaseButton(
                      title: "Re-Book",
                      rightMargin: 6,
                      btnColor: BaseColors.secondaryColor,
                      onPressed: () {
                        Get.to(() => const SelectServiceScreen());
                      },
                    )),
                    Expanded(
                      child: BaseButton(
                        title: "Give Rating",
                        leftMargin: 6,
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              builder: (context) {
                                return RatingBottomSheet(
                                  bookingId: widget.bookingId,
                                );
                              });
                        },
                      ),
                    ),
                  ],
                )
              : Obx(()=> BaseButton(
            leftMargin: 0,
            rightMargin: 0,
            title: "Chat With Service Provider",
            btnColor: ((controller.bookingDetailsData?.value?.roomId?.toString()??"0") != "0" && (controller.bookingDetailsData?.value?.roomId?.toString()??"").isNotEmpty) ? BaseColors.primaryColor : Colors.grey,
            onPressed: () {
              if (((controller.bookingDetailsData?.value?.roomId?.toString()??"0") != "0" && (controller.bookingDetailsData?.value?.roomId?.toString()??"").isNotEmpty)) {
                Get.to(() => MessageScreen(
                  name: controller.bookingDetailsData?.value?.userData?.name??"",
                  convenienceId: controller.bookingDetailsData?.value?.roomId?.toString()??"0",
                  senderId: BaseStorage.read(StorageKeys.userId)?.toString()??"",
                  bookingId: controller.bookingDetailsData?.value?.id?.toString()??"",
                ));
              }
            },
          ),
          ),
        ),
      ),
    );
  }

  Widget bookingDetailsTile({required List<Widget> children}) {
    return BaseContainer(
      topMargin: 18,
      bottomMargin: 0,
      borderRadius: 14,
      topPadding: 12,
      bottomPadding: 15,
      rightPadding: 15,
      leftPadding: 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
