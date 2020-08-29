import 'package:bloc_example/cep_bloc.dart';
import 'package:bloc_example/endereco_model.dart';
import 'package:bloc_example/home_bloc.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomePageBloc bloc = HomePageBloc();
  HomeCepBloc cepBloc = HomeCepBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                cepBloc.input.add(value);
              },
              decoration: InputDecoration(
                  hintText: "Digite o CEP", border: OutlineInputBorder()),
            ),
            StreamBuilder<EnderecoModel>(
              stream: cepBloc.output,
              initialData: EnderecoModel(bairro: "Sem bairro"),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Erro na pesquisa");
                }
                EnderecoModel model = snapshot.data;
                return Text('Bairro: ${model.bairro}');
              },
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
                stream: bloc.output,
                builder: (context, snapshot) {
                  return Text(
                    '${bloc.counter}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc.incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
