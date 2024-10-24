
import 'package:get/get.dart';

import '../../data/models/payment_mode.dart';

class InvoiceCreationState extends GetxController {
  late Object _response;
  List<PaymentMethod> _paymentMethodsMobile = [];
  List<PaymentMethod> _paymentMethodsInternet = [];
  List<PaymentMethod> _paymentMethodsCard = [];
  bool _isBusy = false;
  int _totalPayable = 0;
  Map<PaymentType, int> _selectedPaymentIndex = {};

  bool get isBusy => _isBusy;

  Object get response => _response;

  int getSelectedPaymentIndex(PaymentType paymentType) {
    return _selectedPaymentIndex[paymentType] ?? -1;
  }

  PaymentMethod getSelectedPaymentInfo() {
    late PaymentType paymentType;
    late int index;
    _selectedPaymentIndex.forEach((key, value) {
      paymentType = key;
      index = value;
    });
    if (paymentType == PaymentType.mobileBanking) {
      return _paymentMethodsMobile[index];
    } else if (paymentType == PaymentType.internetBanking) {
      return _paymentMethodsInternet[index];
    }
    return _paymentMethodsCard[index];
  }

  bool isSelectedPaymentIndexEmpty() => _selectedPaymentIndex.isEmpty;

  List<PaymentMethod> get paymentMethodsMobile => _paymentMethodsMobile;

  List<PaymentMethod> get paymentMethodsInternet => _paymentMethodsInternet;

  List<PaymentMethod> get paymentMethodsCard => _paymentMethodsCard;

  int get totalPayable => _totalPayable;

  set setIsBusy(bool isBusy) {
    _isBusy = isBusy;
    update();
  }

  void setSelectedPaymentIndex(int index, PaymentType paymentType) {
    resetPaymentSelection();
    _selectedPaymentIndex[paymentType] = index;
    update();
  }

  void resetPaymentSelection() {
    _selectedPaymentIndex.clear();
  }

  Future<bool> createInvoice(String token) async {
    bool _responseStatus = false;
    setIsBusy = true;
    _response = await InvoiceService().createInvoice(token);
    if (_response is Success) {
      await loadPaymentMethods(_response);
      _responseStatus = true;
    }
    setIsBusy = false;
    return _responseStatus;
  }

  Future<void> loadPaymentMethods(Object response) async {
    clearAllPaymentMethods();
    Map<String, dynamic> jsonData =
    (response as Success).response as Map<String, dynamic>;
    CreateInvoiceModel createInvoiceModel =
    CreateInvoiceModel.fromJson(jsonData);
    _totalPayable = createInvoiceModel.invoiceCreateData![0].payable!;
    for (PaymentMethod paymentMethod
    in createInvoiceModel.invoiceCreateData![0].paymentMethod!) {
      if (paymentMethod.type == PaymentType.mobileBanking.name.toLowerCase()) {
        _paymentMethodsMobile.add(paymentMethod);
      } else if (paymentMethod.type ==
          PaymentType.internetBanking.name.toLowerCase()) {
        _paymentMethodsInternet.add(paymentMethod);
      } else {
        _paymentMethodsCard.add(paymentMethod);
      }
    }
  }

  void clearAllPaymentMethods() {
    _paymentMethodsMobile.clear();
    _paymentMethodsInternet.clear();
    _paymentMethodsCard.clear();
  }
}