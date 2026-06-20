import 'package:flutter/material.dart';

import '../models/usuario.dart';

/// Card estilizado para exibir as informações de um [Usuario]
/// dentro do ListView.
class UsuarioCard extends StatelessWidget {
  final Usuario usuario;

  const UsuarioCard({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.indigo.shade100,
              child: Text(
                usuario.nome.isNotEmpty ? usuario.nome[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    usuario.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '@${usuario.username}',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 6),
                  _linha(Icons.email_outlined, usuario.email),
                  _linha(Icons.phone_outlined, usuario.telefone),
                  _linha(
                    Icons.location_city_outlined,
                    '${usuario.cidade} • ${usuario.empresa}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _linha(IconData icone, String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Icon(icone, size: 14, color: Colors.grey.shade600),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              texto,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
