import 'package:binbear/ui/base_components/base_button.dart';
import 'package:binbear/ui/base_components/base_list_checkbox.dart';
import 'package:binbear/ui/base_components/base_page_sub_title.dart';
import 'package:binbear/ui/base_components/base_page_title.dart';
import 'package:binbear/ui/base_components/base_app_bar.dart';
import 'package:binbear/ui/base_components/base_scaffold_background.dart';
import 'package:binbear/ui/base_components/smart_refresher_base_header.dart';
import 'package:binbear/ui/home_tab/controller/home_controller.dart';
import 'package:binbear/ui/week_or_month_confirm_screen.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WeekOrMonthSelectionScreen extends StatefulWidget {

  const WeekOrMonthSelectionScreen({super.key});

  @override
  State<WeekOrMonthSelectionScreen> createState() => _WeekOrMonthSelectionScreenState();
}

class _WeekOrMonthSelectionScreenState extends State<WeekOrMonthSelectionScreen> {
  int selectedServiceIndex = 0;
  HomeController controller = Get.find<HomeController>();
  @override
  void initState() {
    super.initState();
    controller.serviceRefreshController = RefreshController(initialRefresh: false);
    controller.getSubServiceList(serviceId: '1');
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
              title: "Can 2 Curb Service",
              bottomMargin: 0,
            ),
            const BasePageSubTitle(
              subTitle: "1x Can2curb service",
              bottomMargin: 45,
            ),
            Expanded(
              child: Obx(()=>SmartRefresher(
                controller: controller.serviceRefreshController,
                header: const SmartRefresherBaseHeader(),
                onRefresh: (){
                  controller.getSubServiceList(serviceId: "1");
                },
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.subServiceList?.length??0,
                    itemBuilder: (context, index){
                      return BaseListCheckbox(
                        imageUrl: controller.subServiceList?[index]?.image??"",
                        title: controller.subServiceList?[index]?.title??"",
                        isChecked: selectedServiceIndex == index,
                        onTap: (){
                          triggerHapticFeedback();
                          setState(() {
                            selectedServiceIndex = index;
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
                  Get.to(() => WeekOrMonthConfirmScreen(
                    selectedServiceTitle: controller.subServiceList?[selectedServiceIndex]?.title??"",
                    price: controller.subServiceList?[selectedServiceIndex]?.price?.toString()??"",
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
