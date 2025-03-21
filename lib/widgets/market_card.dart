import 'package:flutter/material.dart';

class MarketCard extends StatelessWidget {
  final String title;
  final String number;
  final String openTime;
  final String closeTime;
  final String status;

  const MarketCard({
    super.key,
    required this.title,
    required this.number,
    required this.openTime,
    required this.closeTime,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFFEFF1F3), Colors.white],
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              number,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              status,
              style: TextStyle(
                color: status == 'Market Running' ? Colors.green : Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Image.asset(
                    "assets/chart.png",
                    fit: BoxFit.contain,
                    width: 20,
                  ),
                ),
                Image.asset(
                  status == 'Market Running'
                      ? "assets/arrow_out.png"
                      : "assets/icon.png",
                  fit: BoxFit.contain,
                  width: 20,
                ),
              ],
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Open - $openTime',
                      style: TextStyle(fontSize: 9),
                    ),
                    Text(
                      'Close - $closeTime',
                      style: TextStyle(fontSize: 9),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
