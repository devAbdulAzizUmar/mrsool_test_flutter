import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mrsool_test/models/order.dart';

import '../api/orders_api.dart';

class OrdersProvider with ChangeNotifier {
  final List<Order> _allOrders = [];
  final List<Order> _acceptedOrders = [];
  final List<Order> _pendingOrders = [];
  final List<Order> _rejectedOrders = [];
  final List<Order> _timedOutOrders = [];

  bool _isLoadingAllOrdersList = true;
  bool _hasFailedGettingAllOrdersList = false;

  List<Order> get allOrders => [..._allOrders];
  List<Order> get acceptedOrders => [..._acceptedOrders];
  List<Order> get pendingOrders => [..._pendingOrders];
  List<Order> get rejectedOrders => [..._rejectedOrders];
  List<Order> get timedOutOrders => [..._timedOutOrders];

  bool get isLoadingAllOrdersList => _isLoadingAllOrdersList;
  bool get hasFailedGettingAllOrdersList => _hasFailedGettingAllOrdersList;

  void getAllOrders() async {
    _isLoadingAllOrdersList = true;
    _hasFailedGettingAllOrdersList = false;
    notifyListeners();

    _allOrders.clear();
    _acceptedOrders.clear();
    _pendingOrders.clear();
    _rejectedOrders.clear();
    _timedOutOrders.clear();

    try {
      final result = await OrdersApi.instance.getOrdersList();

      if (result.statusCode == 200) {
        final resultJson = jsonDecode(utf8.decode(result.bodyBytes));
        final ordersJson = resultJson['data'];
        if (ordersJson != null) {
          ordersJson.forEach((json) {
            final order = Order.fromJson(json);
            _allOrders.add(order);
            if (order.status == Order.accepted) _acceptedOrders.add(order);
            if (order.status == Order.pending) _pendingOrders.add(order);
            if (order.status == Order.rejected) _rejectedOrders.add(order);
            if (order.status == Order.timeOut) _timedOutOrders.add(order);
          });
        }
      } else {
        _hasFailedGettingAllOrdersList = true;
        debugPrint("getOrders: ${result.body}");
      }
    } on SocketException catch (e) {
      _hasFailedGettingAllOrdersList = true;
      debugPrint("getOrders: ${e.message}");
    } on Exception catch (e) {
      debugPrint("getOrders: $e");
      _hasFailedGettingAllOrdersList = true;
    }

    _isLoadingAllOrdersList = false;
    notifyListeners();
  }
}
