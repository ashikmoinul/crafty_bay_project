import 'package:crafty_bay_project/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/cart/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holders/bottom_nav_bar_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        backToHome();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text('Cart'),
          leading: IconButton(
            onPressed: backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const CartItemWidget();
                },
                // separatorBuilder: (_, __) => const SizedBox(
                //   height: 8,
                // ),
              ),
            ),
            _buildPriceAndAddToCartSection()
          ],
        ),
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Price'),
              Text(
                '\$1000',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
              width: 140,
              child: ElevatedButton(onPressed: () {}, child: Text('Checkout')))
        ],
      ),
    );
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
