Uri Function(
  String path, {
  Map<String, dynamic>? queryParameters,
  String? fragment,
}) createDynamicEndpoint(Uri Function() constructor) {
  return (path, {queryParameters, fragment}) {
    return createStaticEndpoint(constructor())(
      path,
      queryParameters: queryParameters,
      fragment: fragment,
    );
  };
}

Uri Function(
  String path, {
  Map<String, dynamic>? queryParameters,
  String? fragment,
}) createStaticEndpoint(Uri origin) {
  return (path, {queryParameters, fragment}) {
    return Uri(
      scheme: origin.scheme,
      host: origin.host,
      port: origin.port,
      path: "${origin.path}/$path",
      queryParameters: queryParameters,
      fragment: fragment,
    );
  };
}
