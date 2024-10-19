import 'package:asyltas_app/core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBottom extends StatelessWidget {
  const HomeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: newBlack,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () async {
                    const url =
                        'https://2gis.kz/almaty/geo/70000001025719705/76.892922,43.292601';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: const Text(
                    'Северное кольцо 23, Алатау 4 блок',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: newWhite,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.41,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: SvgPicture.asset(
                    'assets/inst.svg',
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () async {
                    const url =
                        'https://www.instagram.com/furnitura_asyl_tas?igsh=MXFyeWN6bjYwc3FyOQ%3D%3D&utm_source=qr ';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  child: SvgPicture.asset(
                    'assets/whats.svg',
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () async {
                    const url = 'https://wa.me/message/PQBV66LSNTE6O1';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              color: newWhite,
              height: 0.33,
            ),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.center,
            child: Text(
              '© 2024 Asyltas Разработано galab.kz',
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.41,
                color: newWhite,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
