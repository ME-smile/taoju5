import 'package:flutter/material.dart';
import 'package:taoju5/bapp/domain/model/product/design_product_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_mixin_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_model.dart';
import 'package:taoju5/bapp/res/b_colors.dart';
import 'package:taoju5/bapp/res/b_dimens.dart';
import 'package:taoju5/bapp/res/b_icons.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/subpage/design_product/design_product_modal/design_product_modal_controller.dart';
import 'package:taoju5/bapp/ui/widgets/common/x_photo_viewer.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taoju5/utils/common_kit.dart';

class DesignCurtainProductCard extends StatelessWidget {
  final DesignProductModel designProduct;
  final ProductMixinModel product;
  final String tag;
  const DesignCurtainProductCard(
      {Key key,
      @required this.product,
      @required this.designProduct,
      @required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: BDimens.gap32, horizontal: BDimens.gap32),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  width: 180.w,
                  height: 180.w,
                  child: XPhotoViewer(url: product.image)),
              Expanded(
                  child: Container(
                height: 180.w,
                margin: EdgeInsets.only(left: BDimens.gap24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                              fontSize: BDimens.sp28,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: BDimens.gap16),
                          child: Text(
                            "??${product.price.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: BColors.highLightColor,
                                fontSize: BDimens.sp28),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: BDimens.gap8),
                        child: Text(
                          "????????????:  ???:${product?.widthMStr}??? ???:${product?.heightMStr}???  ${product?.room}",
                          style: TextStyle(
                              color: BColors.descriptionTextColor,
                              fontSize: BDimens.sp28),
                        )),
                    GestureDetector(
                      onTap: () => Get.find<DesignProductModalController>()
                          .modifyMeasureData(product),
                      child: Row(
                        children: [
                          Text(
                            "??????????????????",
                            style: TextStyle(
                                fontSize: BDimens.sp24,
                                color: BColors.lightAccentColor),
                          ),
                          Icon(BIcons.next,
                              size: BDimens.sp28,
                              color: BColors.lightAccentColor)
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "??${product.totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: BColors.highLightColor,
                              fontSize: BDimens.sp28),
                        ),
                        Visibility(
                          visible: !CommonKit.isNullOrZero(product.marketPrice),
                          child: Container(
                            margin: EdgeInsets.only(left: BDimens.gap16),
                            child: Text(
                              "??${product.marketPrice.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: BColors.tipTextColor,
                                  fontSize: BDimens.sp24),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
            ],
          ),
          Visibility(
            visible: !GetUtils.isNullOrBlank(product.attrList),
            child: Container(
              margin:
                  EdgeInsets.only(top: BDimens.gap24, bottom: BDimens.gap16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "??????:",
                    style: TextStyle(
                        fontSize: BDimens.sp24, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () => Get.find<DesignProductModalController>()
                        .modifyAttribute(product),
                    child: Row(
                      children: [
                        Text(
                          "????????????",
                          style: TextStyle(
                              fontSize: BDimens.sp24,
                              color: BColors.lightAccentColor),
                        ),
                        Icon(BIcons.next,
                            size: BDimens.sp28, color: BColors.lightAccentColor)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 8.2,
            children: [
              for (CurtainProductAttrAdapterModel attr in product.attrList)
                Text(
                  "${attr?.typeName}: ${attr?.value}",
                  style: TextStyle(
                      fontSize: BDimens.sp24, color: BColors.greyTextColor),
                )
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: BDimens.gap16),
              child: Divider())
        ],
      ),
    );
  }
}
