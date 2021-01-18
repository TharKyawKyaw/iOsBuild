import 'dart:convert';

class QandA{

  String question;
  String paragraph1;
  String paragraph2;
  String paragraph3;
  String paragraph4;
  String paragraph5;


  QandA({
    this.question,
    this.paragraph1,
    this.paragraph2,
    this.paragraph3,
    this.paragraph4,
    this.paragraph5,
  });

  factory QandA.fromJson(Map<String, dynamic> json){
    return new QandA(
      question : json["question"],
      paragraph1 : json["answerParagraph1"],
      paragraph2 : json["answerParagraph2"],
      paragraph3 : json["answerParagraph3"],
      paragraph4 : json["answerParagraph4"],
      paragraph5 : json["answerParagraph5"],
    );
  }



}