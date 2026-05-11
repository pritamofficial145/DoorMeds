import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      "title": "Medicine",
      "icon": Icons.medication_liquid,
      "color": Color(0xff7C4DFF),
    },
    {
      "title": "Magazines",
      "icon": Icons.menu_book,
      "color": Color(0xffFF5CA8),
    },
    {
      "title": "Babycare",
      "icon": Icons.child_care,
      "color": Color(0xff3D9BFF),
    },
    {
      "title": "Covid Care",
      "icon": Icons.coronavirus,
      "color": Color(0xff7C4DFF),
    },
    {
      "title": "Health",
      "icon": Icons.favorite,
      "color": Color(0xffFF5CA8),
    },
  ];

  final List<Map<String, String>> products = const [
    {
      "image": "assets/images/product1.png",
      "title": "Zandu Pure Honey",
      "price": "₹185",
      "oldPrice": "₹210",
    },
    {
      "image": "assets/images/product2.png",
      "title": "Antiseptic Liquid",
      "price": "₹140",
      "oldPrice": "₹165",
    },
    {
      "image": "assets/images/product3.png",
      "title": "Herbal Face Wash",
      "price": "₹110",
      "oldPrice": "₹140",
    },
    {
      "image": "assets/images/product4.png",
      "title": "Health Supplement",
      "price": "₹220",
      "oldPrice": "₹260",
    },
  ];

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 8,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          const Text(
            "See all",
            style: TextStyle(
              fontSize: 11,
              color: Color(0xff745CFF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget productCard(Map<String, String> product) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              product["image"]!,
              height: 95,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product["title"]!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                product["price"]!,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6A4CFF),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                product["oldPrice"]!,
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget productGrid(List<Map<String, String>> productList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: productList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.78,
        ),
        itemBuilder: (context, index) {
          final product = productList[index];

          return Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xffEEEEEE)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      product["image"]!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  product["title"]!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      product["price"]!,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff6A4CFF),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      product["oldPrice"]!,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget quickAction(IconData icon, String title) {
    return Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xffF3F1FF),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color: const Color(0xff745CFF),
            size: 24,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi Pritam",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "Have a great day!",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Color(0xffF4F1FF),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: const Icon(
                        Icons.notifications_none,
                        color: Color(0xff745CFF),
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),

              /// Search Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xffE6E6E6)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, size: 20, color: Colors.black54),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Search medicine...",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Icon(Icons.camera_alt_outlined, size: 20),
                    ],
                  ),
                ),
              ),

              /// Banner
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/banner.png",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Category
              sectionTitle("Category"),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: categories.map((item) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 23,
                          backgroundColor: item["color"],
                          child: Icon(
                            item["icon"],
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item["title"],
                          style: const TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              /// Quick Actions
              sectionTitle("Quick Actions"),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    quickAction(Icons.biotech, "Lab test"),
                    const SizedBox(width: 16),
                    quickAction(Icons.shopping_bag_outlined, "Orders"),
                    const SizedBox(width: 16),
                    quickAction(Icons.description_outlined, "Reports"),
                    const SizedBox(width: 16),
                    quickAction(Icons.upload_file, "Upload"),
                  ],
                ),
              ),

              /// Just for you
              sectionTitle("Just for you"),
              productGrid(products),

              /// Personal Care
              sectionTitle("Personal Care"),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return productCard(products[index]);
                  },
                ),
              ),

              /// Vitamins
              sectionTitle("Vitamins & Supplements"),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return productCard(products[index]);
                  },
                ),
              ),

              /// Popular Items
              sectionTitle("Popular Items"),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return productCard(products[index]);
                  },
                ),
              ),

              /// Health Care Device
              sectionTitle("HealthCare Device"),
              productGrid(products),

              /// Deals
              sectionTitle("Deals you'll love"),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/deal_banner.png",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /// Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
        selectedItemColor: const Color(0xff745CFF),
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}