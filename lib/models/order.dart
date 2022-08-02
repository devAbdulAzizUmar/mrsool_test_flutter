import 'package:flutter/material.dart';

class Order with ChangeNotifier {
  static const accepted = "accepted";
  static const pending = "pending";
  static const timeOut = "time_out";
  static const rejected = "rejected";
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
}
