import 'package:eternify/adicionar_pessoa.dart';
import 'package:eternify/procurar_pessoa.dart';
import 'package:eternify/text_form_field_demo.dart';
import "package:flutter/material.dart";

void main() {
  runApp(new MaterialApp(
    home: new Example(),
  ));
}

class Example extends StatefulWidget {
  @override
  ExampleState createState() => new ExampleState();
}

class ExampleState extends State<Example> {
  int currentTab = 0;
  ProcurarPessoa procurarPessoa = new ProcurarPessoa();
  NovaPessoa novaPessoa = new NovaPessoa();
  TextFormFieldDemo textFormFieldDemo = new TextFormFieldDemo();
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    pages = [procurarPessoa, novaPessoa, textFormFieldDemo, textFormFieldDemo];
    currentPage = procurarPessoa;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color COR_PADRAO_BARRA = Colors.blue;
    final BottomNavigationBar navBar = new BottomNavigationBar(
      currentIndex: currentTab,
      onTap: (int numTab) {
        setState(() {
          currentTab = numTab;
          currentPage = pages[numTab];
        });
      },
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
            backgroundColor: COR_PADRAO_BARRA,
            icon: new Icon(Icons.location_searching),
            title: new Text("Buscar Memórias")),
        new BottomNavigationBarItem(
            backgroundColor: COR_PADRAO_BARRA,
            icon: new Icon(Icons.add),
            title: new Text("Nova Memória")),
        new BottomNavigationBarItem(
            backgroundColor: COR_PADRAO_BARRA,
            icon: new Icon(Icons.add),
            title: new Text("Nova Memória")),
      ],
    );

    return new Scaffold(
      bottomNavigationBar: navBar,
      body: currentPage,
    );
  }
}

class PageTwo extends StatelessWidget {
  // Creating a simple example page.
  @override
  Widget build(BuildContext context) {
    return new Center(child: new Text("Page two"));
  }
}

class PageThree extends StatelessWidget {
  // Creating a simple example page.
  @override
  Widget build(BuildContext context) {
    return new Center(child: new Text("Page three"));
  }
}
