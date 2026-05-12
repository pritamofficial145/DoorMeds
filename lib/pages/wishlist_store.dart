import 'package:flutter/material.dart';

class WishlistStore {
  static final ValueNotifier<List<Map<String, String>>> wishlistItems =
      ValueNotifier<List<Map<String, String>>>([]);

  static bool isLiked(String title) {
    return wishlistItems.value.any((item) => item["title"] == title);
  }

  static void toggleWishlist(Map<String, String> product) {
    final List<Map<String, String>> currentList =
        List<Map<String, String>>.from(wishlistItems.value);

    final bool alreadyLiked =
        currentList.any((item) => item["title"] == product["title"]);

    if (alreadyLiked) {
      currentList.removeWhere((item) => item["title"] == product["title"]);
    } else {
      currentList.add(product);
    }

    wishlistItems.value = currentList;
  }

  static void removeFromWishlist(String title) {
    final List<Map<String, String>> currentList =
        List<Map<String, String>>.from(wishlistItems.value);

    currentList.removeWhere((item) => item["title"] == title);

    wishlistItems.value = currentList;
  }
}