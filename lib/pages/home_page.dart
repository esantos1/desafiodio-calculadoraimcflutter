import 'package:calcularimcemflutter/classes/pessoa.dart';
import 'package:calcularimcemflutter/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isImcCalculate = false;
  double imc = 0.0;
  String resultadoFinal = "";

  final nomeController = TextEditingController(text: "");
  final pesoController = TextEditingController(text: "");
  final alturaController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Calculadora de IMC')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextField(controller: nomeController, labelText: 'Nome'),
              SizedBox(height: 16),
              CustomTextField(controller: pesoController, labelText: 'Peso'),
              SizedBox(height: 16),
              CustomTextField(
                  controller: alturaController, labelText: 'Altura'),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: calcImcMostrarResult,
                      child: Text('Calcular'),
                    ),
                  ),
                ],
              ),
              isImcCalculate
                  ? Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: novoCalc,
                            child: Text('Fazer novo calculo'),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              isImcCalculate ? widgetMostrarResultado() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void calcImcMostrarResult() {
    String nome = "";
    double peso = 0.0, altura = 0.0;
    bool mostrarResultado;

    FocusScope.of(context).unfocus();

    if (nomeController.text.isNotEmpty) {
      nome = nomeController.text;

      mostrarResultado = true;
    } else {
      showErrorDialog('Insira um nome válido.');

      mostrarResultado = false;
    }

    try {
      peso = double.parse(pesoController.text);
      mostrarResultado = true;
    } catch (e) {
      showErrorDialog(
          'Insira um peso válido. Este campo aceita apenas números e vírgulas!');

      mostrarResultado = false;
    }

    try {
      altura = double.parse(alturaController.text);
      mostrarResultado = true;
    } catch (e) {
      showErrorDialog(
          'Insira um peso válido. Este campo aceita apenas números e vírgulas!');

      mostrarResultado = false;
    }

    Pessoa pessoa = Pessoa(nome, peso, altura);

    setState(() {
      imc = pessoa.calcularImc();

      if (imc < 18.5) {
        resultadoFinal = "Magreza";
      } else if (imc >= 18.5 && imc < 25.0) {
        resultadoFinal = "Normal";
      } else if (imc >= 25.0 && imc < 30.0) {
        resultadoFinal = "Sobrepeso";
      } else if (imc >= 30.0 && imc < 35.0) {
        resultadoFinal = "Obesidade grau I";
      } else if (imc >= 35.0 && imc < 40.0) {
        resultadoFinal = "Obesidade grau II";
      } else {
        resultadoFinal = "Obesidade grau III";
      }

      isImcCalculate = mostrarResultado;
    });
  }

  void showErrorDialog(String textoErro) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(textoErro),
          duration: Duration(seconds: 3),
        ),
      );

  Widget widgetMostrarResultado() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              imc.toStringAsFixed(1),
              style: TextStyle(color: Colors.black38, fontSize: 16),
            ),
            Text(resultadoFinal, style: TextStyle(fontSize: 32)),
          ],
        ),
      );

  void novoCalc() {
    setState(() => isImcCalculate = false);

    nomeController.text = "";
    pesoController.text = "";
    alturaController.text = "";
  }
}
