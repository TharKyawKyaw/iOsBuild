import 'dart:convert';

List<UserData> userDataFromJson(String str) => List<UserData>.from(json.decode(str).map((x)=>UserData.fromJson(x)));

String userDataToJson(List<UserData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData{

  UserData({ this.id , this.name , this.address , this.phoneNumber ,this.email,
    this.goldCoupons , this.silverCoupons,this.bronzeCoupons, this.stickers,
    this.googleID, this.facebookID,this.userImageURL});

  String id;
  String name;
  String address;
  String phoneNumber;
  String email;
  String googleID;
  String facebookID;
  String userImageURL;
  int goldCoupons;
  int silverCoupons;
  int bronzeCoupons;
  int stickers;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    name: json["name"],
    address: json["address"],
    phoneNumber: json["phone"],
    email: json["email"],
    googleID: json["googleID"],
    facebookID: json["facebookID"],
    userImageURL: json["userImageURL"],
    goldCoupons: json["goldCoupons"],
    silverCoupons: json["silverCoupons"],
    bronzeCoupons: json["bronzeCoupons"],
    stickers: json["stickers"],
  );

  Map<String , dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "phone": phoneNumber,
    "email": email,
    "googleID": googleID,
    "facebookID": facebookID,
    "userImageURL": userImageURL,
    "goldCoupons": goldCoupons,
    "silverCoupons": silverCoupons,
    "bronzeCoupons": bronzeCoupons,
    "stickers": stickers,
  };

}

class UserInfoData{
  String id;
  String name;
  String address;
  String phoneNumber;
  String email;
  String googleID;
  String facebookID;
  String userImageURL;
  int goldCoupons;
  int silverCoupons;
  int bronzeCoupons;
  int stickers;

  UserInfoData(
      this.id,
      this.name,
      this.address,
      this.phoneNumber,
      this.email,
      this.goldCoupons,
      this.silverCoupons,
      this.bronzeCoupons,
      this.stickers,
      this.googleID,
      this.facebookID,
      this.userImageURL);

  UserInfoData.fromJson(Map<String , dynamic>json){
    id = json["_id"];
    name= json["name"];
    address= json["address"];
    phoneNumber= json["phone"];
    email= json["email"];
    googleID= json["googleID"];
    facebookID= json["facebookID"];
    userImageURL= json["userImageURL"];
    goldCoupons= json["goldCoupons"];
    silverCoupons= json["silverCoupons"];
    bronzeCoupons= json["bronzeCoupons"];
    stickers= json["stickers"];
  }
}

class UserToken{
  String token;
  UserToken({this.token});
  factory UserToken.fromJson(Map<String, dynamic> json) => UserToken(
    token: json["token"]
  );

  Map<String , dynamic> toJson() => {
    "token": token,
  };
}