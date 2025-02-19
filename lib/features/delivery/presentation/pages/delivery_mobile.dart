import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants.dart';
import '../../../main/presentation/pages/home_page.dart';

class DeliveryMobile extends StatefulWidget {
  const DeliveryMobile({super.key});

  @override
  _DeliveryMobileState createState() => _DeliveryMobileState();
}

class _DeliveryMobileState extends State<DeliveryMobile> {
  Future<String> _fetchDeliveryText() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('delivery')
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) return 'No delivery info found';

      final text = querySnapshot.docs.first.get('text') as String?;
      return text ?? 'No text available';
    } catch (e) {
      return 'Error loading info: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: newWhite,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 27),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (context) => false,
                      );
                    },
                    child: const Text(
                      'ASYLTAS',
                      style: TextStyle(
                        color: newBlack,
                        fontSize: 17,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/сlose.svg',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                  child: FutureBuilder<String>(
                    future: _fetchDeliveryText(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        String text = snapshot.data ?? '';
                        List<String> lines = text.split('#');
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: lines
                              .map(
                                (line) => Text(
                                  line.trim(),
                                  style: const TextStyle(
                                    color: newBlack,
                                    fontSize: 18,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                              .toList(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
