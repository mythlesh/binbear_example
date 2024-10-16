import 'package:binbear/ui/base_components/animated_column.dart';
import 'package:binbear/ui/base_components/base_button.dart';
import 'package:binbear/ui/base_components/base_container.dart';
import 'package:binbear/ui/base_components/base_page_sub_title.dart';
import 'package:binbear/ui/base_components/base_page_title.dart';
import 'package:binbear/ui/base_components/base_app_bar.dart';
import 'package:binbear/ui/base_components/base_scaffold_background.dart';
import 'package:binbear/ui/base_components/base_text.dart';
import 'package:binbear/ui/manual_address/manual_address_screen.dart';
import 'package:binbear/ui/manual_address/model/saved_address_response.dart';
import 'package:binbear/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:binbear/ui/payment_gateway/payment_gateway_screen.dart';

class MonthTrashCleaningConfirmScreen extends StatefulWidget {
  final String selectedLoadSizePrice;
  const MonthTrashCleaningConfirmScreen({super.key, required this.selectedLoadSizePrice});

  @override
  State<MonthTrashCleaningConfirmScreen> createState() => _MonthTrashCleaningConfirmScreenState();
}

class _MonthTrashCleaningConfirmScreenState extends State<MonthTrashCleaningConfirmScreen> {

  String selectedImage = "";
  String? selectedImageName;
  String selectedCanTitle = "";
  String selectedAddress = "Select Your Address";
  String selectedAddressId = "";
  String selectedCouponId = "";
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
                title: "Trash Can Cleaning",
                bottomMargin: 0,
              ),
              const BasePageSubTitle(
                subTitle: "You don't have to take your trash cans to the street. We'll collect them, clean them, and return them to your home.",
                bottomMargin: 45,
              ),
              BaseContainer(
                topMargin: 20,
                bottomMargin: 0,
                leftPadding: horizontalScreenPadding,
                rightPadding: horizontalScreenPadding,
                topPadding: 22,
                bottomPadding: 22,
                borderRadius: 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BaseText(
                      value: "\$${widget.selectedLoadSizePrice}",
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    const BaseText(
                      topMargin: 3,
                      value: "/Month",
                      fontSize: 18,
                      color: Color(0xff707070),
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
                    serviceTypeId: "3",
                    subServiceId: "",
                    noOfCans: "",
                    price: newPriceAfterDiscount.toString(),
                    addressId: selectedAddressId.toString(),
                    couponId: "",
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
