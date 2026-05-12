import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'cart_screen.dart';
import 'wish_list.dart';
import 'profile_screen.dart';
import 'item_details.dart';
import 'wishlist_store.dart';

import 'category_products_screen.dart';
import 'order_again_screen.dart';
import 'orders_screen.dart';
import 'reports_screen.dart';
import 'customize_package_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController bannerController = PageController();
  final TextEditingController searchController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();

  int currentBannerIndex = 0;
  int selectedNavIndex = 0;

  Timer? bannerTimer;

  String searchText = "";

  List<Map<String, dynamic>> notifications = [
    {
      "title": "Order Update",
      "message": "Your medicine order is being processed.",
      "read": false,
    },
    {
      "title": "Special Offer",
      "message": "Get 20% off on wellness products today.",
      "read": false,
    },
    {
      "title": "Prescription Reminder",
      "message": "Upload your prescription to complete your order.",
      "read": true,
    },
  ];

  static const List<String> banners = [
    "assets/images/banner/banner1.png",
    "assets/images/banner/banner2.png",
    "assets/images/banner/banner3.png",
  ];

  static const List<Map<String, dynamic>> categories = [
    {
      "title": "Medicine",
      "icon": Icons.medication_liquid_outlined,
      "color": Color(0xff745CFF),
    },
    {
      "title": "Ayurveda",
      "icon": Icons.eco_outlined,
      "color": Color(0xff22C55E),
    },
    {
      "title": "Baby Care",
      "icon": Icons.child_care_outlined,
      "color": Color(0xffFF5CA8),
    },
    {
      "title": "Devices",
      "icon": Icons.monitor_heart_outlined,
      "color": Color(0xff2878E8),
    },
    {
      "title": "Wellness",
      "icon": Icons.fitness_center_outlined,
      "color": Color(0xffFF9800),
    },
  ];

  static const List<Map<String, String>> products = [
    {
      "image": "assets/images/product/product1.png",
      "title": "Pain Relief Oil",
      "price": "₹144",
      "oldPrice": "₹399",
      "brand": "Doormeds Ayurveda",
      "type": "Ayurvedic Pain Relief Oil",
      "quantity": "100 ml",
      "package": "1 Bottle",
      "description":
          "Pain Relief Oil helps reduce muscle pain, joint stiffness, back pain and body ache.",
      "benefits":
          "Helps in joint pain, muscle pain, back pain, sprain and stiffness.",
      "usage": "Apply gently on affected area 2 times daily or as directed.",
      "caution": "For external use only. Avoid contact with eyes.",
    },
    {
      "image": "assets/images/product/product2.png",
      "title": "Ayurvedic Pain Relief Oil",
      "price": "₹144",
      "oldPrice": "₹399",
      "brand": "Herbal Care",
      "type": "Pain Relief Massage Oil",
      "quantity": "120 ml",
      "package": "1 Bottle",
      "description":
          "Ayurvedic Pain Relief Oil gives soothing comfort from body pain.",
      "benefits": "Useful for knee pain, shoulder pain and tired muscles.",
      "usage": "Warm slightly and massage gently for 5 to 10 minutes.",
      "caution": "Do not apply on cuts, wounds or irritated skin.",
    },
    {
      "image": "assets/images/product/product3.png",
      "title": "Natural Herbal Oil",
      "price": "₹185",
      "oldPrice": "₹250",
      "brand": "Nature Plus",
      "type": "Herbal Wellness Oil",
      "quantity": "100 ml",
      "package": "1 Bottle",
      "description":
          "Natural Herbal Oil supports relaxation and body comfort.",
      "benefits": "Supports relaxation, body massage and pain relief.",
      "usage": "Massage gently before bath or before sleep.",
      "caution": "Keep away from children and store in a cool place.",
    },
    {
      "image": "assets/images/product/product4.png",
      "title": "Healthy Nut Mix",
      "price": "₹220",
      "oldPrice": "₹350",
      "brand": "Nutri Health",
      "type": "Nutrition Supplement",
      "quantity": "250 g",
      "package": "1 Pack",
      "description":
          "Healthy Nut Mix supports daily energy, immunity and heart health.",
      "benefits": "Good source of protein, fiber and healthy fats.",
      "usage": "Take one small handful daily as a snack.",
      "caution": "Not suitable for people with nut allergy.",
    },
  ];

  static const List<Map<String, String>> personalCare = [
    {
      "image": "assets/images/product/product5.png",
      "title": "Personal Care Product",
      "price": "₹199",
      "oldPrice": "₹299",
      "brand": "Daily Care",
      "type": "Personal Care",
      "quantity": "1 Unit",
      "package": "1 Pack",
      "description":
          "A daily personal care product designed to support hygiene.",
      "benefits": "Helps maintain freshness and daily skin care.",
      "usage": "Use as directed on the package.",
      "caution": "Stop use if irritation occurs.",
    },
    {
      "image": "assets/images/product/product6.png",
      "title": "Skin Care Lotion",
      "price": "₹249",
      "oldPrice": "₹349",
      "brand": "Soft Care",
      "type": "Moisturizing Lotion",
      "quantity": "200 ml",
      "package": "1 Bottle",
      "description": "Skin Care Lotion helps moisturize dry skin.",
      "benefits": "Useful for dry skin and daily moisturization.",
      "usage": "Apply after bath or whenever skin feels dry.",
      "caution": "For external use only.",
    },
    {
      "image": "assets/images/product/product7.png",
      "title": "Daily Care Cream",
      "price": "₹180",
      "oldPrice": "₹260",
      "brand": "Glow Care",
      "type": "Skin Cream",
      "quantity": "50 g",
      "package": "1 Tube",
      "description": "Daily Care Cream helps protect skin from dryness.",
      "benefits": "Helps with dryness, dullness and skin roughness.",
      "usage": "Apply a small amount on clean skin.",
      "caution": "Avoid direct contact with eyes.",
    },
    {
      "image": "assets/images/product/product8.png",
      "title": "Body Care Product",
      "price": "₹299",
      "oldPrice": "₹399",
      "brand": "Body Plus",
      "type": "Body Care",
      "quantity": "1 Unit",
      "package": "1 Pack",
      "description": "Body Care Product supports daily body hygiene.",
      "benefits": "Keeps body fresh and comfortable.",
      "usage": "Use daily as required.",
      "caution": "Read product label before use.",
    },
  ];

  static const List<Map<String, String>> vitamins = [
    {
      "image": "assets/images/product/product9.png",
      "title": "Vitamin Supplement",
      "price": "₹349",
      "oldPrice": "₹420",
      "brand": "VitaPlus",
      "type": "Vitamin Supplement",
      "quantity": "60 Tablets",
      "package": "1 Bottle",
      "description":
          "Vitamin Supplement supports immunity and daily nutrition.",
      "benefits": "Supports immunity, energy and overall wellness.",
      "usage": "Take 1 tablet daily after meal or as directed.",
      "caution": "Consult doctor if pregnant, nursing or under medication.",
    },
    {
      "image": "assets/images/product/product10.png",
      "title": "Health Capsules",
      "price": "₹499",
      "oldPrice": "₹599",
      "brand": "Health Max",
      "type": "Health Supplement",
      "quantity": "30 Capsules",
      "package": "1 Bottle",
      "description": "Health Capsules support daily wellness.",
      "benefits": "Supports strength, stamina and nutrition balance.",
      "usage": "Take 1 capsule daily after food.",
      "caution": "Do not exceed recommended dose.",
    },
    {
      "image": "assets/images/product/product11.png",
      "title": "Multivitamin Tablets",
      "price": "₹275",
      "oldPrice": "₹350",
      "brand": "MultiCare",
      "type": "Multivitamin",
      "quantity": "30 Tablets",
      "package": "1 Bottle",
      "description":
          "Multivitamin Tablets provide essential vitamins and minerals.",
      "benefits": "Supports immunity, energy and general wellness.",
      "usage": "Take 1 tablet daily after meal.",
      "caution": "Keep away from children.",
    },
    {
      "image": "assets/images/product/product12.png",
      "title": "Vitamin D3 Supplement",
      "price": "₹189",
      "oldPrice": "₹250",
      "brand": "D3 Care",
      "type": "Vitamin D3",
      "quantity": "10 Tablets",
      "package": "1 Strip",
      "description": "Vitamin D3 helps support bones and immunity.",
      "benefits": "Supports bones, teeth and immune health.",
      "usage": "Take as directed by physician.",
      "caution": "Use under medical guidance.",
    },
  ];

  static const List<Map<String, String>> devices = [
    {
      "image": "assets/images/product/product13.png",
      "title": "Health Care Device",
      "price": "₹1199",
      "oldPrice": "₹1499",
      "brand": "MediTech",
      "type": "Health Monitoring Device",
      "quantity": "1 Device",
      "package": "Device + Manual",
      "description": "Health Care Device helps monitor basic health readings.",
      "benefits": "Useful for home health monitoring.",
      "usage": "Use according to user manual.",
      "caution": "Read instructions before use.",
    },
    {
      "image": "assets/images/product/product14.png",
      "title": "Digital Thermometer",
      "price": "₹299",
      "oldPrice": "₹399",
      "brand": "TempCheck",
      "type": "Digital Thermometer",
      "quantity": "1 Piece",
      "package": "Thermometer + Battery",
      "description": "Digital Thermometer gives quick temperature reading.",
      "benefits": "Fast reading, easy to use and suitable for home.",
      "usage": "Place correctly and wait for beep sound.",
      "caution": "Clean before and after every use.",
    },
    {
      "image": "assets/images/product/product15.png",
      "title": "Pulse Oximeter",
      "price": "₹699",
      "oldPrice": "₹999",
      "brand": "OxiCare",
      "type": "Oxygen Monitor",
      "quantity": "1 Device",
      "package": "Oximeter + Manual",
      "description": "Pulse Oximeter checks oxygen level and pulse rate.",
      "benefits": "Useful for oxygen and pulse monitoring at home.",
      "usage": "Place finger inside device and wait for reading.",
      "caution": "Readings may vary if finger is cold or moving.",
    },
    {
      "image": "assets/images/product/product16.png",
      "title": "BP Monitor",
      "price": "₹849",
      "oldPrice": "₹1200",
      "brand": "BP Care",
      "type": "Blood Pressure Monitor",
      "quantity": "1 Device",
      "package": "BP Monitor + Cuff + Manual",
      "description": "BP Monitor helps measure blood pressure at home.",
      "benefits": "Helps track blood pressure regularly.",
      "usage": "Wrap cuff properly and follow device instructions.",
      "caution": "Consult doctor for medical interpretation.",
    },
  ];

  static const List<Map<String, String>> deals = [
    {
      "image": "assets/images/product/product1.png",
      "title": "Best Deal Pain Oil",
      "price": "₹129",
      "oldPrice": "₹299",
      "brand": "Doormeds Ayurveda",
      "type": "Pain Relief Oil",
      "quantity": "100 ml",
      "package": "1 Bottle",
      "description": "Best Deal Pain Oil helps reduce body pain.",
      "benefits": "Helpful for body pain, joint pain and massage.",
      "usage": "Apply on affected area and massage gently.",
      "caution": "For external use only.",
    },
    {
      "image": "assets/images/product/product4.png",
      "title": "Healthy Nut Mix Offer",
      "price": "₹199",
      "oldPrice": "₹349",
      "brand": "Nutri Health",
      "type": "Nutrition Mix",
      "quantity": "250 g",
      "package": "1 Pack",
      "description": "Healthy Nut Mix Offer provides daily nutrition.",
      "benefits": "Supports energy and healthy snacking.",
      "usage": "Eat as a snack daily.",
      "caution": "Avoid if allergic to nuts.",
    },
    {
      "image": "assets/images/product/product9.png",
      "title": "Vitamin Offer Pack",
      "price": "₹249",
      "oldPrice": "₹399",
      "brand": "VitaPlus",
      "type": "Vitamin Supplement",
      "quantity": "30 Tablets",
      "package": "1 Bottle",
      "description": "Vitamin Offer Pack supports daily nutrition.",
      "benefits": "Supports immunity and energy.",
      "usage": "Take after meal.",
      "caution": "Use as directed.",
    },
    {
      "image": "assets/images/product/product16.png",
      "title": "Health Device Offer",
      "price": "₹799",
      "oldPrice": "₹1200",
      "brand": "BP Care",
      "type": "Health Device",
      "quantity": "1 Device",
      "package": "Device + Manual",
      "description": "Health Device Offer helps monitor health readings.",
      "benefits": "Useful for regular home monitoring.",
      "usage": "Use according to manual.",
      "caution": "For monitoring only, not a doctor replacement.",
    },
  ];

  static const List<Map<String, String>> ayurvedaProducts = [
    {
      "image": "assets/images/product/product1.png",
      "title": "Ayurvedic Pain Relief Oil",
      "price": "₹144",
      "oldPrice": "₹399",
      "brand": "Herbal Care",
      "type": "Ayurvedic Oil",
      "quantity": "100 ml",
      "package": "1 Bottle",
      "description": "Ayurvedic oil for pain relief and body massage.",
      "benefits": "Helps in joint pain and muscle stiffness.",
      "usage": "Massage gently on affected area.",
      "caution": "For external use only.",
    },
    {
      "image": "assets/images/product/product3.png",
      "title": "Natural Herbal Oil",
      "price": "₹185",
      "oldPrice": "₹250",
      "brand": "Nature Plus",
      "type": "Herbal Oil",
      "quantity": "100 ml",
      "package": "1 Bottle",
      "description": "Herbal oil for relaxation and wellness.",
      "benefits": "Supports relaxation and body comfort.",
      "usage": "Use before bath or before sleep.",
      "caution": "Keep away from children.",
    },
  ];

  static const List<Map<String, String>> babyCareProducts = [
    {
      "image": "assets/images/product/product5.png",
      "title": "Baby Care Lotion",
      "price": "₹199",
      "oldPrice": "₹299",
      "brand": "Baby Soft",
      "type": "Baby Lotion",
      "quantity": "200 ml",
      "package": "1 Bottle",
      "description": "Gentle baby lotion for soft skin care.",
      "benefits": "Helps moisturize baby skin.",
      "usage": "Apply gently after bath.",
      "caution": "Avoid contact with eyes.",
    },
    {
      "image": "assets/images/product/product6.png",
      "title": "Baby Skin Cream",
      "price": "₹249",
      "oldPrice": "₹349",
      "brand": "Baby Care",
      "type": "Baby Cream",
      "quantity": "100 g",
      "package": "1 Tube",
      "description": "Soft baby cream for dry skin protection.",
      "benefits": "Keeps skin smooth and soft.",
      "usage": "Apply on clean skin.",
      "caution": "Stop use if irritation occurs.",
    },
  ];

  static const List<Map<String, String>> wellnessProducts = [
    {
      "image": "assets/images/product/product9.png",
      "title": "Whey Protein Powder",
      "price": "₹1199",
      "oldPrice": "₹1599",
      "brand": "Gym Fuel",
      "type": "Protein Supplement",
      "quantity": "1 kg",
      "package": "1 Jar",
      "description":
          "Protein powder for gym, muscle recovery and fitness support.",
      "benefits": "Supports muscle growth and post-workout recovery.",
      "usage": "Take 1 scoop with water or milk after workout.",
      "caution": "Use as per recommended serving.",
    },
    {
      "image": "assets/images/product/product10.png",
      "title": "Mass Gainer Protein",
      "price": "₹1499",
      "oldPrice": "₹1999",
      "brand": "Fit Max",
      "type": "Gym Supplement",
      "quantity": "1 kg",
      "package": "1 Jar",
      "description": "Mass gainer for weight and muscle gain.",
      "benefits": "Supports calorie intake and muscle building.",
      "usage": "Take after workout or as advised.",
      "caution": "Not for children.",
    },
    {
      "image": "assets/images/product/product11.png",
      "title": "Multivitamin for Fitness",
      "price": "₹349",
      "oldPrice": "₹499",
      "brand": "Fit Vita",
      "type": "Fitness Vitamin",
      "quantity": "60 Tablets",
      "package": "1 Bottle",
      "description": "Multivitamin support for active lifestyle.",
      "benefits": "Supports energy, immunity and wellness.",
      "usage": "Take 1 tablet daily after meal.",
      "caution": "Do not exceed recommended dose.",
    },
  ];

  @override
  void initState() {
    super.initState();

    bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (bannerController.hasClients) {
        int nextPage = currentBannerIndex + 1;

        if (nextPage >= banners.length) {
          nextPage = 0;
        }

        bannerController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    bannerTimer?.cancel();
    bannerController.dispose();
    searchController.dispose();
    super.dispose();
  }

  int get unreadNotificationCount {
    return notifications.where((item) => item["read"] == false).length;
  }

  List<Map<String, String>> getCategoryProducts(String category) {
    if (category == "Medicine") return products;
    if (category == "Ayurveda") return ayurvedaProducts;
    if (category == "Baby Care") return babyCareProducts;
    if (category == "Devices") return devices;
    if (category == "Wellness") return wellnessProducts;

    return products;
  }

  void openCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryProductsScreen(
          title: category,
          products: getCategoryProducts(category),
        ),
      ),
    );
  }

  void toggleLike(Map<String, String> product) {
    WishlistStore.toggleWishlist(product);
    setState(() {});
  }

  void goToItemDetails(Map<String, String> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetails(product: product),
      ),
    );
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

  void startVoiceSearch() {
    showMessage("Microphone search selected");
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await imagePicker.pickImage(source: source);

      if (image != null) {
        showMessage("Image selected successfully");
      }
    } catch (e) {
      showMessage("Unable to open image picker");
    }
  }

  void showCameraGalleryOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
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
              const Text(
                "Choose medicine image",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Take a photo or select from gallery",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        pickImage(ImageSource.camera);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F1FF),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xffDCD3FF),
                          ),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Color(0xff745CFF),
                              size: 34,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Camera",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        pickImage(ImageSource.gallery);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F1FF),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xffDCD3FF),
                          ),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.photo_library_outlined,
                              color: Color(0xff745CFF),
                              size: 34,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Gallery",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showNotificationPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, bottomSetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.58,
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
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
                      const Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          bottomSetState(() {
                            for (var item in notifications) {
                              item["read"] = true;
                            }
                          });
                          setState(() {});
                        },
                        child: const Text(
                          "Read all",
                          style: TextStyle(
                            color: Color(0xff745CFF),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          bottomSetState(() {
                            notifications.clear();
                          });
                          setState(() {});
                        },
                        child: const Text(
                          "Close all",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: notifications.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 82,
                                  height: 82,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffF0EDFF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.notifications_off_outlined,
                                    color: Color(0xff745CFF),
                                    size: 42,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                const Text(
                                  "No notifications",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              final item = notifications[index];
                              final bool isRead = item["read"] == true;

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: isRead
                                      ? Colors.white
                                      : const Color(0xffF4F1FF),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: isRead
                                        ? const Color(0xffEEEEEE)
                                        : const Color(0xffDCD3FF),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: isRead
                                              ? [
                                                  Colors.grey.shade300,
                                                  Colors.grey.shade400,
                                                ]
                                              : const [
                                                  Color(0xff9C27E8),
                                                  Color(0xff2878E8),
                                                ],
                                        ),
                                      ),
                                      child: Icon(
                                        isRead
                                            ? Icons.notifications_none
                                            : Icons.notifications_active,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item["title"],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900,
                                              color: isRead
                                                  ? Colors.black54
                                                  : Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item["message"],
                                            style: TextStyle(
                                              fontSize: 11,
                                              height: 1.35,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          GestureDetector(
                                            onTap: () {
                                              bottomSetState(() {
                                                item["read"] = true;
                                              });
                                              setState(() {});
                                            },
                                            child: Text(
                                              isRead
                                                  ? "Already read"
                                                  : "Mark as read",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: isRead
                                                    ? Colors.grey
                                                    : const Color(0xff745CFF),
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        bottomSetState(() {
                                          notifications.removeAt(index);
                                        });
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.10),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget upgradedNotificationButton() {
    return GestureDetector(
      onTap: showNotificationPopup,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xffF4F1FF),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff745CFF).withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_none,
              color: Color(0xff745CFF),
              size: 23,
            ),
          ),
          if (unreadNotificationCount > 0)
            Positioned(
              right: -2,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xffFF5CA8),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$unreadNotificationCount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget searchActionIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        margin: const EdgeInsets.only(left: 6),
        decoration: BoxDecoration(
          color: const Color(0xffF4F1FF),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Icon(
          icon,
          size: 18,
          color: const Color(0xff745CFF),
        ),
      ),
    );
  }

  Widget upgradedSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: searchText.isEmpty
                ? const Color(0xffE0E0E0)
                : const Color(0xff745CFF),
            width: searchText.isEmpty ? 1 : 1.4,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff745CFF).withOpacity(0.10),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              color: Color(0xff745CFF),
              size: 24,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search medicine...",
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            if (searchText.isNotEmpty)
              GestureDetector(
                onTap: () {
                  searchController.clear();
                  setState(() {
                    searchText = "";
                  });
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 20,
                ),
              )
            else ...[
              searchActionIcon(
                icon: Icons.mic_none_rounded,
                onTap: startVoiceSearch,
              ),
              searchActionIcon(
                icon: Icons.camera_alt_outlined,
                onTap: showCameraGalleryOptions,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 18,
        bottom: 10,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xffF0EDFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "See all",
              style: TextStyle(
                fontSize: 11,
                color: Color(0xff745CFF),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _assetImage(String path, {double height = 95}) {
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
              color: Color(0xffCCCCCC),
              size: 32,
            ),
          ),
        );
      },
    );
  }

  Widget _discountBadge(String price, String oldPrice) {
    final p = double.tryParse(price.replaceAll(RegExp(r'[₹,]'), '')) ?? 0;
    final op = double.tryParse(oldPrice.replaceAll(RegExp(r'[₹,]'), '')) ?? 0;

    if (op == 0) return const SizedBox.shrink();

    final pct = (((op - p) / op) * 100).round();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xff22C55E),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$pct% OFF',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 7.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _likeButton(Map<String, String> product) {
    final bool isLiked = WishlistStore.isLiked(product["title"]!);

    return GestureDetector(
      onTap: () {
        toggleLike(product);
      },
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? const Color(0xffE91E63) : const Color(0xff745CFF),
          size: 18,
        ),
      ),
    );
  }

  Widget _categoryItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: color,
            size: 25,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _quickAction(IconData icon, String label) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xffF3F1FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xff745CFF),
              size: 25,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              height: 1.15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _horizontalCard(Map<String, String> p) {
    return GestureDetector(
      onTap: () => goToItemDetails(p),
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(9),
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _discountBadge(p["price"]!, p["oldPrice"]!),
                ),
                Center(
                  child: _assetImage(p["image"]!, height: 75),
                ),
                const SizedBox(height: 5),
                Text(
                  p["title"]!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      p["price"]!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff6A4CFF),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      p["oldPrice"]!,
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
            Positioned(
              right: 0,
              top: 0,
              child: _likeButton(p),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridCard(Map<String, String> p) {
    return GestureDetector(
      onTap: () => goToItemDetails(p),
      child: Container(
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _discountBadge(p["price"]!, p["oldPrice"]!),
                ),
                Expanded(
                  child: Center(
                    child: _assetImage(p["image"]!, height: 95),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  p["title"]!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        p["price"]!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6A4CFF),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        p["oldPrice"]!,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: _likeButton(p),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productGrid(List<Map<String, String>> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (_, i) => _gridCard(list[i]),
      ),
    );
  }

  Widget _horizontalList(List<Map<String, String>> list) {
    return SizedBox(
      height: 178,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (_, i) => _horizontalCard(list[i]),
      ),
    );
  }

  Widget _bannerSlider() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff745CFF).withOpacity(0.18),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: PageView.builder(
              controller: bannerController,
              itemCount: banners.length,
              onPageChanged: (index) {
                setState(() {
                  currentBannerIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  banners[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) {
              final bool isActive = currentBannerIndex == index;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 18 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xff745CFF)
                      : const Color(0xffD6D6D6),
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
      ],
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
      height: 72,
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
            onTap: () {},
          ),
          navIcon(
            index: 1,
            icon: Icons.shopping_cart,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              ).then((_) {
                setState(() {
                  selectedNavIndex = 0;
                });
              });
            },
          ),
          navIcon(
            index: 2,
            icon: Icons.favorite,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WishList(),
                ),
              ).then((_) {
                setState(() {
                  selectedNavIndex = 0;
                });
              });
            },
          ),
          navIcon(
            index: 3,
            icon: Icons.person_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              ).then((_) {
                setState(() {
                  selectedNavIndex = 0;
                });
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, String>>>(
      valueListenable: WishlistStore.wishlistItems,
      builder: (context, wishlistItems, child) {
        return Scaffold(
          backgroundColor: const Color(0xffF7F7FB),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff9C27E8),
                                Color(0xff2878E8),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff745CFF).withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi Pritam ",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "Have a great day!",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        upgradedNotificationButton(),
                      ],
                    ),
                  ),

                  upgradedSearchBar(),

                  _bannerSlider(),

                  /// Category
                  _sectionTitle("Category"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: categories.map((item) {
                        return GestureDetector(
                          onTap: () {
                            openCategory(item["title"] as String);
                          },
                          child: _categoryItem(
                            icon: item["icon"] as IconData,
                            label: item["title"] as String,
                            color: item["color"] as Color,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  /// Quick Actions
                  _sectionTitle("Quick Actions"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const OrderAgainScreen(),
                              ),
                            );
                          },
                          child: _quickAction(
                            Icons.replay_rounded,
                            "Order\nAgain",
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const OrdersScreen(),
                              ),
                            );
                          },
                          child: _quickAction(
                            Icons.shopping_bag_outlined,
                            "Orders",
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ReportsScreen(),
                              ),
                            );
                          },
                          child: _quickAction(
                            Icons.description_outlined,
                            "Reports",
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const CustomizePackageScreen(),
                              ),
                            );
                          },
                          child: _quickAction(
                            Icons.inventory_2_outlined,
                            "Customize\nPackages",
                          ),
                        ),
                      ],
                    ),
                  ),

                  _sectionTitle("Just for you"),
                  _productGrid(products),

                  _sectionTitle("Personal Care"),
                  _horizontalList(personalCare),

                  _sectionTitle("Vitamins & Supplements"),
                  _horizontalList(vitamins),

                  _sectionTitle("Popular Items"),
                  _horizontalList(products),

                  _sectionTitle("HealthCare Device"),
                  _productGrid(devices),

                  _sectionTitle("Deals you'll love"),
                  _horizontalList(deals),

                  const SizedBox(height: 24),
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