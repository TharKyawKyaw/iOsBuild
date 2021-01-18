import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/global_data.dart';

class PrivacyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _titleFontSize = deviceWidth/20;
    double _fontSize = deviceWidth/30;
    double _headerFontSize = deviceWidth/25;
    double _paddingHeight =deviceHeight/80;
    return Scaffold(
        backgroundColor: lightGreenColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(titleTexts ,
            style: TextStyle(color: whiteTextColor ,
                fontFamily: 'Roboto_Thin',fontSize: _titleFontSize),
          ),
          backgroundColor: darkGreenColor,
          elevation: elevationShadow,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              Container(
                child: Center(child: Text('Privacy Policy', style: TextStyle(color: whiteTextColor ,
                    fontFamily: 'Roboto_Thin',fontSize: _headerFontSize)),),
              ),
              SizedBox(height: _paddingHeight,),
              Container(
                child: Center(child: Text('\t\t\t\t\t\t\tWe are committed to protecting your privacy. This privacy policy applies to all the web pages related to this website.\n\n'

                '\t\t\t\t\t\t\tAll the information gathered in the online forms on the website is used to personally identify users that subscribe to this service. The information will not be used for anything other than which is stated in the Terms & Conditions of use for this service. None of the information will be sold or made available to any third party under any circumstances, except by court order.\n\n'

                '\t\t\t\t\t\t\tThe Site may collect certain information about your visit, such as the name of the Internet service provider and the Internet Protocol (IP) address through which you access the Internet; the date and time you access the Site; the pages that you access while at the Site and the Internet address of the Web site from which you linked directly to our site. This information is used to help improve the Site, analyse trends, and administer the Site.\n\n'

                '\t\t\t\t\t\t\tWe may need to change this policy from time to time in order to address new issues and reflect changes on our site. We will post those changes here so that you will always know what information we gather, how we might use that information, and whether we will disclose that information to anyone. Please refer back to this policy regularly. If you have any questions or concerns about our privacy policy, please send us an E-mail.\n\n'

                '\t\t\t\t\t\t\tBy using this website, you indicate your acceptance of our Privacy Policy. If you do not agree to this policy, please do not use our site. Your continued use of the website following the posting of changes to these terms will mean that you accept those changes.\n\n'

                'Cookie/Tracking Technology\n\n'

                '\t\t\t\t\t\t\tThe Site may use cookie and tracking technology depending on the features offered. Cookie and tracking technology are useful for gathering information such as browser type and operating system, tracking the number of visitors to the Site, and understanding how visitors use the Site. Cookies can also help customize the Site for visitors. Personal information cannot be collected via cookies and other tracking technology; however, if you previously provided personally identifiable information, cookies may be tied to such information. Aggregate cookie and tracking information may be shared with third parties, but not your personal details or information.\n\n'

                'Third Party Links\n\n'

                '\t\t\t\t\t\t\tIn an attempt to provide increased value to our Users, we may provide links to other websites or resources. We cannot be held liable, directly or indirectly, for the privacy practices or the content of other websites, including any advertising, products or other materials or services on or available from such websites or resources, nor for any damage, loss or offence caused or alleged to be caused by, or in connection with, the use of or reliance on any such content, goods or services available on such external sites or resources.\n\n'

                  'We do encourage you to please notify us by email if any link from our site directs you to unsuitable or unlawful content so that we can investigate and if necessary, discontinue that link.\n\n'

                  'Product availability\n\n'

                  '\t\t\t\t\t\t\tLead time is dependent on stock availability. We will despatch stock as rapidly as possibly to ensure best service to our customers, but we cannot be held liable for any product not being available and use of this site constitutes your consent to indemnify The Liquor Shop from any and all liability, howsoever arising, and from direct or consequential damages due to the unavailability or unsuitability of any product.\n\n'

                  '\t\t\t\t\t\t\tProducts that reflect a zero price are not available at present.\n\n'

                  '\t\t\t\t\t\t\tThe Liquor Shop cannot be held liable for any illness or adverse health consequences suffered as a result of purchasing and consuming any product on this site. While we make every effort to ensure that our products reach you in the premium condition our customers enjoy, you are entirely responsible for your health. The Liquor Shop endorses the Arrive Alive campaign and encourages all its customers to drink responsibly. Don’t drink and drive!\n\n'

                  '\t\t\t\t\t\t\tShould the product not be in stock please allow 10 working days plus freight transit time. This will allow for ordering and delivery to our warehouse.\n\n'

                  '\t\t\t\t\t\t\tEvery effort is made to effect shipment of your order timeously however unforeseen circumstances may cause delays. Should we be faced with such an occurrence The Liquor Shop will contact you via email and provide a revised shipping schedule.\n\n', style: TextStyle(color: whiteTextColor ,
                    fontFamily: 'Roboto_Thin',fontSize:_fontSize),softWrap: true,textAlign: TextAlign.justify,
                )
                ),
              )
            ],
          ),
        )
    );
  }
}
