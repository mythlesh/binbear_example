import 'dart:collection';
import 'dart:developer';
import 'package:binbear/ui/base_components/base_app_bar.dart';
import 'package:binbear/ui/home_tab/controller/home_controller.dart';
import 'package:binbear/ui/onboardings/base_success_screen.dart';
import 'package:binbear/ui/onboardings/splash/controller/base_controller.dart';
import 'package:binbear/utils/base_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentGatewayScreen extends StatefulWidget {
  final String bookingId, userId;
  const PaymentGatewayScreen(
      {super.key, required this.bookingId, required this.userId});

  @override
  _PaymentGatewayScreenState createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  final GlobalKey webViewKey = GlobalKey();
  BaseController baseController =Get.find<BaseController>();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: false,
      iframeAllowFullscreen: false);

  PullToRefreshController? pullToRefreshController;

  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              id: 1,
              title: "Special",
              action: () async {
                log("Menu item Special clicked!");
                log(await webViewController?.getSelectedText() ?? "");
                await webViewController?.clearFocus();
              })
        ],
        settings: ContextMenuSettings(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          log("onCreateContextMenu");
          log(hitTestResult.extra ?? "");
          log(await webViewController?.getSelectedText() ?? "");
        },
        onHideContextMenu: () {
          log("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = contextMenuItemClicked.id;
          log("onContextMenuActionItemClicked: $id ${contextMenuItemClicked.title}");
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(),
      backgroundColor: const Color(0xffba6e1f),
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                  url: WebUri(
                      'https://v1.checkprojectstatus.com/binbear/stripe-payment/${widget.userId}/${widget.bookingId}')),
              initialUserScripts: UnmodifiableListView<UserScript>([]),
              initialSettings: settings,
              contextMenu: contextMenu,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) async {
                webViewController = controller;
              },
              onLoadStart: (controller, url) async {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                    resources: request.resources,
                    action: PermissionResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!;
                if (![
                  "http",
                  "https",
                  "file",
                  "chrome",
                  "data",
                  "javascript",
                  "about"
                ].contains(uri.scheme)) {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(
                      uri,
                    );
                    return NavigationActionPolicy.CANCEL;
                  }
                }
                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controller, url) async {
                pullToRefreshController?.endRefreshing();
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
                if (url.toString().contains("save-card-failed")) {
                  Get.off(() => BaseSuccessScreen(
                        isFailed: true,
                        description:
                            "Your payment is failed, please try again.",
                        btnTitle: "Retry",
                        onBtnTap: () {
                          Get.back();
                        },
                      ));
                } else if (url.toString().contains("save-card-success")) {
                  Get.off(() => BaseSuccessScreen(
                        description: "Your payment is succeed",
                        onBtnTap: () {
                          if (baseController.homeTabServiceIndex.value ==0) {
                            Get.back();
                            Get.back();
                            Get.back();
                          } else if (baseController.homeTabServiceIndex.value ==1) {
                            Get.back();
                            Get.back();
                            Get.back();
                          } else if (baseController.homeTabServiceIndex.value ==2) {
                            Get.back();
                            Get.back();
                          }
                          if (baseController.isHomeTabBookNowTapped.value ==
                              true) {
                            Get.back();
                           baseController.isHomeTabBookNowTapped.value =false;
                          }
                          Get.find<HomeController>().getHomeData();
                        },
                      ));
                }
              },
              onReceivedError: (controller, request, error) {
                pullToRefreshController?.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController?.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                  urlController.text = url;
                });
              },
              onUpdateVisitedHistory: (controller, url, isReload) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                log(consoleMessage.toString());
              },
            ),
            progress < 1.0
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color(0xffba6e1f),
                    child: const SpinKitFoldingCube(
                      color: BaseColors.primaryColor,
                      size: 50,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
