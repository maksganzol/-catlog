class API {
  final String _baseUri;

  API(this._baseUri);

  Uri endpoint(String path) => Uri(host: _baseUri, path: path);
}
