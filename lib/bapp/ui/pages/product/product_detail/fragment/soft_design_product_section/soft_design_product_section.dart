/*
 * @Description: 软装方案
 * @Author: iamsmiling
 * @Date: 2021-01-08 17:25:41
 * @LastEditTime: 2021-02-02 13:39:33
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taoju5/bapp/domain/model/product/design_product_model.dart';
import 'package:taoju5/bapp/res/b_colors.dart';
import 'package:taoju5/bapp/res/b_dimens.dart';
import 'package:taoju5/bapp/routes/bapp_pages.dart';
import 'package:taoju5/bapp/ui/modal/product/design_product/design_product_modal.dart';
import 'package:taoju5/bapp/ui/pages/customer/customer_list/customer_list_controller.dart';
import 'package:taoju5/bapp/ui/pages/home/customer_provider_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/widgets/x_title_bar.dart';
import 'package:taoju5/bapp/ui/widgets/bloc/x_swiper.dart';
import 'package:taoju5/bapp/ui/widgets/common/x_photo_viewer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SoftDesignProductSection extends StatelessWidget {
  final List<DesignProductModel> productList;
  final String fromId;
  const SoftDesignProductSection(
      {Key key, this.productList, @required this.fromId})
      : super(key: key);

  Future openDesignProductModal(int productId) {
    if (Get.find<CustomerProviderController>().isCustomerNull) {
      EasyLoading.showInfo("请先选择客户哦");
      return Get.toNamed(BAppRoutes.customerEdit,
          arguments: ChooseCustomerEventModel(fromUrl: Get.currentRoute));
    }
    return showDesignProductModal(id: "$productId", fromId: fromId);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !GetUtils.isNullOrBlank(productList),
      child: Container(
        margin: EdgeInsets.only(top: BDimens.gap16),
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(
            horizontal: BDimens.gap16, vertical: BDimens.gap16),
        child: Column(
          children: [
            XTitleBar(
              title: "软装方案",
              onTap: () =>
                  Get.toNamed(BAppRoutes.softProductDetail + "?fromId=$fromId"),
            ),
            AspectRatio(
                aspectRatio: 2.4,
                child: XSwiper(
                  itemCount: productList.length,
                  viewportFraction: .98,
                  itemBuilder: (BuildContext context, int i) {
                    DesignProductModel product = productList[i];
                    return Container(
                      margin: EdgeInsets.only(top: 4, bottom: 32),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              width: 1, color: const Color(0xFFE8E8E8)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 2),
                                color: Color.fromARGB(16, 0, 0, 0),
                                blurRadius: 3,
                                spreadRadius: 1),
                          ]),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                              aspectRatio: 1,
                              child: XPhotoViewer(
                                url: product.image,
                                fit: BoxFit.fitHeight,
                              )),
                          Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: BDimens.gap24, right: BDimens.gap20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                          fontSize: BDimens.sp26,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: Text(
                                        product?.fullName ?? '',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            TextStyle(fontSize: BDimens.sp28),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "¥${product?.totalPrice?.toStringAsFixed(2)}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: BDimens.sp28,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: BDimens.gap16),
                                          child: Text(
                                            "¥${product?.marketPrice?.toStringAsFixed(2)}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: BDimens.sp20,
                                                color: product?.marketPrice == 0
                                                    ? Colors.transparent
                                                    : BColors.greyTextColor),
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                            onTap: () => openDesignProductModal(
                                                product.id),
                                            child: Text(
                                              "立即购买",
                                              style: TextStyle(
                                                  color: BColors.highLightColor,
                                                  fontSize: BDimens.sp28,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
