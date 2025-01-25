import 'dart:io';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String productName;
  final File image;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onWishlistToggle;
  final ValueChanged<bool> onCartToggle;
  final bool isWishlisted;
  final bool isInCart;
  final List<PopupMenuItem<String>>? wishlistMenuOptions;
  final Function(String)? onPopupMenuSelected;
  final bool hideWishlistIcon;

  const ProductCard({
    super.key,
    required this.productName,
    required this.image,
    required this.onEdit,
    required this.onDelete,
    required this.onWishlistToggle,
    required this.onCartToggle,
    required this.isWishlisted,
    required this.isInCart,
    this.wishlistMenuOptions,
    this.onPopupMenuSelected,
    this.hideWishlistIcon = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              // Product image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  child: Image.file(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Three-dot menu and wishlist icon
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Row(
                  children: [
                    // Conditionally show wishlist icon (not for wishlist page)
                    // Conditionally show wishlist icon (not for wishlist page)
                    if (!widget.hideWishlistIcon)
                      GestureDetector(
                        onTap: () {
                          widget.onWishlistToggle(!widget.isWishlisted);
                        },
                        child: Icon(
                          widget.isWishlisted
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.isWishlisted ? Colors.red : Colors.grey,
                        ),
                      ),
                    // Popup menu with dynamic options
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            widget.onEdit();
                            break;
                          case 'delete':
                            widget.onDelete();
                            break;
                          case 'cart':
                            widget.onCartToggle(!widget.isInCart);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(widget.isInCart
                                    ? 'Removed from cart'
                                    : 'Added to cart'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            break;
                          default:
                            if (widget.onPopupMenuSelected != null) {
                              widget.onPopupMenuSelected!(value);
                            }
                        }
                      },
                      itemBuilder: (context) => [
                        // Always show these menu items
                        if (!widget.hideWishlistIcon) ...[
                          PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                          PopupMenuItem(
                            value: 'cart',
                            child: Text(widget.isInCart
                                ? 'Remove from Cart'
                                : 'Add to Cart'),
                          ),
                        ],
                        if (widget.wishlistMenuOptions != null)
                          ...widget.wishlistMenuOptions!,
                      ],
                    ),
                    SizedBox(width: 8.0),
                  ],
                ),
              ),
            ],
          ),
          // Product name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.productName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
