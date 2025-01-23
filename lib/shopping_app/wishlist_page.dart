import 'package:flutter/material.dart';
import 'package:practice_1/shopping_app/product_details.dart';
import 'dart:io';

import 'product_card.dart';

class WishlistPage extends StatefulWidget {
  final List<Product> wishlistedProducts;
  final Function(Product) onRemoveFromWishlist;
  final Function(Product) onMoveToCart;

  const WishlistPage({
    Key? key, 
    required this.wishlistedProducts,
    required this.onRemoveFromWishlist,
    required this.onMoveToCart,
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
      _wishlistedProducts.remove(product);
    });
    widget.onRemoveFromWishlist(product);
  }

  void _moveToCart(Product product) {
    setState(() {
      _wishlistedProducts.remove(product);
    });
    widget.onMoveToCart(product);
  }

  @override
  Widget build(BuildContext context) {
    int itemsToShow = 5;
    int extraItems = _wishlistedProducts.length > itemsToShow 
        ? _wishlistedProducts.length - itemsToShow 
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // const Text(
            //   "Wishlist",
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 16),
            Expanded(
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
                  // Display "+count more" card with last added item
                  if (index == itemsToShow && extraItems > 0) {
                    final lastAddedItem = _wishlistedProducts.last;
                    return GestureDetector(
                      onTap: () {
                        // Future: Navigate to full wishlist view
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
                                child: Image.file(
                                  lastAddedItem.image,
                                  fit: BoxFit.cover,
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

                  // Display individual product cards for wishlist items
                  final product = _wishlistedProducts[index];
                  return ProductCard(
                    productName: product.productName,
                    image: product.image,
                    isWishlisted: true,
                    onWishlistToggle: (bool value) {
                      // Remove from wishlist
                      _removeFromWishlist(product);
                    }, 
                    onCartToggle: (bool value) {
                      // Move to cart
                      _moveToCart(product);
                    }, 
                    onEdit: () {},
                    onDelete: () {},
                    isInCart: product.isInCart,
                    wishlistMenuOptions: [
                      PopupMenuItem(
                        value: 'remove',
                        child: Text('Remove'),
                      ),
                      PopupMenuItem(
                        value: 'moveToCart',
                        child: Text('Move to Cart'),
                      ),
                    ],
                    onPopupMenuSelected: (String value) {
                      if (value == 'remove') {
                        _removeFromWishlist(product);
                      } else if (value == 'moveToCart') {
                        _moveToCart(product);
                      }
                    },
                    hideWishlistIcon: true, 
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}