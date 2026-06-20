import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/usuario.dart';

/// Exceção customizada para erros de API, com mensagem amigável
/// para ser exibida diretamente na tela.
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class UsuarioService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration _timeout = Duration(seconds: 10);

  /// Faz a requisição GET, decodifica o JSON e converte
  /// cada item da lista em um objeto [Usuario].
  Future<List<Usuario>> buscarUsuarios() async {
    final uri = Uri.parse('$_baseUrl/users');

    try {
      final response = await http.get(uri).timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> dadosJson = jsonDecode(response.body) as List;
        return dadosJson
            .map((item) => Usuario.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          'O servidor respondeu com erro (código ${response.statusCode}).',
        );
      }
    } on SocketException {
      throw ApiException(
        'Sem conexão com a internet. Verifique sua rede e tente novamente.',
      );
    } on FormatException {
      throw ApiException('A resposta da API veio em um formato inválido.');
    } on http.ClientException {
      throw ApiException('Falha de comunicação com o servidor.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Tempo de espera excedido. Tente novamente.');
    }
  }
}
