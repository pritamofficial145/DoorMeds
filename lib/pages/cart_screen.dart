import 'package:flutter/material.dart';
import 'home_page.dart';
import 'wish_list.dart';
import 'profile_screen.dart';
import 'cart_store.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int selectedNavIndex = 1;

  String formatPrice(int value) {
    return "₹$value.00";
  }

  Widget assetImage(String path, {double height = 78}) {
    return Image.asset(
      path,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          height: height,
          child: const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey,
              size: 28,
            ),
          ),
        );
      },
    );
  }

  Widget quantityButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isPlus = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPlus ? const Color(0xff6E22D5) : const Color(0xffE7E7E7),
        ),
        child: Icon(
          icon,
          size: 11,
          color: isPlus ? Colors.white : Colors.black54,
        ),
      ),
    );
  }

  Widget cartItemCard(
    int index,
    Map<String, dynamic> item,
  ) {
    return Dismissible(
      key: ValueKey(item["title"] + index.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        CartStore.removeItem(index);
      },
      background: Container(
        height: 86,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: const Color(0xffF8DCDD),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.red,
          size: 26,
        ),
      ),
      child: Container(
        height: 86,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 62,
              child: Center(
                child: assetImage(
                  item["image"],
                  height: 66,
                ),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9.8,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        item["price"],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item["oldPrice"],
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Spacer(),
                      quantityButton(
                        icon: Icons.remove,
                        onTap: () {
                          CartStore.decreaseQty(index);
                        },
                      ),
                      const SizedBox(width: 7),
                      Text(
                        "${item["qty"]}",
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 7),
                      quantityButton(
                        icon: Icons.add,
                        isPlus: true,
                        onTap: () {
                          CartStore.increaseQty(index);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: bold ? FontWeight.w900 : FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: bold ? FontWeight.w900 : FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget emptyCart() {
    return Padding(
      padding: const EdgeInsets.only(top: 120),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffF0EDFF),
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 45,
              color: Color(0xff745CFF),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Add medicines to continue shopping",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget navIcon({
    required int index,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final bool selected = selectedNavIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedNavIndex = index;
        });

        Future.delayed(const Duration(milliseconds: 160), onTap);
      },
      child: AnimatedScale(
        scale: selected ? 1.15 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: selected ? 54 : 42,
          height: selected ? 54 : 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: selected
                ? const LinearGradient(
                    colors: [
                      Color(0xff9C27E8),
                      Color(0xff2878E8),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  )
                : null,
            color: selected ? null : Colors.transparent,
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: const Color(0xff745CFF).withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Icon(
            icon,
            color: selected ? Colors.white : Colors.black87,
            size: selected ? 30 : 29,
          ),
        ),
      ),
    );
  }

  Widget upgradedBottomNavBar() {
    return Container(
      height: 82,
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.13),
            blurRadius: 18,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navIcon(
            index: 0,
            icon: Icons.home_rounded,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false,
              );
            },
          ),
          navIcon(
            index: 1,
            icon: Icons.shopping_cart,
            onTap: () {},
          ),
          navIcon(
            index: 2,
            icon: Icons.favorite,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WishList(),
                ),
              );
            },
          ),
          navIcon(
            index: 3,
            icon: Icons.person_outline,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: CartStore.cartItems,
      builder: (context, cartItems, child) {
        final int totalItems = CartStore.totalItems(cartItems);
        final int amount = CartStore.amount(cartItems);
        final int deliveryCharge = CartStore.deliveryCharge(cartItems);
        final int promoDiscount = CartStore.promoDiscount(cartItems);
        final int totalAmount = CartStore.totalAmount(cartItems);

        return Scaffold(
          backgroundColor: const Color(0xffF7F7F7),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff9C27E8),
                                Color(0xff2878E8),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            "My Cart",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 28),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (cartItems.isEmpty)
                    emptyCart()
                  else ...[
                    ListView.separated(
                      itemCount: cartItems.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                      itemBuilder: (context, index) {
                        return cartItemCard(
                          index,
                          cartItems[index],
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffECECEC),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          summaryRow("Total Items", "$totalItems"),
                          summaryRow("Amount", formatPrice(amount)),
                          summaryRow(
                            "Delivery Charge",
                            formatPrice(deliveryCharge),
                          ),
                          summaryRow(
                            "Promo",
                            "-${formatPrice(promoDiscount)}",
                          ),
                          const Divider(
                            color: Color(0xffD0D0D0),
                            thickness: 1,
                            height: 16,
                          ),
                          summaryRow(
                            "Total Amount",
                            formatPrice(totalAmount),
                            bold: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          bottomNavigationBar: upgradedBottomNavBar(),
        );
      },
    );
  }
}