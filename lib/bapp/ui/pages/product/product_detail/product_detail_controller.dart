/*
 * @Description: 商品详情
 * @Author: iamsmiling
 * @Date: 2020-12-21 14:43:22
 * @LastEditTime: 2021-06-16 18:35:32
 */
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taoju5/bapp/domain/model/customer/customer_model.dart';
import 'package:taoju5/bapp/domain/model/order/order_type.dart';
import 'package:taoju5/bapp/domain/model/product/design_product_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_adapter_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_attr_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_detail_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_type.dart';
import 'package:taoju5/bapp/domain/model/window/window_style_model.dart';
import 'package:taoju5/bapp/domain/repository/product/product_repository.dart';
import 'package:taoju5/bapp/routes/bapp_pages.dart';
import 'package:taoju5/bapp/ui/pages/customer/customer_list/customer_list_controller.dart';
import 'package:taoju5/bapp/ui/pages/home/customer_provider_controller.dart';
import 'package:taoju5/bapp/ui/pages/order/commit_order/commit_order_controller.dart';
import 'package:taoju5/bapp/ui/pages/order/order_detail/order_detail_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/gauze/gauze_attr_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/riboux/riboux_attr_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/room/room_attr_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/sectionalbar/sectionalbar_attr_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base/size/size_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/fragment/product_attrs_selector/base_curtain_product_attrs_selector_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/product_pridce_delegator.dart';
import 'package:taoju5/bapp/ui/pages/product/product_detail/product_register_controller.dart';
import 'package:taoju5/bapp/ui/pages/product/selectable_product_list/selectable_product_list_controller.dart';
import 'package:taoju5/bapp/ui/widgets/base/x_view_state.dart';
import 'package:taoju5/bapp/domain/model/product/curtain_product_attr_model.dart';
import 'package:taoju5/xdio/x_dio.dart';

import 'fragment/product_attrs_selector/base/accessory/accessory_attr_selector_controller.dart';
import 'fragment/product_attrs_selector/base/base_attr_selector_controller.dart';
import 'fragment/product_attrs_selector/base/craft/craft_attr_selector_controller.dart';
import 'fragment/product_attrs_selector/base/valance/valance_attr_selector_controller.dart';
import 'fragment/product_attrs_selector/base/window_pattern/window_pattern_selector_controller.dart';
import 'fragment/product_attrs_selector/base/window_style/window_style_selector_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'fragment/product_attrs_selector/rolling_curtain_product_attrs_selector/rolling_curtain_product_attrs_selector_controller.dart';

class EditMeasureDataParamsModel<T> {
  String width;
  String height;
  String dataId;
  String deltaY;
  String productId;
  String roomId;
  String windowPattern;
  String tag;
  List<String> installMode;
  var openMode;

  EditMeasureDataParamsModel(
      {@required this.tag, String defaultWidth, String defaultHeight}) {
    SizeSelectorController sizeSelectorController =
        find<SizeSelectorController>(tag: tag);
    sizeSelectorController?.defaultWidth = defaultWidth;
    sizeSelectorController?.defaultHeight = defaultHeight;
    width = defaultWidth ?? "${sizeSelectorController?.widthCM}";
    height = defaultHeight ?? "${sizeSelectorController?.heightCM}";
    deltaY = sizeSelectorController?.deltaY;
    RoomAttrSelectorController roomController =
        find<RoomAttrSelectorController>(tag: tag);
    roomId = roomController?.id;

    WindowStyleSelectorController styleController =
        find<WindowStyleSelectorController>(tag: tag);
    dataId = "${styleController?.style?.id}";
    windowPattern = styleController?.style?.name;
    installMode = [styleController?.currentInstallModeOption?.name];
    WindowOpenModeOptionModel currentOpenModeOption =
        styleController?.currentOpenModeOption;
    String openModeName = currentOpenModeOption?.name;
    if (GetUtils.isNullOrBlank(currentOpenModeOption?.suboptionList)) {
      openMode = [openModeName];
    } else {
      Map map = {};
      for (WindowSubopenModeModel e in currentOpenModeOption?.suboptionList) {
        map[e?.title] = [
          e?.optionList
              ?.firstWhere((element) => element.isChecked,
                  orElse: () => e.optionList?.first)
              ?.name
        ];
      }
      openMode = {openModeName: map};
    }
  }

  T find<T>({String tag}) {
    if (Get.isRegistered<T>(tag: tag)) {
      return Get.find<T>(tag: tag);
    }
    return null;
  }

  Map get params => {
        "dataId": dataId,
        "width": width,
        "height": height,
        "vertical_ground_height": deltaY,
        "goods_id": tag,
        "install_room": roomId,
        "data": jsonEncode({
          "$dataId": {
            "name": windowPattern,
            "install_room": roomId,
            "w": width,
            "height": height,
            "selected": {"安装选项": installMode, "打开方式": openMode}
          }
        })
      };
}

