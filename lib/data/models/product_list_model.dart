import 'package:crafty_bay_project/data/models/product_model.dart';

class ProductListModel {
  String? msg;
  List<ProductModel>? productList;

  ProductListModel({this.msg, this.productList});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productList = <ProductModel>[];
      json['data'].forEach((v) {
        productList!.add(ProductModel.fromJson(v));
      });
    }
  }

// class Category {
//   int? id;
//   String? categoryName;
//   String? categoryImg;
//   String? createdAt;
//   String? updatedAt;
//
//   Category(
//   {this.id,
//   this.categoryName,
//   this.categoryImg,
//   this.createdAt,
//   this.updatedAt});
//
//   Category.fromJson(Map<String, dynamic> json) {
//   id = json['id'];
//   categoryName = json['categoryName'];
//   categoryImg = json['categoryImg'];
//   createdAt = json['created_at'];
//   updatedAt = json['updated_at'];
//   }
}
