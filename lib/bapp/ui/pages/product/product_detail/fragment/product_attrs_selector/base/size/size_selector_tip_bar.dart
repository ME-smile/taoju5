/*
 * @Description:填写尺寸
 * @Author: iamsmiling
 * @Date: 2021-01-18 15:55:02
 * @LastEditTime: 2021-02-01 16:38:21
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taoju5/bapp/res/b_colors.dart';
import 'package:taoju5/bapp/res/b_dimens.dart';
import 'package:taoju5/bapp/res/b_icons.dart';
import 'package:taoju5/bapp/routes/bapp_pages.dart';
import 'package:taoju5/bapp/ui/pages/order/order_detail/order_detail_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/room/room_attr_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/size/size_selector_controller.dart';

class SizeSelectorTipBar extends GetView<SizeSelectorController> {
  final String tag;
  const SizeSelectorTipBar({Key key, @required this.tag}) : super(key: key);

  ///是否为选品
  bool get isForSelect => controller.selectProductEvent != null;

  _onTap() {
    if (!isForSelect) {
      print(tag);
      return Get.toNamed(BAppRoutes.editMeasureData + "/$tag");
    }
    OrderDetailController orderController = Get.find<OrderDetailController>();

    return Get.toNamed(
        BAppRoutes.orderMeasureData +
            "?id=${orderController.order.id}&productId=$tag",
        arguments: controller.selectProductEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: BDimens.gap32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Visibility(
                          visible: !isForSelect,
                          child: GetBuilder<SizeSelectorController>(
                            tag: tag,
                            id: "size",
                            autoRemove: false,
                            builder: (_) {
                              return Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                        text: '*  ',
                                        style:
                                            TextStyle(color: Color(0xFFE02020)),
                                        children: [
                                          TextSpan(
                                              text: _.isSizeNullOrEmpty
                                                  ? '请预填测装数据'
                                                  : '已预填测装数据',
                                              style: TextStyle(
                                                  fontSize: BDimens.sp28,
                                                  color: BColors.textColor)),
                                        ]),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: isForSelect,
                          child: GetBuilder<SizeSelectorController>(
                            tag: tag,
                            id: "size",
                            autoRemove: false,
                            builder: (_) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                        text: '*  ',
                                        style:
                                            TextStyle(color: BColors.pinkColor),
                                        children: [
                                          TextSpan(
                                              text: _.hasChecked
                                                  ? '已确认测装数据'
                                                  : '请确认测装数据',
                                              style: TextStyle(
                                                  fontSize: BDimens.sp28,
                                                  color: BColors.textColor)),
                                        ]),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        GetBuilder<SizeSelectorController>(
                          tag: tag,
                          id: "size",
                          builder: (_) {
                            return Visibility(
                              visible: !_.isSizeNullOrEmpty,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      "宽:${_.widthM?.toStringAsFixed(2)}米 高:${_.heightM?.toStringAsFixed(2)}米"),
                                  GetBuilder<RoomAttrSelectorController>(
                                    tag: tag,
                                    builder: (_) {
                                      return Text("${_.value}");
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Icon(BIcons.next)
                  ],
                ),
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
