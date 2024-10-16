import 'package:bank_service/model/transacao.dart';
import 'package:bank_service/service/transacao_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransacaoList(),
    );
  }
}

class TransacaoList extends StatefulWidget {
  @override
  _TransacaoListState createState() => _TransacaoListState();
}

class _TransacaoListState extends State<TransacaoList> {
  int contador = 0;
  List<Transacao> items = [];
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  int? editingId;
  TransacaoService service = TransacaoService();

  void getTransacao() async {
    items = await service.getAll();
  }

  void addTransacao() async {
    if (editingId == null) {
      contador += 1;
      final newTransacao = Transacao(
        id: contador,
        nome: nomeController.text,
        valor: double.parse(valorController.text),
      );
      await service.post(newTransacao);
      List<Transacao> itemsAtualizados = await service.getAll();
      setState(() {
        items = itemsAtualizados;
      });
    } else {
      final int index = items.indexWhere((item) => item.id == editingId);
      print(index);
      if (index != -1) {
        items[index].nome = nomeController.text;
        items[index].valor = double.parse(valorController.text);
        service.update(editingId!, items[index]);
        List<Transacao> itemsAtualizados = await service.getAll();
        setState(() {
          items = itemsAtualizados;
        });
      }
      editingId = null;
    }
    clearFields();
  }

  void clearFields() {
    nomeController.clear();
    valorController.clear();
  }

  void editTransacao( item) {
    setState(() {
      editingId = item.id;
      nomeController.text = item.nome;
      valorController.text = item.valor.toString();
    });
  }

  void deleteTransacao(int id) {
    setState(() {
      items.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transação CRUD'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: valorController,
              decoration: const InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: addTransacao,
            child: Text(editingId == null ? 'Add Transacao' : 'Update Transacao'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.nome),
                  subtitle: Text('Valor: ${item.valor}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => editTransacao(item),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteTransacao(item.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}