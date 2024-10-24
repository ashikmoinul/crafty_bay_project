import 'package:crafty_bay_project/data/utils/urls.dart';

class InvoiceService extends NetworkRepository {
  static InvoiceService? _instance;

  InvoiceService._();

  factory InvoiceService() => _instance ??= InvoiceService._();

  Future<Object> createInvoice(String token) async {
    return getRequest(
      url: Urls.createInvoice,
      headers: {
        "token": token,
      },
    );
  }
}