import 'package:flutter/material.dart';
import 'model/MyModel.dart';
void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const DEFAULT_TEXT ='Informe seus dados acima';
  final limits = <ArrItem>[
    ArrItem('Abaixo do peso',18.6),
    ArrItem('Peso ideal',24.9),
    ArrItem('Acima do peso',29.9),
    ArrItem('Obesidade grau 1', 34.9),
    ArrItem('Obesidade grau 2', 39.9),
    ArrItem('Obesidade grau 3', 40),

  ];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _textField = DEFAULT_TEXT;
  void _resetFields(){
    weightController.text='';
    heightController.text='';
    setState(() {
      _textField = DEFAULT_TEXT;
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text)/100;
    double aux= (weight/(height*height));
    String message = limits[limits.length-1].label;
    for(int idx = limits.length-2;idx>-1;idx--){
      if(aux<limits[idx].value){
        message = limits[idx].label;
      }
    }
    setState(() {
      _textField ='IMC: ${aux.toStringAsPrecision(4)} ($message)';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: _getContent(),
        ),
      ),
    );
  }

  Widget _getContent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.person_outline, size: 140, color: Colors.green),
        TextFormField(
          controller: weightController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Peso(kg)",
              labelStyle: TextStyle(color: Colors.green)),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 25),
          validator: (value){
            if(value.isEmpty){
              return "Favor informar o peso!";
            }
          },
        ),
        TextFormField(
          controller: heightController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Altura(cm)",
              labelStyle: TextStyle(color: Colors.green)),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 25),
          validator: (value){
            if(value.isEmpty){
                return "Favor informar a altura!";
            }
          },
        ),
        Container(
          height: 50,
          margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: RaisedButton(
            onPressed:(){
              if(_formKey.currentState.validate()){
                _calculate();
              }
            },
            child: Text('Calcular',
                style: TextStyle(color: Colors.white, fontSize: 25)),
            color: Colors.green,
          ),
        ),
        Text(
          _textField,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 25),
        )
      ],
    );
  }
}
