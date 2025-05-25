import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart'; // Assuming UserProvider exists
import 'home_screen.dart'; // Navigate to HomeScreen after login
import '../utils/theme_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    // --- Placeholder Login Logic --- 
    // In a real app, you would call your auth service here (e.g., Firebase Auth)
    // For now, simulate a delay and assume login is successful
    await Future.delayed(const Duration(seconds: 2));
    print('Simulating login for: ${_emailController.text}');
    
    // Update user state (placeholder)
    // Provider.of<UserProvider>(context, listen: false).loginUser(/* User data */);

    setState(() {
      _isLoading = false;
    });

    // Navigate to HomeScreen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()), // Assuming HomeScreen exists
      );
    }
    // --- End Placeholder Login Logic ---
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Placeholder for Logo (Optional on Login screen)
                Image.asset(
                  'assets/images_png/lamafia_icon_foreground.png',
                  width: 100,
                  errorBuilder: (context, error, stackTrace) {
                     return const Icon(Icons.hide_image, size: 80, color: ThemeConstants.textSecondaryColor);
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Bem-vindo ao LAMAFIA',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email ou ID',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email ou ID';
                    }
                    // Basic email validation (optional)
                    // if (!value.contains('@')) {
                    //   return 'Email inválido';
                    // }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity, // Make button full width
                        child: ElevatedButton(
                          onPressed: _login,
                          child: const Text('ENTRAR'),
                        ),
                      ),
                const SizedBox(height: 20),
                // Placeholder for 'Forgot Password' or 'Register'
                TextButton(
                  onPressed: () {
                    // TODO: Implement forgot password or registration flow
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Funcionalidade ainda não implementada.')),
                    );
                  },
                  child: Text(
                    'Esqueceu a senha? / Registrar',
                    style: TextStyle(color: ThemeConstants.accentColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

