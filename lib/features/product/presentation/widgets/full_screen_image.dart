import 'dart:io';

import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/features/favorites/presentation/pages/favorites_page.dart';
import 'package:asyltas_app/features/main/presentation/pages/home_page.dart';
import 'package:asyltas_app/features/menu/presentation/pages/menu_page.dart';
import 'package:asyltas_app/provider/favorites_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 31,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset('assets/back.svg'),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FavoritesPage(
                                  fromMain: false,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 31,
                            height: 31,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: SvgPicture.asset(
                                    'assets/menu_like.svg',
                                  ),
                                ),
                                Consumer<FavoritesProvider>(
                                  builder: (context, favorites, child) {
                                    if (favorites.items.isEmpty) {
                                      return const SizedBox();
                                    } else {
                                      return Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                            color: newMainColor,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Center(
                                            child: Text(
                                              favorites.items.length.toString(),
                                              style: const TextStyle(
                                                color: newWhite,
                                                fontSize: 11,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MenuPage(
                                  fromMain: false,
                                ),
                              ),
                            );
                          },
                          child: SvgPicture.asset('assets/menu.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 31,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
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
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: InteractiveViewer(
                  clipBehavior: Clip.none,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        // Image has finished loading
                        return child;
                      }
                      return Center(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Platform.isAndroid
                              ? const CircularProgressIndicator(
                                  color: secondMain,
                                  strokeWidth: 3,
                                )
                              : const CupertinoActivityIndicator(
                                  color: secondMain,
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
