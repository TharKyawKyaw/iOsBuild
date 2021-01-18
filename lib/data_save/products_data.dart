import 'dart:convert';

List<ProductData> productDataFromJson(String str) => List<ProductData>.from(json.decode(str).map((x)=>ProductData.fromJson(x)));

String productDataToJson(List<ProductData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductData{

  String id;
  String name;
  String category;
  String categoryUrl;
  String brand;
  String region;
  String size;
  int alcoholVolume;
  String desctiption;
  int price;
  int stock;
  String imageURL;

  ProductData({
    this.id,
    this.name ,
    this.category,
    this.categoryUrl,
    this.brand,
    this.region,
    this.size,
    this.alcoholVolume,
    this.desctiption,
    this.price,
    this.stock,
    this.imageURL
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
      id: json["_id"],
      name: json["name"],
      category: json["category"],
      categoryUrl: json["categoryImageURL"],
      brand: json["brand"],
      region: json["region"],
      size: json["size"],
      alcoholVolume: json["alcoholVolume"],
      desctiption: json["description"],
      price: json["price"],
      stock: json["stock"],
      imageURL: json["imageURL"],

  );

  Map<String , dynamic> toJson() => {
    "_id": id,
    "name": name,
    "category": category,
    "categoryImageURL": categoryUrl,
    "brand": brand,
    "region": region,
    "size": size,
    "alcoholVolume": alcoholVolume,
    "description": desctiption,
    "price": price,
    "stock": stock,
    "imageURL": imageURL,
  };

}

class ProductInfo{

  String id;
  String name;
  String category;
  String categoryUrl;
  String brand;
  String region;
  String size;
  int alcoholVolume;
  String desctiption;
  int price;
  int stock;
  String imageURL;

  ProductInfo(
      this.id,
      this.name ,
      this.category,
      this.categoryUrl,
      this.brand,
      this.region,
      this.size,
      this.alcoholVolume,
      this.desctiption,
      this.price,
      this.stock,
      this.imageURL);

  ProductInfo.fromJson(Map<String , dynamic>json){
    id = json["_id"];
    name= json["name"];
    category= json["category"];
    categoryUrl= json["categoryImageURL"];
    brand= json["brand"];
    region= json["region"];
    size= json["size"];
    alcoholVolume= json["alcoholVolume"];
    desctiption= json["description"];
    price= json["price"];
    stock= json["stock"];
    imageURL= json["imageURL"];
  }


}

class LiquorList{
  String name;
  String picture;

  LiquorList(this.name , this.picture);
}