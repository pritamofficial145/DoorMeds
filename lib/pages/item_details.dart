import 'package:flutter/material.dart';

import 'order_summery.dart';
import 'wishlist_store.dart';
import 'cart_store.dart';

class ItemDetails extends StatefulWidget {
  final Map<String, String> product;

  const ItemDetails({
    super.key,
    required this.product,
  });

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int selectedTab = 0;

  final List<String> tabs = [
    "Specifications",
    "Description",
    "Manufacturer Info",
  ];

  final List<Map<String, String>> similarProducts = const [
    {
      "image": "assets/images/product/product1.png",
      "title": "Pain Relief Oil",
      "price": "₹144",
      "oldPrice": "₹399",
    },
    {
      "image": "assets/images/product/product2.png",
      "title": "Ayurvedic Pain Relief Oil",
      "price": "₹144",
      "oldPrice": "₹399",
    },
    {
      "image": "assets/images/product/product3.png",
      "title": "Natural Herbal Oil",
      "price": "₹185",
      "oldPrice": "₹250",
    },
  ];

  final List<Map<String, String>> exploreProducts = const [
    {
      "image": "assets/images/product/product5.png",
      "title": "Personal Care Product",
      "price": "₹199",
      "oldPrice": "₹299",
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
    {
      "image": "assets/images/product/product16.png",
      "title": "BP Monitor",
      "price": "₹849",
      "oldPrice": "₹1200",
    },
  ];

  String get productImage =>
      widget.product["image"] ?? "assets/images/product/product1.png";

  String get productTitle => widget.product["title"] ?? "Product Name";

  String get productPrice => widget.product["price"] ?? "₹144";

  String get oldPrice => widget.product["oldPrice"] ?? "₹399";

  Widget productImageWidget(String path, {double height = 100}) {
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

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget smallProductCard(Map<String, String> product) {
    final bool isSmallItemLiked =
        WishlistStore.isLiked(product["title"] ?? "");

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetails(product: product),
          ),
        );
      },
      child: Container(
        width: 105,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: const Color(0xffEEEEEE)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: productImageWidget(
                    product["image"]!,
                    height: 72,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  product["title"]!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Text(
                      product["price"]!,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff6A4CFF),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        product["oldPrice"]!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  WishlistStore.toggleWishlist(product);
                  setState(() {});
                },
                child: Icon(
                  isSmallItemLiked ? Icons.favorite : Icons.favorite_border,
                  color: isSmallItemLiked
                      ? const Color(0xffE91E63)
                      : Colors.grey.shade300,
                  size: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 10.5,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
      ],
    );
  }

  Widget detailRow(
    String leftTitle,
    String leftValue,
    String rightTitle,
    String rightValue,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: infoColumn(leftTitle, leftValue),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: infoColumn(rightTitle, rightValue),
          ),
        ],
      ),
    );
  }

  Widget productHighlights() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffEEEEEE)),
      ),
      child: Column(
        children: [
          detailRow(
            "Sales Package",
            "1 Pack",
            "Brand",
            "Doormeds",
          ),
          detailRow(
            "Model Name",
            productTitle,
            "Quantity",
            "Pack of 1",
          ),
          detailRow(
            "Container Type",
            "Bottle / Box",
            "Application Area",
            "Health & Wellness",
          ),
        ],
      ),
    );
  }

  Widget deliveryDetails() {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xffF5F0FF),
        borderRadius: BorderRadius.circular(13),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Color(0xff745CFF),
                size: 18,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Location not set. Select delivery location",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xff5B42D6),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 18),
          Row(
            children: [
              Icon(
                Icons.local_shipping_outlined,
                color: Color(0xff745CFF),
                size: 18,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Delivery by 2 Apr, Free",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 18),
          Row(
            children: [
              Icon(
                Icons.verified_outlined,
                color: Color(0xff745CFF),
                size: 18,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Fulfilled by Doormeds",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tabSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("All details"),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              tabs.length,
              (index) {
                final bool active = selectedTab == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: active ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: active ? Colors.black : const Color(0xffDDDDDD),
                      ),
                    ),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: active ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xffEEEEEE)),
          ),
          child: selectedTab == 0
              ? const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "In the Box",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Sales Package",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Pack of 1",
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      "General",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Brand: Doormeds\nContainer Type: Bottle / Box\nProduct Type: Health & Wellness\nCountry of Origin: India",
                      style: TextStyle(
                        fontSize: 10.5,
                        height: 1.6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : selectedTab == 1
                  ? Text(
                      "$productTitle is a health and wellness product. Use it as directed on the product package or as suggested by a physician.",
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : const Text(
                      "Manufacturer information and product details are provided by the seller. Please check the original package before use.",
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
        ),
      ],
    );
  }

  Widget productSection(String title, List<Map<String, String>> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(title),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return smallProductCard(list[index]);
            },
          ),
        ),
      ],
    );
  }

  void buyNow() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSummery(
          product: widget.product,
        ),
      ),
    );
  }

  void addToCart() {
    CartStore.addToCart(widget.product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$productTitle added to cart"),
        backgroundColor: const Color(0xff745CFF),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLiked = WishlistStore.isLiked(productTitle);

    final double discount = (() {
      final p =
          double.tryParse(productPrice.replaceAll(RegExp(r'[₹,]'), '')) ?? 0;
      final op = double.tryParse(oldPrice.replaceAll(RegExp(r'[₹,]'), '')) ?? 0;

      if (op == 0) return 0.0;

      return (((op - p) / op) * 100);
    })();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top icons
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
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

                  const Spacer(),

                  GestureDetector(
                    onTap: () {
                      WishlistStore.toggleWishlist(widget.product);
                      setState(() {});
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked
                          ? const Color(0xffE91E63)
                          : Colors.grey.shade300,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// Product image from clicked item
              Center(
                child: productImageWidget(
                  productImage,
                  height: 250,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                productTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Health & Wellness Product",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  Text(
                    productPrice,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    oldPrice,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${discount.round()}% off",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff745CFF),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: addToCart,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xff745CFF),
                          width: 1.3,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "Add to cart",
                        style: TextStyle(
                          color: Color(0xff745CFF),
                          fontSize: 12,
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
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff9C27E8),
                            Color(0xff2878E8),
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: buyNow,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              sectionTitle("Delivery details"),
              deliveryDetails(),

              sectionTitle("Product Highlights"),
              productHighlights(),

              tabSection(),

              productSection("Similar Product", similarProducts),

              productSection("Explore more like this", exploreProducts),
            ],
          ),
        ),
      ),
    );
  }
}