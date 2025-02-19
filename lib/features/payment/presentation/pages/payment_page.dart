import 'package:asyltas_app/features/payment/presentation/pages/payment_mobile.dart';
import 'package:asyltas_app/responsive/responsive.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({
    super.key,
    required this.price,
    required this.name,
  });
  final int price;
  final String name;
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopLayout: PaymentMobile(
        price: price,
        name: name,
      ),
      mobileLayout: PaymentMobile(
        price: price,
        name: name,
      ),
    );
  }
}
