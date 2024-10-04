import 'package:crafty_bay_project/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay_project/presentation/state_holders/slider_list_controller.dart';
import 'package:crafty_bay_project/presentation/ui/screens/category_list_screen.dart';
import 'package:crafty_bay_project/presentation/ui/utils/assets_path.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/home/horizontal_category_list_view.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/home/horizontal_product_list_view.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/home/search_text_field.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/home/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../widgets/home/app_bar_icon_button.dart';
import '../widgets/home_banner_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<SliderListController>().getSliderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16,),
                SearchTextField(textEditingController: TextEditingController(),),
                const SizedBox(height: 16,),
                const HomeBannerSlider(),
                const SizedBox(height: 16,),
                _buildCategoriesSection(),
                const SizedBox(height: 16,),
                _buildPopularProductsSection(),
                const SizedBox(height: 16,),
                _buildNewProductsSection(),
                const SizedBox(height: 16,),
                _buildSpecialProductsSection(),

              ],
            ),
          ),
        ),
      );
  }

  Widget _buildPopularProductsSection(){
    return Column(
      children: [
        SectionHeader(
          title: 'Popular',
          onTap: () {},
        ),
        SizedBox(
            height: 200,
            child:  HorizontalProductListView(),
        ),
      ],
    );
  }

  Widget _buildNewProductsSection(){
    return Column(
      children: [
        SectionHeader(
          title: 'New',
          onTap: () {},
        ),
        SizedBox(
            height: 200,
            child:  HorizontalProductListView(),
        ),
      ],
    );
  }

  Widget _buildSpecialProductsSection(){
    return Column(
      children: [
        SectionHeader(
          title: 'Special',
          onTap: () {
            Get.find<BottomNavBarController>().selectCategory();
          },
        ),
        SizedBox(
            height: 200,
            child: HorizontalProductListView(),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
            children: [
              SectionHeader(
                title: 'Categories',
                onTap: () {
                  Get.to(() => const CategoryListScreen());
                },
              ),
              const SizedBox(height: 8,),
              SizedBox(
                height: 105,
                child: HorizontalCategoryListView(),
              ),
            ],
          );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: SvgPicture.asset(AssetsPath.appLogoNav),
      actions: [
        AppBarIconButton(
          iconData: Icons.person,
          onTap: () {  },

        ),const SizedBox(width: 8,),
        AppBarIconButton(
          iconData: Icons.call,
          onTap: () {  },

        ),const SizedBox(width: 8,),
        AppBarIconButton(
          iconData: Icons.notifications_active,
          onTap: () {  },

        )
      ],
    );
  }
}














