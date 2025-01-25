import 'package:flutter/material.dart';
import 'package:practice_1/shopping_app/home_page.dart' as home;
import 'product_card.dart' as card;

class WishlistedItem extends StatefulWidget {
  final List<home.Product> wishlistedProducts;
  final Function(home.Product) onRemoveFromWishlist;
  final Function(home.Product) onMoveToCart;

  const WishlistedItem({
    Key? key,
    required this.wishlistedProducts,
    required this.onRemoveFromWishlist,
    required this.onMoveToCart,
  }) : super(key: key);

  @override
  _WishlistedItemState createState() => _WishlistedItemState();
}

class _WishlistedItemState extends State<WishlistedItem> {
  late List<home.Product> _wishlistedProducts;

  @override
  void initState() {
    super.initState();
    _wishlistedProducts = List.from(widget.wishlistedProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlisted Items"),
      ),
      body: _wishlistedProducts.isEmpty
          ? Center(
              child: Text(
                "Your wishlist is empty",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: _wishlistedProducts.length,
                itemBuilder: (context, index) {
                  final product = _wishlistedProducts[index];
                  return card.ProductCard(
                    productName: product.productName,
                    imageUrl: product.imageUrl,
                    isWishlisted: true,
                    onWishlistToggle: (_) {},
                    onCartToggle: (_) {},
                    isInCart: product.isInCart,
                    hideWishlistIcon: true,
                    onTap: () {},
                    onRemoveFromWishlist: (removedProduct) {
                      // Immediately remove from local list
                      setState(() {
                        _wishlistedProducts.removeWhere(
                            (p) => p.productName == removedProduct.productName);
                      });

                      // Find matching product in original list
                      final originalProduct = widget.wishlistedProducts
                          .firstWhere((p) =>
                              p.productName == removedProduct.productName);

                      // Update parent's state and storage
                      widget.onRemoveFromWishlist(originalProduct);

                      // Close page if no items left
                      if (_wishlistedProducts.isEmpty) {
                        Navigator.pop(context);
                      }
                    },
                    onMoveToCart: (movedProduct) {
                      // Immediately remove from local list and update UI
                      setState(() {
                        _wishlistedProducts.removeWhere(
                            (p) => p.productName == movedProduct.productName);
                      });

                      // Find matching product in original list
                      final originalProduct = widget.wishlistedProducts
                          .firstWhere(
                              (p) => p.productName == movedProduct.productName);

                      // Trigger move to cart in parent
                      widget.onMoveToCart(originalProduct);

                      // Close page if no items left
                      if (_wishlistedProducts.isEmpty) {
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              ),
            ),
    );
  }
}
