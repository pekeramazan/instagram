import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
final GoogleSignIn gSignIn= GoogleSignIn();
class _HomePageState extends State<HomePage> 
{
bool isSignedIn=false;
void initState()
{
  super.initState();
  gSignIn.onCurrentUserChanged.listen((gSignInAccount) { 
    controlSignIn(gSignInAccount);
  },onError: (gError){
    print ("Error Message : "+gError);
  });
  gSignIn.signInSilently(suppressErrors:false).then((gSignInAccount) {
        controlSignIn(gSignInAccount);

  }).catchError((gError){
    print ("Error Message : "+gError);
  });
}
controlSignIn(GoogleSignInAccount signInAccount) async{
if(signInAccount !=null)
 {
   setState(() {
     isSignedIn=true;
   });
 }
 else
 {
setState(() {
     isSignedIn=false;
   }); }
}
loginUser()
{
    gSignIn.signIn();
}
logOutUser()
{
  gSignIn.signOut();
}
Widget buildHomeScreen()
{
  return RaisedButton.icon(onPressed:logOutUser ,icon:Icon(Icons.close), label: Text("Sign Out"));

}

 Scaffold buildSignInScreen() 
 {
   return Scaffold(
     body: Container(
       decoration: BoxDecoration(
         gradient: LinearGradient(
           begin: Alignment.topRight,
           end: Alignment.bottomLeft,
           colors: [Theme.of(context).accentColor,Theme.of(context).primaryColor],
         ),
       ),
       alignment: Alignment.center,
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

         children: <Widget>[
           Text(
             "InstaPeker",
             style: TextStyle(fontSize: 92.0,color: Colors.white,fontFamily: "Signatra"),
           ),
           GestureDetector(
             onTap: loginUser ,
             child: Container(
               width: 270.0,
               height: 65.0,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage("assets/images/google_signin_button.png"),
                   fit: BoxFit.cover,
                 )
               ),
             ),
           ),

         ],
       ),
     ),

   );
 }
  @override
  Widget build(BuildContext context) { 
   if(isSignedIn)
     {
       return buildHomeScreen();

     }
   else
     {
       return buildSignInScreen();
            }
         }
       
        
}

  





