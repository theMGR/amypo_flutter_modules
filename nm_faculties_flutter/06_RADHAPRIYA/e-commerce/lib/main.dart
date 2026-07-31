import 'package:flutter/material.dart';

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class Product {
  final String name;
  final double price;
  final IconData icon;

  Product(this.name, this.price, this.icon);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Product> products = [
    Product("Laptop", 55000, Icons.laptop),
    Product("Mobile", 20000, Icons.phone_android),
    Product("Headphones", 2500, Icons.headphones),
    Product("Smart Watch", 6000, Icons.watch),
    Product("Keyboard", 1500, Icons.keyboard),
    Product("Mouse", 800, Icons.mouse),
  ];

  final List<Product> cart = [];

  double get total =>
      cart.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Commerce App"),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartPage(cart: cart),
                    ),
                  );
                },
              ),
              if (cart.isNotEmpty)
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    "${cart.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(item.icon, size: 40),
              title: Text(item.name),
              subtitle: Text("₹${item.price.toStringAsFixed(0)}"),
              trailing: ElevatedButton(
                child: const Text("Add"),
                onPressed: () {
                  setState(() {
                    cart.add(item);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${item.name} added to cart"),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(16),
        child: Text(
          "Cart Total: ₹${total.toStringAsFixed(0)}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> cart;

  const CartPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    double total =
    cart.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
      ),
      body: cart.isEmpty
          ? const Center(
        child: Text(
          "Your cart is empty",
          style: TextStyle(fontSize: 20),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];

                return ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.name),
                  trailing: Text(
                    "₹${item.price.toStringAsFixed(0)}",
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade100,
            child: Column(
              children: [
                Text(
                  "Total: ₹${total.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                        Text("Order placed successfully!"),
                      ),
                    );
                  },
                  child: const Text("Checkout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}