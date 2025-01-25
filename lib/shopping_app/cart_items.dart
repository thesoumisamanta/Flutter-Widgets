import 'package:flutter/material.dart';
import 'package:practice_1/shopping_app/home_page.dart';

class CartItems extends StatefulWidget {
  final List<Product> cartProducts;
  final Function(Product) onRemoveFromCart;

  const CartItems({
    Key? key,
    required this.cartProducts,
    required this.onRemoveFromCart,
  }) : super(key: key);

  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  late List<Product> _cartProducts;

  @override
  void initState() {
    super.initState();
    _cartProducts = List.from(widget.cartProducts);
  }

  void _removeFromCart(Product product) {
    // Remove from the local list
    setState(() {
      _cartProducts.removeWhere((p) => p.productName == product.productName);
    });

    // Call the parent's onRemoveFromCart
    widget.onRemoveFromCart(product);

    // Navigate back if the cart becomes empty
    if (_cartProducts.isEmpty) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Items"),
      ),
      body: _cartProducts.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty",
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
                  childAspectRatio: 0.6,
                ),
                itemCount: _cartProducts.length,
                itemBuilder: (context, index) {
                  final product = _cartProducts[index];
                  return Stack(
                    children: [
                      // Card design identical to CartPage
                      Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Product image
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                child: Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Product name
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.productName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Remove button at the same position
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
                            child: Text(
                              'Remove',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
