import 'package:flutter/material.dart';
import 'package:mrsool_test/api/orders_api.dart';

import '../lang/app_localization.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);
  static const routeName = "OrderDetailsScreen";

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late AppLocalizations _appLocalizations;

  @override
  void didChangeDependencies() async {
    final orderId = ModalRoute.of(context)!.settings.arguments as int;
    print("Order ID: $orderId");
    final result = await OrdersApi.instance.getOrderDetails(orderId: orderId);
    print(result.body);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appLocalizations.details ?? "Details",
        ),
      ),
    );
  }
}
