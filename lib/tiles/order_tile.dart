import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection("orders")
              .document(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            int status = snapshot.data["status"];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Codigo do pedido: ${snapshot.data.documentID}",
                style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 4,),
                Text(
                  _buildProductsText(snapshot.data)
                ),
                SizedBox(height: 4,),
                Text("Status do Pedido:",
                  style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircle("1", "Preparação", status, 1),
                    Container(
                      height: 1,
                      width: 40,
                      color: Colors.grey[500]
                    ),
                    _buildCircle("2", "Transporte", status, 2),
                    Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500]
                    ),
                    _buildCircle("3", "Entrega", status, 3)

                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot){
    String text = "Descrição:\n";
    for(LinkedHashMap p in snapshot.data["products"]){
      text += "${p["quantity"]} x ${p["product"]["title"]} (R\$ ${p["product"]["price"].toStringAsFixed(2)})\n";
    }
    text += "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}";

    return text;
  }

  Widget _buildCircle(String title, String subTitle, int status, int thisStatus){
    Color backColor;
    Widget child;
    if(status < thisStatus){
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white),);
    }
    if(status == thisStatus){
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: [
          Text(title, style: TextStyle(color: Colors.white),),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    }
    if(status > thisStatus){
      backColor = Colors.green;
      child = Icon(Icons.check);
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child:child
        ),
        Text(subTitle)
      ],
    );
  }
}
