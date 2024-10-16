import 'package:binbear/ui/base_components/base_button.dart';
import 'package:binbear/ui/base_components/base_list_checkbox.dart';
import 'package:binbear/ui/base_components/base_page_sub_title.dart';
import 'package:binbear/ui/base_components/base_page_title.dart';
import 'package:binbear/ui/base_components/base_app_bar.dart';
import 'package:binbear/ui/base_components/base_scaffold_background.dart';
import 'package:binbear/ui/base_components/smart_refresher_base_header.dart';
import 'package:binbear/ui/load_size_selection_screen.dart';
import 'package:binbear/ui/month_trash_cleaning_confirm_screen.dart';
import 'package:binbear/ui/select_service/controller/select_service_controller.dart';
import 'package:binbear/ui/week_or_month_selection_screen.dart';
import 'package:binbear/utils/base_functions.dart';
import 'package:binbear/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SelectServiceScreen extends StatefulWidget {

  const SelectServiceScreen({super.key});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  SelectServiceController controller = Get.put(SelectServiceController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: Column(
          children: [
            const BasePageTitle(
              topMargin: 0,
              title: "Schedule Pick-Up",
              bottomMargin: 0,
            ),
            const BasePageSubTitle(
              subTitle: "Select the Service\nThat Best Meets your Needs",
              bottomMargin: 17,
            ),
            Expanded(
              child: SmartRefresher(
                controller: controller.refreshController,
                header: const SmartRefresherBaseHeader(),
                onRefresh: (){
                  controller.getServiceList();
                },
                child: Obx(()=> ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.serviceList?.length??0,
                    itemBuilder: (context, index){
                      return Obx(()=>BaseListCheckbox(
                        showMostPopularTag: (controller.serviceList?[index]?.status?.toString()??"") == "2",
                        imageUrl: controller.serviceList?[index]?.image??"",
                        title: controller.serviceList?[index]?.title??"",
                        isChecked: controller.selectedServiceIndex.value == index,
                        onTap: (){
                          triggerHapticFeedback();
                          controller.selectedServiceIndex.value = index;
                        },
                      ),
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
                  switch (controller.selectedServiceIndex.value) {
                    /// Can 2 Curb Service
                    case 0: {
                      Get.off(() => const WeekOrMonthSelectionScreen());
                      break;
                    }
                    /// Bulk Trash Pickup
                    case 1: {
                      Get.off(() => const SelectLoadSizeScreen());
                      break;
                    }
                    /// Trash Can Cleaning
                    case 2: {
                      Get.off(() => MonthTrashCleaningConfirmScreen(selectedLoadSizePrice: controller.serviceList?[controller.selectedServiceIndex.value]?.price?.toString()??""));
                      break;
                    }
                    default:
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
