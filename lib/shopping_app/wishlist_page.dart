import 'package:flutter/material.dart';
import 'package:practice_1/shopping_app/home_page.dart';
import 'wishlisted_item.dart';
import 'product_card.dart';

class WishlistPage extends StatefulWidget {
  final List<Product> wishlistedProducts;
  final Function(Product)? onRemoveFromWishlist;
  final Function(Product)? onMoveToCart;

  const WishlistPage({
    Key? key,
    required this.wishlistedProducts,
    this.onRemoveFromWishlist,
    this.onMoveToCart,
  }) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late List<Product> _wishlistedProducts;

  @override
  void initState() {
    super.initState();
    _wishlistedProducts = List.from(widget.wishlistedProducts);
  }

  void _removeFromWishlist(Product product) {
  setState(() {
    // Remove from local list
    _wishlistedProducts.removeWhere(
      (p) => p.productName == product.productName
    );
  });

  // Trigger parent's remove method to update home page and storage
  widget.onRemoveFromWishlist?.call(product);

  // Close page if no items left
  if (_wishlistedProducts.isEmpty) {
    Navigator.pop(context);
  }
}

  void _moveToCart(Product product) {
    setState(() {
      _wishlistedProducts
          .removeWhere((p) => p.productName == product.productName);
    });
    widget.onMoveToCart?.call(product);
  }

  @override
  Widget build(BuildContext context) {
    int itemsToShow = 3;
    int extraItems = _wishlistedProducts.length > itemsToShow
        ? _wishlistedProducts.length - itemsToShow
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: _wishlistedProducts.length > itemsToShow
              ? itemsToShow + 1
              : _wishlistedProducts.length,
          itemBuilder: (context, index) {
            if (index == itemsToShow && extraItems > 0) {
              final lastAddedItem = _wishlistedProducts.last;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WishlistedItem(
                        wishlistedProducts: _wishlistedProducts,
                        onRemoveFromWishlist: _removeFromWishlist,
                        onMoveToCart: _moveToCart,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            lastAddedItem.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '+$extraItems more',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final product = _wishlistedProducts[index];
            return ProductCard(
              productName: product.productName,
              imageUrl: product.imageUrl,
              isWishlisted: true,
              onWishlistToggle: (_) {},
              onCartToggle: (_) {},
              isInCart: product.isInCart,
              hideWishlistIcon: true,
              onTap: () {},
              // onRemoveFromWishlist: _removeFromWishlist,
              // onMoveToCart: _moveToCart,
            );
          },
        ),
      ),
    );
  }
}
