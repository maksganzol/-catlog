import 'package:catalog/models/auth_provider.dart';
import 'package:catalog/models/catalog_model.dart';
import 'package:catalog/screens/product_details.dart';
import 'package:catalog/widgets/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final catalogModel = Provider.of<CatalogModel>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => authProvider.signOut(),
            child: Text('Sign out'),
          )
        ],
        centerTitle: true,
        title: Text('Catalog'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              ...catalogModel.products.map(
                (product) => TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      Colors.grey[800],
                    ),
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ProductDetails(product: product),
                    ),
                  ),
                  child: ProductListItem(
                    title: product.title,
                    logo: Image.network(
                      product.img,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
