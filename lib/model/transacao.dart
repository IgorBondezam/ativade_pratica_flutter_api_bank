class Transacao {
  int id;
  String nome;
  double valor;

  Transacao({required this.id,
    required this.nome,
    required this.valor
  });

  factory Transacao.fromJson(Map<String, dynamic> json) {
    return Transacao(id: json['id'] as int, nome: json['nome'], valor: json['valor']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'valor': valor,
    };
  }
  @override
  String toString() {
    return 'id: $id - nome: $nome - valor: $valor';
  }
}