// ignore_for_file: avoid_print, unused_local_variable
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const MyHomePage(title: 'Cadastro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var nomeController = TextEditingController();
  var cepController = TextEditingController();
  var telController = TextEditingController();
  var emailController = TextEditingController();
  var avatarController = TextEditingController();
  int idUser = 0;

  String logradouro = '';
  String bairro = '';
  String localidade = '';
  String estado = '';
  var endereco = '';

  List<Person> persons = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              flex: 5,
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: const Color.fromARGB(255, 248, 248, 248),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: nomeController,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 36, 35, 35)),
                            decoration: const InputDecoration(
                                floatingLabelStyle: TextStyle(
                                    color: Color.fromARGB(255, 1, 22, 26)),
                                icon: Icon(Icons.person),
                                hintText: 'Ex: Jorge da Silva',
                                labelText: 'Nome',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 1, 22, 26)),
                                )),
                          ),
                          TextFormField(
                            controller: cepController,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 36, 35, 35)),
                            decoration: const InputDecoration(
                                floatingLabelStyle: TextStyle(
                                    color: Color.fromARGB(255, 1, 22, 26)),
                                icon: Icon(Icons.home),
                                hintText: 'Ex: 06699-050',
                                labelText: 'CEP',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 1, 22, 26)),
                                )),
                          ),
                          TextFormField(
                            controller: telController,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 36, 35, 35)),
                            decoration: const InputDecoration(
                                floatingLabelStyle: TextStyle(
                                    color: Color.fromARGB(255, 1, 22, 26)),
                                icon: Icon(Icons.phone),
                                hintText: 'Ex: +55 11 90000-0000',
                                labelText: 'Telefone',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 1, 22, 26)),
                                )),
                          ),
                          TextFormField(
                            controller: emailController,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 36, 35, 35)),
                            decoration: const InputDecoration(
                                floatingLabelStyle: TextStyle(
                                    color: Color.fromARGB(255, 1, 22, 26)),
                                icon: Icon(Icons.link),
                                hintText: 'Ex: email@email.com',
                                labelText: 'Email',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 1, 22, 26)),
                                )),
                          ),
                          TextFormField(
                            controller: avatarController,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 36, 35, 35)),
                            decoration: const InputDecoration(
                                floatingLabelStyle: TextStyle(
                                    color: Color.fromARGB(255, 1, 22, 26)),
                                icon: Icon(Icons.image),
                                hintText: 'Cole um Link de Imagem',
                                labelText: 'Avatar',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 1, 22, 26)),
                                )),
                          ),
                        ]),
                  ),
                ),
              )),
          Expanded(
            flex: 5,
            child: ListView(
            scrollDirection: Axis.horizontal,
            children: persons.map((userone) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Card(
                color: const Color.fromARGB(255, 248, 248, 248),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5), // Image border
                      child: SizedBox.fromSize(
                        child: Image.network(userone.avatar.toString(),
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            "#${userone.id} - ${userone.name}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 36, 35, 35)),
                          ),
                          Text(
                            "${userone.address}\n${userone.phone}\n${userone.email}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 36, 35, 35)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
              }).toList(),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: () async {
          var cepDigitado = cepController.text;
          var url = Uri.https(
              'viacep.com.br', '/ws/$cepDigitado/json/', {'q': '{http}'});
          var response = await http.get(url);

          if (response.statusCode == 200) {
            var jsonResponse =
                convert.jsonDecode(response.body) as Map<String, dynamic>;

            logradouro = jsonResponse['logradouro'];
            bairro = jsonResponse['bairro'];
            localidade = jsonResponse['localidade'];
            estado = jsonResponse['uf'];
            endereco = '$logradouro - $bairro, $localidade ($estado).';
          } else {
            log('Request failed with status: ${response.statusCode}.');
          }

          idUser++;
          persons.add(Person(
              id: '$idUser',
              name: nomeController.text,
              phone: telController.text,
              address: endereco,
              email: emailController.text,
              avatar: avatarController.text));
          setState(() {});
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        color: Colors.teal,
        child: Container(
          height: 40,
        ),
      ),
    );
  }
}

class Person {
  //modal class for Person object
  String id, name, phone, address, avatar, email;
  Person(
      {required this.id,
      required this.name,
      required this.phone,
      required this.address,
      required this.email,
      required this.avatar});
}
