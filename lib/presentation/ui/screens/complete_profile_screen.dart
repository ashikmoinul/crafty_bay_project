import 'package:crafty_bay_project/presentation/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              AppLogoWidget(),
              SizedBox(
                height: 16,
              ),
              Text(
                'Complete Profile',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Get Started with us by providing your information',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black54),
              ),
              SizedBox(height: 10),
              TextFormField(
        
                decoration: InputDecoration(hintText: 'First Name'),
              ),
              SizedBox(height: 10),
                TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'Last Name'),
              ),
              SizedBox(height: 10),
                TextFormField(
                  textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Mobile'),
              ),
              SizedBox(height: 10),
                TextFormField(
                  textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'City'),
              ),
              SizedBox(height: 10),
                TextFormField(
                maxLines: 4,
                decoration: InputDecoration(hintText: 'Shipping Address'),
              ),
        
              const SizedBox(height: 12,),
              ElevatedButton(
                onPressed:() {},
                child: const Text('Complete'),
              ),
            ],
          ),
        ),
      ),
    );

  }




  @override
  void dispose() {
    super.dispose();

    // TODO: implement dispose

  }
}
