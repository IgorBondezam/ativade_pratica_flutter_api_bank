import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class AbstractApi<T> {

  static const url = 'http://localhost:3000';

  String rota();

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson(T object);

  Future<List<T>> getAll() async {
    var response = await http.get(Uri.parse('$url/${rota()}'));
    List<Map<String, dynamic>> lista = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    return lista.map((json) => fromJson(json)).toList();
  }

  Future<T> getById(String id) async {
    var response = await http.get(Uri.parse("$url/${rota()}/$id"));
    var jsonResponse = jsonDecode(response.body);
    return fromJson(jsonResponse);
  }

  Future<Map<String, dynamic>> post(T object) async {
    await http.post(Uri.parse("$url/${rota()}"),
      body: jsonEncode(toJson(object)),
    );
    return {"status": 201, "message": "Criação feita com sucesso!"};
  }

  Future<Map<String, dynamic>> delete(String id) async {
    await http.delete(Uri.parse("$url/${rota()}/$id"));
    return {"status": 204, "message": "Exclusão feita com sucesso!"};
  }

  Future<Map<String, dynamic>> update(String id, T object) async {
    await http.put(Uri.parse("$url/${rota()}/$id"),
      body: jsonEncode(toJson(object)),
    );
    return {"status": 200, "message": "Atualização feita com sucesso!"};
  }
}