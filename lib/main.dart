import 'package:catalog/api_services/api.dart';
import 'package:catalog/api_services/api_auth_service.dart';
import 'package:catalog/api_services/api_catalog_service.dart';
import 'package:catalog/models/auth_provider.dart';
import 'package:catalog/models/catalog_model.dart';
import 'package:catalog/screens/catalog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final api = API('http://smktesting.herokuapp.com', pathPrefix: 'api');
    final authService = ApiAuthService(api);
    final catalogService = APICatalogService(api);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (ctx) => AuthProvider(authService),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CatalogModel>(
          update: (ctx, auth, catalogModel) =>
              catalogModel!..user = auth.currentUser,
          create: (ctx) => CatalogModel(catalogService),
        ),
      ],
      child: MaterialApp(home: CatalogHome()),
    );
  }
}
