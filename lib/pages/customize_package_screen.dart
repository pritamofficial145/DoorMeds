import 'package:flutter/material.dart';
import 'cart_store.dart';

class CustomizePackageScreen extends StatefulWidget {
  const CustomizePackageScreen({super.key});

  @override
  State<CustomizePackageScreen> createState() => _CustomizePackageScreenState();
}

class _CustomizePackageScreenState extends State<CustomizePackageScreen> {
  final List<Map<String, dynamic>> medicines = [
    {
      "image": "assets/images/product/product1.png",
      "name": "Pain Relief Oil",
      "price": 144,
      "oldPrice": 399,
      "category": "Pain Relief",
      "selected": false,
    },
    {
      "image": "assets/images/product/product2.png",
      "name": "Ayurvedic Pain Relief Oil",
      "price": 144,
      "oldPrice": 399,
      "category": "Ayurvedic",
      "selected": false,
    },
    {
      "image": "assets/images/product/product3.png",
      "name": "Natural Herbal Oil",
      "price": 185,
      "oldPrice": 250,
      "category": "Herbal Care",
      "selected": false,
    },
    {
      "image": "assets/images/product/product9.png",
      "name": "Vitamin Supplement",
      "price": 349,
      "oldPrice": 420,
      "category": "Vitamins",
      "selected": false,
    },
    {
      "image": "assets/images/product/product10.png",
      "name": "Health Capsules",
      "price": 499,
      "oldPrice": 599,
      "category": "Wellness",
      "selected": false,
    },
    {
      "image": "assets/images/product/product11.png",
      "name": "Multivitamin Tablets",
      "price": 275,
      "oldPrice": 350,
      "category": "Daily Health",
      "selected": false,
    },
    {
      "image": "assets/images/product/product12.png",
      "name": "Vitamin D3 Supplement",
      "price": 189,
      "oldPrice": 250,
      "category": "Bone Health",
      "selected": false,
    },
    {
      "image": "assets/images/product/product14.png",
      "name": "Digital Thermometer",
      "price": 299,
      "oldPrice": 399,
      "category": "Health Device",
      "selected": false,
    },
  ];

  int get selectedCount {
    return medicines.where((medicine) => medicine["selected"] == true).length;
  }

  int get totalAmount {
    int total = 0;

    for (final medicine in medicines) {
      if (medicine["selected"] == true) {
        total += medicine["price"] as int;
      }
    }

    return total;
  }

  int get totalOldAmount {
    int total = 0;

    for (final medicine in medicines) {
      if (medicine["selected"] == true) {
        total += medicine["oldPrice"] as int;
      }
    }

    return total;
  }

  int get savedAmount {
    return totalOldAmount - totalAmount;
  }

  List<Map<String, dynamic>> get selectedMedicines {
    return medicines.where((medicine) => medicine["selected"] == true).toList();
  }

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
              size: 28,
            ),
          ),
        );
      },
    );
  }

  void createPackage() {
    if (selectedCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select at least one medicine"),
          backgroundColor: Color(0xff745CFF),
        ),
      );
      return;
    }

    showPackageCreatedPopup();
  }

  void addPackageToCart() {
    for (final medicine in selectedMedicines) {
      CartStore.addToCart({
        "image": medicine["image"],
        "title": medicine["name"],
        "price": "₹${medicine["price"]}",
        "oldPrice": "₹${medicine["oldPrice"]}",
      });
    }

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Medicine package added to cart"),
        backgroundColor: Color(0xff745CFF),
      ),
    );
  }

  void showPackageCreatedPopup() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.25),
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 78,
                  height: 78,
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
                    Icons.medication_liquid_outlined,
                    color: Colors.white,
                    size: 42,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "Medicine Package Created",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "$selectedCount medicines selected\nTotal Amount: ₹$totalAmount",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                if (savedAmount > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    "You saved ₹$savedAmount",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff22C55E),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],

                const SizedBox(height: 22),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xff745CFF),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            color: Color(0xff745CFF),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Container(
                        height: 45,
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
                          onPressed: addPackageToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            "Add Cart",
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
          ),
        );
      },
    );
  }

  Widget medicineCard(int index) {
    final medicine = medicines[index];
    final bool selected = medicine["selected"] == true;

    return GestureDetector(
      onTap: () {
        setState(() {
          medicine["selected"] = !selected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffF4F1FF) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? const Color(0xff745CFF) : const Color(0xffEEEEEE),
            width: selected ? 1.4 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 78,
                  height: 78,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: assetImage(
                    medicine["image"],
                    height: 68,
                  ),
                ),

                if (selected)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xff745CFF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine["name"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffF0EDFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      medicine["category"],
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xff745CFF),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        "₹${medicine["price"]}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        "₹${medicine["oldPrice"]}",
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Icon(
              selected
                  ? Icons.check_circle_rounded
                  : Icons.add_circle_outline_rounded,
              color: selected ? const Color(0xff745CFF) : Colors.grey.shade400,
              size: 27,
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSummary() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 14,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: selectedCount == 0
                ? const Text(
                    "Select medicines\nto create package",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      height: 1.35,
                      color: Colors.black87,
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$selectedCount Medicines",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Text(
                            "₹$totalAmount",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                          if (savedAmount > 0) ...[
                            const SizedBox(width: 6),
                            Text(
                              "Save ₹$savedAmount",
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xff22C55E),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
          ),

          Container(
            width: 160,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              gradient: const LinearGradient(
                colors: [
                  Color(0xff9C27E8),
                  Color(0xff2878E8),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff745CFF).withOpacity(0.22),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: createPackage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
              child: const Text(
                "Create Package",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
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
              "Customize Medicine Package",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xffF0EDFF),
            Color(0xffE8F1FF),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffDDD5FF),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            color: Color(0xff745CFF),
            size: 30,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Choose your regular medicines and create your own monthly medicine package.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                height: 1.35,
                fontWeight: FontWeight.w700,
              ),
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
      body: SafeArea(
        child: Column(
          children: [
            header(),
            infoBanner(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  return medicineCard(index);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomSummary(),
    );
  }
}