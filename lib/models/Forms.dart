import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  var completeForm = CompleteForm();

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: myController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Digite O nome da Ação da Bolsa';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                this.completeForm.text = myController.text;
                ScaffoldMessenger
                    .of(context)
                    .showSnackBar(
                    SnackBar(content: Text(myController.text)));
                }
                },
            child: const Text('Submit'),
          ),
          CheckboxListTile(
            title: Text("title text"),
            value: completeForm.checkboxValue,
            onChanged: (newValue) {
              setState(() {
                completeForm.checkboxValue = newValue!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          Slider(
              min: 0,
              max: 20,
              value:completeForm.slideValue,
              onChanged: (double inValue){
                setState(() {
                  completeForm.slideValue = inValue;
                });
              })
        ],
      ),
    );
  }
}

class CompleteForm {
  String text = " ";
  bool checkboxValue = false;
  bool switchValue = false;
  double slideValue = .5;
  int radioValue = 1;
  int radioValue2 = 1;
  int bottomSheetChoice = 0;

  doSomething() {
    return "checkbox: $checkboxValue\n" +
        "Switch: $switchValue\n" +
        "Slider: $slideValue\n" +
        "Radio: $radioValue\n";
  }
}
