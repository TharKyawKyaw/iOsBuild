import 'package:flutter/material.dart';
import 'package:i_love_liquor/data_save/global_data.dart';

class TermsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double _fontSize = deviceWidth/30;
    double _titleFontSize = deviceWidth/20;
    double _headerFontSize = deviceWidth/25;
    double _paddingHeight = deviceHeight/80;
    
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
              child: Center(child: Text('TERMS AND CONDITIONS', style: TextStyle(color: whiteTextColor ,
                  fontFamily: 'Roboto_Thin',fontSize: _headerFontSize)),),
            ),
            SizedBox(height:_paddingHeight,),
            Container(
              child: Center(child: Text('Site usage\n\n'

                   '\t\t\t\t\t\t\tYou may only use this site to browse the content, make legitimate purchases; not for any other purposes, including to make any speculative, false or fraudulent purchase. '
                  'This site and the content provided in this site may not be copied, reproduced, republished, uploaded, posted, transmitted or distributed. '
                  '‘Deep-linking’, ‘embedding’ or using analogous technology is strictly prohibited. '
                  'Unauthorized use of this site and/or the materials contained on this site may violate applicable copyright, trademark or other intellectual property laws or other laws.\n\n'
                  'Disclaimer of Warranty\n\n'

                  '\t\t\t\t\t\t\tThe contents of this site are provided “as is” without warranty of any kind, either expressed or implied. Subject to our high standards of quality, we cannot be held responsible for the customer purchasing the wrong type of product.\n\n'

                  '\t\t\t\t\t\t\tThe owner of this site, the authors of these contents and in general anybody connected to this site in any way, from now on collectively called “Providers”, assume no responsibility for errors or omissions in these contents.\n\n'

                  '\t\t\t\t\t\t\tThe Providers further do not warrant, guarantee or make any representation regarding the safety, reliability, accuracy, correctness or completeness of these contents. The Providers shall not be liable for any direct, indirect, general, special, incidental or consequential damages (including -without limitation- data loss, lost revenues and lost profit) which may result from the inability to use or the correct or incorrect use, abuse, or misuse of these contents, even if the Providers have been informed of the possibilities of such damages. The Providers cannot assume any obligation or responsibility.\n\n'

                  '\t\t\t\t\t\t\tThe use of these contents is forbidden in those places where the law does not allow this disclaimer to take full effect.\n\n'

                  'Our Rights\n\n'

                  'We reserve the right to:\n\n'

                  '1. modify or withdraw, temporarily or permanently, the Website (or any part including any product/s) with or without notice to you and you confirm that we shall not be liable to you or any third party for any modification to or withdrawal of the Website; and/or\n\n'

                  '2. change these Conditions from time to time, and your continued use of the Website (or any part of) following such change indicates your acceptance of that change. It is your responsibility to check regularly to determine whether the Conditions have been changed. If you do not agree to any change to the Conditions then you must immediately stop using the Website.\n\n'

                  '3. We will use our best reasonable endeavours to maintain the Website. The Website is subject to change from time to time. We will not be liable for, nor will you be eligible to any compensation because you cannot use any part of the Website or because of a failure, suspension or withdrawal of all or part of the Website due to circumstances beyond our control.\n\n'

                  '4. Not honour any purchase, on condition that we refund the purchaser in full for any purchase, for any reason whatsoever. This situation is obviously undesirable but may be necessary where the website contains patent errors or price irregularities.\n\n',
                style: TextStyle(color: whiteTextColor ,
                  fontFamily: 'Roboto_Thin',fontSize: _fontSize),softWrap: true,textAlign: TextAlign.justify,
              )
              ),
            )
          ],
        ),
      )
    );
  }
}
