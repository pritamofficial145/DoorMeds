import 'package:flutter/material.dart';

class LiveLocationScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const LiveLocationScreen({
    super.key,
    required this.order,
  });

  void openDriverChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DriverChatScreen(
          driverName: "Rajdip the Hacker",
          bikeName: "Honda Activa 6G",
          bikeNumber: "TR01 AB 4587",
          order: order,
        ),
      ),
    );
  }

  Widget mapBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xffEAF2FF),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: RoadMapPainter(),
            ),
          ),

          /// Route marker 1
          Positioned(
            left: 270,
            top: 420,
            child: routeNumber("1"),
          ),

          /// Route marker 2
          Positioned(
            right: 35,
            top: 350,
            child: routeNumber("2"),
          ),

          /// Route marker 3
          Positioned(
            left: 170,
            top: 260,
            child: routeNumber("3"),
          ),

          /// Route marker 4
          Positioned(
            left: 135,
            top: 185,
            child: routeNumber("4"),
          ),

          /// Current delivery marker
          Positioned(
            left: 190,
            top: 150,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xff745CFF),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff745CFF).withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.delivery_dining_rounded,
                color: Colors.white,
                size: 27,
              ),
            ),
          ),

          /// Back button
          Positioned(
            top: 18,
            left: 18,
            child: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 42,
                    height: 42,
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
                      size: 22,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget routeNumber(String number) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: const Color(0xffFFE44D),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xff111111),
          width: 1.6,
        ),
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget driverBottomSheet(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34),
            topRight: Radius.circular(34),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 18,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Driver info row
            Row(
              children: [
                const CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.black87,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 31,
                  ),
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Rajdip the Hacker",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Driver",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    openDriverChat(context);
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xffF4F1FF),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffDDD5FF),
                      ),
                    ),
                    child: const Icon(
                      Icons.call,
                      color: Colors.black87,
                      size: 21,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                GestureDetector(
                  onTap: () {
                    openDriverChat(context);
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xffF4F1FF),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffDDD5FF),
                      ),
                    ),
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.black87,
                      size: 21,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Bike details box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffF8F8F8),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xffEEEEEE),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.two_wheeler_rounded,
                        color: Color(0xff745CFF),
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Bike Name",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Text(
                        "Honda Activa 6G",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      const Icon(
                        Icons.confirmation_number_outlined,
                        color: Color(0xff745CFF),
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Bike Number",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Text(
                        "TR01 AB 4587",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Order info
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
                    Icons.local_shipping_outlined,
                    color: Color(0xff745CFF),
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Order ID: ${order["orderId"] ?? "DM10245"}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Text(
                    "25 min",
                    style: TextStyle(
                      fontSize: 12,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAF2FF),
      body: SafeArea(
        child: Stack(
          children: [
            mapBackground(),
            driverBottomSheet(context),
          ],
        ),
      ),
    );
  }
}

class DriverChatScreen extends StatefulWidget {
  final String driverName;
  final String bikeName;
  final String bikeNumber;
  final Map<String, dynamic> order;

  const DriverChatScreen({
    super.key,
    required this.driverName,
    required this.bikeName,
    required this.bikeNumber,
    required this.order,
  });

  @override
  State<DriverChatScreen> createState() => _DriverChatScreenState();
}

class _DriverChatScreenState extends State<DriverChatScreen> {
  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      "text": "Hi, I am on the way with your medicine order.",
      "isMe": false,
    },
    {
      "text": "Okay, please call me when you reach nearby.",
      "isMe": true,
    },
    {
      "text": "Sure, I will reach in around 25 minutes.",
      "isMe": false,
    },
  ];

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add({
        "text": text,
        "isMe": true,
      });
    });

    messageController.clear();
  }

  Widget messageBubble(Map<String, dynamic> message) {
    final bool isMe = message["isMe"] == true;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isMe ? 70 : 0,
          right: isMe ? 0 : 70,
          bottom: 12,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          gradient: isMe
              ? const LinearGradient(
                  colors: [
                    Color(0xff9C27E8),
                    Color(0xff2878E8),
                  ],
                )
              : null,
          color: isMe ? null : const Color(0xffF1F1F1),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isMe ? 18 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 18),
          ),
        ),
        child: Text(
          message["text"],
          style: TextStyle(
            fontSize: 13,
            height: 1.35,
            color: isMe ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 34,
              height: 34,
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
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 12),

          const CircleAvatar(
            radius: 22,
            backgroundColor: Colors.black87,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 25,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.driverName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "${widget.bikeName} • ${widget.bikeNumber}",
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
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
              Icons.call,
              color: Color(0xff745CFF),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: const Color(0xffF4F1FF),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 13,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          GestureDetector(
            onTap: sendMessage,
            child: Container(
              width: 45,
              height: 45,
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
                Icons.send_rounded,
                color: Colors.white,
                size: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderMiniCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 8),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xffF4F1FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xffDDD5FF),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_shipping_outlined,
            color: Color(0xff745CFF),
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Order ID: ${widget.order["orderId"] ?? "DM10245"}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Text(
            widget.order["price"] ?? "",
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xff745CFF),
              fontWeight: FontWeight.w900,
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
            header(context),
            orderMiniCard(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return messageBubble(messages[index]);
                },
              ),
            ),
            bottomInput(),
          ],
        ),
      ),
    );
  }
}

class RoadMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundRoad = Paint()
      ..color = Colors.white
      ..strokeWidth = 22
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final mainRoute = Paint()
      ..color = const Color(0xff2337E8)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final yellowRoad = Paint()
      ..color = const Color(0xffF6C453)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final greenRoad = Paint()
      ..color = const Color(0xff58B368)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final pinkRoad = Paint()
      ..color = const Color(0xffD266D2)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final route = Path()
      ..moveTo(25, 40)
      ..lineTo(70, 65)
      ..lineTo(112, 130)
      ..lineTo(96, 200)
      ..lineTo(170, 240)
      ..lineTo(220, 190)
      ..lineTo(265, 260)
      ..lineTo(220, 340)
      ..lineTo(285, 430)
      ..lineTo(200, 520)
      ..lineTo(110, 505)
      ..lineTo(65, 575);

    canvas.drawPath(route, backgroundRoad);
    canvas.drawPath(route, mainRoute);

    final road1 = Path()
      ..moveTo(0, 120)
      ..quadraticBezierTo(size.width * 0.45, 80, size.width, 105);

    canvas.drawPath(road1, yellowRoad);

    final road2 = Path()
      ..moveTo(0, 245)
      ..quadraticBezierTo(size.width * 0.45, 210, size.width, 250);

    canvas.drawPath(road2, yellowRoad);

    final road3 = Path()
      ..moveTo(40, 0)
      ..quadraticBezierTo(150, 230, 120, size.height);

    canvas.drawPath(road3, greenRoad);

    final road4 = Path()
      ..moveTo(size.width, 30)
      ..quadraticBezierTo(250, 220, size.width, 460);

    canvas.drawPath(road4, pinkRoad);

    final road5 = Path()
      ..moveTo(0, 420)
      ..lineTo(size.width, 380);

    canvas.drawPath(road5, yellowRoad);

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    void drawArea(String text, Offset offset) {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, offset);
    }

    drawArea("Town Road", const Offset(35, 160));
    drawArea("Hospital Area", const Offset(210, 285));
    drawArea("Market Road", const Offset(95, 330));
    drawArea("Home Area", const Offset(215, 465));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}