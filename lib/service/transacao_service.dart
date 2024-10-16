import 'package:bank_service/model/transacao.dart';
import 'package:bank_service/service/abstract_api.dart';

class TransacaoService extends AbstractApi<Transacao>{
  @override
  String rota() {
    return 'transacoes';
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return Transacao.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Transacao object) {
    return object.toJson();
  }

}