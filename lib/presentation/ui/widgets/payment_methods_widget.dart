import 'package:flutter/material.dart';

import '../../../data/models/payment_mode.dart';

class PaymentMethods extends StatelessWidget {
  final List<PaymentMethod> paymentMethods;
  final int selectedIndex;
  final Function(int) onTap;

  const PaymentMethods(
      {super.key,
        required this.paymentMethods,
        required this.selectedIndex,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridViewLayout(
        length: paymentMethods.length,
        shrinkWrap: true,
        disableScroll: true,
        child: (index) {
          return CachedNetworkImage(
            imageUrl: paymentMethods[index].logo.toString().toString(),
            errorWidget: (context, string, _) {
              return Icon(
                Icons.error,
                color: Colors.red,
              );
            },
            imageBuilder: (context, imageProvider) {
              return SelectableContainer(
                selected: (selectedIndex == index),
                selectedBackgroundColor: Colors.transparent,
                selectedBorderColor: Colors.transparent,
                unselectedBackgroundColor: Colors.transparent,
                unselectedBorderColor: Colors.transparent,
                onValueChanged: (bool value) {
                  if (value) {
                    onTap(index);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          );
        },
        mainAxisExtent: 120,
        crossAxisExtent: 120,
      ),
    );
  }
}