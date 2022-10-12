import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  SignupPageState createState() {
    return SignupPageState();
  }
}

class SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  var completeForm = CompleteForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Registrar",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            buildGenericTextInput(
                              label: "Email:",
                              datafield: "email",
                            ),
                            buildGenericTextInput(
                              label: "Nome Completo:",
                              datafield: "name",
                            ),
                            buildGenericTextInput(
                              label: "Senha",
                              datafield: "password",
                              obsureText: true,
                            ),
                            buildGenericTextInput(
                              label: "Confirmação da Senha:",
                              datafield: "password-confirmation",
                              obsureText: true,
                            ),
                            Card(
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 25.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Quanto da sua renda você planeja investir?",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87),
                                    ),
                                    Text(
                                      "${completeForm.slideValue.ceil()}% da minha renda",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.deepOrange[800]),
                                    ),
                                    Slider(
                                        min: 0,
                                        max: 100,
                                        activeColor: Colors.deepOrange[400],
                                        inactiveColor: Colors.deepOrange[100],
                                        value: completeForm.slideValue,
                                        onChanged: (double inValue) {
                                          setState(() {
                                            completeForm.slideValue = inValue;
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            CheckboxListTile(
                              title: const Text("Aceito os termos de uso"),
                              activeColor: Colors.yellow[700],
                              value: completeForm.checkboxValue,
                              onChanged: (newValue) {
                                setState(() {
                                  completeForm.checkboxValue = newValue!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: const Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: MaterialButton(
                            minWidth: 200,
                            height: 60,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text(completeForm.doSomething())));
                              }
                            },
                            color: Colors.yellowAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "Registrar-se",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGenericTextInput({
    required String label,
    String? datafield,
    bool obsureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obsureText,
          onChanged: (value) {
            setState(() {
              completeForm.textfields[datafield] = value;
            });
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}

class CompleteForm {
  Map textfields = {
    "email": "",
    "name": "",
    "password": "",
    "password-confirmation": "",
  };
  bool checkboxValue = false;
  double slideValue = .5;

  doSomething() {
    return "Checkbox: $checkboxValue\n"
        "Slider: $slideValue\n"
        "Text: $textfields\n";
  }
}
