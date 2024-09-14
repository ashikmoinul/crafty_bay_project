import 'package:crafty_bay_project/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value){
        backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          leading: IconButton(
            onPressed: backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 0.75),
            itemBuilder: (context, index) {
              return CategoryCard();
            }),
      ),
    );

  }
  void backToHome(){
    Get.find<BottomNavBarController>().backToHome();
  }
}
