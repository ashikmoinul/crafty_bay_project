import 'package:crafty_bay_project/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/color_picker.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/product_image_slider.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildProductDetails(),
          ),
          _buildPriceAndAddToCartSection(),
        ],
      ),
    );
  }

  SingleChildScrollView _buildProductDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProductImageSlider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameAndQuantitySection(),
                const SizedBox(height: 4),
                _buildRatingAndReviewSection(),
                const SizedBox(height: 4),
                ColorPicker(
                  colors: [
                    Colors.red,
                    Colors.green,
                    Colors.yellow,
                    Colors.black,
                  ],
                  onColorSelected: (color) {},
                ),
                const SizedBox(height: 16),
                SizePicker(
                  sizes: ['S', 'M', 'L', 'XL', 'XXL'],
                  onSizeSelected: (String selectedSize) {},
                ),
                const SizedBox(height: 16),
                _buildDescriptionSection(),
                const SizedBox(height: 8),
                const Text(
                  '''Item Count Number Button is a Flutter package that allows you to easily implement a customizable item count widget with increment and decrement buttons. This widget is particularly useful in scenarios where you need to manage the quantity of items, such as in a shopping cart or inventory management system''',
                  style: TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {

    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              );
  }

  Widget _buildNameAndQuantitySection() {
    return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Nike Shoe 2024 Latest Model - New year special deal',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ItemCount(
                    initialValue: 1,
                    minValue: 1,
                    maxValue: 10,
                    decimalPlaces: 0,
                    color: AppColors.themeColor,
                    onChanged: (value) {},
                  ),
                ],
              );
  }

  Widget _buildRatingAndReviewSection() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
            Text(
              '3',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.themeColor,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 4,
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Reviews',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.themeColor,
            ),
          ),
        ),
        Card(
          color: AppColors.themeColor,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(
              Icons.favorite_border,
              size: 16,
              color: Colors.white,
            ),
          ),
        )
      ],
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
              Text('Price'),
              Text(
                '\$100',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
              width: 140,
              child:
                  ElevatedButton(onPressed: () {}, child: Text('Add to Cart')))
        ],
      ),
    );
  }
}
