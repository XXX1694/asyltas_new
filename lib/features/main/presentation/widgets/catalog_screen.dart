import 'package:asyltas_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants.dart';
import '../bloc/catalog_bloc.dart';
import 'catalog_item.dart';
import 'mini_catalog_placegolder.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    super.key,
    required this.currentCategoryId,
  });

  final String currentCategoryId;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late final String currentCategoryId = widget.currentCategoryId;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<CatalogBloc>().add(LoadCatalog(categoryId: currentCategoryId));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final catalogBloc = context.read<CatalogBloc>();
      final state = catalogBloc.state;
      if (state is CatalogLoaded && !state.hasNext) {
        catalogBloc.add(LoadCatalog(
          categoryId: currentCategoryId,
          isInitialLoad: false,
        ));
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (BuildContext context, CatalogState state) {
        if (state is CatalogLoaded) {
          final products = state.products;
          if (products.isEmpty) {
            return const Center(
              child: Text('Нет товаров в данной категории'),
            );
          }

          return LimitedBox(
            maxHeight: MediaQuery.of(context).size.height,
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 12,
                childAspectRatio: 0.56,
              ),
              itemCount: state.hasNext ? products.length : products.length + 1,
              itemBuilder: (context, index) {
                if (index < products.length) {
                  final cartItem =
                      context.watch<CartProvider>().firstWhereOrNull(
                            (cartItem) => cartItem.id == products[index].id,
                          );
                  products[index].count = cartItem?.count ?? 0;
                  final product = products[index];
                  return CatalogItem(
                    item: product,
                    showCustomSnackBar: showCustomSnackBar,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        }
        if (state is CatalogError) {
          return Center(
            child: Text(state.message),
          );
        }

        return const MiniCatalogShimmer();
      },
    );
  }

  void showCustomSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    final animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 0,
        bottom: MediaQuery.of(context).size.height * 0.12,
        child: SlideTransition(
          position: animation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: newBlack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: const TextStyle(color: newWhite),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    animationController.forward();

    Future.delayed(const Duration(milliseconds: 1000), () {
      animationController.reverse().then((value) {
        overlayEntry.remove();
        animationController.dispose();
      });
    });
  }
}
