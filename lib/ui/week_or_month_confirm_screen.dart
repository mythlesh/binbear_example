import 'package:binbear/backend/base_responses/can_list_response.dart';
import 'package:binbear/ui/base_components/animated_column.dart';
import 'package:binbear/ui/base_components/base_button.dart';
import 'package:binbear/ui/base_components/base_container.dart';
import 'package:binbear/ui/base_components/base_page_sub_title.dart';
import 'package:binbear/ui/base_components/base_page_title.dart';
import 'package:binbear/ui/base_components/base_app_bar.dart';
import 'package:binbear/ui/base_components/base_scaffold_background.dart';
import 'package:binbear/ui/base_components/base_text.dart';
import 'package:binbear/ui/coupons_list/coupon_list_screen.dart';
import 'package:binbear/ui/coupons_list/models/coupon_list_response.dart';
import 'package:binbear/ui/manual_address/manual_address_screen.dart';
import 'package:binbear/ui/manual_address/model/saved_address_response.dart';
import 'package:binbear/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbear/ui/payment_gateway/payment_gateway_screen.dart';
import 'package:binbear/utils/base_assets.dart';
import 'package:binbear/utils/base_colors.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WeekOrMonthConfirmScreen extends StatefulWidget {
  final String selectedServiceTitle, price;
  const WeekOrMonthConfirmScreen({super.key, required this.selectedServiceTitle, required this.price});

  @override
  State<WeekOrMonthConfirmScreen> createState() => _WeekOrMonthConfirmScreenState();
}

class _WeekOrMonthConfirmScreenState extends State<WeekOrMonthConfirmScreen> {

  String selectedCanTitle = "";
  String selectedCanValue = "";
  String selectedAddress = "Select Your Address";
  String selectedAddressId = "";
  String selectedCouponId = "";
  String selectedCouponName = "";

