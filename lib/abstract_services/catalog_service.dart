import 'package:catalog/entities/product.dart';
import 'package:catalog/entities/user.dart';

abstract class CatalogService {
  Future<List<Product>> list();
  Future<Comment> addReview(
    int productId, {
    required String text,
    required int rate,
    required User creator,
  });
}
