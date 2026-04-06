import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isLogin = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [

                // 🔥 TITLE
                Text(
                  "FinTrack",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2962FF),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  isLogin ? "Login" : "Create Account",
                  style: TextStyle(fontSize: 18),
                ),

                SizedBox(height: 30),

                // EMAIL
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                SizedBox(height: 15),

                // PASSWORD
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),

                SizedBox(height: 25),

                // 🔥 BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Color(0xFF2962FF),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() => isLoading = true);

                          final auth = Provider.of<AuthProvider>(
                              context,
                              listen: false);

                          if (isLogin) {
                            bool success =
                                await auth.login(email.text, password.text);

                            if (!success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Invalid credentials ❌"),
                                ),
                              );
                            }
                          } else {
                            await auth.signup(email.text, password.text);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Account created successfully ✅"),
                              ),
                            );

                            setState(() {
                              isLogin = true;
                            });
                          }

                          setState(() => isLoading = false);
                        },
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(isLogin ? "Login" : "Sign Up"),
                ),

                SizedBox(height: 15),

                // 🔄 TOGGLE
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(
                    isLogin
                        ? "Don't have an account? Sign Up"
                        : "Already have an account? Login",
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
