import 'package:crafty_bay_project/data/models/network_response.dart';
import 'package:crafty_bay_project/data/services/network_caller.dart';
import 'package:crafty_bay_project/data/utils/urls.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(String email, String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.verifyOtp(email, otp),
    );

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
