class Contato {
  final String id;
  final String nome;
  final String telefone;
  final String imagePath;

  Contato({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.imagePath,
  });

  // Você pode adicionar métodos para serialização ou deserialização conforme necessário para salvar/recuperar do banco de dados
}
