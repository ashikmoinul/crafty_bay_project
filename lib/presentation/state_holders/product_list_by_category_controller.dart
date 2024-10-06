import 'package:crafty_bay_project/data/models/network_response.dart';
import 'package:crafty_bay_project/data/models/product_list_model.dart';
import 'package:crafty_bay_project/data/models/product_model.dart';
import 'package:crafty_bay_project/data/services/network_caller.dart';
import 'package:crafty_bay_project/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductListByCategoryController extends GetxController {
  // progress
  bool _inProgress = false;

  // progress getter method
  bool get inProgress => _inProgress;


  //list of product
  List<ProductModel> _productList = [];

  //expose the list
  List<ProductModel> get productList => _productList;

  //errorMessage
  String? _errorMessage;

  //getter method for errorMessage
  String? get errorMessage => _errorMessage;

  //API Call
  Future<bool> getProductListByCategory(int categoryId) async {
    bool isSuccess = false;
    _inProgress = true;

    update();

    //Api call response
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productListByCategory(categoryId),
    );

    if (response.isSuccess) {
      _productList =
          ProductListModel.fromJson(response.responseData).productList ?? [];
      isSuccess = true;
      _errorMessage = null;

      // Error message set for response
    } else {
    _errorMessage = response.errorMessage;
    }
    // In Progress stop
    _inProgress = false;
    update();
    return isSuccess;
  }
}
