import 'package:catalog/entities/product.dart';

abstract class CatalogService {
  Future<List<Product>> list();
  Future<Comment> addReview(String productId, {String text, int rate});
}
