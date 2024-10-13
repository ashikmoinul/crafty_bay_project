import 'package:crafty_bay_project/data/models/network_response.dart';
import 'package:crafty_bay_project/data/services/network_caller.dart';
import 'package:crafty_bay_project/data/utils/urls.dart';
import 'package:crafty_bay_project/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {
  // progress
  bool _inProgress = false;

  // globally exposed
  bool _isProfileCompleted = false;

  // progress getter method
  bool get inProgress => _inProgress;

  // progress getter method
  bool get isProfileCompleted => _isProfileCompleted;


  //errorMessage
  String? _errorMessage;

  //getter method for errorMessage
  String? get errorMessage => _errorMessage;

  //API Call
  Future<bool> getProfileDetails(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    

      update();

    //Api call response
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.readProfileUrl,
      token: token,
    );

    if (response.isSuccess) {

      if(response.responseData['data'] != null){
        _isProfileCompleted == true;
        await Get.find<AuthController>().saveAccessToken(token);
      }
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
