/*
 * @Description: 窗纱属性选择
 * @Author: iamsmiling
 * @Date: 2021-01-18 13:11:20
 * @LastEditTime: 2021-04-20 15:16:51
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taoju5/bapp/ui/modal/product/curtain_attr_selector.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/base_attr_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/product_detail_controller.dart';
import 'package:taoju5/bapp/ui/widgets/common/textfield/x_selector_text_field.dart';

import 'gauze_attr_selector_controller.dart';

class GauzeAttrSelectorBar extends StatelessWidget {
  final String tag;
  const GauzeAttrSelectorBar({Key key, @required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GauzeAttrSelectorController>(
      tag: tag,
      id: "attribute",
      builder: (_) {
        return Container(
          child: XSelectorTextField(
            label: Text("窗纱"),
            key: ValueKey(_?.description),
            initialValue: _?.description ?? '',
            onFuture: () =>
                showCurtainAttrSelectorModal<GauzeAttrSelectorController>(
                        title: "选择窗纱", tag: tag)
                    .then((value) {
              ///轨道类型
              OrbitType type;
              if (Get.isRegistered<ProductDetailController>(tag: tag)) {
                type = getOrbitType(Get.find<ProductDetailController>(tag: tag)
                    ?.selectProductEvent
                    ?.orderProduct
                    ?.measureData
                    ?.partType);
              }
              _.filter(orbitType: type);
              _.update(["attribute"]);
            }),
          ),
        );
      },
    );
  }
}
