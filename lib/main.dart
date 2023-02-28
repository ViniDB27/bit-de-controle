import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum TypeParidade { impar, par }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controllerMessage = TextEditingController();

  String message = '';
  List<int> bytes = [];
  String binario = '';

  TypeParidade typeParidade = TypeParidade.par;

  verifyMessage() {
    if (typeParidade == TypeParidade.par) {
      int bitsOne = 0;

      for (var byte in bytes) {
        if (byte == 1) {
          bitsOne += 1;
        }
      }

      if (bitsOne % 2 != 0) {
        bytes = [1, ...bytes];
      } else {
        bytes = [0, ...bytes];
      }
    } else {
      int bitsOne = 0;

      for (var byte in bytes) {
        if (byte == 1) {
          bitsOne += 1;
        }
      }

      if (bitsOne % 2 == 0) {
        bytes = [1, ...bytes];
      } else {
        bytes = [0, ...bytes];
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Trabalho"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Mensagem"),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: controllerMessage,
                ),
              ),
              const SizedBox(height: 20),
              if (typeParidade == TypeParidade.par) const Text("Paridade Par"),
              if (typeParidade == TypeParidade.impar)
                const Text("Paridade Impar"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (typeParidade == TypeParidade.par) {
                    typeParidade = TypeParidade.impar;
                  } else {
                    typeParidade = TypeParidade.par;
                  }
                  setState(() {});
                },
                child: const SizedBox(
                  height: 50,
                  width: 150,
                  child: Center(
                    child: Text(
                      "Mudar Paridade",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  message = controllerMessage.text;
                  bytes = utf8.encode(message);

                  verifyMessage();

                  binario = bytes
                      .map((b) => b.toRadixString(2).padLeft(8, '0'))
                      .join();
                  setState(() {});
                },
                child: const SizedBox(
                  height: 50,
                  width: 300,
                  child: Center(
                    child: Text(
                      "Enviar Mensagem",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Text(binario)
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
