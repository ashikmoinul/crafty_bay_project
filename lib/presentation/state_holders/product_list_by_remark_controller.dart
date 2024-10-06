import 'package:crafty_bay_project/data/models/network_response.dart';
import 'package:crafty_bay_project/data/models/product_list_model.dart';
import 'package:crafty_bay_project/data/models/product_model.dart';
import 'package:crafty_bay_project/data/services/network_caller.dart';
import 'package:crafty_bay_project/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductListByRemarkController extends GetxController {
  // three progress
  bool _popularProductInProgress = false;
  bool _newProductInProgress = false;
  bool _specialProductInProgress = false;

  // progress getter method
  bool get popularProductInProgress => _popularProductInProgress;
  bool get netProductInProgress => _newProductInProgress;
  bool get specialProductInProgress => _specialProductInProgress;

  //list of product
  List<ProductModel> _popularProductList = [];
  List<ProductModel> _newProductList = [];
  List<ProductModel> _specialProductList = [];

  //expose the list
  List<ProductModel> get popularProductList => _popularProductList;
  List<ProductModel> get newProductList => _popularProductList;
  List<ProductModel> get specialProductList => _popularProductList;

  //errorMessage
  String? _popularErrorMessage;
  String? _newErrorMessage;
  String? _specialErrorMessage;

  //getter method for errorMessage
  String? get popularErrorMessage => _popularErrorMessage;
  String? get newErrorMessage => _newErrorMessage;
  String? get specialErrorMessage => _specialErrorMessage;

  //API Call
  Future<bool> getProductByRemark(String remark) async {
    bool isSuccess = false;
    if (remark == 'popular') {
      _popularProductInProgress = true;
    } else if (remark == 'new') {
      _newProductInProgress = true;
    } else {
      _specialProductInProgress = true;
    }
    update();

    //Api call response
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productListByRemark(remark),
    );

    if (response.isSuccess) {
      if (remark == 'popular') {
        _popularErrorMessage = null; // if error message being null
        _popularProductList =
            ProductListModel.fromJson(response.responseData).productList ?? [];
      } else if (remark == 'new') {
        _newErrorMessage = null;
        _newProductList =
            ProductListModel.fromJson(response.responseData).productList ?? [];
      } else {
        _specialErrorMessage = null;
        _specialProductList =
            ProductListModel.fromJson(response.responseData).productList ?? [];
      }
      isSuccess = true;

      // Error message set for response
    } else {
      if (remark == 'popular') {
        _popularErrorMessage = response.errorMessage;
      } else if (remark == 'new') {
        _newErrorMessage = response.errorMessage;
      } else {
        _specialErrorMessage = response.errorMessage;
      }
    }
    // In Progress stop
    if (remark == 'popular') {
      _popularProductInProgress = false;
    } else if (remark == 'new') {
      _newProductInProgress = false;
    } else {
      _specialProductInProgress = false;
    }

    update();
    return isSuccess;
  }
}
