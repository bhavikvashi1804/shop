import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {

  static const routeName='/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final _priceFocusNode=FocusNode();
  //manually configure after title price should be shown
  final _descFocusNode=FocusNode();
  final _imageUrlFocusNode=FocusNode();


  final _imageUrlController=TextEditingController();


  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }


  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }


  void _updateImageUrl(){

    if(!_imageUrlFocusNode.hasFocus){
      // if it loses focus then set state means widgets are rebuild and image preview display container has image 
      setState(() {
        
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                //after this next button show
                //you can also show submit button
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                //here we have enter button to enter new line
                //show we do not need to provide to pass the focus to next input
                focusNode: _descFocusNode,

              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty? 
                    Text('Enter a URL'):
                    FittedBox(
                      child: Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover,
                      ),

                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Image URL'
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      //now we want that when user click on other field thwn it also show image preview
                      //as of noew when user press submit then and only then image is displayed
                      //so we have to use listener

                    ),
                  ),


                ],
              )

            ],
          ) ,
        ),
      ),  
    );
  }
}