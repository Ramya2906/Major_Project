import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project3/home.dart';
import 'package:project3/models/user_model.dart';

import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth =FirebaseAuth.instance;
  final _formKey=GlobalKey<FormState>();
  final fullNameController=new TextEditingController();
  // final secondNameController=new TextEditingController();
  final emailController=new TextEditingController();
  final passwordController=new TextEditingController();
  final confirmPswController=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fullName=TextFormField(
      autofocus: false,
      controller: fullNameController,
      keyboardType: TextInputType.name,
      onSaved: (value){
        emailController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );


    final email=TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return("Please enter email-id");
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return("Please enter valid email-id");
        }
        return null;
      },
      onSaved: (value){
        emailController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final password=TextFormField(
      autofocus: false,
      controller: passwordController,
      // keyboardType: TextInputType.,
      obscureText: true,
      validator: (value){
        RegExp regex=new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return("Password is required to login");
        }
        if(!regex.hasMatch(value)){
          return("Please enter valid password (Min 6 characters)");
        }
      },
      onSaved: (value){
        passwordController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final confirmPsw=TextFormField(
      autofocus: false,
      controller: confirmPswController,
      // keyboardType: TextInputType.emailAddress,
      obscureText: true,
      validator: (value){
        if(confirmPswController.text!= passwordController.text){
          return("Password doesn't match");
        }
      },
      onSaved: (value){
        confirmPswController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final signUpButton=Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.red[200],
      child:MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailController.text, passwordController.text);
        },
        child: Text("SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,
          ),),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.redAccent,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    SizedBox(
                      height: 250,
                      child: Image(
                        image: AssetImage("assets/login_logo.jpeg"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 5,),
                    fullName,
                    SizedBox(height: 25,)
                    ,email,
                    SizedBox(height: 25,),
                    password,
                    SizedBox(height: 25,),
                    confirmPsw,
                    SizedBox(height: 35,),
                    signUpButton,
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget> [
                        Text("Already have an account? "),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          },
                          child: Text("Login",
                            style: TextStyle(
                                color:Colors.red[200],fontWeight: FontWeight.bold,fontSize: 17),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void signUp(String email, String password) async{
    if(_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
            postDetailsToFirestore(),
      }).catchError((e){
          Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email=user!.email;
    userModel.uid= user.uid;
    userModel.name=fullNameController.text;


    await firebaseFirestore
    .collection("users")
    .doc(user.uid)
    .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully..");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
  }
}
