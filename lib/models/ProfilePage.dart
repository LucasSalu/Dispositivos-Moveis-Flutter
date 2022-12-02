import 'package:atividade_2/bloc/auth/auth_bloc.dart';
import 'package:atividade_2/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  var completeForm = CompleteForm();

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

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
                            "Perfil",
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
                      Column(
                        children: [
                          Card(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 25.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: Column(
                                children: [
                                  const ListTile(
                                    title: Text(
                                      "Dados pessoais:",
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: MaterialButton(
                          minWidth: 200,
                          height: 60,
                          onPressed: () {
                            authBloc
                                .add(LogoutUser(token: authBloc.state.token));
                          },
                          color: Colors.yellowAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "Sair",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
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
}

class CompleteForm {
  Map textFields = {
    "email": "jorgeOmar@shark.com.br",
    "name": "Jorge Omar",
  };
}
