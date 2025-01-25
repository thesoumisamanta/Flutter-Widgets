import 'package:flutter/material.dart';
import 'dart:io';

import 'package:practice_1/product_mart/product_details.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartProducts;
  final Function(Product) onRemoveFromCart;

  const CartPage({
    Key? key, 
    required this.cartProducts,
    required this.onRemoveFromCart,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Product> _cartProducts;

  @override
  void initState() {
    super.initState();
    _cartProducts = List.from(widget.cartProducts);
  }

  void _removeFromCart(Product product) {
    setState(() {
      _cartProducts.remove(product);
    });
    widget.onRemoveFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    int itemsToShow = 5;
    int extraItems = _cartProducts.length > itemsToShow 
        ? _cartProducts.length - itemsToShow 
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // const Text(
            //   "Cart",
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemCount: _cartProducts.length > itemsToShow
                    ? itemsToShow + 1
                    : _cartProducts.length,
                itemBuilder: (context, index) {
                  // Display "+count more" card with last added item
                  if (index == itemsToShow && extraItems > 0) {
                    final lastAddedItem = _cartProducts.last;
                    return GestureDetector(
                      onTap: () {
                        // Future: Navigate to full cart view
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

                  // Display individual product cards for cart items
                  final product = _cartProducts[index];
                  return Stack(
                    children: [
                      Container(
                        child: Card(
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Product image 
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: Image.file(
                                    product.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Product name
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.productName,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () => _removeFromCart(product),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Remove', style: TextStyle(color: Colors.grey[700]),),
                          ),
                        ),
                      ),
                    ],
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