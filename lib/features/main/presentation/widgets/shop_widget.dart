import 'package:asyltas_app/core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopWidget extends StatelessWidget {
  const ShopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: newMainColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            '3Д МАГАЗИН',
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: newWhite,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onPressed: () async {
        const url = 'https://maps.app.goo.gl/ZsPb2fo19S6m82CW9?g_st=iwb';
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.externalApplication,
          );
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }
}
