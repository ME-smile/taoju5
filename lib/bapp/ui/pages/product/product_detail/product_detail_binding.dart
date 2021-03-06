/*
 * @Description: productDetailBinding
 * @Author: iamsmiling
 * @Date: 2020-12-21 14:42:56
 * @LastEditTime: 2021-02-01 16:59:42
 */
import 'package:get/get.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/craft/craft_attr_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/riboux/riboux_attr_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/sectionalbar/sectionalbar_attr_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/size/size_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/valance/valance_attr_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/window_pattern/window_pattern_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/finished_product_attrs_selector/finished_product_attrs_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/product_detail_controller.dart';
import 'package:taoju5/bapp/ui/widgets/bloc/x_cart_button.dart';
import 'package:taoju5/bapp/ui/widgets/bloc/x_like_button.dart';

import 'fragment/product_attrs_selector/base/accessory/accessory_attr_selector_controller.dart';
import 'fragment/product_attrs_selector/base/gauze/gauze_attr_selector_controller.dart';
import 'fragment/product_attrs_selector/base/room/room_attr_selector_controller.dart';
import 'fragment/product_attrs_selector/base/window_style/window_style_selector_controller.dart';
import 'fragment/product_attrs_selector/rolling_curtain_product_attrs_selector/rolling_curtain_product_attrs_selector_controller.dart';
import 'product_register_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    String id = Get.parameters["id"];

    Get.lazyPut(() => ProductRegisterController());

    Get.lazyPut(() => ProductDetailController(), tag: id);

    ///???????????????
    Get.put(RoomAttrSelectorController(), tag: id, permanent: true);

    ///???????????????
    Get.lazyPut(() => AccessoryAttrSelectorController(), tag: id, fenix: true);

    ///???????????????
    Get.lazyPut(() => GauzeAttrSelectorController(), tag: id, fenix: true);

    ///????????????
    Get.lazyPut(() => CraftAttrSelectorController(), tag: id, fenix: true);

    ///??????
    Get.lazyPut(() => SectionalbarAttrSelectorController(),
        tag: id, fenix: true);

    ///??????
    Get.lazyPut(() => RibouxAttrSelectorController(), tag: id, fenix: true);

    ///??????
    Get.lazyPut(() => ValanceAttrSelectorController(), tag: id, fenix: true);

    ///??????
    Get.put(WindowPatternSelectorController(tag: id), tag: id, permanent: true);

    ///????????????
    Get.lazyPut(() => SizeSelectorController(), tag: id, fenix: true);

    Get.put(WindowStyleSelectorController(tag: id), tag: id, permanent: true);

    // Get.lazyPut(() => ProductDetailController(), tag: id);

    ///??????????????????
    Get.lazyPut(() => FinishedProductAttrsController(id: id), tag: id);

    ///??????????????????
    Get.lazyPut(() => RollingCurtainProductAttrsSelectorController(tag: id),
        tag: id);

    Get.lazyPut(() => XLikeController());

    Get.lazyPut(() => XCartCountController());
  }
}
