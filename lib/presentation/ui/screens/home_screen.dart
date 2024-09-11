import 'package:crafty_bay_project/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay_project/presentation/ui/utils/assets_path.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/search_text_field.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/app_bar_icon_button.dart';
import '../widgets/home_banner_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16,),
            SearchTextField(textEditingController: TextEditingController(),),
            SizedBox(height: 16,),
            const HomeBannerSlider(),
            SizedBox(height: 16,),
            _buildCategoriesSection(),

          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
            children: [
              SectionHeader(
                title: 'Categories',
                onTap: () {},
              ),
              SizedBox(height: 8,),
              SizedBox(
                height: 140,
                child: _buildCategoryListView(),
              ),
            ],
          );
  }

  Widget _buildCategoryListView() {
    return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index){
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.themeColor.withOpacity(0.1),
                      ),
                      child: const Icon(Icons.computer, size: 48,
                      color: AppColors.themeColor,),
                    ),
                    const SizedBox(height: 4,),
                    const Text('Electronics',
                      style: TextStyle(
                        color: AppColors.themeColor,
                      ),)
                  ],
                );
              },
                separatorBuilder: (_, __) => const SizedBox(width: 8,),
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








