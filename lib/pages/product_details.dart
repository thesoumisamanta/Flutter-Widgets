import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Product {
  String caption;
  File image;

  Product({required this.caption, required this.image});

  Map<String, String> toMap() {
    return {
      'caption': caption,
      'imagePath': image.path,
    };
  }

  static Product fromMap(Map<String, String> map) {
    return Product(
      caption: map['caption'] ?? '',
      image: File(map['imagePath'] ?? ''),
    );
  }
}

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextEditingController _captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  List<Product> _products = [];
  File? _selectedImage;
  int? _editingIndex;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final allKeys = await _storage.readAll();
    List<Product> loadedProducts = [];

    allKeys.forEach((key, value) {
      if (value.contains('|')) {
        List<String> productData = value.split('|');
        if (productData.length == 2) {
          Map<String, String> map = {
            'caption': productData[0],
            'imagePath': productData[1],
          };
          loadedProducts.add(Product.fromMap(map));
        }
      }
    });

    setState(() {
      _products = loadedProducts;
    });
  }

  Future<void> _addOrEditProduct() async {
    if (_captionController.text.isEmpty || (_editingIndex == null && _selectedImage == null)) return;

    if (_editingIndex != null) {
      final editedProduct = _products[_editingIndex!];
      editedProduct.caption = _captionController.text;
      if (_selectedImage != null) {
        editedProduct.image = _selectedImage!;
      }

      await _storage.write(
        key: editedProduct.caption,
        value: '${editedProduct.caption}|${editedProduct.image.path}',
      );
    } else {
      final product = Product(
        caption: _captionController.text,
        image: _selectedImage!,
      );

      final productKey = DateTime.now().toString();
      await _storage.write(
        key: productKey,
        value: '${product.caption}|${product.image.path}',
      );

      setState(() {
        _products.add(product);
      });
    }

    _resetForm();
    _loadProducts();
  }

  void _resetForm() {
    _captionController.clear();
    _selectedImage = null;
    _editingIndex = null;
  }

  void _startEditingProduct(int index) {
    setState(() {
      _editingIndex = index;
      _captionController.text = _products[index].caption;
      _selectedImage = _products[index].image;
    });
  }

  Future<void> _deleteProduct(int index) async {
    final productKey = _products[index].caption;
    await _storage.delete(key: productKey);

    setState(() {
      _products.removeAt(index);
    });
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Page"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _captionController,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _showImagePickerBottomSheet,
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
          ElevatedButton(
            onPressed: _addOrEditProduct,
            child: Text(_editingIndex == null ? 'Add' : 'Save'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                _products[index].caption,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            PopupMenuButton<int>(
                              onSelected: (value) {
                                if (value == 0) {
                                  _startEditingProduct(index);
                                } else if (value == 1) {
                                  _deleteProduct(index);
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 0,
                                  child: Text('Edit'),
                                ),
                                PopupMenuItem(
                                  value: 1,
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: 300,
                          child: Image.file(_products[index].image),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
