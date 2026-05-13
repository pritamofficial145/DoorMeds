import 'package:flutter/material.dart';
import 'payment_screen.dart';

class OrderSummery extends StatelessWidget {
  final Map<String, String> product;

  const OrderSummery({
    super.key,
    required this.product,
  });

  String get productImage =>
      product["image"] ?? "assets/images/product/product1.png";

  String get productTitle =>
      product["title"] ??
      "Kerala Ayurveda Murivenna Oil For Burns, Cuts, and Sprains";

  String get productPrice => product["price"] ?? "₹144";

  String get oldPrice => product["oldPrice"] ?? "₹399";

  Widget productImageWidget(String path, {double height = 120}) {
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
              size: 35,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }

  Widget stepCircle({
    required String number,
    required bool active,
  }) {
    return Container(
      width: 21,
      height: 21,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? const Color(0xff745CFF) : Colors.grey.shade400,
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget stepperLine({required bool active}) {
    return Expanded(
      child: Container(
        height: 1.4,
        color: active ? const Color(0xff745CFF) : Colors.grey.shade300,
      ),
    );
  }

  Widget orderStepper() {
    return Column(
      children: [
        Row(
          children: [
            stepCircle(number: "1", active: true),
            stepperLine(active: true),
            stepCircle(number: "2", active: true),
            stepperLine(active: false),
            stepCircle(number: "3", active: false),
          ],
        ),
        const SizedBox(height: 5),
        const Row(
          children: [
            Expanded(
              child: Text(
                "Address",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Order summary",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Payment",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget priceRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
              color: Colors.black,
              fontWeight: bold ? FontWeight.w900 : FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  void continuePayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          product: product,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 31,
                          height: 31,
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
                      const Text(
                        "Order Summary",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  orderStepper(),
                ],
              ),
            ),

            const SizedBox(height: 2),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Deliver to :",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffEFEFEF),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Text(
                                  "Change",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 13),
                          const Text(
                            "Pritam Biswas",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 13),
                          const Text(
                            "XYZ , Near to Chain Smoker area, 122425",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 22,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: productImageWidget(
                              productImage,
                              height: 135,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productTitle,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    height: 1.25,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Text(
                                      productPrice,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                    Text(
                                      oldPrice,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                    const Text(
                                      "57% off",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Color(0xff745CFF),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(18, 22, 18, 8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          priceRow("MRP", oldPrice),
                          priceRow("Discount", "57% off"),
                          priceRow("Delivery Charge", "₹50"),
                          const Divider(
                            height: 8,
                            thickness: 1,
                            color: Color(0xffEFEFEF),
                          ),
                          const SizedBox(height: 12),
                          priceRow("Total Amount", productPrice, bold: true),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 150,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff9C27E8),
                                Color(0xff2878E8),
                              ],
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              continuePayment(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}