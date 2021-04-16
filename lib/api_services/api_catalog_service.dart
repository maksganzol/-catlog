import 'dart:convert';

import 'package:catalog/abstract_services/catalog_service.dart';
import 'package:catalog/api_services/api.dart';
import 'package:catalog/entities/product.dart';
import 'package:catalog/entities/user.dart';

import 'package:http/http.dart' as http;

class APICatalogService implements CatalogService {
  final API _api;
  final User? _user;
  APICatalogService(this._api, {User? user}) : _user = user;

  Map<String, String> _authHeaders() => {
        if (_user != null) 'Authorization': 'Token ${_user!.token}',
        'Content-Type': 'application/json',
      };

  Future<List<Map<String, dynamic>>> _getList(String path) async {
    print(_api.endpoint(path).path);
    final response =
        await http.get(_api.endpoint(path), headers: _authHeaders());
    return List.from(jsonDecode(response.body)).cast<Map<String, dynamic>>();
  }

  @override
  Future<List<Product>> list() async {
    final rawProducts = await _getList('products/');
    final products = await Future.wait(
      rawProducts.map((rawProd) async {
        final rawComments = await _getList('reviews/${rawProd['id']}');
        final fullImgUrl = _api.assetUrl(rawProd['img']);
        print(fullImgUrl);
        return Product.fromMap({
          ...rawProd,
          'comments': rawComments,
          'img': fullImgUrl,
        });
      }),
    );
    return products.toList();
  }

  @override
  Future<Comment> addReview(
    int productId, {
    required String text,
    required int rate,
  }) async {
    if (_user == null) throw new Exception('Unauthorized user');
    await http.post(
      _api.endpoint('reviews/$productId'),
      headers: _authHeaders(),
      body: jsonEncode({
        'text': text,
        'rate': rate,
      }),
    );
    return Comment(
      content: text,
      rate: rate,
      creator: Creator(
        username: _user!.username,
      ),
    );
  }
}