class AddToCartParamsModel {
  T find<T>({String tag}) {
    if (Get.isRegistered<T>(tag: tag)) {
      return Get.find<T>(tag: tag);
    }
    return null;
  }

  String tag;
  String clientId;
  Map attribute;

  String measureId;
  String totalPrice;
  Map description;

  ProductDetailModel product;
  AddToCartParamsModel(
      {@required this.tag,
      @required this.product,
      @required this.totalPrice,
      this.measureId});

  Map get params {
    clientId = Get.find<CustomerProviderController>().id;
    attribute = CurtainProductAtrrParamsModel(tag: tag).params;
    description = product.toJson();
    return {
      "client_uid": clientId,
      "wc_attr": jsonEncode(attribute),
      "cart_detail": jsonEncode(description),
      "measure_id": measureId,
      "estimated_price": totalPrice,
    };
  }
}

class CurtainProductAtrrParamsModel<T> {
  String tag;

  CurtainProductAtrrParamsModel({@required this.tag});

  List get _controllers => [
        _find<RoomAttrSelectorController>(tag: tag),
        _find<GauzeAttrSelectorController>(tag: tag),
        _find<CraftAttrSelectorController>(tag: tag),
        _find<SectionalbarAttrSelectorController>(tag: tag),
        _find<RibouxAttrSelectorController>(tag: tag),
        _find<ValanceAttrSelectorController>(tag: tag),
        _find<AccessoryAttrSelectorController>(tag: tag),
        _find<SizeSelectorController>(tag: tag)
      ];

  T _find<T>({@required String tag}) {
    if (Get.isRegistered<T>(tag: tag)) {
      return Get.find<T>(tag: tag);
    }
    return null;
  }

  Map get params {
    Map map = {};

    _controllers.forEach((e) {
      if (e == null) {
        return;
      }
      if (e is BaseAttrSelectorController) {
        map.addAll(e?.attr?.params ?? {});
      }
      if (e is SizeSelectorController) {
        map.addAll(e?.params ?? {});
      }
    });
    return map;
  }
}

class ProductDetailController extends GetxController {
  ProductRepository _repository = ProductRepository();

  ProductDetailModelWrapper wrapper;

  String currentRoute = Get.currentRoute;

  ///选品事件
  SelectProductEvent selectProductEvent;

  ProductDetailModel product = ProductDetailModel();

  XLoadState loadState = XLoadState.idle;

  BaseCurtainProductAttrsSelectorController selectorController;

  BasePoductPriceDelegator get priceDelegator {
    if (product.productType is GauzeCurtainProductType) {
      return GauzeCurtainProductPriceDelegator(product);
    }
    if (product.productType is RollingCurtainProductType) {
      return RollingCurtainProductPriceDelegator(product);
    }
    if (product.productType is FabricCurtainProductType) {
      return FabricCurtainProductPriceDelegator(product);
    }
    if (product.productType is SectionalbarProductType) {
      return SectionalbarProductPriceDelegator(product);
    }

    if (product.productType is FinishedProductType) {
      return FinishedProductPriceDelegator(product);
    }
    return null;
  }

  ScrollController scrollController;

  ///搭配精选
  List<ProductModel> mixedProductList;

  ///为你推荐
  List<ProductModel> recomendProductList;

  ///场景推荐
  List<DesignProductModel> sceneDesignProductList;

  ///软装方案
  List<DesignProductModel> softDesignProductList;

  Future loadData() {
    loadState = XLoadState.busy;

    return _repository
        .productDetail(params: {"goods_id": id, "go_selection": flag}).then(
            (ProductDetailModelWrapper wrapper) {
      loadState = XLoadState.idle;
      this.wrapper = wrapper;
      product = wrapper.product;
      mixedProductList = wrapper.mixedProductList;
      sceneDesignProductList = wrapper.sceneDesignProductList;
      softDesignProductList = wrapper.softDesignProductList;
      recomendProductList = wrapper.recommendedProductList;
      scrollController = ScrollController();
      product.detailImgList.forEach((e) {
        precacheImage(NetworkImage(e), Get.context);
      });

      if (product.productType is RollingCurtainProductType &&
          selectProductEvent != null) {
        selectProductEvent.orderProduct.measureData.hasChecked = true;
        if (Get.isRegistered<RoomAttrSelectorController>(tag: tag)) {
          Get.find<RoomAttrSelectorController>(tag: tag).disabled = true;
          Get.find<RoomAttrSelectorController>(tag: tag)
              .initWithMeasureData(selectProductEvent.orderProduct.measureData);
        }

        if (Get.isRegistered<RollingCurtainProductAttrsSelectorController>(
            tag: tag)) {
          Get.find<RollingCurtainProductAttrsSelectorController>(tag: tag)
              .disabled = true;
          Get.find<SizeSelectorController>(tag: tag)
              .initWithMeasureData(selectProductEvent.orderProduct.measureData);
        }
        if (Get.isRegistered<WindowPatternSelectorController>(tag: tag)) {
          Get.find<WindowPatternSelectorController>(tag: tag).disabled = true;
        }
      }
    }).catchError((err) {
      loadState = XLoadState.error;
    }).whenComplete(update);
  }

