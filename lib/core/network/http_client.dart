import 'package:http/http.dart' as http;

class HttpClient {
  static final HttpClient _instance = HttpClient._internal();
  late final http.Client client;

  // cada vez que llames a HttpClient(), devuelve la misma instancia (no se crean más).
  factory HttpClient() {
    return _instance;
  }

  // constructor privado
  HttpClient._internal() {
    client = http.Client();
  }

  void dispose() {
    client.close();
  }
}
