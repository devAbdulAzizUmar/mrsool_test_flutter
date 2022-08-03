import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../api/orders_api.dart';
import '../models/order.dart';

class OrdersProvider with ChangeNotifier {
  final List<Order> _allOrders = [];

  bool _isLoadingAllOrdersList = true;
  bool _hasFailedGettingAllOrdersList = false;

  List<Order> get allOrders => [..._allOrders];

  bool get isLoadingAllOrdersList => _isLoadingAllOrdersList;
  bool get hasFailedGettingAllOrdersList => _hasFailedGettingAllOrdersList;

  Future<void> getAllOrders() async {
    _isLoadingAllOrdersList = true;
    _hasFailedGettingAllOrdersList = false;
    notifyListeners();

    _allOrders.clear();

    try {
      final result = await OrdersApi.instance.getOrdersList();

      if (result.statusCode == 200) {
        final resultJson = jsonDecode(utf8.decode(result.bodyBytes));
        final ordersJson = resultJson['data'];
        if (ordersJson != null) {
          ordersJson.forEach((json) {
            final order = Order.fromJson(json);
            _allOrders.add(order);
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

  Order? getOrderById(int id) {
    return _allOrders.firstWhereOrNull((element) => element.id == id);
  }

  void updateLists() {
    notifyListeners();
  }
}
