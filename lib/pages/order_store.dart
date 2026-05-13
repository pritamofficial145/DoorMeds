import 'package:flutter/material.dart';

class OrderStore {
  static final ValueNotifier<List<Map<String, dynamic>>> orders =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  static void addOrder(Map<String, dynamic> order) {
    final currentOrders = List<Map<String, dynamic>>.from(orders.value);
    currentOrders.insert(0, order);
    orders.value = currentOrders;
  }

  static void markDelivered(String orderId) {
    final currentOrders = List<Map<String, dynamic>>.from(orders.value);

    final index = currentOrders.indexWhere(
      (order) => order["orderId"] == orderId,
    );

    if (index != -1) {
      currentOrders[index]["delivered"] = true;
      currentOrders[index]["status"] = "Delivered";
      currentOrders[index]["step"] = 4;
      orders.value = currentOrders;
    }
  }

  static void clearOrders() {
    orders.value = [];
  }
}