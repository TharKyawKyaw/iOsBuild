import 'dart:convert';

List<OrderData> orderDataFromJson(String str) => List<OrderData>.from(json.decode(str).map((x)=>OrderData.fromJson(x)));

String orderDataToJson(List<OrderData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderData{

  OrderProduct orderProduct ;
  OrderUser orderUser;

  String deliveryAddress;
  //String productName;
  String userId;
  String contactNumber;
  int quantity;

  OrderData({
    //this.productName,
    this.userId,
    this.deliveryAddress,
    this.contactNumber,
    this.quantity
  });


  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    //productName: json["productName"],
    userId: json["userId"],
      deliveryAddress: json["deliveryAddress"],
      contactNumber: json["contactNumber"],
      quantity: json["quantity"],
  );



  Map<String , dynamic> toJson() => {
      "userId": userId,
      "quantity": quantity,
      //"productName": productName,
      "deliveryAddress": deliveryAddress,
      "contactNumber": contactNumber,
  };

}

class OrderProduct{

  String productName;

  OrderProduct({this.productName});

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
    productName: json["productName"],
  );



  Map<String , dynamic> toJson() => {
      "productName": productName,
  };

}

class OrderUser{

  String name;

  OrderUser({this.name});

  factory OrderUser.fromJson(Map<String, dynamic> json) => OrderUser(
      name: json["name"],
  );



  Map<String , dynamic> toJson() => {
    "name": name,
  };

}

class OrderInfo{
  String id;
  String productName;
  int quantity;
  int subtotal;
  int total;

  OrderInfo(this.id , this.productName , this.quantity , this.subtotal , this.total);

  OrderInfo.fromJson(Map<String , dynamic>json){
    id = json['_id'];
    productName = json['productName'];
    quantity = json['quantity'];
    subtotal = json['subtotal'];
    total = json['total'];
  }

}