import 'package:crafty_bay_project/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {

  @override
  void dependencies() {
      Get.lazyPut(() =>BottomNavBarController());
  }}