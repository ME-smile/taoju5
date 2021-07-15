/*
 * @Description: 商品详情
 * @Author: iamsmiling
 * @Date: 2021-04-23 15:05:41
 * @LastEditTime: 2021-07-02 14:24:48
 */
import 'package:get/get.dart';
import 'package:taoju5_c/ui/pages/product/product_detail/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    String? id = Get.parameters["id"];
    Get.lazyPut(() => ProductDetailController(), tag: id);
  }
}
