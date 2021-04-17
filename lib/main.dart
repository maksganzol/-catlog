import 'package:catalog/api_services/api.dart';
import 'package:catalog/api_services/api_auth_service.dart';
import 'package:catalog/api_services/api_catalog_service.dart';
import 'package:catalog/models/auth_provider.dart';
import 'package:catalog/models/catalog_model.dart';
import 'package:catalog/screens/catalog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final api = API('http://smktesting.herokuapp.com', pathPrefix: 'api');
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authService = ApiAuthService(api);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (ctx) => AuthProvider(authService),
      child: AppPage(),
    );
  }
}

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final catalogService = APICatalogService(
      api,
      user: authProvider.currentUser,
    );

    final catalogModel = CatalogModel(catalogService)..initModels();

    return ChangeNotifierProvider<CatalogModel>.value(
      value: catalogModel,
      child: MaterialApp(home: CatalogHome()),
    );
  }
}
