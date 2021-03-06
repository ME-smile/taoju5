/*
 * @Description: 窗型选择器
 * @Author: iamsmiling
 * @Date: 2021-01-18 13:52:13
 * @LastEditTime: 2021-04-28 14:32:13
 */

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:taoju5/bapp/domain/model/product/product_mixin_model.dart';
import 'package:taoju5/bapp/domain/model/window/window_pattern_model.dart';
import 'package:taoju5/bapp/ui/pages/home/taojuwu_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/craft/craft_attr_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/window_style/window_style_selector_controller.dart';

class WindowPatternSelectorController extends GetxController {
  final String tag;

  ProductMixinModel product;

  WindowPatternSelectorController({@required this.tag});

  String get value =>
      "${facade.confirmedOptionName}/${windowBay.confirmedOptionName}/${windowBox.confirmedOptionName}";

  WindowPatternModel facade;

  WindowPatternModel windowBay;

  WindowPatternModel windowBox;

  bool disabled = false;

  List<WindowPatternModel> get styleList => [facade, windowBay, windowBox];

  WindowStyleSelectorController get styleController =>
      Get.find<WindowStyleSelectorController>(tag: tag);

  @override
  void onInit() {
    TaojuwuController taoju5Controller = Get.find<TaojuwuController>();
    facade = taoju5Controller.facade;
    windowBay = taoju5Controller.windowBay;
    windowBox = taoju5Controller.windowBox;
    initWithMixinProduct();
    super.onInit();
  }

  void initWithMixinProduct() {
    if (product != null) {
      if (product?.style == null) {
        return;
      } else {
        List<String> list = product?.windowPattern?.split("/");
        _initCheckedStatusByName(facade, list[0]);
        _initCheckedStatusByName(windowBay, list[1]);
        _initCheckedStatusByName(windowBox, list[2]);
      }
    }
  }

  void _initCheckedStatusByName(WindowPatternModel model, String name) {
    model?.optionList?.forEach((element) {
      element.isChecked =
          element.name.contains(name) || name.contains(element?.name);
      element.hasConfirm = element.isChecked;
    });
  }

  void select(WindowPatternModel pattern, WindowPatternOptionModel option) {
    pattern.optionList.forEach((e) {
      e.isChecked = e == option;
    });
    update(["options"]);
  }

  void onConfirm({ProductMixinModel product}) {
    facade.currentOption.hasConfirm = true;
    windowBay.currentOption.hasConfirm = true;
    windowBox.currentOption.hasConfirm = true;
    if (product != null) {
      product.windowPattern = value;
    }
    Get.back();
    styleController.update();
    if (Get.isRegistered<CraftAttrSelectorController>(tag: tag)) {
      final craft = Get.find<CraftAttrSelectorController>(tag: tag);
      craft.filter();
    }
    update(["value"]);
  }

  Future<bool> onCancel() {
    _reset(facade);
    _reset(windowBay);
    _reset(windowBox);
    update();

    Get.back();
    return Future.value(true);
  }

  void _reset(WindowPatternModel pattern) {
    if (GetUtils.isNullOrBlank(pattern?.optionList)) return;
    if (GetUtils.isNullOrBlank(pattern?.confirmedOption)) {
      pattern.optionList?.first?.isChecked = true;
      pattern.optionList?.first?.hasConfirm = true;
    } else {
      pattern.optionList?.forEach((e) {
        e.isChecked = e == pattern?.confirmedOption;
      });
    }
  }
}
