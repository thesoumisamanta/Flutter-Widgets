import 'package:flutter/material.dart';
import 'package:practice_1/shopping_app/home_page.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onAddToCart;

  const ProductDetailsPage({
    Key? key,
    required this.product,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: Image.network(product.imageUrl),
            ),
          ),
          const SizedBox(height: 16),

          // Product Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              product.productName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),

          // Product Description (Dummy description for example)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus ut ligula venenatis condimentum.',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),

          // Price (Dummy price for example)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '\$${product.id}', // Just using product id as price for now
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(), // To push the bottom bar down

          // Bottom Bar with Add to Cart and Buy Now
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Add to Cart Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add to Cart logic
                      onAddToCart(product);
                      // Flash message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product added to the cart.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ),
                const SizedBox(width: 16),
                // Buy Now Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Purchase'),
                          content: const Text(
                            'Are you sure you want to buy this?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                                // Flash message for order placed
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Your order has been placed!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Buy Now'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
