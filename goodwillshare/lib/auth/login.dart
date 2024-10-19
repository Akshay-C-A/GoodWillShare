import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goodwillshare/donor/donordashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isObscure = true;
  String? _emailError;
  String? _passwordError;

  void _navigateToHome(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Replace HomePage() with your actual home page widget
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DonorDashboard()),
      );
    }
  }

  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
      _emailError = null;
      _passwordError = null;
    });

    try {
      // Validate email and password
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      
      if (email.isEmpty) {
        setState(() {
          _emailError = 'Email is required';
          _isLoading = false;
        });
        return;
      }
      if (password.isEmpty) {
        setState(() {
          _passwordError = 'Password is required';
          _isLoading = false;
        });
        return;
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Only navigate if sign in was successful
      if (mounted) {
        _navigateToHome(context);
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'invalid-email':
            _emailError = 'Invalid email address';
            break;
          case 'user-not-found':
            _emailError = 'No user found with this email';
            break;
          case 'wrong-password':
            _passwordError = 'Incorrect password';
            break;
          case 'user-disabled':
            _emailError = 'This account has been disabled';
            break;
          case 'network-request-failed':
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Network error. Please check your connection.')),
            );
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${e.message}')),
            );
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'LOGIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email id',
                    errorText: _emailError,
                    errorStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: _passwordError,
                    errorStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscure,
                ),
                SizedBox(height: 20.0),
                if (_isLoading)
                  Center(child: CircularProgressIndicator())
                else
                  ElevatedButton(
                    onPressed: signIn,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Login', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                SizedBox(height: 20.0),
                Center(child: Text("or")),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}