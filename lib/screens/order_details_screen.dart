import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mrsool_test/models/order.dart';
import 'package:mrsool_test/providers/orders_provider.dart';
import 'package:mrsool_test/utils/pdf_utils.dart';

import 'package:mrsool_test/utils/utils.dart';
import 'package:open_file/open_file.dart';

import 'package:provider/provider.dart';

import '../lang/app_localization.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);
  static const routeName = "OrderDetailsScreen";

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late AppLocalizations _appLocalizations;
  late Order? order;

  bool isInit = true;

  @override
  void didChangeDependencies() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isInit) {
        isInit = false;
        order = context.read<Order>();
        order!.getOrderDetails();
        if (order!.shouldStatusTimeout()) {
          context.read<OrdersProvider>().updateLists();
        }
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context)!;
    order = context.watch<Order>();
    final mediaQuery = MediaQuery.of(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              _appLocalizations.details ?? "Details",
            ),
            actions: [
              if ((order!.status == Order.accepted || order!.orderDetails?.status == Order.accepted) &&
                  !order!.isLoadingOrderDetails &&
                  !order!.hasFailedGettingOrderDetails)
                IconButton(
                  onPressed: printOrder,
                  icon: const Icon(Icons.print),
                ),
            ],
          ),
          body: order == null
              ? buildFailedGettingDetails()
              : order!.isLoadingOrderDetails
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : order!.orderDetails == null
                      ? buildFailedGettingDetails()
                      : Column(
                          children: [
                            Expanded(
                              child: buildOrderDetails(),
                            ),
                            buildActionButtons(),
                            Utils.verticalSpace(mediaQuery.padding.bottom + 10),
                          ],
                        ),
        ),
        if (order!.isUpdatingStatus)
          Positioned.fill(
            child: Container(
              color: Colors.lightBlue.shade300.withOpacity(0.3),
              alignment: Alignment.center,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator.adaptive(),
                    const SizedBox(
                      width: 10,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(_appLocalizations.updating ?? "Updating"),
                    )
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildFailedGettingDetails() {
    return Center(
      child: Text(_appLocalizations.failedToGetDetails ?? "Failed to get details"),
    );
  }

  Widget buildOrderDetails() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (order!.orderId != null)
              Text(
                "${_appLocalizations.orderId}: ${order!.orderId}",
              ),
            if (order!.orderDetails!.status != null) ...[
              Utils.verticalSpace(10),
              Text(
                "${_appLocalizations.status}: ${_appLocalizations.getLocalizedText(order!.orderDetails!.status!)}",
              ),
            ],
            if (order!.orderDetails!.items != null) ...[
              Utils.verticalSpace(10),
              Text("${_appLocalizations.items ?? "Items"}:"),
              Utils.verticalSpace(10),
              ...order!.orderDetails!.items!.map((e) {
                String productName = "";
                if (Localizations.localeOf(context).languageCode == "ar") {
                  productName = e.name ?? "";
                } else {
                  productName = e.enName ?? "";
                }

                return Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.grey.shade300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(productName),
                      Text("${_appLocalizations.sar ?? "SAR"} ${e.itemPrice}"),
                    ],
                  ),
                );
              }).toList()
            ],
            if (order!.orderDetails!.grandTotal != null) ...[
              Utils.verticalSpace(10),
              Row(
                children: [
                  Text("${_appLocalizations.grandTotal ?? "Grand Total"}: "),
                  Text("${_appLocalizations.sar} ${order!.orderDetails!.grandTotal!}"),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  buildActionButtons() {
    if (order!.status != Order.pending) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 130,
          child: ElevatedButton(
            child: Text(_appLocalizations.accept ?? "Accept"),
            onPressed: () {
              updateOrderStatus(Order.accepted);
            },
          ),
        ),
        SizedBox(
          width: 130,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red.shade900),
            child: Text(_appLocalizations.reject ?? "Reject"),
            onPressed: () {
              updateOrderStatus(Order.rejected);
            },
          ),
        )
      ],
    );
  }

  void updateOrderStatus(String status) async {
    final success = await order!.updateOrderStatus(status: status, orderId: order!.id!);
    String message = "";
    if (success) {
      message = _appLocalizations.statusUpdated ?? "Status updated";
    } else {
      message = _appLocalizations.failedUpdatingStatus ?? "Failed updating status";
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      if (success) context.read<OrdersProvider>().updateLists();
    }
  }

  void printOrder() async {
    File orderPdf = await PdfUtils.printOrder(order!, context);
    OpenFile.open(orderPdf.path);
  }
}
