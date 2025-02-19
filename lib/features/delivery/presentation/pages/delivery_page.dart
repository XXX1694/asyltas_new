import 'package:asyltas_app/responsive/responsive.dart';
import 'package:flutter/material.dart';

import 'delivery_mobile.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      desktopLayout: DeliveryMobile(),
      mobileLayout: DeliveryMobile(),
    );
  }
}
