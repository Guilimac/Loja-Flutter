import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=>SignupScreen())
              );
            },
            child: Text("Criar Conta", style: TextStyle(fontSize: 15),),
            textColor: Colors.white,
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading)
            return Center(child:CircularProgressIndicator());
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "E-mail"
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text){
                    if(text.isEmpty || !text.contains("@")) return "E-mail inválido";
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  controller: passController,
                  decoration: InputDecoration(
                      hintText: "Senha"
                  ),
                  obscureText: true,
                  validator: (text){
                    if(text.isEmpty || text.length < 6) return "Senha inválida";
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){
                      if(emailController.text.isEmpty){
                        _scafoldKey.currentState.showSnackBar(
                        SnackBar(content: Text("Insira um e-mail para recuperação"),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 2),));
                      }
                      else{
                        model.recoverPass(emailController.text);
                        _scafoldKey.currentState.showSnackBar(
                        SnackBar(content: Text("Confira seu e-mail"),
                          backgroundColor: Theme.of(context).primaryColor,
                          duration: Duration(seconds: 2),));
                      }
                    },
                    child: Text("Esqueci minha senha",
                      textAlign: TextAlign.right,),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(height: 16,),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        model.signIn(email: emailController.text, pass: passController.text
                            , onSuccess: _onSuccess,
                            onFail: _onFail);
                      }

                    },
                    child: Text("Entrar",
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess(){
    Navigator.of(context).pop();
  }
  void _onFail(){
    _scafoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao efetuar o Login"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),)
    );
  }
}

