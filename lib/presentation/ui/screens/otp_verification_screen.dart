import 'package:crafty_bay_project/presentation/ui/screens/complete_profile_screen.dart';
import 'package:crafty_bay_project/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(
                height: 88,
              ),
              AppLogoWidget(),
              SizedBox(
                height: 16,
              ),
              Text(
                'OTP Code',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'A 4 digit OTP has been sent to your email',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 16),
              PinCodeTextField(
                keyboardType: TextInputType.number,
                length: 6,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  selectedColor: AppColors.themeColor,
                  inactiveFillColor: Colors.white,
                  inactiveColor: AppColors.themeColor,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                controller: _otpTEController,
                appContext: context,
              ),
              const SizedBox(
                height: 2,
              ),
              ElevatedButton(
                onPressed: _onTapNextButton,
                child: const Text('Next'),
              ),
              SizedBox(
                height: 16,
              ),
              RichText(
                text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey),
                    text: 'The code will be expire in',
                    children: [
                      TextSpan(
                        text: ' 120s',
                        style: TextStyle(
                          color: AppColors.themeColor,
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: 2,),
              TextButton(onPressed: () {}, child: Text('Resend Code'),),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapNextButton() {
    Get.to(() => const CompleteProfileScreen());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _otpTEController.dispose();
  }
}
