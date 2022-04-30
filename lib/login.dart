import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project3/signup.dart';
import 'package:project3/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey=GlobalKey<FormState>();
  final TextEditingController emailController=new TextEditingController();
  final TextEditingController passwordController=new TextEditingController();
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailField=TextFormField(
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
          // fillColor: Colors.red[200],
          // filled: true,
        // hintStyle: TextStyle(
        //     color: Colors.red,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
              // borderSide: BorderSide(color: Colors.red),
          )
      ),
    );
    final passwordField=TextFormField(
      autofocus: false,
      controller: passwordController,
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
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final loginButton=Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.red[200],
      child:MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          // Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
          signIn(emailController.text, passwordController.text);
        },
        child: Text("Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,
          ),),
      ),
    );
    return Scaffold(
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
                    SizedBox(height: 25,),
                    emailField,
                    SizedBox(height: 25,)
                    ,passwordField,
                    SizedBox(height: 35,),
                    loginButton,
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget> [
                        Text("Don't have an account? "),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                          },
                          child: Text("SignUp",
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
  void signIn(String email, String password) async{
    if(_formKey.currentState!.validate()){
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
            Fluttertoast.showToast(msg: "Login successful.."),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage())),
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
