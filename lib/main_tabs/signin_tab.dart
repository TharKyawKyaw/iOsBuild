/*
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_love_liquor/child_tabs/edit_tab.dart';
import 'package:i_love_liquor/child_tabs/setting_tab.dart';
import 'package:i_love_liquor/data_save/global_data.dart';
import 'package:i_love_liquor/data_save/user_data.dart';
import 'package:i_love_liquor/main_tabs/first_tab.dart';
import 'package:i_love_liquor/main_tabs/home_widget.dart';
import 'package:http/http.dart' as http;
import 'package:localize_and_translate/localize_and_translate.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'account_tab.dart';
import 'home_widget.dart';
import 'dart:convert' as JSON;







Map userProfile;
final facebookLogin = FacebookLogin();
List<UserInfo> _userInfo;
bool loading = false;
final FirebaseAuth firebaseAuth =  FirebaseAuth.instance;
SharedPreferences preferences;
bool _newLogin = false;

final GoogleSignIn googleSignIn = new GoogleSignIn();


TextEditingController item_quantity;

class SignInTab extends StatefulWidget {

  _SignInTabState createState() => _SignInTabState();

}

class _SignInTabState extends State<SignInTab> {

  bool _loading =false;


  TextEditingController _userController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

*/
/*  Future<List<UserInfoData>> fetchNotes() async{

    setState(() {
      dataLoading = true;
    });
    var url = 'https://calm-wave-88750.herokuapp.com/users';
    var response = await http.get(url);

    var datas = List<UserInfoData>();

    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);
      setState(() {
        for(var dataJson in datasJson){
          datas.add(UserInfoData.fromJson(dataJson));
        }
        dataLoading = false;
      });

      return datas;

    }
  }

  Future<List<ProductInfo>> fetchProducts() async{

    var url = 'https://calm-wave-88750.herokuapp.com/products';
    var response = await http.get(url);

    var datas = List<ProductInfo>();

    if(response.statusCode == 200 ){
      var datasJson = json.decode(response.body);

      for(var dataJson in datasJson){
        datas.add(ProductInfo.fromJson(dataJson));
      }
      return datas;
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNotes().then((value){
      setState(() {
        userInfo.addAll(value);
        print(userInfo);
      });
    });
    fetchProducts().then((value){
      setState(() {
        productInfo.addAll(value);
        print(productInfo);
      });
    });

  }*//*




  Future<List<UserData>> googleRegisterVersion(String name , String email, String phone, String address, String googleID ,String facebookID , String imageURL   ) async{

    final String url = 'https://calm-wave-88750.herokuapp.com/register';
    final response = await http.post(url,body:{
      "name": name,
      "email": email,
      "phoneNumber": phone,
      "address": address,
      "googleID": googleID,
      "facebookID": facebookID,
      "imageURL": imageURL,
    });

    if(response.statusCode == 201){
      final String responseString = response.body;
      return userDataFromJson(responseString);
    }else{
      return null;
    }

  }

  Future<List<UserData>> FbRegisterVersion(String name , String email, String phone, String address,String googleID , String facebookID , String imageURL) async{

    final String url = 'https://calm-wave-88750.herokuapp.com/register';
    final response = await http.post(url,body:{
      "name": name,
      "email": email,
      "phoneNumber": phone,
      "address": address,
      "googleID": googleID,
      "facebookID": facebookID,
      "imageURL": imageURL,
    });
    //print(response.body);
    if(response.statusCode == 201){
      final String responseString = response.body;
      return userDataFromJson(responseString);
    }else{
      return null;
    }

  }



  void isSignedIn() async{

    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();
    if(isLogedin){
      _loginWithGoogle();
    }
    setState(() {
      loading = false;
    });
  }

  Future _loginWithGoogle() async{

    preferences = await SharedPreferences.getInstance();


    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;

    GoogleAuthCredential credential = await GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
    );
    final User user = (await firebaseAuth.signInWithCredential(credential)).user;

    if(user!=null){
      assert(!user.isAnonymous);
      assert(await user.getIdToken()!= null);
      final User currentUser = firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);
      _userInfo=user.providerData;
      print(user);
    }
    setState(() {
      isLogedin = true;
      user_ggID = _userInfo.single.uid;
      user_photo = user.photoURL;
    });
    if(userInfo.length >0){
      for(int i=0 ; i<userInfo.length;i++){
        if(userInfo[i].googleID == user_ggID){
          setState(() {
            user_id = userInfo[i].id;
            user_name = userInfo[i].name;
            user_phone = userInfo[i].phoneNumber;
            user_address = userInfo[i].address;
            user_email = userInfo[i].email;
            user_photo = userInfo[i].imageURL;
            isSignin = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>
                AccountTab()),
          );
          break;
        }
        else{
          if(i==userInfo.length-1){
            final List<UserData> googleUser = await googleRegisterVersion(user_name , user_email ,user_phone , user_address, user_ggID ,user_fbID, user_photo);

            setState(() {
              isSignin = false;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>
                  AccountTab()),
            );
            break;
          }

        }
      }
    }
    else{
      final List<UserData> googleUser = await googleRegisterVersion(user_name , user_email ,user_phone , user_address, user_ggID ,user_fbID, user_photo);
      setState(() {
        isSignin = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>
            AccountTab()),
      );
    }

  }

  void isLoggedIn() async{

    setState(() {
      loading = true;
    });
    isFBLoggedIn = await facebookLogin.isLoggedIn;
    if(isFBLoggedIn){
      _loginWithFB();
    }
    setState(() {
      loading = false;
    });
  }

  _loginWithFB() async{

    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);

        setState(() {
          userProfile = profile;
          user_fbID = userProfile['id'];
          user_photo = userProfile['picture']['data']['url'];
          isFBLoggedIn = true;
          print(userProfile);
        });
        print(user_photo);
        if(userInfo.length >0){
          for(int i=0 ; i<userInfo.length;i++){
            if(userInfo[i].facebookID == user_fbID){
              setState(() {
                user_id = userInfo[i].id;
                user_name = userInfo[i].name;
                user_phone = userInfo[i].phoneNumber;
                user_address = userInfo[i].address;
                user_email = userInfo[i].email;
                user_photo = userInfo[i].imageURL;
                isSignin = false;
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>
                    AccountTab()),
              );
              break;
            }
            else{
              if(i==userInfo.length-1){

                final List<UserData> facebookUser = await FbRegisterVersion(user_name , user_email ,user_phone , user_address, user_ggID ,user_fbID, user_photo);

                setState(() {
                  isSignin = false;
                  _newLogin = true;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      AccountTab()),
                );
                break;
              }

            }
          }
        }
        else{
          final List<UserData> facebookUser = await FbRegisterVersion(user_name , user_email ,user_phone , user_address, user_ggID ,user_fbID, user_photo);
          setState(() {
            isSignin = false;
            _newLogin = true;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>
                AccountTab()),
          );
        }
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => isFBLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => isFBLoggedIn = false );
        break;
    }

  }


  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/30 ;
    double _btnHeight = deviceHeight/20;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        backgroundColor: lightGreenColor,

        body: _loading
            ?Center(child: CircularProgressIndicator())
            :ListView(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    color: Colors.black26,
                    child: Center(
                      child: usernameField(_fontSize),
                    )
                ),
                SizedBox(height: 20),
                //Password
                Container(
                    color: Colors.black26,
                    child: Center(
                      child: phoneField(_fontSize),
                    )
                ),
                SizedBox(height: 20),
                Container(
                    color: Colors.black26,
                    child: Center(
                      child: emailField(_fontSize),
                    )
                ),
                SizedBox(height: 20),
                Container(
                    color: Colors.black26,
                    child: Center(
                      child: addressField(_fontSize),
                    )
                ),
                SizedBox(height: 20),
                //Divider
                Container(
                  height: deviceHeight/30,

                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                            color: Colors.black,
                            height: 20,
                            thickness: 2,
                            indent: 0,
                            endIndent: 10,)
                      ),
                      Text("OR" , style: new TextStyle(
                          fontFamily: 'Roboto_Thin',
                          color: whiteTextColor ,
                          fontSize: _fontSize
                      ),),
                      Expanded(
                          child: Divider(
                            color: Colors.black,
                            height: 20,
                            thickness: 2,
                            indent: 10,
                            endIndent: 0,)
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                //Login With Google
                Container(
                  height: _btnHeight,
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: (){
                      if(_userController.text != null &&_phoneController.text != null
                          &&_emailController.text != null && _addressController != null
                          &&_userController.text != "" &&_phoneController.text != ""
                          &&_emailController.text != "" && _addressController != ""){

                        setState(() {
                          user_name  = _userController.text;
                          user_phone = _phoneController.text;
                          user_address = _addressController.text;
                          user_email = _emailController.text;
                        });
                        _loginWithGoogle();
                      }
                      else{
                        AlartBox(context);
                      }

                    },
                    child: Text(translator.translate('Log in with Google') , style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto_Thin',
                        fontSize: _fontSize)  ),
                    color: ggBgColor,

                  ),
                ),
                SizedBox(height: 20),
                //Login With Facebook
                Container(
                  height: _btnHeight,
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: (){
                      if(_userController.text != null &&_phoneController.text != null
                          &&_emailController.text != null && _addressController != null
                          &&_userController.text != "" &&_phoneController.text != ""
                          &&_emailController.text != "" && _addressController != ""){
                        setState(() {
                          user_name  = _userController.text;
                          user_phone = _phoneController.text;
                          user_address = _addressController.text;
                          user_email = _emailController.text;
                        });
                        _loginWithFB();
                      }
                      else{
                        AlartBox(context);
                      }
                    },
                    child: Text(translator.translate('Log in with Facebook') , style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto_Thin',
                        fontSize: _fontSize)  ),
                    color: fbBgColor,

                  ),
                ),
              ],
            ),
          ],
        )



    );
  }

  Widget usernameField(double _fontSize) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: 'Your Name',
          hintStyle: new TextStyle(
              fontFamily: 'Roboto_Thin',
              fontSize: _fontSize
          )
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Roboto_Thin',
          fontSize: _fontSize
      ),
      keyboardType: TextInputType.name,
      controller: _userController,
    );
  }

  Widget phoneField(double _fontSize) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: 'Your Phone',
          hintStyle: new TextStyle(
            fontFamily: 'Roboto_Thin',
            fontSize: _fontSize,
          )
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Roboto_Thin',
          fontSize: _fontSize
      ),
      keyboardType: TextInputType.phone,
      controller: _phoneController,
    );
  }

  Widget addressField(double _fontSize) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: 'Your Address',
          hintStyle: new TextStyle(
              fontFamily: 'Roboto_Thin',
              fontSize: _fontSize
          )
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Roboto_Thin',
          fontSize: _fontSize
      ),
      keyboardType: TextInputType.streetAddress,
      controller: _addressController,
    );
  }

  Widget emailField(double _fontSize) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: 'Your Email',
          hintStyle: new TextStyle(
              fontFamily: 'Roboto_Thin',
              fontSize: _fontSize
          )
      ),
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Roboto_Thin',
          fontSize: _fontSize
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
    );
  }

  void AlartBox (BuildContext context){


    double deviceWidth = MediaQuery.of(context).size.width;

    double _fontSize = deviceWidth/25;


    var alert = AlertDialog(
      content: Text("Please Enter all data" ,style: TextStyle(fontSize: _fontSize ,
        fontFamily: 'Roboto_Thin',)),
    );

    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        });
  }

}*/
