import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matka_user/widgets/market_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> marketData = [];
  @override
  void initState() {
    super.initState();
    loadMarketData();
  }

  Future<void> loadMarketData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);
    setState(() {
      marketData = data['markets'];
    });
  }

  String getStatus(String openTime, String closeTime) {
    final now = TimeOfDay.now();
    final open = _convertToTimeOfDay(openTime);
    final close = _convertToTimeOfDay(closeTime);

    if ((now.hour > open.hour ||
            (now.hour == open.hour && now.minute >= open.minute)) &&
        (now.hour < close.hour ||
            (now.hour == close.hour && now.minute < close.minute))) {
      return 'Market Running';
    }
    return 'Market Closed';
  }

  TimeOfDay _convertToTimeOfDay(String time) {
    final parts = time.split(' ')[0].split(':');
    final format = time.split(' ')[1].toUpperCase().trim();

    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    if (format == 'PM' && hour != 12) hour += 12;
    if (format == 'AM' && hour == 12) hour = 0;

    return TimeOfDay(hour: hour, minute: minute);
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF8F9FA),
        selectedItemColor: Colors.lime[900],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee, size: 28),
            label: 'Rates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28),
            label: 'Profile',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(screenWidth * 0.05, screenHeight * 0.03,
                screenWidth * 0.05, 0.0),
            child: Image.asset("assets/top_image.png"),
          ),
          Center(
            child: Text(
              "Welcome to the My Kalyan Matka. New interface to provide better.",
              style: TextStyle(
                color: Colors.red[900],
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset("assets/wallet.png", width: 25, height: 25),
                        Row(
                          children: [
                            const Text('Wallet',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 2,
                            ),
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Colors.lime[900],
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text('₹9999+',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset("assets/add.png", width: 25, height: 25),
                        const Text('Add Funds',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset("assets/withdraw.png",
                            width: 25, height: 25),
                        const Text('Withdraw',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset("assets/whatsapp.jpg",
                            width: 25, height: 25),
                        const Text('Contact Us',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 30,
                ),
              ],
            ),
          ),
          Expanded(

            child: GridView.builder(
                padding: EdgeInsets.all(screenWidth * 0.02),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
                itemCount: marketData.length,
                itemBuilder: (context, index) {
                  final market = marketData[index];
                  final status =
                      getStatus(market['openTime'], market['closeTime']);
                  return MarketCard(
                    title: market['title'],
                    number: market['number'],
                    openTime: market['openTime'],
                    closeTime: market['closeTime'],
                    status: status,
                  );
                }),
          )
        ],
      ),
    );
  }
}
