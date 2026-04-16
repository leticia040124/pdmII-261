// device.dart
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

Future<void> main() async {
  await iniciarIoTDevice('Sensor-01');
}

Future<void> iniciarIoTDevice(String nome) async {
  final host = InternetAddress.loopbackIPv4;
  final port = 8080;

  while (true) {
    try {
      print('🔄 Tentando conectar...');
      final socket = await Socket.connect(host, port);
      print('✅ Conectado ao servidor');

      final random = Random();

      // Envio periódico a cada 10 segundos
      final timer = Timer.periodic(Duration(seconds: 10), (_) {
        final temperatura = 20 + random.nextDouble() * 15;

        final data = {
          'device': nome,
          'temperature': temperatura,
          'timestamp': DateTime.now().toIso8601String(),
        };

        final message = jsonEncode(data);

        socket.write(message + '\n');
        print('📤 Enviado: ${temperatura.toStringAsFixed(2)}°C');
      });

      // Aguarda desconexão
      await socket.done;

      timer.cancel();
      print('⚠️ Conexão encerrada. Reconectando...');

    } catch (e) {
      print('❌ Falha na conexão: $e');
    }

    // Espera antes de tentar reconectar
    await Future.delayed(Duration(seconds: 5));
  }
}