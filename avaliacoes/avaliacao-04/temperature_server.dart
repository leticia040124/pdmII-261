// server.dart
import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  final address = InternetAddress.anyIPv4;
  final port = 8080;

  final server = await ServerSocket.bind(address, port);
  print('🚀 Servidor rodando em ${server.address.address}:$port');

  await for (Socket client in server) {
    handleClient(client);
  }
}

void handleClient(Socket client) {
  final clientAddress = client.remoteAddress.address;
  print('🔌 Cliente conectado: $clientAddress');

  client.listen(
    (data) {
      final message = utf8.decode(data).trim();

      try {
        final jsonData = jsonDecode(message);
        final device = jsonData['device'];
        final temp = jsonData['temperature'];
        final time = jsonData['timestamp'];

        print('📥 [$time] $device -> 🌡️ ${temp.toStringAsFixed(2)}°C');
      } catch (e) {
        print('⚠️ Erro ao processar mensagem: $message');
      }
    },
    onError: (error) {
      print('❌ Erro com cliente $clientAddress: $error');
      client.close();
    },
    onDone: () {
      print('🔌 Cliente desconectado: $clientAddress');
      client.close();
    },
    cancelOnError: true,
  );
}