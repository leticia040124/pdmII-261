/// Modelo que representa um usuário retornado pela API.
/// Mapeia o JSON de https://jsonplaceholder.typicode.com/users
class Usuario {
  final int id;
  final String nome;
  final String username;
  final String email;
  final String telefone;
  final String cidade;
  final String empresa;

  Usuario({
    required this.id,
    required this.nome,
    required this.username,
    required this.email,
    required this.telefone,
    required this.cidade,
    required this.empresa,
  });

  /// Converte um Map (JSON decodificado) em um objeto Usuario.
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      nome: json['name'] as String? ?? 'Sem nome',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      telefone: json['phone'] as String? ?? '',
      cidade: (json['address']?['city'] as String?) ?? 'Não informado',
      empresa: (json['company']?['name'] as String?) ?? 'Não informado',
    );
  }
}
