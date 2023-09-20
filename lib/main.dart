import 'package:flutter/material.dart';

//Importação do http
import 'package:http/http.dart' as http;

//Importação do Convert
import 'dart:convert';

//Inicialização
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purpleAccent,
        ),
      ),
      home: const Pagina(),
    );
  }
}

class Pagina extends StatefulWidget {
  const Pagina({super.key});

  @override
  State<StatefulWidget> createState() {
    return ConteudoPagina();
  }
}

//State
class ConteudoPagina extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("7 aula de Flutter"),
      ), //AppBar
      body: FutureBuilder(
        future: obterPostagens(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: Text("Id: ${snapshot.data![index].id}"),
              );
            },
          );
        },
      ),
    );
  }
}

// Classe de Postagem
class Post {
  int? userId;
  int? id;
  String? title;
  String? body;
}

//Classe contendo método assincrono
Future<List<Post>> obterPostagens() async {
// URL da Api
  String url = "https://jsonplaceholder.typicode.com/posts";
  // Realizar a requisição
  var requisicao = await http.get(Uri.parse(url));

  // Converter a requisição em um objeto JSON
  var dados = json.decode(requisicao.body);

  // Criar uma lista de postagens
  List<Post> postagens = [];

// Laço de repetição
  for (var objeto in dados) {
// Criar objeto do tipo postagem
    Post p = Post();

//Atribuindo cararacterísticas ao objeto
    p.userId = objeto["userId"];
    p.id = objeto["id"];
    p.title = objeto["title"];
    p.body = objeto["body"];

// Adicionar o objeto no vetor de postagens
    postagens.add(p);
  }

  //Retorno
  return postagens;
}
