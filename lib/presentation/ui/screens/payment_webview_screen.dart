import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../data/models/payment_mode.dart';
import '../../state_holders/payment_webview_controller.dart';
import '../utils/payment_webview_string.dart';
import '../widgets/webview_status.dart';


class PaymentWebView extends StatefulWidget {
  final PaymentMethod paymentMethod;

  const PaymentWebView({super.key, required this.paymentMethod});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 5,
      ),
      body: GetBuilder<PaymentWebViewState>(
        builder: (paymentWebViewState) {
          if (paymentWebViewState.isPaymentPending) {
            return PopScope(
              canPop: false,
              child: WebViewWidget(
                controller: paymentWebViewState.configureController(
                  widget.paymentMethod,
                ),
              ),
            );
          }
          if (paymentWebViewState.isPaymentSuccess) {
            if (paymentWebViewState.isBusy) {
              return Center(
                child: Lottie.asset(AppAssets.cartLottie, width: 80),
              );
            }
            return PaymentStatus(
              //payment success
              animationAsset: AppAssets.paymentSuccess,
              headerText: PaymentWebViewStrings.paymentSuccessfulHeaderText,
              subtitleText: PaymentWebViewStrings.paymentSuccessfulSubtitleText,
            );
          }
          return PaymentStatus(
            //payment failed
            animationAsset: AppAssets.paymentFailure,
            headerText: PaymentWebViewStrings.paymentFailureHeaderText,
            subtitleText: PaymentWebViewStrings.paymentFailureSubtitleText,
          );
        },
      ),
    );
  }
}