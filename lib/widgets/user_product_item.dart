import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {

  final String title;
  final String imageUrl;

  UserProductItem({this.title,this.imageUrl});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title) ,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        // to set bg as image you have to use NetworkImage
      ),
      trailing: Container(
        //provide width else it gives errors because trailing has fix size
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: (){

              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: (){
                
              },
            ),

          ],
        ),
      ),
    );
  }
}