import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8016/products/';

  Future<List<Product>> fetchProductByName(String productName) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$productName'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['products'] as List;
        return data.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}