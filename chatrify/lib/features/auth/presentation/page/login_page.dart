import 'package:chatrify/core/theme.dart';
import 'package:chatrify/features/auth/presentation/bloc/auth_event.dart';
import 'package:chatrify/features/auth/presentation/widget/auth_button.dart';
import 'package:chatrify/features/auth/presentation/widget/login_prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widget/auth_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    BlocProvider.of<AuthBloc>(context).add(
        LoginEvent(
            email: _emailController.text,
            password: _passwordController.text
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthInputField(hint: 'Емаил', icon: Icons.email, controller: _emailController),
                      SizedBox(height: 20,),
                      AuthInputField(hint: 'Лозинка', icon: Icons.lock, controller: _passwordController, isPassword: true),
                      SizedBox(height: 20,),
                      BlocConsumer<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if(state is AuthLoading) {
                              return Center(child: CircularProgressIndicator(),);
                            }

                            return  AuthButton(text: 'Најавете се', onPressed: _onLogin);
                          },
                          listener: (context, state) {
                            if(state is AuthSuccess) {
                              Navigator.pushNamedAndRemoveUntil(context, '/conversationPage', (route) => false);
                            } else if(state is AuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.error))
                              );
                            }
                          }
                      ),
                      SizedBox(height: 20,),
                      LoginPrompt(title: 'Не сте регистрирани? ', subtitle: 'Регистрирајте се', onTap: (){
                        Navigator.pushNamed(context, '/register');
                      })
                    ]
                )
            )
        )
    );
  }
}
