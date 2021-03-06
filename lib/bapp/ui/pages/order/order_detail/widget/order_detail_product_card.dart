/*
 * @Description: 订单详情商品卡片
 * @Author: iamsmiling
 * @Date: 2021-01-06 14:44:36
 * @LastEditTime: 2021-01-22 09:45:57
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taoju5/bapp/domain/model/order/order_detail_product_model.dart';
import 'package:taoju5/bapp/domain/model/order/order_status.dart';
import 'package:taoju5/bapp/domain/model/order/refund_status.dart';
import 'package:taoju5/bapp/res/b_colors.dart';
import 'package:taoju5/bapp/res/b_dimens.dart';
import 'package:taoju5/bapp/routes/bapp_pages.dart';
import 'package:taoju5/bapp/ui/pages/order/order_detail/order_detail_controller.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taoju5/bapp/ui/widgets/common/x_photo_viewer.dart';
import 'package:taoju5/bapp/domain/model/order/order_detail_model.dart';

class OrderDetailProductCard extends StatelessWidget {
  final OrderDetailProductModel product;
  final OrderDetailModel order;

  const OrderDetailProductCard(this.product, {Key key, @required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: BDimens.gap24, vertical: BDimens.gap24),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: BDimens.gap32),
                      child: SizedBox(
                        height: 180.h,
                        width: 180.h,
                        child: XPhotoViewer(url: product.image),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 180.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.hasSelected
                                      ? product.name
                                      : product.room ?? product.name,
                                  style: TextStyle(
                                      fontSize: BDimens.sp30,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  product.orderStatusName,
                                  style: TextStyle(
                                      fontSize: BDimens.sp30,
                                      color: BColors.pinkColor),
                                )
                              ],
                            ),
                            Visibility(
                              visible: product.hasSelected,
                              child: Text(
                                "¥${product.price}",
                                style: TextStyle(fontSize: BDimens.sp28),
                              ),
                            ),
                            Text(product.description,
                                style: TextStyle(
                                    color: BColors.tipColor,
                                    fontSize: BDimens.sp24)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: BDimens.gap32, bottom: BDimens.gap8),
            child: Text(
              "小计:¥${product.totalPrice}",
              style: TextStyle(
                  fontSize: BDimens.sp28, fontWeight: FontWeight.w500),
            ),
          ),

          ///操作按钮
          Container(
            width: Get.width,
            alignment: Alignment.centerRight,
            child: _OrderDetailProductActionBar(product: product),
          )
        ],
      ),
    );
  }
}

class _OrderDetailProductActionBar extends StatelessWidget {
  final OrderDetailProductModel product;

  const _OrderDetailProductActionBar({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      id: "buttonState",
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///进入生产环节的商品不可取消
            Row(
              children: [
                Visibility(
                    child: Container(
                      // margin: EdgeInsets.only(right: BDimens.gap24),
                      child: OutlinedButton(
                        onPressed: () => _.openCancelProductDialog(product),
                        child: Text("取消"),
                      ),
                    ),
                    visible: (_.order.orderStatus < OrderStatus.producing &&
                        product.refundStatus == RefundStatus.refundable)),
                Visibility(
                    visible: (_.order.orderStatus == OrderStatus.toBeSelected),
                    child: Container(
                      margin: EdgeInsets.only(left: BDimens.gap24),
                      child: Row(
                        children: [
                          // Visibility(
                          //   visible:
                          //       product.refundStatus != RefundStatus.refundable,
                          //   child: OutlinedButton(
                          //     onPressed: null,
                          //     child: Text("去选品"),
                          //   ),
                          // ),
                          Visibility(
                            visible:
                                product.refundStatus == RefundStatus.refundable,
                            child: OutlinedButton(
                              onPressed: () => _.goToSelect(product),
                              child: Text(product.hasSelected ? "更换选品" : "去选品"),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            Visibility(
                child: OutlinedButton(
                  onPressed: null,
                  child: Text("取消待审核"),
                ),
                visible: (_.order.orderStatus < OrderStatus.producing &&
                    product.refundStatus == RefundStatus.toBeAuthed)),
            Visibility(
                child: OutlinedButton(
                  onPressed: null,
                  child: Text("商品已取消"),
                ),
                visible: (_.order.orderStatus < OrderStatus.producing &&
                    product.refundStatus == RefundStatus.succeed)),

            ///进入生产环节的商品不可取消
            Visibility(
                child: OutlinedButton(
                  onPressed: () =>
                      Get.toNamed(BAppRoutes.afterSell + "/${_.order.id}"),
                  child: Text("售后维权"),
                ),
                visible: _.order.orderStatus == OrderStatus.finished),
          ],
        );
      },
    );
  }
}
