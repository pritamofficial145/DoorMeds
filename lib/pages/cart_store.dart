import 'package:flutter/material.dart';

class CartStore {
  static final ValueNotifier<List<Map<String, dynamic>>> cartItems =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  static void addToCart(Map<String, String> product) {
    final List<Map<String, dynamic>> currentList =
        List<Map<String, dynamic>>.from(cartItems.value);

    final int index = currentList.indexWhere(
      (item) => item["title"] == product["title"],
    );

    if (index != -1) {
      currentList[index]["qty"] = currentList[index]["qty"] + 1;
    } else {
      currentList.add({
        "image": product["image"] ?? "assets/images/product/product1.png",
        "title": product["title"] ?? "Product",
        "price": product["price"] ?? "₹0",
        "oldPrice": product["oldPrice"] ?? "₹0",
        "qty": 1,
      });
    }

    cartItems.value = currentList;
  }

  static void increaseQty(int index) {
    final List<Map<String, dynamic>> currentList =
        List<Map<String, dynamic>>.from(cartItems.value);

    currentList[index]["qty"] = currentList[index]["qty"] + 1;

    cartItems.value = currentList;
  }

  static void decreaseQty(int index) {
    final List<Map<String, dynamic>> currentList =
        List<Map<String, dynamic>>.from(cartItems.value);

    if (currentList[index]["qty"] > 1) {
      currentList[index]["qty"] = currentList[index]["qty"] - 1;
    }

    cartItems.value = currentList;
  }

  static void removeItem(int index) {
    final List<Map<String, dynamic>> currentList =
        List<Map<String, dynamic>>.from(cartItems.value);

    currentList.removeAt(index);

    cartItems.value = currentList;
  }

  static int priceToInt(String price) {
    return int.tryParse(
          price.replaceAll("₹", "").replaceAll(",", "").trim(),
        ) ??
        0;
  }

  static int totalItems(List<Map<String, dynamic>> items) {
    int total = 0;

    for (final item in items) {
      total += item["qty"] as int;
    }

    return total;
  }

  static int amount(List<Map<String, dynamic>> items) {
    int total = 0;

    for (final item in items) {
      total += priceToInt(item["price"]) * (item["qty"] as int);
    }

    return total;
  }

  static int deliveryCharge(List<Map<String, dynamic>> items) {
    if (items.isEmpty) return 0;
    return 50;
  }

  static int promoDiscount(List<Map<String, dynamic>> items) {
    if (items.isEmpty) return 0;
    return (amount(items) * 0.10).round();
  }

  static int totalAmount(List<Map<String, dynamic>> items) {
    return amount(items) + deliveryCharge(items) - promoDiscount(items);
  }
}