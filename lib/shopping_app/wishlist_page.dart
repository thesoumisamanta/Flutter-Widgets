import 'package:flutter/material.dart';
import 'package:practice_1/shopping_app/product_details.dart';
import 'dart:io';

import 'product_card.dart';

class WishlistPage extends StatelessWidget {
  final List<Product> wishlistedProducts;

  const WishlistPage({Key? key, required this.wishlistedProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemsToShow = 5; // Increase to show 5 wishlist items
    int extraItems = wishlistedProducts.length > itemsToShow 
        ? wishlistedProducts.length - itemsToShow 
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Wishlist",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7, // Adjusted to prevent bottom overflow
                ),
                itemCount: wishlistedProducts.length > itemsToShow
                    ? itemsToShow + 1
                    : wishlistedProducts.length,
                itemBuilder: (context, index) {
                  // Display "+count more" card with last added item
                  if (index == itemsToShow && extraItems > 0) {
                    final lastAddedItem = wishlistedProducts.last;
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
                            // Slightly opaque background image of last added item
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
                            // "+count more" text
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
                  final product = wishlistedProducts[index];
                  return ProductCard(
                    productName: product.productName,
                    image: product.image,
                    isWishlisted: true,
                    // isWishlistPage: true, // Add this to show wishlist-specific menu
                    onWishlistToggle: (bool value) {}, 
                    onCartToggle: (bool value) {}, 
                    onEdit: () {},
                    onDelete: () {},
                    isInCart: product.isInCart,
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