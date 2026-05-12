import 'package:flutter/material.dart';
import 'cart_store.dart';

class OrderAgainScreen extends StatefulWidget {
  const OrderAgainScreen({super.key});

  @override
  State<OrderAgainScreen> createState() => _OrderAgainScreenState();
}

class _OrderAgainScreenState extends State<OrderAgainScreen> {
  final List<Map<String, String>> previousOrders = const [
    {
      "image": "assets/images/product/product1.png",
      "title": "Pain Relief Oil",
      "price": "₹144",
      "oldPrice": "₹399",
    },
    {
      "image": "assets/images/product/product9.png",
      "title": "Vitamin Supplement",
      "price": "₹349",
      "oldPrice": "₹420",
    },
    {
      "image": "assets/images/product/product14.png",
      "title": "Digital Thermometer",
      "price": "₹299",
      "oldPrice": "₹399",
    },
  ];

  Widget assetImage(String path) {
    return Image.asset(
      path,
      height: 75,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) {
        return const Icon(Icons.image_not_supported_outlined);
      },
    );
  }

  void orderAgain(Map<String, String> product) {
    CartStore.addToCart(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product["title"]} added to cart"),
        backgroundColor: const Color(0xff745CFF),
      ),
    );
  }

  Widget orderCard(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 78,
            child: assetImage(item["image"]!),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"]!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      item["price"]!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff745CFF),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item["oldPrice"]!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                SizedBox(
                  height: 34,
                  child: ElevatedButton(
                    onPressed: () => orderAgain(item),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff745CFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      "Order Again",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Order Again",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: previousOrders.length,
        itemBuilder: (context, index) {
          return orderCard(previousOrders[index]);
        },
      ),
    );
  }
}