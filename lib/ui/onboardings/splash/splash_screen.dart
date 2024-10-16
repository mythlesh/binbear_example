
import 'package:animate_do/animate_do.dart';
import 'package:binbear/ui/base_components/base_scaffold_background.dart';
import 'package:binbear/ui/base_error_screen.dart';
import 'package:binbear/ui/dashboard_module/dashboard_screen/controller/dashboard_controller.dart';
import 'package:binbear/ui/dashboard_module/dashboard_screen/dashboard_screen.dart';
import 'package:binbear/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbear/ui/onboardings/welcome_screen.dart';
import 'package:binbear/utils/base_assets.dart';
import 'package:binbear/utils/get_storage.dart';
import 'package:binbear/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  BaseController baseController = Get.put(BaseController());
  DashboardController dashboardController = Get.put(DashboardController());
  bool showFooter = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initGetStorage();
      if (mounted) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
      Future.delayed( const Duration(milliseconds: 2700), () async {
        setState(() {
          showFooter = false;
        });
      });
      Future.delayed( const Duration(seconds: 3), () async {
        if (await FlutterJailbreakDetection.jailbroken) {
          Get.offAll(() => const BaseErrorScreen());
        }else{
          if ((BaseStorage.read(StorageKeys.apiToken)??"").toString().isNotEmpty) {
            // baseController.getCansList();
            Get.offAll(() => const DashBoardScreen());
          }else{
            Get.offAll(() => const WelcomeScreen());
          }
        }
      });
    });
  }

  initGetStorage() async {
    await GetStorage.init('MyStorage');
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldBackground(
        child: Scaffold(
          body: Column(
            children: [
              const Spacer(),
              ZoomIn(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: BaseStorage.read(StorageKeys.apiToken).toString().isNotEmpty ?
                  Hero(
                    tag: "splash_tag",
                    child: SvgPicture.asset(
                      BaseAssets.appLogoWithName,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ) : SvgPicture.asset(
                    BaseAssets.appLogoWithName,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              const Spacer(),
              FadeInUp(
                animate: showFooter,
                child: SvgPicture.asset(
                  BaseAssets.splashFooter,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
