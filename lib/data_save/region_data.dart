import 'dart:convert';

class RegionsData{

  String name;
  int fee;


  RegionsData({
    this.name,
    this.fee,
  });

  factory RegionsData.fromJson(Map<String, dynamic> json){
    return new RegionsData(
      name : json["name"],
      fee : json["fee"],
    );
  }

}
