import 'package:flutter/material.dart';

import '../model/product.dart';
import 'product_card.dart';

class TwoProductCardColumn extends StatelessWidget {
  const TwoProductCardColumn({
    required this.bottom,
    this.top,
    this.onProductTap,
    Key? key,
  }) : super(key: key);

  final Product bottom;
  final Product? top;
  final Function(Product)? onProductTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      const spacerHeight = 44.0;

      double heightOfCards = (constraints.biggest.height - spacerHeight) / 2.0;
      double heightOfImages = heightOfCards - ProductCard.kTextBoxHeight;
      double imageAspectRatio = heightOfImages >= 0.0
          ? constraints.biggest.width / heightOfImages
          : 49.0 / 33.0;

      return ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 28.0),
            child: top != null
                ? GestureDetector(
                    onTap: () => onProductTap?.call(top!),
                    child: ProductCard(
                      imageAspectRatio: imageAspectRatio,
                      product: top!,
                    ),
                  )
                : SizedBox(
                    height: heightOfCards,
                  ),
          ),
          const SizedBox(height: spacerHeight),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 28.0),
            child: GestureDetector(
              onTap: () => onProductTap?.call(bottom),
              child: ProductCard(
                imageAspectRatio: imageAspectRatio,
                product: bottom,
              ),
            ),
          ),
        ],
      );
    });
  }
}

class OneProductCardColumn extends StatelessWidget {
  const OneProductCardColumn({
    required this.product,
    this.onProductTap,
    Key? key,
  }) : super(key: key);

  final Product product;
  final Function(Product)? onProductTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      reverse: true,
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 550,
          ),
          child: GestureDetector(
            onTap: () => onProductTap?.call(product),
            child: ProductCard(
              product: product,
            ),
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}