import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../models/user.dart';
import '../constants/strings.dart';

class ApiService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(ApiEndpoints.products));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception(AppStrings.errorNetwork);
    }
  }

  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.login),
      body: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(AppStrings.errorAuth);
    }
  }

  Future<User> signup(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.register),
      body: {'name': name, 'email': email, 'password': password},
    );
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(AppStrings.errorAuth);
    }
  }

  Future<void> placeOrder(List<OrderItem> items, String token) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.orders),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'items': items.map((item) => item.toJson()).toList()}),
    );
    if (response.statusCode != 201) {
      throw Exception(AppStrings.errorGeneral);
    }
  }
}