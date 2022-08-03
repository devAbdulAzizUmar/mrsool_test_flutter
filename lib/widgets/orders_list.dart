import 'package:flutter/material.dart';
import 'package:mrsool_test/providers/orders_provider.dart';
import 'package:mrsool_test/widgets/order_list_item.dart';
import 'package:provider/provider.dart';

import '../lang/app_localization.dart';
import '../models/order.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({
    Key? key,
    required this.orders,
  }) : super(key: key);
  final List<Order> orders;

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> with AutomaticKeepAliveClientMixin {
  late AppLocalizations _appLocalizations;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    _appLocalizations = AppLocalizations.of(context)!;

    final orders = widget.orders;

    if (orders.isEmpty) {
      return Center(
        child: Text(_appLocalizations.noOrders ?? "No orders found."),
      );
    }

    return RefreshIndicator(
      onRefresh: context.read<OrdersProvider>().getAllOrders,
      child: ListView.separated(
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        padding: const EdgeInsets.all(10),
        itemBuilder: (_, index) => ChangeNotifierProvider.value(
          value: orders[index],
          child: const OrderListItem(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
