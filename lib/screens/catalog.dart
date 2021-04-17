import 'package:catalog/models/auth_provider.dart';
import 'package:catalog/models/catalog_model.dart';
import 'package:catalog/screens/login.dart';
import 'package:catalog/screens/product_details.dart';
import 'package:catalog/widgets/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogHome extends StatelessWidget {
  const CatalogHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final catalogModel = Provider.of<CatalogModel>(context);
    final trailing = authProvider.currentUser != null
        ? ElevatedButton(
            onPressed: () => authProvider.signOut(),
            child: Text('Sign out'),
          )
        : ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => Login(),
              ),
            ),
            child: Text('Sign in'),
          );

    return Scaffold(
      appBar: AppBar(
        actions: [
          trailing,
        ],
        centerTitle: true,
        title: Text('Catalog'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: catalogModel.products.isEmpty
              ? CircularProgressIndicator()
              : Column(
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
