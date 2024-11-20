import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/product_controller.dart';

class ProductListView extends ConsumerStatefulWidget {
  const ProductListView({super.key});

  @override
  ProductListViewState createState() => ProductListViewState();
}

class ProductListViewState extends ConsumerState<ProductListView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 243, 231),
      appBar: AppBar(
        title: const Text('Search Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final productName = _controller.text;
                if (productName.isNotEmpty) {
                  ref.read(productProvider.notifier).fetchProductList(productName);
                }
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 10),
            products.isEmpty
                ? const Center(child: Text('There are no products listed.'))
                : Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network(
                              product.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(product.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\$${product.price.toStringAsFixed(2)}'),
                                const SizedBox(height: 4),
                                Text(
                                  product.description, 
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2, 
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}