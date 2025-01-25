import 'package:flutter/material.dart';
import 'package:practice_1/shopping_app/home_page.dart';

class ProductCard extends StatefulWidget {
  final String productName;
  final String imageUrl;
  final ValueChanged<bool> onWishlistToggle;
  final ValueChanged<bool> onCartToggle;
  final bool isWishlisted;
  final bool isInCart;
  final bool hideWishlistIcon;
  final VoidCallback onTap;
  final Function(Product)? onRemoveFromWishlist;
  final Function(Product)? onMoveToCart;
  final Function(Product)? onRemoveFromCart;
  

  const ProductCard({
    Key? key,
    required this.productName,
    required this.imageUrl,
    required this.onWishlistToggle,
    required this.onCartToggle,
    required this.isWishlisted,
    required this.isInCart,
    this.hideWishlistIcon = false,
    required this.onTap,
    this.onRemoveFromWishlist,
    this.onMoveToCart,
    this.onRemoveFromCart,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 100,
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (!widget.hideWishlistIcon)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => widget.onWishlistToggle(!widget.isWishlisted),
                          child: Icon(
                            widget.isWishlisted 
                              ? Icons.favorite 
                              : Icons.favorite_border,
                            color: widget.isWishlisted ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    // More Options Menu
                    if (widget.onRemoveFromWishlist != null || widget.onMoveToCart != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'remove' && widget.onRemoveFromWishlist != null) {
                              widget.onRemoveFromWishlist!(
                                Product(
                                  id: '',
                                  productName: widget.productName,
                                  imageUrl: widget.imageUrl,
                                  isWishlisted: widget.isWishlisted,
                                  isInCart: widget.isInCart,
                                )
                              );
                            } else if (value == 'moveToCart' && widget.onMoveToCart != null) {
                              widget.onMoveToCart!(
                                Product(
                                  id: '',
                                  productName: widget.productName,
                                  imageUrl: widget.imageUrl,
                                  isWishlisted: widget.isWishlisted,
                                  isInCart: widget.isInCart,
                                )
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            if (widget.onRemoveFromWishlist != null)
                              const PopupMenuItem(
                                value: 'remove',
                                child: Text('Remove'),
                              ),
                            if (widget.onMoveToCart != null)
                              const PopupMenuItem(
                                value: 'moveToCart',
                                child: Text('Move to Cart'),
                              ),
                          ],
                          icon: const Icon(Icons.more_vert),
                        ),
                      ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.productName,
                  style: const TextStyle(
                    fontSize: 14, 
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}