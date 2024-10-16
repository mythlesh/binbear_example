
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoadSizeConfirmScreen extends StatefulWidget {
  final String selectedLoadSizeTitle, selectedLoadSizeImage, selectedLoadSizePrice, subServiceId;
  const LoadSizeConfirmScreen({super.key, required this.selectedLoadSizeTitle, required this.selectedLoadSizeImage, required this.selectedLoadSizePrice, required this.subServiceId});

  @override
  State<LoadSizeConfirmScreen> createState() => _LoadSizeConfirmScreenState();
}

class _LoadSizeConfirmScreenState extends State<LoadSizeConfirmScreen> {

  String selectedDropDownValue = "2 Cans";
  String selectedImage = "";
  String? selectedImageName;
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
    newPriceAfterDiscount = int.parse(widget.selectedLoadSizePrice);
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
                title: "Bulk Trash Pickup",
                bottomMargin: 0,
              ),
              const BasePageSubTitle(
                subTitle: "Please upload 3 photos of the trash you would like to picked-up",
                bottomMargin: 45,
              ),
              GestureDetector(
                onTap: (){
                  triggerHapticFeedback();
                },
                child: Container(
                  height: 85,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 17, bottom: 17, left: 19),
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
                      Image.network(
                        widget.selectedLoadSizeImage,
                        height: 45,
                      ),
                      BaseText(
                        value: widget.selectedLoadSizeTitle,
                        fontSize: 16,
                        leftMargin: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  showMediaPicker().then((value) {
                    if ((value?.path??"").isNotEmpty) {
                      selectedImage = value?.path??"";
                      selectedImageName = (value?.path??"").split("/").last;
                      setState(() {});
                    }
                  });
                },
                child: BaseContainer(
                  topMargin: 15,
                  bottomMargin: 0,
                  leftPadding: horizontalScreenPadding,
                  rightPadding: horizontalScreenPadding,
                  topPadding: 20,
                  bottomPadding: 20,
                  borderRadius: 14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          BaseAssets.icUpload,
                      ),
                      Flexible(
                        child: BaseText(
                          value: selectedImageName??"Upload a picture",
                          fontSize: 14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          leftMargin: 8,
                          color: BaseColors.secondaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BaseContainer(
                topMargin: 15,
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
                        value: "\$${widget.selectedLoadSizePrice}",
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
                                if (int.parse(widget.selectedLoadSizePrice) >= int.parse(couponListData.discount??"0")) {
                                  isCouponApplied = true;
                                  selectedCouponId = couponListData.id.toString();
                                  selectedCouponName=couponListData.couponCode.toString();
                                  newPriceAfterDiscount = int.parse(widget.selectedLoadSizePrice) - int.parse(couponListData.discount??"0");
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
                  serviceTypeId: "2",
                  subServiceId: widget.subServiceId.toString(),
                  noOfCans: selectedCanValue.toString(),
                  price: newPriceAfterDiscount.toString(),
                  addressId: selectedAddressId.toString(),
                  couponId: selectedCouponId.toString(),
                  imagePath: selectedImage??""
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

  List<String> cansList = [
    "1 Can",
    "2 Cans",
    "3 Cans",
  ];
}
