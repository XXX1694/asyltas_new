import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

T provide<T>(BuildContext context) {
  return Provider.of<T>(context);
}

T provideOnce<T>(BuildContext context) {
  return Provider.of<T>(context, listen: false);
}

T? provideOrNull<T>(BuildContext context) {
  try {
    return provide(context);
  } catch (error) {
    return null;
  }
}

T? provideOnceOrNull<T>(BuildContext context) {
  try {
    return provideOnce(context);
  } catch (error) {
    return null;
  }
}
