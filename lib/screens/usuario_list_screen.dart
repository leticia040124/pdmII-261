import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../services/usuario_service.dart';
import '../widgets/usuario_card.dart';

/// Tela principal: busca os usuários na API e exibe em um
/// ListView.builder, tratando os estados de carregamento,
/// erro e sucesso.
class UsuarioListScreen extends StatefulWidget {
  const UsuarioListScreen({super.key});

  @override
  State<UsuarioListScreen> createState() => _UsuarioListScreenState();
}

class _UsuarioListScreenState extends State<UsuarioListScreen> {
  final UsuarioService _service = UsuarioService();
  late Future<List<Usuario>> _futureUsuarios;

  @override
  void initState() {
    super.initState();
    _futureUsuarios = _service.buscarUsuarios();
  }

  /// Refaz a requisição. Usado tanto pelo botão "Tentar novamente"
  /// quanto pelo gesto de pull-to-refresh.
  Future<void> _recarregar() async {
    final novaBusca = _service.buscarUsuarios();
    setState(() {
      _futureUsuarios = novaBusca;
    });
    // Se der erro aqui, o FutureBuilder mostra a tela de erro
    // normalmente; o try/catch evita warning de exceção não tratada.
    try {
      await novaBusca;
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários (API REST)'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _recarregar,
        child: FutureBuilder<List<Usuario>>(
          future: _futureUsuarios,
          builder: (context, snapshot) {
            // 1. Carregando
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. Erro
            if (snapshot.hasError) {
              return _buildErro(snapshot.error.toString());
            }

            final usuarios = snapshot.data ?? [];

            // 3. Lista vazia
            if (usuarios.isEmpty) {
              return _buildVazio();
            }

            // 4. Sucesso -> ListView.builder dinâmica
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                return UsuarioCard(usuario: usuarios[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildErro(String mensagem) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.wifi_off_rounded,
                    size: 56,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Não foi possível carregar os usuários.\n$mensagem',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _recarregar,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tentar novamente'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVazio() {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: const Center(child: Text('Nenhum usuário encontrado.')),
        ),
      ),
    );
  }
}
