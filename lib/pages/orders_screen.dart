import 'package:flutter/material.dart';
import 'live_location.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final List<Map<String, dynamic>> orders = [
    {
      "orderId": "DM10245",
      "image": "assets/images/product/product1.png",
      "title": "Pain Relief Oil",
      "price": "₹144",
      "status": "Out for Delivery",
      "date": "13 May 2026",
      "time": "10:30 AM",
      "address": "XYZ, Near to Chain Smoker area, 122425",
      "delivered": false,
      "step": 3,
    },
    {
      "orderId": "DM10246",
      "image": "assets/images/product/product9.png",
      "title": "Vitamin Supplement",
      "price": "₹349",
      "status": "Packed",
      "date": "13 May 2026",
      "time": "09:15 AM",
      "address": "XYZ, Near to Chain Smoker area, 122425",
      "delivered": false,
      "step": 2,
    },
    {
      "orderId": "DM10247",
      "image": "assets/images/product/product14.png",
      "title": "Digital Thermometer",
      "price": "₹299",
      "status": "Order Confirmed",
      "date": "12 May 2026",
      "time": "07:45 PM",
      "address": "XYZ, Near to Chain Smoker area, 122425",
      "delivered": false,
      "step": 1,
    },
    {
      "orderId": "DM10248",
      "image": "assets/images/product/product11.png",
      "title": "Multivitamin Tablets",
      "price": "₹275",
      "status": "Delivered",
      "date": "10 May 2026",
      "time": "02:20 PM",
      "address": "XYZ, Near to Chain Smoker area, 122425",
      "delivered": true,
      "step": 4,
    },
    {
      "orderId": "DM10249",
      "image": "assets/images/product/product6.png",
      "title": "Skin Care Lotion",
      "price": "₹249",
      "status": "Delivered",
      "date": "05 May 2026",
      "time": "11:15 AM",
      "address": "XYZ, Near to Chain Smoker area, 122425",
      "delivered": true,
      "step": 4,
    },
  ];

  Widget assetImage(String path, {double height = 72}) {
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
              size: 30,
            ),
          ),
        );
      },
    );
  }

  Color statusColor(String status) {
    if (status == "Delivered") {
      return const Color(0xff16A34A);
    }

    if (status == "Out for Delivery") {
      return const Color(0xff22C55E);
    }

    if (status == "Packed") {
      return const Color(0xff2878E8);
    }

    return const Color(0xff745CFF);
  }

  void openLiveLocation(Map<String, dynamic> order) {
    Navigator.pop(context);

    if (order["delivered"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("This order is already delivered"),
          backgroundColor: Color(0xff22C55E),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveLocationScreen(
          order: order,
        ),
      ),
    );
  }

  void showTrackOrderSheet(Map<String, dynamic> order) {
    final bool isDelivered = order["delivered"] == true;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Text(
                      isDelivered ? "Order Delivered" : "Track Order",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.10),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7FB),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xffEEEEEE),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: assetImage(order["image"], height: 62),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order["title"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Order ID: ${order["orderId"]}",
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              order["price"],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xff745CFF),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                trackingStep(
                  title: "Order Confirmed",
                  subtitle: "Your order has been placed successfully.",
                  active: order["step"] >= 1,
                  completed: order["step"] > 1,
                ),
                trackingStep(
                  title: "Packed",
                  subtitle: "Your medicine is packed and ready.",
                  active: order["step"] >= 2,
                  completed: order["step"] > 2,
                ),
                trackingStep(
                  title: "Out for Delivery",
                  subtitle: isDelivered
                      ? "Your order reached your delivery address."
                      : "Delivery boy is on the way.",
                  active: order["step"] >= 3,
                  completed: order["step"] > 3,
                ),
                trackingStep(
                  title: "Delivered",
                  subtitle: isDelivered
                      ? "Order delivered successfully."
                      : "Order will be delivered soon.",
                  active: order["step"] >= 4,
                  completed: order["step"] >= 4,
                  showLine: false,
                ),

                const SizedBox(height: 18),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F1FF),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Color(0xff745CFF),
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          order["address"],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                Container(
                  width: double.infinity,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    gradient: LinearGradient(
                      colors: isDelivered
                          ? const [
                              Color(0xff22C55E),
                              Color(0xff16A34A),
                            ]
                          : const [
                              Color(0xff9C27E8),
                              Color(0xff2878E8),
                            ],
                    ),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (isDelivered) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("This order is already delivered"),
                            backgroundColor: Color(0xff22C55E),
                          ),
                        );
                      } else {
                        openLiveLocation(order);
                      }
                    },
                    icon: Icon(
                      isDelivered
                          ? Icons.check_circle_outline
                          : Icons.my_location_rounded,
                      color: Colors.white,
                      size: 19,
                    ),
                    label: Text(
                      isDelivered
                          ? "Delivered Successfully"
                          : "Track Live Location",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget trackingStep({
    required String title,
    required String subtitle,
    required bool active,
    required bool completed,
    bool showLine = true,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? const Color(0xff745CFF) : Colors.grey.shade300,
              ),
              child: Icon(
                completed ? Icons.check : Icons.circle,
                color: Colors.white,
                size: completed ? 18 : 9,
              ),
            ),
            if (showLine)
              Container(
                width: 2,
                height: 42,
                color: active ? const Color(0xff745CFF) : Colors.grey.shade300,
              ),
          ],
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: active ? Colors.black87 : Colors.grey,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget orderCard(Map<String, dynamic> order) {
    final bool isDelivered = order["delivered"] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffEEEEEE),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 76,
                height: 76,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xffF7F7FB),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: assetImage(order["image"], height: 65),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order["title"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "Order ID: ${order["orderId"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        Text(
                          order["price"],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff745CFF),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor(order["status"])
                                .withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order["status"],
                            style: TextStyle(
                              fontSize: 9.5,
                              color: statusColor(order["status"]),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xffF7F7FB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xff745CFF),
                  size: 19,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${order["date"]} • ${order["time"]}",
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    showTrackOrderSheet(order);
                  },
                  icon: Icon(
                    isDelivered
                        ? Icons.check_circle_outline
                        : Icons.local_shipping_outlined,
                    size: 18,
                  ),
                  label: Text(isDelivered ? "View Details" : "Track Order"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: isDelivered
                        ? const Color(0xff22C55E)
                        : const Color(0xff745CFF),
                    side: BorderSide(
                      color: isDelivered
                          ? const Color(0xff22C55E)
                          : const Color(0xff745CFF),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff9C27E8),
                        Color(0xff2878E8),
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Delivery support coming soon"),
                          backgroundColor: Color(0xff745CFF),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      "Need Help",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 32,
              height: 32,
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
                size: 19,
              ),
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Text(
              "My Orders",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xffF4F1FF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xff745CFF),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionLabel(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 8, 2, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeOrders =
        orders.where((order) => order["delivered"] == false).toList();

    final deliveredOrders =
        orders.where((order) => order["delivered"] == true).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF7F7FB),
      body: SafeArea(
        child: Column(
          children: [
            header(),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
                children: [
                  if (activeOrders.isNotEmpty) ...[
                    sectionLabel("Active Orders"),
                    ...activeOrders.map((order) => orderCard(order)),
                  ],

                  if (deliveredOrders.isNotEmpty) ...[
                    sectionLabel("Delivered Orders"),
                    ...deliveredOrders.map((order) => orderCard(order)),
                  ],

                  if (activeOrders.isEmpty && deliveredOrders.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 120),
                      child: Center(
                        child: Text(
                          "No orders found",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
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
      ),
    );
  }
}