import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
          builder: (context,child,model){
            if (model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Nome Completo"
                    ),
                    validator: (text){
                      if(text.isEmpty) return "Nome inválido";
                    },
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: emailController
                    ,
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
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                        hintText: "Endereço"
                    ),
                    validator: (text){
                      if(text.isEmpty) return "Endereço inválida";
                    },
                  ),
                  SizedBox(height: 16,),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){

                          Map<String,dynamic> userData = {
                            "name": nameController.text,
                            "email": emailController.text,
                            "address": addressController.text
                          };

                          model.signUp(
                              userData: userData,
                              pass: passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                          );
                        }
                      },
                      child: Text("Criar Conta",
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
          }
      ),
    );
  }
  void _onSuccess(){
    _scafoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),)
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }
  void _onFail(){
    _scafoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),)
    );
  }
}



