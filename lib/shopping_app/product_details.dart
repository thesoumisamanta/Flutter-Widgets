import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:practice_1/shopping_app/cart_page.dart';
import 'package:practice_1/shopping_app/custom_add_button.dart';
import 'package:practice_1/shopping_app/custom_text_field.dart';
import 'package:practice_1/shopping_app/product_card.dart';
import 'package:practice_1/shopping_app/wishlist_page.dart';

class Product {
  String id;
  String productName;
  File image;
  bool isWishlisted;
  bool isInCart;

  Product({
    required this.id,
    required this.productName,
    required this.image,
    this.isWishlisted = false,
    this.isInCart = false,
  });

  Future<Map<String, String>> toMap() async {
    final appDir = await getApplicationDocumentsDirectory();

    final fileName =
        'product_${id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final newPath = '${appDir.path}/$fileName';

    if (image.path != newPath) {
      await image.copy(newPath);
    }

    return {
      'id': id,
      'productName': productName,
      'imagePath': newPath,
      'isWishlisted': isWishlisted.toString(),
      'isInCart': isInCart.toString(),
    };
  }

  static Product fromMap(Map<String, String> map) {
    return Product(
      id: map['id'] ?? DateTime.now().toString(),
      productName: map['productName'] ?? '',
      image: File(map['imagePath'] ?? ''),
      isWishlisted: map['isWishlisted'] == 'true',
      isInCart: map['isInCart'] == 'true',
    );
  }
}

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextEditingController _productNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  List<Product> _products = [];
  File? _selectedImage;
  String? _editingId;

  int _wishlistCount = 0;
  Map<String, bool> _wishlistStatus = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final allData = await _storage.readAll();
      List<Product> loadedProducts = [];

      for (var entry in allData.entries) {
        if (entry.key.startsWith('product_')) {
          try {
            final Map<String, dynamic> productMap =
                Map<String, String>.from(json.decode(entry.value));

            final product = Product(
              id: productMap['id'] ?? '',
              productName: productMap['productName'] ?? '',
              image: File(productMap['imagePath'] ?? ''),
              isWishlisted: productMap['isWishlisted'] == 'true',
              isInCart: productMap['isInCart'] == 'true',
            );

            if (await product.image.exists()) {
              loadedProducts.add(product);
            }
          } catch (e) {
            print('Error parsing product data: $e');
          }
        }
      }

      setState(() {
        _products = loadedProducts;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> _saveData() async {
    try {
      for (var product in _products) {
        final productMap = await product.toMap();
        // Convert map to JSON string for storage
        final productString = json.encode(productMap);

        await _storage.write(
          key: 'product_${product.id}',
          value: productString,
        );
      }
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  Future<void> _addOrEditProduct() async {
    if (_productNameController.text.isEmpty ||
        (_editingId == null && _selectedImage == null)) return;

    try {
      if (_editingId != null) {
        // Edit existing product
        final productIndex = _products.indexWhere((p) => p.id == _editingId);
        if (productIndex != -1) {
          final existingProduct = _products[productIndex];
          final updatedProduct = Product(
            id: _editingId!,
            productName: _productNameController.text,
            image: _selectedImage ?? existingProduct.image,
            isWishlisted: existingProduct.isWishlisted,
            isInCart: existingProduct.isInCart,
          );

          setState(() {
            _products[productIndex] = updatedProduct;
          });
        }
      } else {
        // Add new product
        final newProduct = Product(
          id: DateTime.now().toString(),
          productName: _productNameController.text,
          image: _selectedImage!,
          isWishlisted: false,
          isInCart: false,
        );

        setState(() {
          _products.add(newProduct);
        });
      }

      await _saveData();
      _resetForm();
    } catch (e) {
      print('Error adding/editing product: $e');
    }
  }

  void _resetForm() {
    setState(() {
      _productNameController.clear();
      _selectedImage = null;
      _editingId = null;
    });
  }

  void _startEditingProduct(String productId) {
    final product = _products.firstWhere((p) => p.id == productId);
    setState(() {
      _editingId = productId;
      _productNameController.text = product.productName;
      _selectedImage = product.image;
    });
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      // Remove from storage
      await _storage.delete(key: 'product_$productId');

      // Update wishlist status before removing product
      bool wasWishlisted = _wishlistStatus[productId] ?? false;

      setState(() {
        _products.removeWhere((p) => p.id == productId);
        _wishlistStatus.remove(productId);
        if (wasWishlisted) {
          _wishlistCount = _wishlistCount - 1;
        }
      });

      await _saveData();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  void _toggleWishlist(String productId, bool isWishlisted) async {
    setState(() {
      final productIndex = _products.indexWhere((p) => p.id == productId);
      if (productIndex != -1) {
        _products[productIndex] = Product(
          id: _products[productIndex].id,
          productName: _products[productIndex].productName,
          image: _products[productIndex].image,
          isWishlisted: isWishlisted,
          isInCart: _products[productIndex].isInCart,
        );
      }
    });

    await _saveData();
  }

  void _toggleCart(String productId, bool isInCart) async {
    setState(() {
      final productIndex = _products.indexWhere((p) => p.id == productId);
      if (productIndex != -1) {
        final product = _products[productIndex];
        _products[productIndex] = Product(
          id: product.id,
          productName: product.productName,
          image: product.image,
          isWishlisted: product.isWishlisted,
          isInCart: isInCart,
        );
      }
    });

    await _saveData();
  }

  void _navigateToWishlist() {
    final wishlistedProducts =
        _products.where((product) => product.isWishlisted).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WishlistPage(
          wishlistedProducts: wishlistedProducts,
          onRemoveFromWishlist: (Product product) {
            // Remove from wishlist
            _toggleWishlist(product.id, false);
          },
          onMoveToCart: (Product product) {
            // Remove from wishlist and add to cart
            _toggleWishlist(product.id, false);
            _toggleCart(product.id, true);
          },
        ),
      ),
    );
  }

  void _navigateToCart() {
    final cartProducts =
        _products.where((product) => product.isInCart).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(
          cartProducts: cartProducts,
          onRemoveFromCart: (Product product) {
            // Remove from cart
            _toggleCart(product.id, false);
          },
        ),
      ),
    );
  }

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  setState(() {
                    _selectedImage = File(image.path);
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _selectedImage = File(image.path);
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final wishlistCount = _products.where((p) => p.isWishlisted).length;
    final cartCount = _products.where((p) => p.isInCart).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Page"),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 35,
                ),
                if (wishlistCount > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        wishlistCount > 9 ? '9+' : wishlistCount.toString(),
                        style: TextStyle(fontSize: 8, color: Colors.white),
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
                Icon(
                  Icons.shopping_cart,
                  size: 35,
                ),
                if (cartCount > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        cartCount > 9 ? '9+' : cartCount.toString(),
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: _navigateToCart,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _productNameController,
                    onImagePick: _showImagePickerBottomSheet,
                  ),
                ),
                SizedBox(width: 8.0),
                CustomAddButton(
                  onPressed: _addOrEditProduct,
                  label: _editingId == null ? 'Add' : 'Save',
                ),
              ],
            ),
          ),
          if (_selectedImage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ProductCard(
                  productName: product.productName,
                  image: product.image,
                  onEdit: () => _startEditingProduct(product.id),
                  onDelete: () => _deleteProduct(product.id),
                  onWishlistToggle: (isWishlisted) {
                    _toggleWishlist(product.id, isWishlisted);
                  },
                  onCartToggle: (isInCart) {
                    _toggleCart(product.id, isInCart);
                  },
                  isWishlisted: product.isWishlisted,
                  isInCart: product.isInCart,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
