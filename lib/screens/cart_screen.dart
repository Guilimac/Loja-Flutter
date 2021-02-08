import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/screens/order_screen.dart';
import 'package:loja_virtual/tiles/cart_tile.dart';
import 'package:loja_virtual/widgets/cart_price.dart';
import 'package:loja_virtual/widgets/discount_card.dart';
import 'package:loja_virtual/widgets/not_logged_in.dart';
import 'package:loja_virtual/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context,child,model){
                int p = model.products.length;
                return Text(
                  "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context,child,model){
          if(model.isLoading && UserModel.of(context).isLoggedIn()){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(!UserModel.of(context).isLoggedIn()){
            return NotLoggedIn();
          }
          if(model.products == null || model.products.length == 0){
            return Center(
              child: Text("Nenhum produto no carrinho",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),
            );
          }
          return ListView(
            children: [
              Column(
                children: model.products.map((product){
                  return CartTile(product);
                }).toList(),
              ),
              DiscountCard(),
              ShipCard(),
              CartPrice(()async{
                String orderId = await model.finishOrder();
                if(orderId != null){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>OrderScreen(orderId)));
                }
              })
            ],
          );
        },
      ),
    );
  }
}
