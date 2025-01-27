import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:practice_1/shopping_app/cart_page.dart';

import 'package:practice_1/shopping_app/product_card.dart';
import 'package:practice_1/shopping_app/product_details_page.dart';
import 'package:practice_1/shopping_app/wishlist_page.dart';
import 'package:http/http.dart' as http;
import 'package:practice_1/shopping_app/wishlist_page.dart';

class Product {
  final String id;
  final String productName;
  final String imageUrl;
  final double? price;
  final String? description;
  bool isWishlisted;
  bool isInCart;

  Product({
    required this.id,
    required this.productName,
    required this.imageUrl,
    this.price,
    this.description,
    this.isWishlisted = false,
    this.isInCart = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      productName: json['title'],
      imageUrl: json['image'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
    );
  }
}

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final List<Product> _products = [];
  final List<Product> _filteredProducts = [];
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  final int _productsPerPage = 6;
  final ScrollController _scrollController = ScrollController();
  int _wishlistCount = 0;
  int _cartCount = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeApp();
    _searchController.addListener(_onSearch);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    await _fetchProducts();
    await _syncWishlist();
    await _syncCart();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _fetchProducts();
      }
    });
  }

  Future<void> _fetchProducts() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Product> fetchedProducts =
            data.map((json) => Product.fromJson(json)).toList();

        final startIndex = (_currentPage - 1) * _productsPerPage;
        final endIndex = startIndex + _productsPerPage;

        if (startIndex < fetchedProducts.length) {
          setState(() {
            _products.addAll(fetchedProducts.sublist(
              startIndex,
              endIndex > fetchedProducts.length
                  ? fetchedProducts.length
                  : endIndex,
            ));
            _currentPage++;
            _hasMore = endIndex < fetchedProducts.length;
          });
        } else {
          setState(() {
            _hasMore = false;
          });
        }
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts.clear();
      _filteredProducts.addAll(
        _products.where(
            (product) => product.productName.toLowerCase().contains(query)),
      );
    });
  }

  // Load wishlist from local storage and sync with products
  Future<void> _syncWishlist() async {
    final wishlistData = await _storage.read(key: 'wishlist');
    if (wishlistData != null) {
      final List<String> wishlistedIds =
          List<String>.from(json.decode(wishlistData));
      setState(() {
        for (var product in _products) {
          product.isWishlisted = wishlistedIds.contains(product.id);
        }
        _wishlistCount = wishlistedIds.length;
      });
    }
  }

  Future<void> _syncCart() async {
    final cartData = await _storage.read(key: 'cart');
    if (cartData != null) {
      // Decode JSON and expect a List of cart IDs
      final cartIds = List<String>.from(json.decode(cartData));

      setState(() {
        for (var product in _products) {
          product.isInCart = cartIds.contains(product.id);
        }
        _cartCount = cartIds.length;
      });
    }
  }

  // Save wishlist to local storage
  Future<void> _saveWishlist() async {
    final wishlistedIds = _products
        .where((p) => p.isWishlisted)
        .map((p) => p.id)
        .toList(); // Convert Set to List
    await _storage.write(key: 'wishlist', value: json.encode(wishlistedIds));
  }

  void _toggleWishlist(Product product) {
    setState(() {
      product.isWishlisted = !product.isWishlisted;
      _wishlistCount = _products.where((p) => p.isWishlisted).length;
    });
    _saveWishlist();
  }

  void _toggleCart(Product product) {
    setState(() {
      product.isInCart = !product.isInCart;
      _cartCount = _products.where((p) => p.isInCart).length;
    });
    _saveCart(); // Save updated cart to local storage
  }

  Future<void> _saveCart() async {
    // Convert Set to List before encoding to JSON
    final cartIds =
        _products.where((p) => p.isInCart).map((p) => p.id).toList();
    await _storage.write(key: 'cart', value: json.encode(cartIds));
  }

  void onMoveToCart(Product product) {
    setState(() {
      // Find the actual product in _products list
      final productToUpdate =
          _products.firstWhere((p) => p.productName == product.productName);

      // Remove from wishlist
      productToUpdate.isWishlisted = false;

      // Add to cart
      productToUpdate.isInCart = true;

      // Update counts
      _wishlistCount = _products.where((p) => p.isWishlisted).length;
      _cartCount = _products.where((p) => p.isInCart).length;
    });

    // Sync storage consistently
    _saveWishlist();
    _saveCart();
  }

  void _navigateToWishlist() {
    final wishlistedProducts =
        _products.where((product) => product.isWishlisted).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WishlistPage(
          wishlistedProducts: wishlistedProducts,
          onRemoveFromWishlist: _removeFromWishlist,
          onMoveToCart: onMoveToCart,
        ),
      ),
    );
  }

  void _removeFromWishlist(Product product) {
    setState(() {
      // Find the actual product in _products list
      final productToUpdate =
          _products.firstWhere((p) => p.productName == product.productName);

      // Update wishlist status
      productToUpdate.isWishlisted = false;

      // Recalculate wishlist count
      _wishlistCount = _products.where((p) => p.isWishlisted).length;
    });

    // Update storage
    final updatedWishlist =
        _products.where((p) => p.isWishlisted).map((p) => p.id).toList();
    _storage.write(key: 'wishlist', value: json.encode(updatedWishlist));
  }

  void _navigateToCart() {
    final cartProducts =
        _products.where((product) => product.isInCart).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CartPage(
              cartProducts: cartProducts, onRemoveFromCart: onRemoveFromCart)),
    );
  }

  void onRemoveFromCart(Product product) {
    setState(() {
      product.isInCart = false;
      _cartCount = _products.where((p) => p.isInCart).length;
    });
    _saveCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: _searchController.text.isEmpty
                  ? _products.length + (_hasMore ? 1 : 0)
                  : _filteredProducts.length,
              itemBuilder: (context, index) {
                final List<Product> displayProducts =
                    _searchController.text.isEmpty
                        ? _products
                        : _filteredProducts;

                if (index < displayProducts.length) {
                  final product = displayProducts[index];
                  return ProductCard(
                    productName: product.productName,
                    imageUrl: product.imageUrl,
                    onWishlistToggle: (isWishlisted) =>
                        _toggleWishlist(product),
                    onCartToggle: (isInCart) => _toggleCart(product),
                    isWishlisted: product.isWishlisted,
                    isInCart: product.isInCart,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            product: product,
                            onAddToCart: (product) => _toggleCart(product),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.favorite_border, size: 35),
                    if (_wishlistCount > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            _wishlistCount > 9
                                ? '9+'
                                : _wishlistCount.toString(),
                            style: const TextStyle(
                                fontSize: 8, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: _navigateToWishlist,
              ),
              IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart, size: 35),
                    if (_cartCount > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            _cartCount > 9 ? '9+' : _cartCount.toString(),
                            style: const TextStyle(
                                fontSize: 8, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: _navigateToCart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
