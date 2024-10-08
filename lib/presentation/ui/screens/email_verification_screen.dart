import 'package:crafty_bay_project/presentation/state_holders/email_verification_controller.dart';
import 'package:crafty_bay_project/presentation/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_project/presentation/ui/utils/snack_message.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/app_logo_widget.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final EmailVerificationController _emailVerificationController =
      Get.find<EmailVerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formkey,
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
                'Welcome Back',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Please enter your email address,',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black54),
              ),
              SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailTEController,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (String? value) {
                  //TODO: verify valid email by regex
                  if (value?.isEmpty ?? true) {
                    return 'Enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder<EmailVerificationController>(
                builder: (emailVerificationController) {
                  return Visibility(
                    visible: !emailVerificationController.inProgress,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapNextButton,
                      child: const Text('Next'),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }

    bool result = await _emailVerificationController
        .verifyEmail(_emailTEController.text.trim());
    if (result) {
      Get.to(() => OtpVerificationScreen(email: _emailTEController.text.trim(),));
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, _emailVerificationController.errorMessage!, true);
      }
    }

    @override
    void dispose() {
      super.dispose();
      _emailTEController.dispose();
    }
  }
}
