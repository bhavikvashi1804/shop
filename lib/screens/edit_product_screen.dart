import 'dart:ui';

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


  var _isInit=true;
  var _initValues={
    'title':'',
    'desc':'',
    'price':'',
    'imageURL':'',
  };

  var _isLoading=false;


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

  @override
  void didChangeDependencies() {

    if(_isInit){
       final productID=ModalRoute.of(context).settings.arguments as String;
       if(productID!=null){
         _editedProduct=Provider.of<Products>(context,listen: false).findByID(productID);
         _initValues={
          'title':_editedProduct.title,
          'desc':_editedProduct.description,
          'price':_editedProduct.price.toString(),
          'imageURL':_editedProduct.imageUrl,
        };
        _imageUrlController.text=_editedProduct.imageUrl;
       }
      

    }
    _isInit=false;
    //dependencies run multiple time 
    //to over come this problem we need to manually execute it for once
   
    super.didChangeDependencies();
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



  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
     
    } 
    else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } 
      catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occurred!'),
                content: Text('Something went wrong.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
        );
      } 
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
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
      body: _isLoading?
      Center(
        child: CircularProgressIndicator(),
      ):
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          
          key: _form,
          
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
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
                    id: _editedProduct.id,
                    isFavorite: _editedProduct.isFavorite,
                    description: _editedProduct.description ,
                    imageUrl: _editedProduct.imageUrl,
                    title: value ,
                    price: _editedProduct.price,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
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
                    id: _editedProduct.id ,
                    isFavorite: _editedProduct.isFavorite,
                    description: _editedProduct.description ,
                    imageUrl: _editedProduct.imageUrl,
                    title: _editedProduct.title ,
                    price: double.parse(value),
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['desc'],
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
                    id: _editedProduct.id ,
                    isFavorite: _editedProduct.isFavorite,
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
                      //if you use contoller then it does not allow to use initialValue at here 
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
                          id: _editedProduct.id ,
                          description: _editedProduct.description ,
                          imageUrl: value,
                          title: _editedProduct.title ,
                          price: _editedProduct.price,
                          isFavorite: _editedProduct.isFavorite,
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