class NewsInfo{
  String title;
  String paragraph1;
  String paragraph2;
  String paragraph3;
  String paragraph4;
  String paragraph5;
  String imageURL;

  NewsInfo(this.title , this.paragraph1 ,this.paragraph2 ,this.paragraph3 ,this.paragraph4 ,this.paragraph5, this.imageURL);

  NewsInfo.fromJson(Map<String , dynamic>json){
    title = json['title'];
    paragraph1 = json['paragraph1'];
    paragraph2 = json['paragraph2'];
    paragraph3 = json['paragraph3'];
    paragraph4 = json['paragraph4'];
    paragraph5 = json['paragraph5'];
    imageURL = json['imageURL'];
  }

}