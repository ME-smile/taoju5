/*
 * @Description: 提交订单主体内容
 * @Author: iamsmiling
 * @Date: 2021-01-07 22:14:53
 * @LastEditTime: 2021-02-01 17:46:27
 */
import 'package:taoju5/bapp/res/b_icons.dart';
import 'package:taoju5/bapp/ui/widgets/common/x_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taoju5/bapp/domain/model/product/product_adapter_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_type.dart';
import 'package:taoju5/bapp/res/b_colors.dart';
import 'package:taoju5/bapp/res/b_dimens.dart';
import 'package:taoju5/bapp/ui/pages/order/commit_order/commit_order_controller.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taoju5/bapp/ui/pages/product/widgets/product_attr_card.dart';

class CommitOrderBody extends GetView<CommitOrderController> {
  const CommitOrderBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !GetUtils.isNullOrBlank(controller.productList),
      child: Container(
        color: BColors.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: BDimens.gap32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (ProductAdapterModel product in controller.productList)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: product.productType is CurtainProductType &&
                        !GetUtils.isNullOrBlank(product?.room),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: BDimens.gap20),
                      child: Text(
                        product.room ?? "",
                        style: TextStyle(
                            fontSize: BDimens.sp28,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 180.w,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: XCachedNetworkImage(imageUrl: product.image),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 180.w,
                          margin: EdgeInsets.only(left: BDimens.gap24),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                        fontSize: BDimens.sp30,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "¥${product.unitPrcie?.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: BDimens.sp26,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: BDimens.gap16),
                                  child: Text(
                                    product.description ?? "",
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 6,
                                    style: TextStyle(
                                        fontSize: BDimens.sp24,
                                        color: BColors.descriptionTextColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: (product.productType is CurtainProductType) &&
                        !GetUtils.isNullOrBlank(product.attrList),
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: BDimens.gap24),
                        padding: EdgeInsets.all(BDimens.gap20),
                        decoration: BoxDecoration(
                            color: BColors.accentCardColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: ProductAttrCard(attrList: product.attrList)),
                  ),
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: BDimens.gap8),
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "小计:¥${product.totalPrice?.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: BDimens.sp28,
                              fontWeight: FontWeight.w500),
                        ),
                        Visibility(
                          visible: product.productType is CurtainProductType,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                BIcons.exclamation_point,
                                size: 16,
                              ),
                              Text(
                                "预估价格",
                                style: TextStyle(
                                    color: BColors.greyTextColor, fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
