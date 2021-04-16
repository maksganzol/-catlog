import 'package:catalog/abstract_services/catalog_service.dart';
import 'package:catalog/entities/product.dart';
import 'package:flutter/cupertino.dart';

class CatalogModel extends ChangeNotifier {
  final CatalogService _service;
  List<Product> _allProducts = [];

  CatalogModel(
    this._service,
  );

  Future<void> initModels() async {
    _allProducts = await _service.list();
    notifyListeners();
  }

  Future<void> addReview(
    int productId, {
    required String content,
    required int rate,
  }) async {
    final comment = await _service.addReview(
      productId,
      text: content,
      rate: rate,
    );

    _allProducts = _allProducts.map((prod) {
      if (prod.id == productId)
        return prod..comments = [...prod.comments, comment];
      return prod;
    }).toList();

    notifyListeners();
  }

  List<Product> get products => _allProducts;
}
