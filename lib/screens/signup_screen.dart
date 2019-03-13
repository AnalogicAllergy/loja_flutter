import 'package:flutter/material.dart';
import 'package:loja_flutter/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _globalKey = GlobalKey<FormState>();
  final _scaffoldlKey = GlobalKey<ScaffoldState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passController = TextEditingController();

  final enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldlKey,
        appBar: AppBar(
          title: Text('Criar Conta'),
          centerTitle: true,
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _globalKey,
            child: ListView(
              padding: EdgeInsets.all(8),
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Nome Completo'),
                  validator: (text) {
                    if (text.isEmpty || text.length < 2)
                      return "Nome inválido!";
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@'))
                      return "Email inválido!";
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: passController,
                  decoration: InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha inválida (mín 6 caracteres)";
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: enderecoController,
                  decoration: InputDecoration(hintText: 'Endereço'),
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Endereço inválido (mín 6 caracteres)";
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'CRIAR CONTA',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {
                      if (_globalKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          'name': nameController.text,
                          'email': emailController.text,
                          'address': enderecoController.text,
                        };
                        model.signUp(
                          userData: userData,
                          pass: passController.text,
                          onSuccess: _onSuccess,
                          onFailure: _onFailure,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          );
        }));
  }

  void _onSuccess() {
    _scaffoldlKey.currentState.showSnackBar(SnackBar(
      content: Text('Usuário criado com sucesso!'),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFailure() {
    _scaffoldlKey.currentState.showSnackBar(SnackBar(
      content: Text('Falha ao criar usuário!'),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
