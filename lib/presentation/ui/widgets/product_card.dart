import 'package:crafty_bay_project/data/models/product_model.dart';
import 'package:crafty_bay_project/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay_project/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(
              productId: product.id!,
            ));
      },
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160,
                height: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(product.image ?? ''),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? '',
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black54),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.themeColor,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              '${product.star}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.themeColor,
                              ),
                            ),
                          ],
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
