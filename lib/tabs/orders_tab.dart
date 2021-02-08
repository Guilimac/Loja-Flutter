import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/tiles/order_tile.dart';
import 'package:loja_virtual/widgets/not_logged_in.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(UserModel.of(context).isLoggedIn()){
      String uid = UserModel.of(context).firebaseUser.uid;
      return FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("users").document(uid)
        .collection("orders").getDocuments(),
          builder: (context,snapshot){
            if(!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),);
            return ListView(
              children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList()
              .reversed.toList(),
            );
          },
      );
    }
    return NotLoggedIn();
  }
}
