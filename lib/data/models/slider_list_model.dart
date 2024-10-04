import 'package:crafty_bay_project/data/models/slider_model.dart';

class SliderListModel {
  String? msg;
  List<CategoryModel>? sliderList;

  SliderListModel({this.msg, this.sliderList});

  SliderListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      sliderList = <CategoryModel>[];
      json['data'].forEach((v) {
        sliderList!.add(CategoryModel.fromJson(v));
      });
    }
  }

}