  bool _checkValidCustomer() {
    if (Get.find<CustomerProviderController>().isCustomerNull) {
      EasyLoading.showInfo("请先选择客户哦");
      Get.toNamed(BAppRoutes.customerEdit,
          arguments: ChooseCustomerEventModel(fromUrl: Get.currentRoute));
      throw false;
    }
    return true;
  }

  bool _checkValidSize() {
    // if (product.productType is RollingCurtainProductType) return true;
    if (!(product.productType is CurtainProductType)) return true;
    if (!Get.isRegistered<SizeSelectorController>(tag: tag) ||
        Get.find<SizeSelectorController>(tag: tag).isSizeNullOrEmpty) {
      EasyLoading.showInfo("请先填写测装数据哦");
      return false;
    }
    return true;
  }

  Future<BaseResponse> addMeasureData() {
    if (!_isValidInfo()) {
      scrollToTop();
      return Future.error(null);
    }
    EditMeasureDataParamsModel args = EditMeasureDataParamsModel(tag: tag);
    return _repository.addMeasureData(params: args.params);
  }

  bool _isValidInfo() {
    if (product.productType is FinishedProductType) {
      return _checkValidCustomer();
    }
    return _checkValidCustomer() && _checkValidSize();
  }

  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  Future buy() {
    if (product.productType is SectionalbarProductType) {
      if (GetUtils.isNullOrBlank(product.materialUsed)) {
        EasyLoading.showInfo("请输入型材用料哦");
        throw Future.value(false);
      }
    }
    if (!_isValidInfo()) {
      scrollToTop();
      throw Future.error(false);
    }
    if (product.productType is CurtainProductType) {
      return addMeasureData().then((BaseResponse response) {
        Get.toNamed(BAppRoutes.commitOrder,
            arguments: CommitOrderEvent(
                productList: adapt(measureId: "${response.data}"),
                orderType: OrderType.selectionOrder),
            preventDuplicates: false);
      });
    }

    return Future.value().then((value) {
      Get.toNamed(BAppRoutes.commitOrder,
          arguments: CommitOrderEvent(
              productList: adapt(measureId: "0"),
              orderType: OrderType.selectionOrder),
          preventDuplicates: false);
    });
  }

  Future addToCart() {
    AddToCartParamsModel args = AddToCartParamsModel(
        tag: tag, product: product, totalPrice: "${priceDelegator.totalPrice}");
    if (product.productType is SectionalbarProductType) {
      if (GetUtils.isNullOrBlank(product.materialUsed)) {
        EasyLoading.showInfo("请输入型材用料哦");
        throw Future.value(false);
      }
    }

    if (product.productType is CurtainProductType) {
      return addMeasureData().then((BaseResponse response) {
        // if (response == null) return;
        String measureId = "${response.data}";
        args.measureId = measureId;
        _sendAddToCartRequest(args);
      });
    }
    if (!_isValidInfo()) {
      scrollToTop();
      return Future.value(false);
    }
    return _sendAddToCartRequest(args);
  }

  Future _sendAddToCartRequest(AddToCartParamsModel arg) {
    return _repository
        .addToCart(params: arg.params)
        .then((BaseResponse response) {
      CustomerProviderController customerController =
          Get.find<CustomerProviderController>();
      customerController.updateCartCount("${response.data}");
    });
  }

  @override
  void onInit() {
    tag = Get.parameters["id"];
    if (Get.isRegistered<ProductRegisterController>()) {
      Get.find<ProductRegisterController>().pageManager.add(Get.currentRoute);
    }
    if (Get.arguments != null && Get.arguments is SelectProductEvent) {
      selectProductEvent = Get.arguments;
      scheduleMicrotask(() {
        if (Get.isRegistered<CraftAttrSelectorController>(tag: tag)) {
          Get.find<CraftAttrSelectorController>(tag: tag).filter(
              orbitType: getOrbitType(
                  selectProductEvent?.orderProduct?.measureData?.partType));
        }
      });
    }
    if (selectProductEvent != null) {
      CustomerModel customer = selectProductEvent.customer;
      Get.find<CustomerProviderController>().setCustomer(customer);
    }
    loadData();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController?.dispose();
    _onClose();
    super.onClose();
  }

