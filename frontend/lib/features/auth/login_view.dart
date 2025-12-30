import 'package:flutter/material.dart';
import 'package:frontend/features/giftcards/giftcards_view.dart';
import 'package:provider/provider.dart';
import 'auth_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final vm = AuthViewModel();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>.value(
      value: vm,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Consumer<AuthViewModel>(
            builder: (_, vm, __) {
              return Center(
                child: SizedBox(
                  height: 300,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: emailCtrl,

                          decoration: const InputDecoration(labelText: 'Email'),
                          style: TextStyle(color: Colors.black),
                        ),
                        TextField(
                          controller: passCtrl,
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),

                        if (vm.isLoading) const CircularProgressIndicator(),

                        if (vm.error != null)
                          Text(
                            vm.error!,
                            style: const TextStyle(color: Colors.red),
                          ),

                        ElevatedButton(
                          onPressed: vm.isLoading
                              ? null
                              : () async {
                                  await vm.login(emailCtrl.text, passCtrl.text);

                                  if (vm.token != null && context.mounted) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            GiftcardsView(token: vm.token!),
                                      ),
                                    );
                                  }
                                },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
