/*
 * @Description: 订单商品卡片
 * @Author: iamsmiling
 * @Date: 2021-01-04 15:46:09
 * @LastEditTime: 2021-04-28 18:44:42
 */
import 'package:taoju5/bapp/ui/widgets/common/x_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taoju5/bapp/domain/model/order/order_model.dart';
import 'package:taoju5/bapp/domain/model/order/order_status.dart';
import 'package:taoju5/bapp/domain/model/order/order_type.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taoju5/bapp/res/b_colors.dart';
import 'package:taoju5/bapp/res/b_dimens.dart';

///选品单
class _SelectOrderCard extends StatelessWidget {
  final OrderModel order;
  final OrderProductModel product;
  final String lastOrderNo;
  const _SelectOrderCard(
      {Key key, this.order, this.product, this.lastOrderNo = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(BDimens.gap32),
            color: BColors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180.h,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: XCachedNetworkImage(imageUrl: product.image),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  height: 180.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: BDimens.gap32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                        fontSize: BDimens.sp28,
                                        color: BColors.textColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    product.statusName,
                                    style: TextStyle(
                                        fontSize: BDimens.sp26,
                                        color: BColors.pinkColor),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: BDimens.gap8),
                                child: Text(
                                    "¥${product.price.toStringAsFixed(2)}"),
                              )
                            ],
                          ),
                        ),
                        DefaultTextStyle(
                            style: TextStyle(
                                fontSize: BDimens.sp24,
                                color: BColors.tipTextColor),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("客户:${order.customerName}"),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(bottom: BDimens.gap4),
                                      child: Text("订单编号:${order.no}"))
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///未测量的测量单
class _UnMeasuredOrderCard extends StatelessWidget {
  final OrderModel order;
  final OrderProductModel product;
  const _UnMeasuredOrderCard({Key key, this.order, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(BDimens.gap32),
            color: BColors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180.h,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: XCachedNetworkImage(imageUrl: product.image),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  height: 180.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: BDimens.gap32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order.typeName,
                                    style: TextStyle(
                                        fontSize: BDimens.sp28,
                                        color: BColors.textColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    product.statusName,
                                    style: TextStyle(
                                        fontSize: BDimens.sp26,
                                        color: BColors.pinkColor),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: BDimens.gap8),
                                child: Text("${order.windowCount}扇"),
                              )
                            ],
                          ),
                        ),
                        DefaultTextStyle(
                            style: TextStyle(
                                fontSize: BDimens.sp24,
                                color: BColors.tipTextColor),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("客户:${order.customerName}"),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(bottom: BDimens.gap4),
                                      child: Text("订单编号:${order.no}"))
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///已经选品但没有确认的订单
class _SeletedMeasureOrderCard extends StatelessWidget {
  final OrderModel order;
  final OrderProductModel product;
  const _SeletedMeasureOrderCard(
      {Key key, @required this.order, @required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(BDimens.gap32),
            color: BColors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180.h,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: XCachedNetworkImage(imageUrl: product.image),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  height: 180.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: BDimens.gap32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                        fontSize: BDimens.sp28,
                                        color: BColors.textColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    product.statusName,
                                    style: TextStyle(
                                        fontSize: BDimens.sp26,
                                        color: BColors.pinkColor),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: BDimens.gap8),
                                child: Text(
                                  "¥${product.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: BDimens.sp28,
                                      color: BColors.textColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                // padding: EdgeInsets.symmetric(
                                //     vertical: BDimens.gap8),
                                child: Text(
                                  "空间:${product.room}",
                                  style: TextStyle(
                                      fontSize: BDimens.sp24,
                                      color: BColors.tipTextColor),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: BDimens.gap8),
                                child: Text(
                                  "宽:${(product.width / 100).toStringAsFixed(2)}米 高:${(product.height / 100).toStringAsFixed(2)}米",
                                  style: TextStyle(
                                      fontSize: BDimens.sp24,
                                      color: BColors.tipTextColor),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // DefaultTextStyle(
                        //     style: TextStyle(
                        //         fontSize: BDimens.sp24,
                        //         color: BColors.tipTextColor),
                        //     child: Container(
                        //       child: Column(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text("空间:${product.room}"),
                        //           Padding(
                        //               padding:
                        //                   EdgeInsets.only(bottom: BDimens.gap4),
                        //               child: Text(
                        //                   "宽:${product.width}米 高:${product.height}"))
                        //         ],
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///测量完成的测量单
class _UnselectedOrderCard extends StatelessWidget {
  final OrderModel order;
  final OrderProductModel product;
  const _UnselectedOrderCard({Key key, this.order, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(BDimens.gap32),
            color: BColors.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180.h,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: XCachedNetworkImage(imageUrl: product.image),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  height: 180.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: BDimens.gap32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.room,
                                    style: TextStyle(
                                        fontSize: BDimens.sp28,
                                        color: BColors.textColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    product.statusName,
                                    style: TextStyle(
                                        fontSize: BDimens.sp26,
                                        color: BColors.pinkColor),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: BDimens.gap8),
                                child: Text(
                                  "宽:${(product.width / 100).toStringAsFixed(2)}米 高:${(product.height / 100).toStringAsFixed(2)}米",
                                  style: TextStyle(
                                      fontSize: BDimens.sp28,
                                      color: BColors.textColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                "${product.style}",
                                style: TextStyle(
                                    fontSize: BDimens.sp24,
                                    color: BColors.tipTextColor),
                              ),
                            ],
                          ),
                        ),

                        // DefaultTextStyle(
                        //     style: TextStyle(
                        //         fontSize: BDimens.sp24,
                        //         color: BColors.tipTextColor),
                        //     child: Container(
                        //       child: Column(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text("空间:${product.room}"),
                        //           Padding(
                        //               padding:
                        //                   EdgeInsets.only(bottom: BDimens.gap4),
                        //               child: Text(
                        //                   "宽:${product.width}米 高:${product.height}"))
                        //         ],
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderProductCard extends StatelessWidget {
  final OrderModel order;
  final OrderProductModel product;
  const OrderProductCard(
      {Key key, @required this.product, @required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BColors.primaryColor,
      child: Column(
        children: [
          ///选品单
          Visibility(
            visible: order.orderType == OrderType.selectionOrder,
            child: _SelectOrderCard(order: order, product: product),
          ),

          ///测量单
          Visibility(
            visible: order.orderType == OrderType.measureOrder,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///测量未完成测量
                Visibility(
                  visible: order.orderStatus <= OrderStatus.toBeMeasured,
                  child: _UnMeasuredOrderCard(order: order, product: product),
                ),

                ///测量完成
                Visibility(
                  visible: order.orderStatus > OrderStatus.toBeMeasured,
                  child: Column(
                    children: [
                      if (product.hasSelected)
                        _SeletedMeasureOrderCard(order: order, product: product)
                      else
                        _UnselectedOrderCard(order: order, product: product)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