  String id = Get.parameters["id"];
  bool get isForSelect => selectProductEvent != null;
  String get flag => isForSelect ? '1' : '0';
  String tag;
  List<GetxController> get attrControllerList => [
        Get.find<RoomAttrSelectorController>(tag: tag),
        Get.find<GauzeAttrSelectorController>(tag: tag),
        Get.find<CraftAttrSelectorController>(tag: tag),
        Get.find<SectionalbarAttrSelectorController>(tag: tag),
        Get.find<RibouxAttrSelectorController>(tag: tag),
        Get.find<SizeSelectorController>(tag: tag),
        Get.find<RibouxAttrSelectorController>(tag: tag),
        Get.find<WindowStyleSelectorController>(tag: tag)
      ];

  void _onClose() {
    attrControllerList?.forEach((e) {
      e?.onClose();
      e?.onDelete();
    });

    _onDelete();
  }

  void _onDelete({bool force = true}) {
    Get.delete<RoomAttrSelectorController>(tag: tag, force: force);
    Get.delete<AccessoryAttrSelectorController>(tag: tag, force: force);
    Get.delete<GauzeAttrSelectorController>(tag: tag, force: force);
    Get.delete<CraftAttrSelectorController>(tag: tag, force: force);
    Get.delete<SectionalbarAttrSelectorController>(tag: tag, force: force);
    Get.delete<RibouxAttrSelectorController>(tag: tag, force: force);
    Get.delete<ValanceAttrSelectorController>(tag: tag, force: force);
    Get.delete<WindowPatternSelectorController>(tag: tag, force: force);
    Get.delete<SizeSelectorController>(tag: tag, force: force);
    Get.delete<WindowStyleSelectorController>(tag: tag, force: force);
  }

  void updateTotalPrice() {
    update(["totalPrice"]);
  }

  String get _description {
    if (product.productType is SectionalbarProductType) {
      return "用料:${product.material}米";
    }
    if (product.productType is FinishedProductType) {
      return "${product.currentSpecOptionName}\n数量x${product.count}";
    }
    String description = "";

    for (GetxController e in attrControllerList) {
      if (e is RoomAttrSelectorController) {
        description += "${e?.value}、";
      }
      if (e is WindowStyleSelectorController) {
        String windowPattern = e?.style?.name;
        description += "$windowPattern、";
        String installMode = e?.currentInstallModeOption?.name;
        description += "$installMode、";
        WindowOpenModeOptionModel option = e?.currentOpenModeOption;
        description += "${option.name}、";
        if (!GetUtils.isNullOrBlank(option?.suboptionList)) {
          for (WindowSubopenModeModel mode in option?.suboptionList) {
            for (WindowSubopenModeOptionModel o in mode?.optionList)
              if (o.isChecked) {
                description += "${mode.title}:${o.name};";
              }
          }
        }
      }
      if (e is SizeSelectorController) {
        description += "宽:${e.widthM}米,";
        description += "高:${e.heightM}米,";
        description += "离地距离:${e.deltaY}cm,";
      }
    }
    return description;
  }

  List<ProductAttrAdapterModel> get _attrList {
    if (product.productType is FinishedProductType) return [];
    if (product.productType is RollingCurtainProductType) return [];
    List<ProductAttrAdapterModel> list = [];
    for (GetxController e in attrControllerList) {
      if (e is BaseAttrSelectorController &&
          !(e is RoomAttrSelectorController)) {
        list.add(ProductAttrAdapterModel.fromJson(
            {"attr_category": e?.attr?.typeName, "attr_name": e?.value}));
      }
    }
    return list;
  }

  ///模型适配转换
  List<ProductAdapterModel> adapt({@required String measureId}) {
    CurtainProductAtrrParamsModel attr =
        CurtainProductAtrrParamsModel(tag: tag);

    Map json = {
      "type": product.type,
      "id": product.id,
      "name": product.name,
      "room": selectorController?.room?.currentOptionName,
      "price": product.price,
      "attr_list": _attrList,
      "description": _description,
      "total_price": priceDelegator.totalPrice,
      "image": product.cover,
      "measure_id": measureId,
      "sku_id": product.skuId,
      "material": product.material,
      "count": product.count,
      "attribute": jsonEncode(attr?.params)
    };
    return [ProductAdapterModel.fromJson(json)];
  }

  Future selectProduct() {
    if (!selectProductEvent.orderProduct.measureData.hasChecked) {
      EasyLoading.showInfo("请先确认测装数据哦");
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 375), curve: Curves.ease);
      throw Future.value(false);
    }
    return Get.find<OrderDetailController>().select(
        productId: tag,
        orderProductId: selectProductEvent.orderProduct.id,
        measureData: selectProductEvent.orderProduct.measureData);
  }
}
