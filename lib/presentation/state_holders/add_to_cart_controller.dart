import 'package:crafty_bay_project/data/models/network_response.dart';
import 'package:crafty_bay_project/data/services/network_caller.dart';
import 'package:crafty_bay_project/data/utils/urls.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> addToCart(
      int productId, String color, String size, int quantity) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.addToCartUrl, body: {
      "product_id": productId,
      "color": color,
      "size": size,
      "qty": quantity,
    });

    if (response.isSuccess && response.responseData['msg'] == 'success') {
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
