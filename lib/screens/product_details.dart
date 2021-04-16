import 'package:catalog/entities/product.dart';
import 'package:catalog/models/auth_provider.dart';
import 'package:catalog/models/catalog_model.dart';
import 'package:catalog/widgets/review.dart';
import 'package:catalog/widgets/review_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CatalogModel>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
            child: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        floatingActionButton: authProvider.currentUser != null
            ? FloatingActionButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => ReviewDialog(
                    onSubmit: (content, rate) => model.addReview(
                      product.id,
                      content: content,
                      rate: rate,
                    ),
                  ),
                ),
                child: Icon(Icons.comment),
              )
            : null,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      product.img,
                      height: 200,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      Text(
                        product.decription,
                        style: TextStyle(fontSize: 20),
                      ),
                      ...product.comments.map(
                        (comment) => Review(comment: comment),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
