/*
 * @Description: 商品详情数据模型
 * @Author: iamsmiling
 * @Date: 2020-12-21 14:44:38
 * @LastEditTime: 2021-01-25 09:49:04
 */

import 'package:get/utils.dart';
import 'package:taoju5/bapp/domain/model/product/product_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_type.dart';
import 'package:taoju5/bapp/interface/i_xselectable.dart';
import 'package:taoju5/utils/json_kit.dart';

import 'abstract_product_model.dart';
import 'design_product_model.dart';

class ProductDetailModelWrapper {
  ProductDetailModel product;
  String mainImg;

  List<ProductModel> mixedProductList;
  List<ProductModel> recommendedProductList;

  ///场景推荐
  List<DesignProductModel> sceneDesignProductList;

  ///软装方案
  List<DesignProductModel> softDesignProductList;
  ProductDetailModelWrapper.fromJson(Map json) {
    product = ProductDetailModel.fromJson(json['goods_detail']);
    mainImg = JsonKit.asWebUrl(json["scenes_list_img"]);
    mixedProductList = JsonKit.asList(json["related_goods"])
        .map((e) => ProductModel.fromJson(e))
        .toList();
    sceneDesignProductList = JsonKit.asList(json["scenes_list"])
        .map((e) => DesignProductModel.fromJson(e))
        .toList();
    softDesignProductList = JsonKit.asList(json["soft_project_list"])
        .map((e) => DesignProductModel.fromJson(e))
        .toList();
    recommendedProductList = JsonKit.asList(json["referrals_goods"])
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}

class ProductMaterialFunctionInfoModel {
  int id;
  String key;
  String value;

  ProductMaterialFunctionInfoModel.fromJson(Map json) {
    id = json["attr_value_id"];
    key = json["attr_value"];
    value = json["attr_value_name"];
  }
}

class ProductDetailModel implements AbstractProdductModel {
  ProductDetailModel();
  int id;
  String name;
  String fullName;
  int shopId;
  int isCollect;

  //0  成品  1 布艺帘  2卷帘
  int type;
  double marketPrice;
  double price;

  String unit;
  List<String> imgList;
  String skuId;
  String skuName;
  int defalutSkuId;
  String picture;
  var picId;
  int count = 1;
  String cover;
  List<String> detailImgList;
  bool isChecked = true;
  num width;
  num height;

  bool isFixedHeight; // 窗帘是否定高
  bool isFixedWidth; //窗帘是否定宽
  bool isCustomSize; //自定义宽高

  double doorWidth; //门幅
  double flowerSize; //花距
  bool hasFlower; // 窗帘是否有拼花

  String materialUsed;
  String material;

  List<ProductSpecModel> specList;
  List<ProductSkuModel> skuList;
  List<ProductMaterialModel> materialList;

  String _currentSpecOptionName;

  ProductDetailModel.fromJson(Map json) {
    id = json['goods_id'];

    name = json['goods_name'];
    fullName = json['show_name'];
    shopId = json['shop_id'];
    isCollect = json['is_collect'];
    type = json['goods_type'];
    picId = json['picture'];
    specList = JsonKit.asList(json["spec_list"])
        .map((e) => ProductSpecModel.fromJson(e))
        .cast<ProductSpecModel>()
        .toList();
    skuList = JsonKit.asList(json["sku_list"])
        .map((e) => ProductSkuModel.fromJson(e))
        .cast<ProductSkuModel>()
        .toList();
    marketPrice = JsonKit.asDouble(json['market_price']);
    price = JsonKit.asDouble(json['price']);
    unit = json["goods_unit"];
    imgList = JsonKit.asList(json['goods_img_list'])
        .map((e) => JsonKit.asWebUrl(
            JsonKit.getValueByKey(e, 'pic_cover_long').toString()))
        .toList();
    cover = JsonKit.getValueByKey(json['picture_info'], 'pic_cover_small') ??
        JsonKit.asWebUrl(json['image'] ?? imgList?.first);
    materialList = JsonKit.asList(json['goods_attribute_list'])
        .map((e) => ProductMaterialModel.fromJson(e))
        ?.toList();
    skuId = "${json['sku_id']}";
    skuName = json['sku_name'];
    detailImgList = json["new_description"]?.cast<String>();
    isFixedHeight = json['fixed_height'] == 1;
    isFixedWidth = json['fixed_height'] == 2;
    isCustomSize = json['fixed_height'] == 3;

    ///后台数据以cm为单位,在这里进行单位转换
    doorWidth = (JsonKit.asDouble(json['larghezza_size']) / 100);
    flowerSize = (JsonKit.asDouble(json['flower_distance']) / 100);

    hasFlower = json['is_flower'] == 1;
    materialUsed = json["material"];
  }
}

extension ProductDetailModelKit on ProductDetailModel {
  BaseProductType get productType => getProductType(type);

