import 'package:atividade_2/bloc/auth/auth_event.dart';
import 'package:atividade_2/bloc/stock/user_stock_bloc.dart';
import 'package:atividade_2/bloc/view/view_bloc.dart';
import 'package:atividade_2/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/stock/user_stock_event.dart';
import '../bloc/view/view_events.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  var completeForm = CompleteForm();

  @override
  Widget build(BuildContext context) {
    ViewBloc viewBloc = BlocProvider.of<ViewBloc>(context);
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    UserLoginBloc userLoginBloc = BlocProvider.of<UserLoginBloc>(context);
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
                            "Login",
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
                              label: "Senha",
                              datafield: "password",
                              obsureText: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                minWidth: 20,
                                height: 40,
                                onPressed: () {
                                  setState(() {
                                    completeForm.hasAuthError = false;
                                  });
                                  authBloc.add(
                                    LoginUser(
                                        email: completeForm.textFields["email"],
                                        password: completeForm
                                            .textFields["password"]),
                                  );
                                  if (!authBloc.state.isAuthenticated) {
                                    setState(() {
                                      completeForm.hasAuthError = true;
                                    });
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    return;
                                  }
                                },
                                color: Colors.yellowAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "Entrar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                minWidth: 20,
                                height: 40,
                                onPressed: () {
                                  viewBloc.add(ChangeView(view: 'register'));
                                },
                                color: Colors.yellowAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "Cadastrar-se",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ]),
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
        TextFormField(
          obscureText: obsureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor preencha este campo corretamente';
            } else if (completeForm.hasAuthError) {
              return 'Email ou senha incorretos';
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
    "password": "",
  };
  bool hasAuthError = false;
}

bool verifyError(AuthBloc authBloc) {
  //await Future.delayed(const Duration(milliseconds: 100));
  if (authBloc.state.token.isEmpty) {
    return true;
  } else {
    return false;
  }
}
