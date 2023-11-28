import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  final _inputReal = TextEditingController();
  final _inputDolar = TextEditingController();
  final _inputCotacao = TextEditingController();
  final _inputConta = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _labelButton = 'Converter';

  double _resultado = 0;

  void _getRequestDolar() async {
    try {
      var dio = Dio();
      dio.options.connectTimeout = Duration(seconds: 5);
      dio.options.connectTimeout = Duration(seconds: 3);

      setWaiting('Aguarde.....');
      var url = 'https://economia.awesomeapi.com.br/last/USD-BRL';
      var response = await dio.get(url);

      if (response.data['erro'] != null) {
        setMsgErro(
            'Erro ao converter o real em dolar', 'Cotaçao não encontrado');
        setWaiting('Converter:');
        return;
      }

      _inputDolar.text = response.data['USDBRL']['bid'];
      _inputCotacao.text = 'Cotação Atual' + response.data['USDBRL']['high'];

      _resultado =
          double.parse(_inputReal.text) * double.parse(_inputDolar.text);

      _inputConta.text = _resultado.toStringAsFixed(2);

      setState(() {});

      setWaiting('Converter:');
    } on Exception catch (erro) {
      setWaiting('Converter:');
      setMsgErro('Erro ao retornar a converção', erro.toString());
    }
  }

  void setMsgErro(String aTitulo, String aMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(height: 15),
                Text(
                  aTitulo,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            content: Text(
              aMessage,
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
  }

  void setWaiting(String vCotacao) {
    _labelButton = vCotacao;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onLongPress: () {
                            _inputReal.clear();
                            _inputCotacao.clear();
                            _inputConta.clear();

                            setState(() {});
                          },
                          child: Image.asset(
                            'assets/imagens/dolar.png',
                            width: 100,
                            height: 110,
                          ),
                        ),
                        const Text(
                          'De real em dolar',
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _inputReal,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              labelText: 'Valor em Real',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(
                                Icons.attach_money,
                                color: Colors.white,
                              )),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                double.parse(value) <= 0) {
                              return 'Informe o valor em real';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _getRequestDolar();
                                setState(() {});
                              }
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_labelButton,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      )),
                                ])),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _inputConta,
                          obscureText: false,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelStyle: TextStyle(color: Colors.black),
                            filled: true,
                            fillColor: Colors.white,
                            prefixText: 'Valor em Dólar: ',
                            prefixStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          readOnly: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          _inputCotacao.text,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
