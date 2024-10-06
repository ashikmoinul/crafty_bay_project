import 'package:crafty_bay_project/data/models/network_response.dart';
import 'package:crafty_bay_project/data/models/product_details_model.dart';
import 'package:crafty_bay_project/data/models/product_list_model.dart';
import 'package:crafty_bay_project/data/models/product_model.dart';
import 'package:crafty_bay_project/data/services/network_caller.dart';
import 'package:crafty_bay_project/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  // progress
  bool _inProgress = false;

  // progress getter method
  bool get inProgress => _inProgress;


  //list of product
  ProductDetailsModel? _productModel;

  //expose the list
  ProductDetailsModel? get product => _productModel;

  //errorMessage
  String? _errorMessage;

  //getter method for errorMessage
  String? get errorMessage => _errorMessage;

  //API Call
  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    _inProgress = true;

    update();

    //Api call response
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productListByID(productId),
    );

    if (response.isSuccess) {
      _productModel = ProductDetailsModel.fromJson(response.responseData['data'][0]);
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
