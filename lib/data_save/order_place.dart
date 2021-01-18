import 'dart:convert';

import 'package:i_love_liquor/child_tabs/promotions_items.dart';

//List<ApplyOrder> ApplyOrderFromJson(String str) => List<ApplyOrder>.from(json.decode(str).map((x)=>ApplyOrder.fromJson(x)));

//String ApplyOrderToJson(List<ApplyOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApplyOrder{

  List<Purchases> orderPurchases ;
  List<InvoiceProductInfo> invoiceProductInfo ;
  OrderCoupon orderCoupon;
  String deliveryAddress;
  String deliveryRegion;
  String contactNumber;
  String orderID;
  String id;
  String order_date;
  var discount;
  int tax;
  int deliveryFee;
  int total;
  int subtotal;
  bool orderConfirmed;


  ApplyOrder({

    this.orderPurchases ,
    this.invoiceProductInfo ,
    this.deliveryAddress ,
    this.orderCoupon ,
    this.orderID,
    this.id,
    this.contactNumber ,
    this.order_date ,
    this.deliveryRegion ,
    this.deliveryFee ,
    this.discount,
    this.tax,
    this.subtotal,
    this.total,
    this.orderConfirmed,
});

  factory ApplyOrder.fromJson(Map<String, dynamic> json){
    var _purchaseslist = json["purchases"] as List;
    var _productNamelist= json["orderInfos"] as List;
    //var _couponList= json["couponsUsed"] as List;
    List<Purchases> purchaseList = _purchaseslist.map((i) => Purchases.fromJson(i)).toList();
    List<InvoiceProductInfo> productList = _productNamelist.map((i) => InvoiceProductInfo.fromJson(i)).toList();
    //List<OrderCoupon> couponList = _couponList.map((i) => OrderCoupon.fromJson(i)).toList();
    return new ApplyOrder(
        deliveryAddress : json["deliveryAddress"],
        deliveryRegion : json["deliveryRegion"],
        order_date : json["dateOfOrder"],
        orderID : json["orderID"],
        contactNumber : json["contactNumber"],
      deliveryFee: json["deliveryFee"],
      id: json["_id"],
      discount: json["discount"],
      tax: json["tax"],
      total: json["total"],
      subtotal: json["subtotal"],
      orderConfirmed: json["orderConfirmed"],
      orderPurchases: purchaseList,
      invoiceProductInfo: productList,
        //orderCoupon: (json['couponsUsed']).map((i) => OrderCoupon.fromJson(i)).toList(),
    );
  }

  Map<String , dynamic> toJson(){
    final Map<String , dynamic>data = new Map<String , dynamic>();
        data["deliveryAddress"]= deliveryAddress;
        data["deliveryRegion"]= deliveryRegion;
        data["orderConfirmed"]= orderConfirmed;
        data["_id"]= id;
        data["contactNumber"]= contactNumber;
        if(this.orderPurchases != null){
          for(int i=0 ; i<orderPurchases.length ;i++){
            data["purchases"] = this.orderPurchases.map((e) => e.toJson()).toList();
          }
        }
    //data["couponsUsed"] = this.orderCoupon.map((e) => e.toJson()).toList();
    data["couponsUsed"] = this.orderCoupon.toJson();
        return data;
  }

}

class Purchases{

  String productID;
  String productName;
  int quantity;

  Purchases({
    this.quantity,
    this.productName,
    this.productID
});

  factory Purchases.fromJson(Map<String ,dynamic> json){
    return Purchases(
      productID: json["productID"],
      productName: json["productName"],
      quantity: json["quantity"],
    );
  }

  Map<String , dynamic> toJson() {
    final Map<String , dynamic>data = new Map<String , dynamic>();
    data["productID"] =  productID;
    data["productName"] =  productName;
    data["quantity"] =  quantity;
    return data;
  }


  }


class InvoiceProductInfo{
    String productName;
    int quantity;
    int subtotalPerProduct;
    InvoiceProductInfo({
      this.productName,
      this.quantity,
      this.subtotalPerProduct
});
    factory InvoiceProductInfo.fromJson(Map<String ,dynamic> json){
      return InvoiceProductInfo(
        productName: json["productName"],
        subtotalPerProduct: json["subtotalPerProduct"],
        quantity: json["quantity"],
      );
    }

}

class OrderCoupon{

  int gold;
  int silver;
  int bronze;

  OrderCoupon({this.gold, this.silver, this.bronze});

  OrderCoupon.fromJson(Map<String , dynamic>json){
    gold = json['gold'];
    silver = json['silver'];
    bronze = json['bronze'];
  }


  Map<String , dynamic> toJson() => {
    "gold": gold,
    "silver": silver,
    "bronze": bronze,
  };

}