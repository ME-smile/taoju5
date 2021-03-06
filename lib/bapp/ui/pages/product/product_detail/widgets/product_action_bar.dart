/*
 * @Description: 商品 加入购物车 购买
 * @Author: iamsmiling
 * @Date: 2021-01-10 17:31:33
 * @LastEditTime: 2021-02-02 14:04:10
 */
import 'package:flutter/material.dart';
import 'package:taoju5/bapp/res/b_colors.dart';
import 'package:taoju5/bapp/res/b_dimens.dart';
import 'package:taoju5/bapp/ui/widgets/common/button/x_future_button.dart';

class ProductActionBar extends StatelessWidget {
  final Function onBuy;
  final Function onAddToCart;
  const ProductActionBar(
      {Key key, @required this.onBuy, @required this.onAddToCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                foregroundColor: MaterialStateProperty.all(BColors.textColor),
                minimumSize: MaterialStateProperty.all(
                    Size(BDimens.minW156, BDimens.minH64)),
                textStyle: MaterialStateProperty.all(TextStyle(
                    fontSize: BDimens.sp28, color: BColors.textColor)),
                side: MaterialStateProperty.all(
                    BorderSide(color: BColors.outlineBorderColor, width: 1)))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                textStyle: MaterialStateProperty.all(TextStyle(
                    color: BColors.primaryColor, fontSize: BDimens.sp28)),
                backgroundColor: MaterialStateProperty.all(BColors.buttonColor),
                // foregroundColor: MaterialStateProperty.all(BColors.buttonColor),
                // overlayColor: MaterialStateProperty.all(BColors.buttonColor),
                minimumSize: MaterialStateProperty.all(
                    Size(BDimens.minW156, BDimens.minH64)))),
      ),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: XFutureButton(
                onFuture: onAddToCart,
                buttonMode: ButtonMode.outline,
                successTip: "加入购物车成功",
                failTip: "加入购物车失败",
                showSuccessTip: true,
                child: Text("加入购物车"),
              ),
            ),
            Expanded(
              child: XFutureButton(
                onFuture: onBuy,
                child: Text("立即购买"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
