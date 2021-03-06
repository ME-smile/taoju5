/*
 * @Description: ๅๅๅ่กจ
 * @Author: iamsmiling
 * @Date: 2020-12-21 10:28:50
 * @LastEditTime: 2021-01-25 09:44:56
 */
import 'package:taoju5/bapp/domain/model/product/cart_product_model.dart';
import 'package:taoju5/bapp/domain/model/product/design_product_detail_model.dart';
import 'package:taoju5/bapp/domain/model/product/design_product_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_collection_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_detail_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_filter_tag_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_model.dart';
import 'package:taoju5/bapp/domain/model/product/product_tab_model.dart';
import 'package:taoju5/bapp/domain/provider/product/product_api.dart';
import 'package:taoju5/utils/json_kit.dart';
import 'package:taoju5/xdio/x_dio.dart';

class ProductRepository {
  final ProductAPI _api = ProductAPI();

  Future<BaseResponse> categoryList({Map params}) {
    return _api.categoryList("/api/goods/getGoodsCategory");
  }

  Future<ProductModelListWrapper> productList({Map params}) {
    return _api
        .productList("/api/goods/goodsListByConditions", params: params)
        .then((BaseResponse response) {
      if (response.isValid) {
        return ProductModelListWrapper.fromJson(response.data);
      }
      throw Future.error(response.message);
    }).catchError((err) {
      throw err;
    });
  }

  Future<ProductDetailModelWrapper> productDetail({Map params}) => _api
          .productDetail("/api/goods/goodsDetail", params: params)
          .then((BaseResponse response) {
        if (response.isValid) {
          return ProductDetailModelWrapper.fromJson(response.data);
        }
        throw Exception(response.message);
      }).catchError((err) {
        throw err;
      });
  Future<ProductDetailModelWrapper> productWebDetail({Map params}) => _api
          .productDetail("/api/goods/goodsDetailForWeb", params: params)
          .then((BaseResponse response) {
        if (response.isValid) {
          return ProductDetailModelWrapper.fromJson(response.data);
        }
        throw Exception(response.message);
      }).catchError((err) {
        throw err;
      });
  Future<BaseResponse> productShare({Map params}) => _api
          .productDetail("/api/goods/goodsShare", params: params)
          .then((BaseResponse response) async {
        if (response.isValid) {
          return response;
        }
        throw Exception(response.message);
      }).catchError((err) {
        throw err;
      });

  ///่ดญ็ฉ่ฝฆๆฐ้
  Future<BaseResponse> cartCount({Map params}) {
    return _api.cartCount("/api/goods/cartCount", params: params);
  }

  Future<CartPorductModelListWrapper> cartList({Map params}) {
    return _api
        .cartList("/api/goods/cartList", params: params)
        .then((BaseResponse response) {
      if (response.isValid) {
        return CartPorductModelListWrapper.fromJson(response.data);
      }
      throw Future.error(response.message);
    }).catchError((err) {
      throw err;
    });
  }

  Future<BaseResponse> modifyProductAttr({Map params}) {
    return _api.modifyProductAttr("/api/goods/modifyCartAccessory",
        params: params);
  }

  Future<ProductFilterTagModelListWrapper> filterTag({Map params}) {
    return _api
        .cartList("/api/goods/filtrateTag", params: params)
        .then((BaseResponse response) {
      if (response.isValid) {
        return ProductFilterTagModelListWrapper.fromJson(response.data);
      }
      throw Future.error(response.message);
    }).catchError((err) {
      throw err;
    });
  }

  //// {'scenes_id': widget.scenesId
  Future<DesignProductDetailModelWrapper> sceneDesignProductDetail(
      {Map params}) {
    return _api
        .cartList("/api/goods/scenesDetail", params: params)
        .then((BaseResponse response) {
      if (response.isValid) {
        return DesignProductDetailModelWrapper.fromJson(response.data);
      }
      throw Future.error(response.message);
    }).catchError((err) {
      throw err;
    });
  }

  ///่ฝฏ่ฃๆนๆก่ฏฆๆ
  Future<DesignProductModel> softDesignProductDetail({Map params}) {
    return _api
        .softDesignProductDetail(params: params)
        .then((BaseResponse response) {
      return DesignProductModel.fromJson(response.data);
    });
  }

  //// {'scenes_id': widget.scenesId
  Future<List<DesignProductModel>> softDesignProducList({Map params}) {
    return _api
        .softDesignProductList(params: params)
        .then((BaseResponse response) {
      return response.data
          .map((e) => DesignProductModel.fromJson(e))
          .toList()
          .cast<DesignProductModel>();
    });
  }

  Future<BaseResponse> isLiked({Map params}) {
    return _api.isLiked("/api/goods/whetherCollection", params: params);
  }

  Future<BaseResponse> like({Map params}) {
    return _api.like("/api/member/addCollection", params: params);
  }

  Future<BaseResponse> dislike({Map params}) {
    return _api.dislike("/api/member/cancelCollection", params: params);
  }

  Future<BaseResponse> scanFromCode({Map params}) {
    return _api.scanFromCode("/api/goods/scanqrcode", params: params);
  }

  Future<BaseResponse> addToCart({Map params}) {
    return _api.addToCart("/api/goods/addCart", params: params);
  }

  ///ๆทปๅ?ๆต่ฃๆฐๆฎ
  Future<BaseResponse> addMeasureData({Map params}) {
    return _api.addMeasureData("/api/order/saveMeasure", params: params);
  }

  ///ไป่ดญ็ฉ่ฝฆไธญ็งป้ค
  Future<BaseResponse> removeFromCart({Map params}) {
    return _api.removeFromCart("/api/goods/deleteCart", params: params);
  }

  ///่ทๅๆถ่ๅ่กจ
  Future<List<ProductCollectionModel>> collection({Map params}) =>
      _api.collection(params: params).then((BaseResponse response) {
        return response.data["data"]
            .map((e) => ProductCollectionModel.fromJson(e))
            .toList()
            .cast<ProductCollectionModel>();
      });

  ///ไปๆถ่ๅ่กจไธญๅ?้ค
  Future<BaseResponse> removeFromCollection({Map params}) =>
      _api.removeFromCollection(params: params);

  ///ไฟฎๆน่ดญ็ฉ่ฝฆๅๅๆฐ้
  Future<BaseResponse> modifyProuductCountInCart({Map params}) =>
      _api.modifyProuductCountInCart(params: params);

  ///่ทๅ่ดญ็ฉ่ฝฆๅ็ฑป
  Future<List<ProductTabModel>> cartCategory({Map params}) =>
      _api.cartCategory(params: params).then((BaseResponse response) {
        return JsonKit.asList(response.data)
            .map((e) => ProductTabModel.fromJson(e))
            .toList()
            .cast<ProductTabModel>();
      });

  ///ไฟฎๆน่ดญ็ฉ่ฝฆๆๅๅฑๆง
  Future<BaseResponse> modifyProuductAttrInCart({Map params}) =>
      _api.modifyProuductAttrInCart(params: params);

  ///่ฝฏ่ฃๆนๆก ๅบๆฏ่ฎพ่ฎกๅ?ๅฅ่ดญ็ฉ่ฝฆ
  Future<BaseResponse> addDesignProductToCart({Map params}) =>
      _api.addDesignProductToCart(params: params);
}
