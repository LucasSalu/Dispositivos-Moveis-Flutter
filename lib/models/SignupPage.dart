import 'package:atividade_2/bloc/auth/auth_bloc.dart';
import 'package:atividade_2/bloc/auth/auth_event.dart';
import 'package:atividade_2/bloc/auth/auth_state.dart';
import 'package:atividade_2/bloc/view/view_bloc.dart';
import 'package:atividade_2/bloc/view/view_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    ViewBloc viewBloc = BlocProvider.of<ViewBloc>(context);
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
                              obscureText: true,
                            ),
                            buildGenericTextInput(
                              label: "Confirmação da Senha:",
                              datafield: "password-confirmation",
                              obscureText: true,
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
                              side: BorderSide(
                                  color: completeForm.checkBoxError
                                      ? Colors.red
                                      : Colors.black),
                              title: Text(
                                "Aceito os termos de uso",
                                style: TextStyle(
                                    color: completeForm.checkBoxError
                                        ? Colors.red
                                        : Colors.black),
                              ),
                              subtitle: completeForm.checkBoxError
                                  ? const Text(
                                      "Você precisa aceitar os termos de uso",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : null,
                              activeColor: Colors.yellow[700],
                              value: completeForm.checkboxValue,
                              onChanged: (newValue) {
                                setState(() {
                                  completeForm.checkboxValue = newValue!;
                                  if (completeForm.checkBoxError == true) {
                                    setState(() {
                                      completeForm.checkBoxError = false;
                                    });
                                  }
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
                              if (completeForm.checkboxValue == false) {
                                setState(() {
                                  completeForm.checkBoxError = true;
                                });
                                return;
                              } else if (_formKey.currentState!.validate()) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Wrap(
                                        children: [
                                          const ListTile(
                                            title: Text(
                                              "Confira os dados que você inseriu:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87),
                                            ),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.email),
                                            title: const Text("Email:"),
                                            subtitle: Text(completeForm
                                                .textFields["email"]
                                                .toString()),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.person),
                                            title: const Text("Nome Completo:"),
                                            subtitle: Text(completeForm
                                                .textFields["name"]
                                                .toString()),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.money),
                                            title: const Text(
                                                "Renda que você planeja investir:"),
                                            subtitle: Text(
                                                "${completeForm.slideValue.ceil()}% da minha renda"),
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                MaterialButton(
                                                  minWidth: 20,
                                                  height: 40,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  color: Colors.redAccent,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: const Text(
                                                    "Cancelar",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                MaterialButton(
                                                  minWidth: 20,
                                                  height: 40,
                                                  onPressed: () {
                                                    setState(() {
                                                      completeForm
                                                          .hasAuthError = false;
                                                    });
                                                    authBloc.add(RegisterUser(
                                                      email: completeForm
                                                          .textFields["email"]
                                                          .toString(),
                                                      password: completeForm
                                                          .textFields[
                                                              "password"]
                                                          .toString(),
                                                      name: completeForm
                                                          .textFields["name"]
                                                          .toString(),
                                                      hasAcceptedTerms:
                                                          completeForm
                                                              .checkboxValue,
                                                    ));
                                                    Navigator.pop(context);
                                                    if (!authBloc.state
                                                        .isAuthenticated) {
                                                      setState(() {
                                                        completeForm
                                                                .hasAuthError =
                                                            true;
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          backgroundColor:
                                                              Colors.redAccent,
                                                          content: Text(
                                                            "Ocorreu um erro ao cadastrar o usuário!!",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else if (authBloc.state
                                                        .isAuthenticated) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          backgroundColor:
                                                              Colors
                                                                  .greenAccent,
                                                          content: Text(
                                                            "Cadastrado com sucesso!",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  color: Colors.greenAccent,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: const Text(
                                                    "Confirmar",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    );
                                  },
                                );
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
    bool obscureText = false,
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
        TextFormField(
          obscureText: obscureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor preencha este campo corretamente';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              completeForm.textFields[datafield] = value;
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
  Map textFields = {
    "email": "",
    "name": "",
    "password": "",
    "password-confirmation": "",
  };
  bool checkboxValue = false;
  bool checkBoxError = false;
  bool hasAuthError = false;
  double slideValue = .5;
}
