class Item {
  int? id_ShopItem;
  String? shopItemName;
  String? description;
  num? price;
  int? itemCount;
  String? image_URL;
  Item(
      {this.id_ShopItem,
      this.shopItemName,
      this.description,
      this.price,
      this.itemCount,
      this.image_URL});
  static fromJson(Map<String, dynamic> jsonResponse) {
    return Item(
      id_ShopItem: jsonResponse['id_ShopItem'],
      shopItemName: jsonResponse['shopItemName'],
      description: jsonResponse['description'],
      price: jsonResponse['price'],
      itemCount: jsonResponse['itemCount'],
      image_URL: jsonResponse['image_URL'],
    );
  }
}

class BasketFullInfo {
  int? id_ShopBasket;
  int? item_id;
  int? user_id;
  String? item_Name;
  String? item_Description;
  num? item_Price;
  int? item_Count;
  String? user_Name;
  num? fullPriceThisPosition;
  int? shopItemCount;
  String? image_URL;
  bool? isSelected;
  int? order_id;
  BasketFullInfo(
      {this.id_ShopBasket,
      this.item_id,
      this.user_id,
      this.item_Name,
      this.item_Description,
      this.item_Price,
      this.item_Count,
      this.user_Name,
      this.fullPriceThisPosition,
      this.shopItemCount,
      this.image_URL,
      this.isSelected,
      this.order_id});
  static fromJson(Map<String, dynamic> jsonResponse) {
    return BasketFullInfo(
        id_ShopBasket: jsonResponse['id_ShopBasket'],
        item_id: jsonResponse['item_id'],
        user_id: jsonResponse['user_id'],
        item_Name: jsonResponse['item_Name'],
        item_Description: jsonResponse['item_Description'],
        item_Price: jsonResponse['item_Price'],
        item_Count: jsonResponse['item_Count'],
        user_Name: jsonResponse['user_Name'],
        fullPriceThisPosition: jsonResponse['fullPriceThisPosition'],
        shopItemCount: jsonResponse['shopItemCount'],
        image_URL: jsonResponse['image_URL'],
        order_id: jsonResponse['order_id'],
        isSelected: false);
  }
}

class ShopOrderFullInfo {
  int? id_Order;
  int? orderStatus_id;
  int? user_id;
  String? orderStatus_Name;
  DateTime? orderDate;
  num? totalSum;
  List<BasketFullInfo>? shopBaskets;
  String? paymentUri;
  List<StatusAndDate>? statusAndDates;

  ShopOrderFullInfo(
      {this.id_Order,
      this.orderStatus_id,
      this.user_id,
      this.orderStatus_Name,
      this.orderDate,
      this.totalSum,
      this.shopBaskets,
      this.paymentUri,
      this.statusAndDates});

  static fromJson(Map<String, dynamic> jsonResponse) {
    return ShopOrderFullInfo(
        id_Order: jsonResponse['id_Order'],
        user_id: jsonResponse['user_id'],
        totalSum: jsonResponse['totalSum'],
        shopBaskets: jsonResponse['shopBaskets'] != null
            ? List<BasketFullInfo>.from((jsonResponse['shopBaskets'])
                .map((model) => BasketFullInfo.fromJson(model)))
            : null,
        statusAndDates: jsonResponse['statusAndDates'] != null
            ? List<StatusAndDate>.from((jsonResponse['statusAndDates'])
                .map((model) => StatusAndDate.fromJson(model)))
            : null,
        paymentUri: jsonResponse['paymentUri'] != null
            ? jsonResponse['paymentUri']
            : null);
  }
}

class StatusAndDate {
  int? orderStatus_id;
  String? status;
  DateTime? dateOrder;

  StatusAndDate({this.orderStatus_id, this.status, this.dateOrder});

  static fromJson(Map<String, dynamic> jsonResponse) {
    return StatusAndDate(
        orderStatus_id: jsonResponse['orderStatus_id'],
        status: jsonResponse['status'],
        dateOrder: DateTime.parse(jsonResponse['dateOrder']));
  }
}
