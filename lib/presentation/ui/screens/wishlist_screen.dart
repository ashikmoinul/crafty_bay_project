import 'package:crafty_bay_project/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        backToHome();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Wishlist'),

            leading: IconButton(

              onPressed: backToHome,
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8),
              itemBuilder: (context, index) {
                //return const ProductCard();
              })),
    );
  }

  void backToHome(){
    Get.find<BottomNavBarController>().backToHome();
  }

}
