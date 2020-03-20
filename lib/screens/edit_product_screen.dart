import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';
import '../provider/products_provider.dart';

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


  final _form=GlobalKey<FormState>();

  var _editedProduct=Product(
    id: null, 
    title: '', 
    description: '', 
    price: 0, 
    imageUrl: ''
  );


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
      
      //now make sure that if url is not valid then we donot want to display image
      //if url is invalid image display URL will remain as it is
      if( (!_imageUrlController.text.startsWith('http') && !_imageUrlController.text.startsWith('https'))||
      (!_imageUrlController.text.endsWith('.png')&& !_imageUrlController.text.endsWith('.jpeg')&& !_imageUrlController.text.endsWith('.jpg'))){
        return ;
      }
      
      
      // if it loses focus then set state means widgets are rebuild and image preview display container has image 
      setState(() {
        
      });
    }

  }



  void _saveForm(){

    final isValid=_form.currentState.validate();
   

    if(!isValid){
      return;
      //is it is not valid then simply exit
      //else save the form
    }
    _form.currentState.save();

    Provider.of<Products>(context,listen: false).addProduct(_editedProduct);
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save), 
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          
          key: _form,
          
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
                validator: (value){
                  if(value.isEmpty){
                    return 'Please provide title.';
                  }
                  return null;
                  //return null means no error

                },
                onSaved: (value){
                  _editedProduct=Product(
                    id: null ,
                    description: _editedProduct.description ,
                    imageUrl: _editedProduct.imageUrl,
                    title: value ,
                    price: _editedProduct.price,
                  );
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
                validator: (value){
                  if(value.isEmpty){
                    return 'Please provide price.';
                  }
                  if(double.tryParse(value)==null){
                    return 'Please provide valid number.';
                  }
                  if(double.parse(value)<=0){
                    return 'Please enter price which is greater than 0.';
                  }
                  return null;
                  //return null means no error

                },
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onSaved: (value){
                  _editedProduct=Product(
                    id: null ,
                    description: _editedProduct.description ,
                    imageUrl: _editedProduct.imageUrl,
                    title: _editedProduct.title ,
                    price: double.parse(value),
                  );
                },
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
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter a description.';
                  }
                  if(value.length<10){
                    return 'Description should be atleast 10 character long.';
                  }

                  return null;
                },
                onSaved: (value){
                  _editedProduct=Product(
                    id: null ,
                    description: value ,
                    imageUrl: _editedProduct.imageUrl,
                    title: _editedProduct.title ,
                    price: _editedProduct.price,
                  );
                },

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
                      validator: (value){
                        if(value.isEmpty){
                          return 'Please enter image URL.';
                        }
                        if(!value.startsWith('http') && !value.startsWith('https')){
                          return 'Please enter valid URL.';
                        }
                        if(!value.endsWith('.png') && !value.endsWith('.jpg') && !value.endsWith('jpeg')){
                          return 'Please enter valid image URL.';
                        }
                        return null;
                      },
                      focusNode: _imageUrlFocusNode,
                      //now we want that when user click on other field thwn it also show image preview
                      //as of noew when user press submit then and only then image is displayed
                      //so we have to use listener


                      onFieldSubmitted:(_)=> _saveForm(),
                      onSaved: (value){
                        _editedProduct=Product(
                          id: null ,
                          description: _editedProduct.description ,
                          imageUrl: value,
                          title: _editedProduct.title ,
                          price: _editedProduct.price,
                        );
                      },

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