  int newPriceAfterDiscount = 0;
  bool isCouponApplied = false;
  @override
  void initState() {
    super.initState();
    if (Get.find<BaseController>().canListData.isNotEmpty) {
      selectedCanTitle = Get.find<BaseController>().canListData.first.value??"";
      selectedCanValue = Get.find<BaseController>().canListData.first.value??"";
      newPriceAfterDiscount = int.parse(widget.price);
    }
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: SingleChildScrollView(
          child: AnimatedColumn(
            children: [
              const BasePageTitle(
                topMargin: 0,
                title: "Can 2 Curb Service",
                bottomMargin: 0,
              ),
              const BasePageSubTitle(
                subTitle: "1x Can2curb service",
                bottomMargin: 0,
              ),
              const BasePageSubTitle(
                topMargin: 13,
                leftMargin: horizontalScreenPadding,
                rightMargin: horizontalScreenPadding,
                subTitle: "Your cans will be placed on your curb during the evening prior to service day or the morning of service day before 6am. Then they will be returned once they are emptied.",
                bottomMargin: 20,
                fontSize: 12,
              ),
              Container(
                height: 85,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: horizontalScreenPadding),
                padding: const EdgeInsets.only(top: 17, bottom: 17, left: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                  border: Border.all(
                    width: 2.5,
                    color: BaseColors.secondaryColor,
                  ),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: const Offset(0,4),
                      color: BaseColors.primaryColor.withOpacity(0.8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(BaseAssets.icServiceCalendar),
                    BaseText(
                      value: widget.selectedServiceTitle,
                      fontSize: 16,
                      leftMargin: 7,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              BaseContainer(
                topMargin: 15,
                bottomMargin: 0,
                rightMargin: horizontalScreenPadding,
                leftMargin: horizontalScreenPadding,
                leftPadding: horizontalScreenPadding,
                rightPadding: horizontalScreenPadding,
                topPadding: 10,
                bottomPadding: 18,
                borderRadius: 14,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseText(
                      value: "No. of Cans",
                      fontSize: 13,
                      bottomMargin: 8,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    DropdownButton(
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      hint: BaseText(
                        value: selectedCanTitle,
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: Get.find<BaseController>().canListData.map((CanListData items) {
                        return DropdownMenuItem<CanListData>(
                          value: items,
                          child: Text(items.value?.toString()??""),
                        );
                      }).toList(),
                      isDense: true,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          selectedCanTitle = value?.value?.toString()??"";
                          selectedCanValue= value?.value?.toString()??"";
                        });
                      },
                    ),
                  ],
                ),
              ),
              BaseContainer(
                topMargin: 15,
                rightMargin: horizontalScreenPadding,
                leftMargin: horizontalScreenPadding,
                leftPadding: horizontalScreenPadding,
                rightPadding: horizontalScreenPadding,
                topPadding: 10,
                bottomMargin: 0,
                bottomPadding: 12,
                borderRadius: 14,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BaseText(
                      value: "Payment Amount",
                      fontSize: 14,
                      bottomMargin: 8,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    Visibility(
                      visible: isCouponApplied,
                      child: BaseText(
                        value: "\$${widget.price}",
                        fontSize: 19,
                        bottomMargin: 0,
                        lineThrough: true,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    BaseText(
                      value: "\$${newPriceAfterDiscount.toString()}",
                      fontSize: 32,
                      bottomMargin: 0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              BaseContainer(
                topMargin: 15,
                rightMargin: horizontalScreenPadding,
                leftMargin: horizontalScreenPadding,
                leftPadding: horizontalScreenPadding,
                rightPadding: horizontalScreenPadding,
                topPadding: 10,
                bottomPadding: 12,
                borderRadius: 14,
                bottomMargin: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseText(
                      value: "Apply Coupon",
                      fontSize: 13,
                      bottomMargin: 8,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: (){
                        triggerHapticFeedback();
                        Get.to(() => const CouponListScreen())?.then((value) {
                          if (value != null) {
                            CouponListData couponListData = value;
                            if ((couponListData.discount?.toString()??"").isNotEmpty && (couponListData.discount?.toString()??"0") != "0") {
                              setState(() {
                                if (int.parse(widget.price) >= int.parse(couponListData.discount??"0")) {
                                  isCouponApplied = true;
                                  selectedCouponId = couponListData.id.toString();
                                  selectedCouponName=couponListData.couponCode.toString();
                                  newPriceAfterDiscount = int.parse(widget.price) - int.parse(couponListData.discount??"0");
                                }
                              });
                            }
                          }
                        });
                      },
                      child:  Row(
                        children: [
                          Expanded(
                            child: BaseText(
                              value: selectedCouponName,
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: 11,)
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey, height: 15, thickness: 0.6,)
                  ],
                ),
              ),
              BaseContainer(
                topMargin: 15,
                rightMargin: horizontalScreenPadding,
                leftMargin: horizontalScreenPadding,
                leftPadding: horizontalScreenPadding,
                rightPadding: horizontalScreenPadding,
                topPadding: 10,
                bottomPadding: 12,
                borderRadius: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseText(
                      value: "Select Address",
                      fontSize: 13,
                      bottomMargin: 8,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        triggerHapticFeedback();
                        Get.to(() => const ManualAddressScreen(showSavedAddress: true))?.then((value) {
                          SavedAddressListData savedAddress = value;
                          if (savedAddress.fullAddress != null && (savedAddress.fullAddress?.toString()??"").isNotEmpty) {
                            setState(() {
                              selectedAddress = savedAddress.fullAddress??"";
                              selectedAddressId = savedAddress.id?.toString()??"";
                            });
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: BaseText(
                              value: selectedAddress,
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 11,)
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 15,
                      thickness: 0.6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: horizontalScreenPadding, vertical: 14),
          width: double.infinity,
          color: Colors.white,
          child: BaseButton(
            title: 'Confirm & Pay',
            onPressed: (){
              if (selectedAddress != "Select Your Address") {
                Get.find<BaseController>().createBooking(
                  serviceTypeId: "1",
                  subServiceId: widget.selectedServiceTitle == "Weekly Service" ? "1" : "2",
                  noOfCans: selectedCanValue.toString(),
                  price: newPriceAfterDiscount.toString(),
                  addressId: selectedAddressId.toString(),
                  couponId: selectedCouponId.toString(),
                ).then((value) {
                  if ((value.id?.toString()??"") != "") {
                    Get.to( PaymentGatewayScreen(
                      bookingId: value.id?.toString()??"",
                      userId: value.userId?.toString()??"",
                    ));
                  }
                });
              }else{
                showSnackBar(subtitle: "Please Select Address");
              }
            },
          ),
        ),
      ),
    );
  }
}
