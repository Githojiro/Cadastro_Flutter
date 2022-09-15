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
  List pessoa = ['testes'];

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
        title: const Text("Add And Delete List"),
        backgroundColor: Colors.redAccent,
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
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pessoa.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Card(
                          color: const Color.fromARGB(255, 248, 248, 248),
                          child: Column(
                            children: [
                              Text(pessoa[index]),
                            ],
                          ),
                        ));
                  })),
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

          persons.add(Person(
              id: "5",
              name: "Hari Prasad Chaudhary",
              phone: "9812122233",
              address: "Kathmandu, Nepal",
              avatar: " "));
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
  String id, name, phone, address, avatar;
  Person(
      {required this.id,
      required this.name,
      required this.phone,
      required this.address,
      required this.avatar});
}
