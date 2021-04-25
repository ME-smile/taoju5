/*
 * @Description: 商品详情
 * @Author: iamsmiling
 * @Date: 2021-04-23 15:05:21
 * @LastEditTime: 2021-04-25 15:52:17
 */
import 'package:get/get.dart';
import 'package:taoju5_c/domain/entity/product/product_detail_entity.dart';
import 'package:taoju5_c/domain/repository/product_repository.dart';
import 'package:taoju5_c/ui/pages/product/product_detail/modal/open_finished_product_attribute_modal.dart';

class ProductDetailController extends GetxController {
  ProductRepository _repository = ProductRepository();

  String? id = Get.parameters["id"];

  late ProductDetailEntity product;

  Future loadData() {
    return _repository.productDetail({"goods_id": id}).then((value) {
      product = value;
      if (product.productType is! FinishedProductType) {
        _repository.productAttribute({"goods_id": id});
      }
      update();
    }).whenComplete(update);
  }

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  selectAttr() {
    openFinishedProductAttributeModal(Get.context!, product: product);
  }
}
