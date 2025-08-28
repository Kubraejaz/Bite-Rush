import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/order.dart';

class CartProvider with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items => _items;

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  void addToCart(Product product) {
    final existingItemIndex = _items.indexWhere((item) => item.productId == product.id);
    if (existingItemIndex >= 0) {
      _items[existingItemIndex] = OrderItem(
        productId: product.id,
        quantity: _items[existingItemIndex].quantity + 1,
        price: product.price,
      );
    } else {
      _items.add(OrderItem(productId: product.id, quantity: 1, price: product.price));
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  void clearCart() {
    _items = [];
    notifyListeners();
  }
}