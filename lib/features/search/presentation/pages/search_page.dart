import 'package:asyltas_app/core/constants.dart';
import 'package:asyltas_app/core/models/product.dart';
import 'package:asyltas_app/features/favorites/presentation/pages/favorites_page.dart';
import 'package:asyltas_app/features/main/presentation/pages/home_page.dart';
import 'package:asyltas_app/features/menu/presentation/pages/menu_page.dart';
import 'package:asyltas_app/features/product/presentation/pages/product_page.dart';
import 'package:asyltas_app/provider/favorites_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _products = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      _searchProducts(_searchController.text);
    });
  }

  Future<void> _searchProducts(String searchTerm) async {
    setState(() {
      _isLoading = true;
    });

    if (searchTerm.isEmpty) {
      setState(() {
        _products = [];
        _isLoading = false;
      });
      return;
    }

    String lowerCaseSearchTerm = searchTerm.toLowerCase();

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .get(); // Fetch all products for case-insensitive search

      List<ProductModel> searchResults = snapshot.docs
          .map((doc) =>
              ProductModel.fromJson(doc.data() as Map<String, dynamic>))
          .where((product) =>
              product.name != null &&
              product.name!.toLowerCase().contains(lowerCaseSearchTerm))
          .toList();

      setState(() {
        _products = searchResults;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: newWhite,
      body: SafeArea(
        child: Column(
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
                                                favorites.items.length
                                                    .toString(),
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  fontFamily: 'Gilroy',
                  color: newBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Поиск...',
                  hintStyle: TextStyle(
                    fontFamily: 'Gilroy',
                    color: newBlack54,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SvgPicture.asset(
                      'assets/search.svg',
                      height: 22,
                      width: 24,
                    ),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(maxHeight: 24, maxWidth: 48),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: secondMain),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _products.isEmpty
                      ? const Center(child: Text('Ничего не найдено'))
                      : ListView.builder(
                          itemCount: _products.length,
                          itemBuilder: (context, index) {
                            ProductModel product = _products[index];
                            return GestureDetector(
                              onTap: () {
                                if (product.itemLeft == null ||
                                    product.itemLeft == 0) {
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                        product: product,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: product.images?[0] ?? '',
                                    height: 60,
                                    width: 70,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        color: Colors.grey.shade200,
                                        height: double.infinity,
                                        width: double.infinity,
                                      );
                                    },
                                  ),
                                ),
                                title: Text(product.name ?? ''),
                                subtitle: product.itemLeft == null ||
                                        product.itemLeft == 0
                                    ? const Text('Нет в наличии')
                                    : Text('Цена: ${product.price},00 ₸'),
                                // Add more details as needed
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ошибка'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
