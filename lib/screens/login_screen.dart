import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/mock_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  void _login() async {
    setState(() => _loading = true);
    try {
      final svc = Provider.of<MockService>(context, listen: false);
      await svc.fakeLogin(_userCtrl.text.trim(), _passCtrl.text.trim());
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Align(alignment: Alignment.centerLeft, child: Text('Welcome back', style: Theme.of(context).textTheme.headlineMedium)),
              const SizedBox(height: 8),
              Align(alignment: Alignment.centerLeft, child: Text('Log in to continue learning', style: Theme.of(context).textTheme.bodyLarge)),
              const SizedBox(height: 32),
              TextField(
                controller: _userCtrl,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: _loading ? null : _login,
                icon: _loading ? const SizedBox.shrink() : const Icon(Icons.login),
                label: Text(_loading ? 'Logging...' : 'Sign in'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  // quick demo login
                  _userCtrl.text = 'admin';
                  _passCtrl.text = '123456';
                },
                child: const Text('Fill demo credentials'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}