  set currentSpecOptionName(String val) {
    _currentSpecOptionName = val;
  }

  String get currentSpecOptionName =>
      _currentSpecOptionName ??
      specList?.map((e) => e?.currentOption?.name ?? "")?.join(",") ??
      "";

  String get tip {
    if (productType is SectionalbarProductType) {
      if (GetUtils.isNullOrBlank(materialUsed)) return "请输入型材用料";
      return "已选:用料$materialUsed米";
    }
    if (GetUtils.isNullOrBlank(specList)) return "已选:数量x$count";
    return "已选:$currentSpecOptionName 数量x$count";
  }

  int get colorCount {
    String keyword = "颜色";
    ProductSpecModel color = specList?.firstWhere(
        (e) => e.name.contains(keyword) || keyword.contains(e.name),
        orElse: () => null);
    return color?.optionList?.length ?? 0;
  }

  ProductSkuModel get currentSku {
    List<String> list = [];
    for (ProductSpecModel spec in specList) {
      for (ProductSpecOptionModel option in spec.optionList) {
        if (option.isChecked) {
          list.add(option.name);
        }
      }
    }
    String key = list.join(" ");
    return skuList?.firstWhere(
        (e) => e.name.contains(key) || key.contains(e.name),
        orElse: () => null);
  }

  Map toJson() => {
        "sku_id": currentSku?.id ?? skuId,
        "goods_id": id,
        "goods_name": name,
        "shop_id": shopId,
        "price": price,
        "picture": currentSku?.picId ?? picId,
        "num": count,
        "material": material
      };
}

class ProductSpecModel {
  String name;
  String id;
  String type;
  bool isMultiple = false;

  List<ProductSpecOptionModel> optionList;

  ProductSpecModel.fromJson(Map json) {
    id = json["spec_id"];
    name = json["spec_name"];
    optionList = JsonKit.asList(json['value'])
        .map((e) => ProductSpecOptionModel.fromJson(e))
        .cast<ProductSpecOptionModel>()
        .toList();
  }
}

class ProductMaterialModel {
  int id;
  String key;
  String value;
  ProductMaterialModel.fromJson(Map<String, dynamic> json) {
    id = json['attr_value_id'];
    key = json['attr_value'];
    value = json['attr_value_name'];
  }
}

extension ProductSpecModelKit on ProductSpecModel {
  ProductSpecOptionModel get currentOption {
    if (GetUtils.isNullOrBlank(optionList)) return null;
    return optionList.firstWhere((e) => e.isChecked, orElse: () => null);
  }
}

class ProductSpecOptionModel implements IXSelectable {
  String id;
  String optionId;
  String desc;
  String name;

  @override
  bool isChecked;

  ProductSpecOptionModel.fromJson(Map json) {
    id = json['spec_id'];
    optionId = json['spec_value_id'];
    desc = json['spec_name'];
    name = json['spec_value_name'];
    isChecked = json['selected'];
  }
}

class ProductSkuModel {
  int id;
  String name;
  String marketPrice;
  double price;
  String image;
  int picId;
  int productId;
  int count;

  ProductSkuModel.fromJson(Map json) {
    name = json["sku_name"];
    image = JsonKit.asWebUrl(
        JsonKit.getValueInComplexMap(json, ["sku_img_main", "pic_cover"]));
    price = JsonKit.asDouble(json["price"]);
    marketPrice = json['market_price'];
    id = json["sku_id"];
    picId = json["picture"];
    count = 1;
  }
}
