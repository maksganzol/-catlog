import 'package:catalog/abstract_services/catalog_service.dart';
import 'package:catalog/entities/product.dart';
import 'package:flutter/cupertino.dart';

class CatalogModel extends ChangeNotifier {
  final CatalogService _service;
  final List<Product> _allProducts;

  CatalogModel(
    this._service, {
    List<Product> products,
  }) : _allProducts = products ?? [];

  Future<void> addReview(String productId, {String content, int rate}) async {
    final comment = await _service.addReview(
      productId,
      text: content,
      rate: rate,
    );

    _allProducts.map((prod) {
      if (prod.id == productId) prod.comments.add(comment);
    });

    notifyListeners();
  }
}
