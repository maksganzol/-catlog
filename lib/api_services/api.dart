class API {
  final String _host;
  final String? _pathPrefix;

  API(this._host, {String? pathPrefix}) : _pathPrefix = pathPrefix;

  Uri endpoint(String path) => Uri.parse('$_host/${_pathPrefix ?? ''}/$path');

  String assetUrl(String assetName) => '$_host/static/$assetName';
}
