import 'package:crafty_bay_project/data/models/product_details_model.dart';
import 'package:crafty_bay_project/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay_project/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay_project/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay_project/presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay_project/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay_project/presentation/ui/utils/snack_message.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/product_image_slider.dart';
import 'package:crafty_bay_project/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectedColor = '';
  String _selectedSize = '';
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        if (productDetailsController.inProgress) {
          return const CenteredCircularProgressIndicator();
        }
        if (productDetailsController.errorMessage != null) {
          return Center(
            child: Text(productDetailsController.errorMessage!),
          );
        }

        return Column(
          children: [
            Expanded(
              child: _buildProductDetails(productDetailsController.product!),
            ),
            _buildPriceAndAddToCartSection(productDetailsController.product!),
          ],
        );
      }),
    );
  }

  SingleChildScrollView _buildProductDetails(ProductDetailsModel product) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSlider(
            sliderUrls: [
              product.img1!,
              product.img2!,
              product.img3!,
              product.img4!,
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameAndQuantitySection(product),
                const SizedBox(height: 4),
                _buildRatingAndReviewSection(product),
                const SizedBox(height: 4),
                // ColorPicker(
                //   colors: [
                //     Colors.red,
                //     Colors.green,
                //     Colors.yellow,
                //     Colors.black,
                //   ],
                //   onColorSelected: (color) {},
                // ),
                const SizedBox(height: 16),
                SizePicker(
                  sizes: product.color!.split(
                      ','), //split for comma separated string because api shows in string by comma
                  onSizeSelected: (String selectedColor) {
                    _selectedColor = selectedColor;
                  },
                ),

                const SizedBox(height: 16),

                SizePicker(
                  sizes: product.size!.split(
                      ','), //split for comma separated string because api shows in string by comma
                  onSizeSelected: (String selectedSize) {
                    _selectedSize = selectedSize;
                  },
                ),

                const SizedBox(height: 16),
                _buildDescriptionSection(product),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(ProductDetailsModel productDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          productDetails.product?.shortDes ?? '',
          style: const TextStyle(color: Colors.black45),
        ),
      ],
    );
  }

  Widget _buildNameAndQuantitySection(ProductDetailsModel productDetails) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            productDetails.product?.title ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ItemCount(
          initialValue: 1,
          minValue: 1,
          maxValue: 10,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          onChanged: (value) {
            quantity = value.toInt();
          },
        ),
      ],
    );
  }

  Widget _buildRatingAndReviewSection(ProductDetailsModel productDetails) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            Text(
              '${productDetails.product?.star ?? ''}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.themeColor,
              ),
            ),
          ],
        ),
        const SizedBox(
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
        const Card(
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

  Widget _buildPriceAndAddToCartSection(ProductDetailsModel productDetails) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price'),
              Text(
                '\$${productDetails.product?.price}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child:
                GetBuilder<AddToCartController>(builder: (addToCartController) {
              return Visibility(
                visible: !addToCartController.inProgress,
                replacement: const CenteredCircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: _onTapAddToCart,
                  child: const Text('Add to Cart'),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapAddToCart() async {
    bool isLoggedInUser = await Get.find<AuthController>().isLoggedInUser();
    if (isLoggedInUser) {
      final result = await Get.find<AddToCartController>().addToCart(
        widget.productId,
        _selectedColor,
        _selectedSize,
        quantity,
      );
      if (result) {
        if (mounted) {
          showSnackBarMessage(context, 'Added to cart');
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, Get.find<AddToCartController>().errorMessage!, true);
        }
      }
    } else {
      Get.to(() => const EmailVerificationScreen());
    }
  }
}
