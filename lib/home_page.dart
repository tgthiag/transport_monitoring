import 'package:flutter/material.dart';
import 'package:transport_monitoring/custom_components/homepage_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.pending_actions,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    top: 30.0, bottom: 30.0, left: 30.0, right: 15.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.blue),
                    borderRadius: BorderRadiusDirectional.circular(20)),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Registrar pedido:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      HomePageButton(
                          btText: "Registrar pedido",
                          onBtPress: () => print("registrar"),
                          btColor: Colors.blue),
                      const TextField(
                          autocorrect: false,
                          decoration:
                              InputDecoration(labelText: 'Código do material')),
                      const TextField(
                          autocorrect: false,
                          decoration: InputDecoration(labelText: 'Lote')),
                      const TextField(
                          autocorrect: false,
                          decoration: InputDecoration(labelText: 'Descrição')),
                      const TextField(
                          autocorrect: false,
                          decoration: InputDecoration(labelText: 'Cap')),
                      HomePageButton(
                          btText: "Cancelar Pedido",
                          onBtPress: () => print("registrar"),
                          btColor: Colors.blue),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 30.0, bottom: 30.0, left: 15.0, right: 30.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.blue),
                    borderRadius: BorderRadiusDirectional.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Text('Pedidos pendentes:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
