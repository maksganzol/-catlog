import 'package:catalog/api_services/api.dart';
import 'package:catalog/api_services/api_auth_service.dart';
import 'package:catalog/api_services/api_catalog_service.dart';
import 'package:catalog/models/auth_provider.dart';
import 'package:catalog/models/catalog_model.dart';
import 'package:catalog/screens/home.dart';
import 'package:catalog/screens/login.dart';
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
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.currentUser == null)
      return MaterialApp(
        home: Login(),
      );

    final catalogService = APICatalogService(
      api,
      user: authProvider.currentUser!,
    );
    return ChangeNotifierProvider<CatalogModel>(
      create: (ctx) =>
          CatalogModel(catalogService)..initModels().catchError(print),
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}
