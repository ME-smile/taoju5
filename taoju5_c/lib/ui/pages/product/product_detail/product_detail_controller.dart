/*
 * @Description: 商品详情
 * @Author: iamsmiling
 * @Date: 2021-04-23 15:05:21
 * @LastEditTime: 2021-05-24 11:25:47
 */
import 'package:get/get.dart';
import 'package:taoju5_c/component/net/future_loadstate_controller.dart';
import 'package:taoju5_c/domain/entity/params/cart/add_to_cart_params.dart';
import 'package:taoju5_c/domain/entity/product/curtain_attribute_entity.dart';
import 'package:taoju5_c/domain/entity/product/product_detail_entity.dart';
import 'package:taoju5_c/domain/repository/cart_repository.dart';
import 'package:taoju5_c/domain/repository/product_repository.dart';
import 'package:taoju5_c/ui/pages/product/product_detail/dialog/sectionalbar_product_attribute/sectionalbar_product_attribute_dialog.dart'
    as sectionalbarProductDialog;
import 'package:taoju5_c/ui/pages/product/product_detail/modal/open_finished_product_attribute_modal.dart'
    as finishedProductModal;
import 'package:taoju5_c/ui/pages/product/product_detail/modal/open_curtain_product_attribute_modal.dart'
    as curtainProductModal;

import 'dialog/rolling_curtain_product_attribute/rolling_curtain_product_attribute_dialog.dart'
    as rollingCurtainProductDialog;

class ProductDetailController
    extends BaseFutureLoadStateController<ProductDetailEntity> {
  ProductRepository _repository = ProductRepository();

  String? id = Get.parameters["id"];

  late ProductDetailEntity product;

  late CurtainAttributeEntity attribute;

  @override
  Future<ProductDetailEntity> loadData({Map? params}) {
    return _repository.productDetail({"goods_id": id}).then((value) {
      product = value;

      return value;
    });
  }

  ///选择属性
  openFinishedProductAttributeModal() {
    if (Get.isBottomSheetOpen == true) return;
    finishedProductModal.openFinishedProductAttributeModal(Get.context!,
        product: product, onPurchase: () {}, onAddToCart: addToCart);
  }

  openCurtainProductAttributeModal() {
    if (Get.isBottomSheetOpen == true) return;
    return _repository
        .productAttribute({"goods_id": id})
        .then((value) {
          attribute = value;
        })
        .catchError((err) {})
        .then((value) {
          curtainProductModal.openCurtainProductAttributeModal(Get.context!,
              product: product, attribute: attribute);
        });
  }

  openRollingCurtainProductAttributeDialog() {
    return _repository.productAttribute({"goods_id": id}).then((value) {
      attribute = value;
    }).catchError((err) {
      print(err);
    }).then((value) {
      rollingCurtainProductDialog.openRollingCurtainProductAttributeDialog(
          Get.context!,
          product: product,
          attribute: attribute);
    });

    // if (Get.isBottomSheetOpen == true) return;
    // return _repository
    //     .productAttribute({"goods_id": id})
    //     .then((value) {
    //       attribute = value;
    //     })
    //     .catchError((err) {})
    //     .then((value) {
    //       curtainProductModal.openCurtainProductAttributeModal(Get.context!,
    //           product: product, attribute: attribute);
    //     });
  }

  openSectionalbarProductAttributeDialog() {
    return sectionalbarProductDialog
        .openSectionalbarProductAttributeDialog(Get.context!, product: product);
  }

  Future addToCart() {
    CartRepository cartRepository = CartRepository();
    AddToCartParamsEntity arg = AddToCartParamsEntity(product: product);
    return cartRepository.addToCart(params: arg.params);
  }
}