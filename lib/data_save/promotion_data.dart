import 'dart:convert';

class PromotionData{


  int paymentRequiredForSticker;
  int stickersRequiredForGift;
  int paymentRequiredForGoldCoupon;
  int paymentRequiredForSilverCoupon;
  int paymentRequiredForBronzeCoupon;
  int goldCouponDiscount;
  int silverCouponDiscount;
  int bronzeCouponDiscount;
  String imageURL1; String imageURL2; String imageURL3; String imageURL4; String imageURL5;
  String imageURL6; String imageURL7; String imageURL8;String imageURL9;String imageURL10;
  String giftDescription;
  String couponsDescription;
  String giftImageURL;


  PromotionData({
    this.paymentRequiredForSticker,
    this.stickersRequiredForGift,
    this.paymentRequiredForGoldCoupon,
    this.paymentRequiredForSilverCoupon,
    this.paymentRequiredForBronzeCoupon,
    this.goldCouponDiscount,
    this.silverCouponDiscount,
    this.bronzeCouponDiscount,
    this.imageURL1,
    this.imageURL2,
    this.imageURL3,
    this.imageURL4,
    this.imageURL5,
    this.imageURL6,
    this.imageURL7,
    this.imageURL8,
    this.imageURL9,
    this.imageURL10,
    this.giftDescription,
    this.couponsDescription,
    this.giftImageURL,
  });

  factory PromotionData.fromJson(Map<String, dynamic> json){
    return new PromotionData(
      paymentRequiredForSticker : json["paymentRequiredForSticker"],
      stickersRequiredForGift : json["stickersRequiredForGift"],
      paymentRequiredForGoldCoupon : json["paymentRequiredForGoldCoupon"],
      paymentRequiredForSilverCoupon : json["paymentRequiredForSilverCoupon"],
      paymentRequiredForBronzeCoupon : json["paymentRequiredForBronzeCoupon"],
      goldCouponDiscount : json["goldCouponDiscount"],
      silverCouponDiscount : json["silverCouponDiscount"],
      bronzeCouponDiscount : json["bronzeCouponDiscount"],
      imageURL1 : json["imageURL1"],
      imageURL2 : json["imageURL2"],
      imageURL3 : json["imageURL3"],
      imageURL4 : json["imageURL4"],
      imageURL5 : json["imageURL5"],
      imageURL6 : json["imageURL6"],
      imageURL7 : json["imageURL7"],
      imageURL8 : json["imageURL8"],
      imageURL9: json["imageURL9"],
      imageURL10 : json["imageURL10"],
      giftDescription : json["giftDescription"],
      couponsDescription : json["couponsDescription"],
      giftImageURL : json["giftImageURL"],
    );
  }



}