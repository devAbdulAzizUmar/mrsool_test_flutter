import 'package:flutter/material.dart';

import 'package:mrsool_test/screens/order_details_screen.dart';
import 'package:mrsool_test/utils/utils.dart';
import 'package:provider/provider.dart';

import '../lang/app_localization.dart';
import '../models/order.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final order = context.watch<Order>();
    final orderDate = Utils.getFormattedDate(order.receivedAt, context);
    const double itemsGap = 10;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          OrderDetailsScreen.routeName,
          arguments: order.id,
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(
            color: order.status == Order.pending ? Theme.of(context).primaryColor : Colors.grey,
            width: order.status == Order.pending ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              if (order.orderId != null)
                Row(
                  children: [
                    Text(
                      "${appLocalizations.orderId ?? "Order ID"}: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      order.orderId.toString(),
                    )
                  ],
                ),
              Utils.verticalSpace(itemsGap),
              if (orderDate.isNotEmpty)
                Row(
                  children: [
                    Text(
                      "${appLocalizations.date ?? "Order Date"}: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      orderDate,
                    )
                  ],
                ),
              Utils.verticalSpace(itemsGap),
              if (order.grandTotal != null)
                Row(
                  children: [
                    Text(
                      "${appLocalizations.total ?? "Total"}: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${appLocalizations.sar ?? "SAR"} ${order.grandTotal}",
                    )
                  ],
                ),
              Utils.verticalSpace(itemsGap),
              if (order.status != null)
                Row(
                  children: [
                    Text(
                      "${appLocalizations.status ?? "Status"}: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      appLocalizations.getLocalizedText(order.status!) ?? order.status!,
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
