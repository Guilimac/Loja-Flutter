import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/login_screen.dart';

class NotLoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.remove_shopping_cart,
            size: 80, color: Theme.of(context).primaryColor,),
          SizedBox(height: 16,),
          Text("Faça o Login para continuar!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
            textAlign: TextAlign.center,),
          SizedBox(height: 16,),
          RaisedButton(
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              child: Text("Entrar",style: TextStyle(fontSize: 18),),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor
          )
        ],
      ),
    );
  }
}
