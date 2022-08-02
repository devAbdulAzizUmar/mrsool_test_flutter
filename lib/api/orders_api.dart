import 'package:mrsool_test/api/base_api.dart';

import 'package:http/http.dart';

class OrdersApi {
  OrdersApi._constructor();
  static final OrdersApi _instance = OrdersApi._constructor();
  static OrdersApi get instance => _instance;
  final headers = {
    ...BaseApi.defaultHeaders,
    "Authorization": BaseApi.ordersApiToken,
  };

  Future<Response> getOrdersList({
    List<String>? statusFilters,
  }) async {
    final queryParams = {
      "statuses[]": statusFilters,
    };

    return get(
      Uri.https(
        BaseApi.baseUrl,
        '/v1/business_orders/without_items',
        queryParams,
      ),
      headers: headers,
    );
  }

  Future<Response> getOrderDetails({required int orderId}) async {
    return get(
      Uri.https(
        BaseApi.baseUrl,
        '//v1/business_orders/$orderId',
      ),
      headers: headers,
    );
  }
}
