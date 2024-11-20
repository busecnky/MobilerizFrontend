import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductController extends StateNotifier<List<Product>> {
  final ApiService _apiService;
  ProductController(this._apiService) : super([]);

  Future<void> fetchProductList(String name) async {
    try {
      final products = await _apiService.fetchProductByName(name);
      state = products; 
    } catch (e) {
      state = []; 
    }
  }
}

final productProvider = StateNotifierProvider<ProductController, List<Product>>(
  (ref) => ProductController(ApiService()),
);
