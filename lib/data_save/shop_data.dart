import 'dart:convert';

class Branches{

  String branchName;
  String address;
  String phone;


  Branches({
    this.branchName,
    this.address,
    this.phone,
  });

  factory Branches.fromJson(Map<String, dynamic> json){
    return new Branches(
      branchName : json["name"],
      address : json["address"],
      phone : json["phone"],
    );
  }



}

class Release{
  String title;
  String paragraph1;
  String paragraph2;
  String paragraph3;
  String paragraph4;
  String paragraph5;
  String aboutUsImg;
  String contactUsImg;


  Release({
    this.title,
    this.paragraph1,
    this.paragraph2,
    this.paragraph3,
    this.paragraph4,
    this.paragraph5,
    this.aboutUsImg,
    this.contactUsImg,
  });

  factory Release.fromJson(Map<String, dynamic> json){
    return new Release(
      title : json["title"],
      paragraph1 : json["paragraph1"],
      paragraph2 : json["paragraph2"],
      paragraph3 : json["paragraph3"],
      paragraph4 : json["paragraph4"],
      paragraph5 : json["paragraph5"],
      aboutUsImg : json["imageURL1"],
      contactUsImg : json["imageURL2"],
    );
  }



}