/*
 * @Description:app程序入口
 * @Author: iamsmiling
 * @Date: 2021-04-17 21:31:19
 * @LastEditTime: 2021-04-26 17:37:19
 */
import 'package:get/get.dart';
import 'package:taoju5_c/ui/pages/cart/cart_controller.dart';
import 'package:taoju5_c/ui/pages/category/categoty_controller.dart';
import 'package:taoju5_c/ui/pages/home/home_controller.dart';
import 'package:taoju5_c/ui/pages/main/main_controller.dart';
import 'package:taoju5_c/ui/pages/mine/mine_controller.dart';
import 'package:taoju5_c/ui/pages/school/school_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());

    Get.lazyPut(() => HomeController());

    Get.lazyPut(() => CategoryController());

    Get.lazyPut(() => SchoolController());

    Get.lazyPut(() => CartController());

    Get.lazyPut(() => MineController());
  }
}
