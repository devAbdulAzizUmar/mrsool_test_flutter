import 'package:flutter/material.dart';
import 'package:mrsool_test/widgets/app_drawer.dart';
import 'package:mrsool_test/widgets/orders_list.dart';
import 'package:provider/provider.dart';

import '../lang/app_localization.dart';
import '../models/order.dart';
import '../providers/orders_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late OrdersProvider _ordersProvider;

  late AppLocalizations _appLocalizations;

  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _isInit = false;
        _ordersProvider = context.read<OrdersProvider>();
        _ordersProvider.getAllOrders();
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _ordersProvider = context.watch<OrdersProvider>();
    _appLocalizations = AppLocalizations.of(context)!;

    final allOrders = _ordersProvider.allOrders;
    final pendingOrders = allOrders.where(((element) => element.status == Order.pending)).toList();
    final acceptedOrders = allOrders.where(((element) => element.status == Order.accepted)).toList();
    final rejectedOrders = allOrders.where(((element) => element.status == Order.rejected)).toList();
    final timedOutOrders = allOrders.where(((element) => element.status == Order.timeOut)).toList();

    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          centerTitle: false,
          title: Image.asset(
            'assets/mrsool_logo.png',
            height: kToolbarHeight + 50,
          ),
          bottom: TabBar(
            labelPadding: const EdgeInsets.only(bottom: 10, top: 15),
            unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            tabs: [
              Text(_appLocalizations.all ?? "All"),
              Text(_appLocalizations.pending ?? "Pending"),
              Text(_appLocalizations.accepted ?? "Accepted"),
              Text(_appLocalizations.rejected ?? "Rejected"),
              Text(_appLocalizations.timedOut ?? "Timed Out"),
            ],
          ),
        ),
        body: _ordersProvider.isLoadingAllOrdersList
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : TabBarView(
                children: [
                  OrdersList(orders: allOrders),
                  OrdersList(orders: pendingOrders),
                  OrdersList(orders: acceptedOrders),
                  OrdersList(orders: rejectedOrders),
                  OrdersList(orders: timedOutOrders),
                ],
              ),
      ),
    );
  }
}
