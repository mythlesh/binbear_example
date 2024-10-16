import 'package:binbear/ui/base_components/base_button.dart';
import 'package:binbear/ui/base_components/base_list_checkbox.dart';
import 'package:binbear/ui/base_components/base_page_sub_title.dart';
import 'package:binbear/ui/base_components/base_page_title.dart';
import 'package:binbear/ui/base_components/base_app_bar.dart';
import 'package:binbear/ui/base_components/base_scaffold_background.dart';
import 'package:binbear/ui/base_components/smart_refresher_base_header.dart';
import 'package:binbear/ui/home_tab/controller/home_controller.dart';
import 'package:binbear/ui/load_size_confirm_screen.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SelectLoadSizeScreen extends StatefulWidget {

  const SelectLoadSizeScreen({super.key});

  @override
  State<SelectLoadSizeScreen> createState() => _SelectLoadSizeScreenState();
}

class _SelectLoadSizeScreenState extends State<SelectLoadSizeScreen> {

  int selectedLoadSizeIndex = 0;

  HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.serviceRefreshController = RefreshController(initialRefresh: false);
    controller.getSubServiceList(serviceId: '2');
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: Column(
          children: [
            const BasePageTitle(
              topMargin: 0,
              title: "Bulk Trash Pickup",
              bottomMargin: 0,
            ),
            const BasePageSubTitle(
              subTitle: "Please select the appropriate load size",
              bottomMargin: 20,
            ),
            Expanded(
              child: Obx(()=> SmartRefresher(
                controller: controller.serviceRefreshController,
                header: const SmartRefresherBaseHeader(),
                onRefresh: (){
                  controller.getSubServiceList(serviceId: "2");
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.subServiceList?.length??0,
                    itemBuilder: (context, index){
                      return BaseListCheckbox(
                        imageUrl: controller.subServiceList?[index]?.image??"",
                        title: "${controller.subServiceList?[index]?.title??""} : ",
                        isChecked: selectedLoadSizeIndex == index,
                        price: "\$ ${controller.subServiceList?[index]?.price?.toString()??""}",
                        onTap: (){
                          triggerHapticFeedback();
                          setState(() {
                            selectedLoadSizeIndex = index;
                          });
                        },
                      );
                    },
                  ),
              ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: horizontalScreenPadding, vertical: 14),
              width: double.infinity,
              color: Colors.white,
              child: BaseButton(
                title: 'Next',
                onPressed: (){
                  Get.to(() => LoadSizeConfirmScreen(
                    selectedLoadSizeTitle: controller.subServiceList?[selectedLoadSizeIndex]?.title??"",
                    selectedLoadSizeImage: controller.subServiceList?[selectedLoadSizeIndex]?.image??"",
                    selectedLoadSizePrice: controller.subServiceList?[selectedLoadSizeIndex]?.price?.toString()??"",
                    subServiceId: controller.subServiceList?[selectedLoadSizeIndex]?.id?.toString()??"",
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
