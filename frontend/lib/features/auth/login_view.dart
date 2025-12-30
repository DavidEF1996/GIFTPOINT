import 'package:flutter/material.dart';
import 'package:frontend/features/giftcards/giftcards_view.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            if (vm.isLoading) const CircularProgressIndicator(),

            if (vm.error != null)
              Text(vm.error!, style: const TextStyle(color: Colors.red)),

            ElevatedButton(
              onPressed: vm.isLoading
                  ? null
                  : () async {
                      await vm.login(emailCtrl.text, passCtrl.text);

                      if (vm.token != null && context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GiftcardsView(token: vm.token!),
                          ),
                        );
                      }
                    },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
