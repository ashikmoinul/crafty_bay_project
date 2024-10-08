import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay_project/presentation/state_holders/slider_list_controller.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../utils/app_colors.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({
    super.key,
  });

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderListController>(builder: (sliderListController) {
      return Visibility(
        visible: !sliderListController.inProgress,
        replacement: const SizedBox(
          child: CenteredCircularProgressIndicator(),
        ),
        child: Column(
          children: [
            _buildCarouselSlider(sliderListController),
            const SizedBox(
              height: 8,
            ),
            _buildCarouselDots(sliderListController)
          ],
        ),
      );
    });
  }

  Widget _buildCarouselSlider(SliderListController sliderListController) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 180,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            _selectedIndex.value = index;
          }),
      items: sliderListController.sliders.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: AppColors.themeColor,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(slider.image ?? ''),
                      fit: BoxFit.cover),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        slider.price ?? '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.themeColor,
                          ),
                          onPressed: () {},
                          child: const Text('Buy now'),
                        ),
                      ),
                    ],
                  ),
                ));
          },
        );
      }).toList(),
    );
  }

  Widget _buildCarouselDots(SliderListController sliderListController) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, currentIndex, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            for (int i = 0; i < sliderListController.sliders.length; i++)
              Container(
                margin: const EdgeInsets.only(right: 4),
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color:
                      _selectedIndex.value == i ? AppColors.themeColor : null,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
