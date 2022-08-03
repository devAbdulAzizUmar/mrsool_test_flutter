import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mrsool_test/api/orders_api.dart';
import 'package:mrsool_test/models/order_details.dart';

class Order with ChangeNotifier {
  static const accepted = "accepted";
  static const pending = "pending";
  static const timeOut = "time_out";
  static const rejected = "rejected";

  bool _isLoadingOrderDetails = false;
  bool _hasFailedGettingOrderDetails = false;

  bool _isUpdatingStatus = false;

  bool get isLoadingOrderDetails => _isLoadingOrderDetails;
  bool get hasFailedGettingOrderDetails => _hasFailedGettingOrderDetails;
  bool get isUpdatingStatus => _isUpdatingStatus;

  Order({
    this.id,
    this.referenceNumber,
    this.orderId,
    this.businessAccountId,
    this.businessBranchId,
    this.status,
    this.grandTotal,
    this.actualPrepareTime,
    this.estimatedPrepareTime,
    this.rejectionReason,
    this.expiredAt,
    this.isTest,
    this.receivedAt,
    this.orderWorkflow,
    this.businessBranchName,
    this.currency,
    this.pinCode,
    this.orderType,
    this.businessCreditLine,
  });

  int? id;
  String? referenceNumber;
  int? orderId;
  int? businessAccountId;
  int? businessBranchId;
  String? status;
  String? grandTotal;
  String? actualPrepareTime;
  String? estimatedPrepareTime;
  String? rejectionReason;
  dynamic expiredAt;
  bool? isTest;
  String? receivedAt;
  String? orderWorkflow;
  String? businessBranchName;
  String? currency;
  int? pinCode;
  String? orderType;
  bool? businessCreditLine;
  OrderDetails? orderDetails;

  factory Order.fromJson(Map<String?, dynamic> json) => Order(
        id: json["id"],
        referenceNumber: json["reference_number"],
        orderId: json["order_id"],
        businessAccountId: json["business_account_id"],
        businessBranchId: json["business_branch_id"],
        status: json["status"],
        grandTotal: json["grand_total"],
        actualPrepareTime: json["actual_prepare_time"],
        estimatedPrepareTime: json["estimated_prepare_time"],
        rejectionReason: json["rejection_reason"],
        expiredAt: json["expired_at"],
        isTest: json["is_test"],
        receivedAt: json["received_at"],
        orderWorkflow: json["order_workflow"],
        businessBranchName: json["business_branch_name"],
        currency: json["currency"],
        pinCode: json["pin_code"],
        orderType: json["order_type"],
        businessCreditLine: json["business_credit_line"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "reference_number": referenceNumber,
        "order_id": orderId,
        "business_account_id": businessAccountId,
        "business_branch_id": businessBranchId,
        "status": status,
        "grand_total": grandTotal,
        "actual_prepare_time": actualPrepareTime,
        "estimated_prepare_time": estimatedPrepareTime,
        "rejection_reason": rejectionReason,
        "expired_at": expiredAt,
        "is_test": isTest,
        "received_at": receivedAt,
        "order_workflow": orderWorkflow,
        "business_branch_name": businessBranchName,
        "currency": currency,
        "pin_code": pinCode,
        "order_type": orderType,
        "business_credit_line": businessCreditLine,
      };

  void setOrderDetails(OrderDetails orderDetails) {
    this.orderDetails = orderDetails;
    notifyListeners();
  }

  void getOrderDetails() async {
    _isLoadingOrderDetails = true;
    notifyListeners();

    if (id == null) {
      setErrorLoadingDetails(true);
      return;
    }

    try {
      final response = await OrdersApi.instance.getOrderDetails(orderId: id!);
      if (response.statusCode != 200) {
        setErrorLoadingDetails(true);
        return;
      }
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseJson['data'] == null) {
        setErrorLoadingDetails(true);
        return;
      }
      final orderDetails = OrderDetails.fromJson(responseJson['data']);
      setOrderDetails(orderDetails);
    } on SocketException catch (e) {
      debugPrint("getOrderDetails ${e.message}");
      _hasFailedGettingOrderDetails = true;
    } on Exception catch (e) {
      debugPrint("getOrderDetails $e");
      _hasFailedGettingOrderDetails = true;
    }

    _isLoadingOrderDetails = false;
    notifyListeners();
  }

  void setErrorLoadingDetails(bool hasError) {
    _hasFailedGettingOrderDetails = hasError;
    _isLoadingOrderDetails = false;
    notifyListeners();
  }

  Future<bool> updateOrderStatus({required String status, required int orderId}) async {
    bool success = false;
    _isUpdatingStatus = true;
    notifyListeners();

    final response = await OrdersApi.instance.updateOrderStatus(status: status, orderId: orderId);

    if (response.statusCode == 200) {
      this.status = status;
      orderDetails?.status = status;
      success = true;
    } else {
      success = false;
    }

    _isUpdatingStatus = false;
    notifyListeners();
    return success;
  }

  void setOrderStatus({required String status}) {
    //this method is to update the status without actually calling the api
    this.status = status;
    orderDetails?.status = status;
    notifyListeners();
  }

  bool shouldStatusTimeout() {
    if (status != Order.pending) return false;
    if (receivedAt == null) return false;

    final receiveTime = DateTime.parse(receivedAt!);
    final differenceInMinutes = DateTime.now().difference(receiveTime).inMinutes;
    if (differenceInMinutes >= 6) {
      setOrderStatus(status: Order.timeOut);
      return true;
    }
    return false;
  }
}
