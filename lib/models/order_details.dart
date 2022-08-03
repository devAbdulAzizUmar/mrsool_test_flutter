class OrderDetails {
  OrderDetails({
    this.id,
    this.businessAccountId,
    this.businessBranchId,
    this.orderId,
    this.status,
    this.grandTotal,
    this.actualPrepareTime,
    this.estimatedPrepareTime,
    this.rejectionReason,
    this.referenceNumber,
    this.expiredAt,
    this.isTest,
    this.receivedAt,
    this.orderWorkflow,
    this.pinCode,
    this.orderType,
    this.orderCourier,
    this.businessAccountName,
    this.vatPercentage,
    this.vatAmount,
    this.paymentMethod,
    this.businessBranchName,
    this.currency,
    this.items,
  });

  int? id;
  int? businessAccountId;
  int? businessBranchId;
  int? orderId;
  String? status;
  String? grandTotal;
  String? actualPrepareTime;
  String? estimatedPrepareTime;
  String? rejectionReason;
  String? referenceNumber;
  String? expiredAt;
  bool? isTest;
  String? receivedAt;
  String? orderWorkflow;
  int? pinCode;
  String? orderType;
  dynamic orderCourier;
  String? businessAccountName;
  double? vatPercentage;
  String? vatAmount;
  String? paymentMethod;
  String? businessBranchName;
  String? currency;
  List<Item>? items;

  factory OrderDetails.fromJson(Map<String?, dynamic> json) => OrderDetails(
        id: json["id"],
        businessAccountId: json["business_account_id"],
        businessBranchId: json["business_branch_id"],
        orderId: json["order_id"],
        status: json["status"],
        grandTotal: json["grand_total"],
        actualPrepareTime: json["actual_prepare_time"],
        estimatedPrepareTime: json["estimated_prepare_time"],
        rejectionReason: json["rejection_reason"],
        referenceNumber: json["reference_number"],
        expiredAt: json["expired_at"],
        isTest: json["is_test"],
        receivedAt: json["received_at"],
        orderWorkflow: json["order_workflow"],
        pinCode: json["pin_code"],
        orderType: json["order_type"],
        orderCourier: json["order_courier"],
        businessAccountName: json["business_account_name"],
        vatPercentage: json["vat_percentage"],
        vatAmount: json["vat_amount"],
        paymentMethod: json["payment_method"],
        businessBranchName: json["business_branch_name"],
        currency: json["currency"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "business_account_id": businessAccountId,
        "business_branch_id": businessBranchId,
        "order_id": orderId,
        "status": status,
        "grand_total": grandTotal,
        "actual_prepare_time": actualPrepareTime,
        "estimated_prepare_time": estimatedPrepareTime,
        "rejection_reason": rejectionReason,
        "reference_number": referenceNumber,
        "expired_at": expiredAt,
        "is_test": isTest,
        "received_at": receivedAt,
        "order_workflow": orderWorkflow,
        "pin_code": pinCode,
        "order_type": orderType,
        "order_courier": orderCourier,
        "business_account_name": businessAccountName,
        "vat_percentage": vatPercentage,
        "vat_amount": vatAmount,
        "payment_method": paymentMethod,
        "business_branch_name": businessBranchName,
        "currency": currency,
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.businessOrderId,
    this.menuItemId,
    this.menuItemVarietyId,
    this.quantity,
    this.unitPrice,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.itemPrice,
    this.varietyPrice,
    this.name,
    this.enName,
    this.shortDesc,
    this.longDesc,
    this.menuItem,
    this.orderItemAddons,
  });

  int? id;
  int? businessOrderId;
  int? menuItemId;
  dynamic menuItemVarietyId;
  int? quantity;
  String? unitPrice;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? itemPrice;
  String? varietyPrice;
  String? name;
  String? enName;
  String? shortDesc;
  String? longDesc;
  Menu? menuItem;
  List<OrderItemAddon>? orderItemAddons;

  factory Item.fromJson(Map<String?, dynamic> json) => Item(
        id: json["id"],
        businessOrderId: json["business_order_id"],
        menuItemId: json["menu_item_id"],
        menuItemVarietyId: json["menu_item_variety_id"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        itemPrice: json["item_price"],
        varietyPrice: json["variety_price"],
        name: json["name"],
        enName: json["en_name"],
        shortDesc: json["short_desc"],
        longDesc: json["long_desc"],
        menuItem: json["menu_item"] == null ? null : Menu.fromJson(json["menu_item"]),
        orderItemAddons: json["order_item_addons"] == null
            ? null
            : List<OrderItemAddon>.from(json["order_item_addons"].map((x) => OrderItemAddon.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "business_order_id": businessOrderId,
        "menu_item_id": menuItemId,
        "menu_item_variety_id": menuItemVarietyId,
        "quantity": quantity,
        "unit_price": unitPrice,
        "is_deleted": isDeleted,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "item_price": itemPrice,
        "variety_price": varietyPrice,
        "name": name,
        "en_name": enName,
        "short_desc": shortDesc,
        "long_desc": longDesc,
        "menu_item": menuItem == null ? null : menuItem!.toJson(),
        "order_item_addons":
            orderItemAddons == null ? null : List<dynamic>.from(orderItemAddons!.map((x) => x.toJson())),
      };
}

class Menu {
  Menu({
    this.id,
    this.name,
    this.price,
    this.enName,
    this.defaultOption,
  });

  int? id;
  String? name;
  String? price;
  String? enName;
  dynamic defaultOption;

  factory Menu.fromJson(Map<String?, dynamic> json) => Menu(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        enName: json["en_name"],
        defaultOption: json["default_option"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "en_name": enName,
        "default_option": defaultOption,
      };
}

class OrderItemAddon {
  OrderItemAddon({
    this.id,
    this.addonPrice,
    this.name,
    this.enName,
    this.menuItemAddon,
    this.orderItemAddonOptions,
  });

  int? id;
  String? addonPrice;
  String? name;
  String? enName;
  MenuItemAddon? menuItemAddon;
  List<OrderItemAddonOption>? orderItemAddonOptions;

  factory OrderItemAddon.fromJson(Map<String?, dynamic> json) => OrderItemAddon(
        id: json["id"],
        addonPrice: json["addon_price"],
        name: json["name"],
        enName: json["en_name"],
        menuItemAddon: json["menu_item_addon"] == null ? null : MenuItemAddon.fromJson(json["menu_item_addon"]),
        orderItemAddonOptions: json["order_item_addon_options"] == null
            ? null
            : List<OrderItemAddonOption>.from(
                json["order_item_addon_options"].map((x) => OrderItemAddonOption.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "addon_price": addonPrice,
        "name": name,
        "en_name": enName,
        "menu_item_addon": menuItemAddon == null ? null : menuItemAddon!.toJson(),
        "order_item_addon_options":
            orderItemAddonOptions == null ? null : List<dynamic>.from(orderItemAddonOptions!.map((x) => x.toJson())),
      };
}

class MenuItemAddon {
  MenuItemAddon({
    this.id,
    this.price,
    this.menuAddon,
  });

  int? id;
  String? price;
  Menu? menuAddon;

  factory MenuItemAddon.fromJson(Map<String?, dynamic> json) => MenuItemAddon(
        id: json["id"],
        price: json["price"],
        menuAddon: json["menu_addon"] == null ? null : Menu.fromJson(json["menu_addon"]),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "price": price,
        "menu_addon": menuAddon == null ? null : menuAddon!.toJson(),
      };
}

class OrderItemAddonOption {
  OrderItemAddonOption({
    this.id,
    this.addonOptionPrice,
    this.name,
    this.enName,
    this.menuItemAddonOption,
  });

  int? id;
  String? addonOptionPrice;
  String? name;
  String? enName;
  MenuItemAddonOption? menuItemAddonOption;

  factory OrderItemAddonOption.fromJson(Map<String?, dynamic> json) => OrderItemAddonOption(
        id: json["id"],
        addonOptionPrice: json["addon_option_price"],
        name: json["name"],
        enName: json["en_name"],
        menuItemAddonOption: json["menu_item_addon_option"] == null
            ? null
            : MenuItemAddonOption.fromJson(json["menu_item_addon_option"]),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "addon_option_price": addonOptionPrice,
        "name": name,
        "en_name": enName,
        "menu_item_addon_option": menuItemAddonOption == null ? null : menuItemAddonOption!.toJson(),
      };
}

class MenuItemAddonOption {
  MenuItemAddonOption({
    this.id,
    this.price,
    this.menuAddonOption,
  });

  int? id;
  String? price;
  Menu? menuAddonOption;

  factory MenuItemAddonOption.fromJson(Map<String?, dynamic> json) => MenuItemAddonOption(
        id: json["id"],
        price: json["price"],
        menuAddonOption: json["menu_addon_option"] == null ? null : Menu.fromJson(json["menu_addon_option"]),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "price": price,
        "menu_addon_option": menuAddonOption == null ? null : menuAddonOption!.toJson(),
      };
}
