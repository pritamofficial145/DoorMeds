import 'package:flutter/material.dart';
import 'home_page.dart';
import 'order_store.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, String>? product;

  const PaymentScreen({
    super.key,
    this.product,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPayment;
  bool orderSaved = false;

  final TextEditingController upiController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController emiPlanController = TextEditingController();

  @override
  void dispose() {
    upiController.dispose();
    cardNumberController.dispose();
    cardHolderController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    emiPlanController.dispose();
    super.dispose();
  }

  Map<String, String> get currentProduct {
    return widget.product ??
        {
          "image": "assets/images/product/product1.png",
          "title": "Pain Relief Oil",
          "price": "₹144",
          "oldPrice": "₹399",
        };
  }

  String createOrderId() {
    final now = DateTime.now();
    return "DM${now.millisecondsSinceEpoch.toString().substring(7)}";
  }

  String currentDate() {
    final now = DateTime.now();
    return "${now.day}/${now.month}/${now.year}";
  }

  String currentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, "0");
    final period = now.hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $period";
  }

  void selectPayment(String method) {
    setState(() {
      selectedPayment = method;
    });
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xff745CFF),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  bool validatePaymentInfo() {
    if (selectedPayment == "cod") {
      return true;
    }

    if (selectedPayment == "upi") {
      if (upiController.text.trim().isEmpty) {
        showMessage("Please enter your UPI ID");
        return false;
      }
      return true;
    }

    if (selectedPayment == "card") {
      if (cardNumberController.text.trim().isEmpty) {
        showMessage("Please enter card number");
        return false;
      }

      if (cardHolderController.text.trim().isEmpty) {
        showMessage("Please enter card holder name");
        return false;
      }

      if (expiryController.text.trim().isEmpty) {
        showMessage("Please enter expiry date");
        return false;
      }

      if (cvvController.text.trim().isEmpty) {
        showMessage("Please enter CVV");
        return false;
      }

      return true;
    }

    if (selectedPayment == "emi") {
      if (cardNumberController.text.trim().isEmpty) {
        showMessage("Please enter card number");
        return false;
      }

      if (cardHolderController.text.trim().isEmpty) {
        showMessage("Please enter card holder name");
        return false;
      }

      if (expiryController.text.trim().isEmpty) {
        showMessage("Please enter expiry date");
        return false;
      }

      if (cvvController.text.trim().isEmpty) {
        showMessage("Please enter CVV");
        return false;
      }

      if (emiPlanController.text.trim().isEmpty) {
        showMessage("Please enter EMI plan");
        return false;
      }

      return true;
    }

    showMessage("Please select payment method");
    return false;
  }

  void saveOrderToStore() {
    if (orderSaved) return;

    OrderStore.addOrder({
      "orderId": createOrderId(),
      "image": currentProduct["image"] ?? "assets/images/product/product1.png",
      "title": currentProduct["title"] ?? "Medicine Order",
      "price": currentProduct["price"] ?? "₹0",
      "oldPrice": currentProduct["oldPrice"] ?? "",
      "status": "Order Confirmed",
      "date": currentDate(),
      "time": currentTime(),
      "address": "XYZ, Near to Chain Smoker area, 122425",
      "delivered": false,
      "step": 1,
      "paymentMethod": selectedPayment ?? "cod",
    });

    orderSaved = true;
  }

  void placeOrder() {
    if (validatePaymentInfo()) {
      saveOrderToStore();
      showOrderConfirmedPopup();
    }
  }

  void showOrderConfirmedPopup() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Order Confirmed",
      barrierColor: const Color(0xffF4E6FF).withOpacity(0.95),
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: curvedAnimation,
            child: Center(
              child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.symmetric(horizontal: 42),
                child: Container(
                  height: 360,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.elasticOut,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              width: 92,
                              height: 92,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff2878E8),
                                    Color(0xff9C27E8),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff745CFF)
                                        .withOpacity(0.35),
                                    blurRadius: 18,
                                    offset: const Offset(0, 7),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 58,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        "Order Confirmed !!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Your medicine order has been placed successfully.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        width: 170,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff9C27E8),
                              Color(0xff2878E8),
                            ],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: const Text(
                            "Go to home",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget inputField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        obscureText: obscureText,
        cursorColor: const Color(0xff745CFF),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          counterText: "",
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xff745CFF),
            size: 19,
          ),
          filled: true,
          fillColor: const Color(0xffF7F5FF),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 13,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xff745CFF),
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget placeOrderButton() {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xff9C27E8),
            Color(0xff2878E8),
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: placeOrder,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: const Text(
          "Place Order",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget paymentDetailsBox(String value, String title) {
    if (value == "cod") {
      return Column(
        children: [
          const Text(
            "Due to handling costs, a nominal fee of ₹10 will be charged for order placed using this option.",
            style: TextStyle(
              fontSize: 10,
              color: Colors.black54,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          placeOrderButton(),
        ],
      );
    }

    if (value == "upi") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter your UPI ID to continue",
            style: TextStyle(
              fontSize: 11,
              color: Colors.black54,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          inputField(
            hint: "example@upi",
            icon: Icons.account_balance_wallet_outlined,
            controller: upiController,
            keyboardType: TextInputType.emailAddress,
          ),
          placeOrderButton(),
        ],
      );
    }

    if (value == "card") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter your card details",
            style: TextStyle(
              fontSize: 11,
              color: Colors.black54,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          inputField(
            hint: "Card Number",
            icon: Icons.credit_card,
            controller: cardNumberController,
            keyboardType: TextInputType.number,
            maxLength: 16,
          ),
          inputField(
            hint: "Card Holder Name",
            icon: Icons.person_outline,
            controller: cardHolderController,
          ),
          Row(
            children: [
              Expanded(
                child: inputField(
                  hint: "MM/YY",
                  icon: Icons.calendar_month_outlined,
                  controller: expiryController,
                  keyboardType: TextInputType.datetime,
                  maxLength: 5,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: inputField(
                  hint: "CVV",
                  icon: Icons.lock_outline,
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  obscureText: true,
                ),
              ),
            ],
          ),
          placeOrderButton(),
        ],
      );
    }

    if (value == "emi") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter card details for EMI",
            style: TextStyle(
              fontSize: 11,
              color: Colors.black54,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          inputField(
            hint: "Card Number",
            icon: Icons.credit_card,
            controller: cardNumberController,
            keyboardType: TextInputType.number,
            maxLength: 16,
          ),
          inputField(
            hint: "Card Holder Name",
            icon: Icons.person_outline,
            controller: cardHolderController,
          ),
          Row(
            children: [
              Expanded(
                child: inputField(
                  hint: "MM/YY",
                  icon: Icons.calendar_month_outlined,
                  controller: expiryController,
                  keyboardType: TextInputType.datetime,
                  maxLength: 5,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: inputField(
                  hint: "CVV",
                  icon: Icons.lock_outline,
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  obscureText: true,
                ),
              ),
            ],
          ),
          inputField(
            hint: "EMI Plan e.g. 3 months / 6 months",
            icon: Icons.payments_outlined,
            controller: emiPlanController,
          ),
          placeOrderButton(),
        ],
      );
    }

    return Text(
      "You selected $title. Fill the details to place your order.",
      style: const TextStyle(
        fontSize: 10,
        color: Colors.black54,
        height: 1.35,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget paymentMethod({
    required String title,
    required String subtitle,
    required String value,
  }) {
    final bool isSelected = selectedPayment == value;

    return GestureDetector(
      onTap: () {
        selectPayment(value);
      },
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(70, 16, 18, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        if (subtitle.isNotEmpty) ...[
                          const SizedBox(height: 5),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xff745CFF),
                      size: 20,
                    ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.fromLTRB(38, 0, 38, 14),
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: paymentDetailsBox(value, title),
              ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xffEEEEEE),
            ),
          ],
        ),
      ),
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

  Widget paymentStepper() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          Row(
            children: [
              stepCircle(number: "1", active: true),
              stepperLine(active: true),
              stepCircle(number: "2", active: true),
              stepperLine(active: true),
              stepCircle(number: "3", active: true),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
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
                        "Payments",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  paymentStepper(),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    paymentMethod(
                      title: "UPI",
                      subtitle: "Pay by any UPI app",
                      value: "upi",
                    ),
                    paymentMethod(
                      title: "Credit/ Debit/ ATM Card",
                      subtitle: "Add and secure cards as per RBI guidelines",
                      value: "card",
                    ),
                    paymentMethod(
                      title: "EMI",
                      subtitle: "Pay using monthly installment",
                      value: "emi",
                    ),
                    paymentMethod(
                      title: "Cash on Delivery",
                      subtitle: "Pay when medicine reaches your home",
                      value: "cod",
                    ),
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