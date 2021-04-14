import 'dart:convert';

import 'package:catalog/abstract_services/catalog_service.dart';
import 'package:catalog/api_services/api.dart';
import 'package:catalog/entities/product.dart';

import 'package:http/http.dart' as http;

class APICatalogService implements CatalogService {
  final API _api;
  final String _token;
  APICatalogService(this._api, {String token}) : _token = token;

  Map<String, String> _authHeaders() => {'Authorization': 'Token $_token'};

  Future<T> _get<T>(String path) => http
      .get(_api.endpoint('products'), headers: _authHeaders())
      .then((response) => jsonDecode(response.body));

  @override
  Future<List<Product>> list() async {
    final rawProducts = await _get<List<Map<String, dynamic>>>('products');
    final products = await Future.wait(
      rawProducts.map((rawProd) async {
        final rawComments =
            await _get<List<Map<String, dynamic>>>('reviews/${rawProd['id']}');
        return Product.fromMap({...rawProd, 'comments': rawComments});
      }),
    );
    return products.toList();
  }

  @override
  Future<Comment> addReview(String productId, {String text, int rate}) async {
    final response = await http.post(
      _api.endpoint('reviews/$productId'),
      body: jsonEncode({
        'text': text,
        'rate': rate,
      }),
    );
    final id = jsonDecode(response.body)['id'];
    return Comment(content: text, id: id, rate: rate);
  }
}
