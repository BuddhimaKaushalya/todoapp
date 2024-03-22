import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../color.dart';
import 'login.dart';
import '../services//userServices.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = true; // Initially, the button is disabled

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await NetworkService.instance.registerUser(
          _nameController.text,
          _userNameController.text,
          _emailController.text,
          _passwordController.text,
          _confirmPasswordController.text,
        );

        if (response != null) {
          // Registration successful, show success message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Successful'),
                content: Text('You have successfully registered.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle other responses, if needed
        }
      } catch (e) {
        // Handle registration errors
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title:  Text('Registration Failed'),
              content: Text(
                'An error occurred during registration. Please try again later.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        print('Registration failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  blue,
                  violet,
                  lightBlue,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 22),
              child: Text(
                'Hello!\nSign up',
                style: GoogleFonts.openSans(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        SizedBox(height: 15),

                        TextFormField(
                          controller: _nameController,
                          onChanged: (_) => _validateForm(),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                color: violet,
                                fontSize: 17),
                          ),
                        ),
                        SizedBox(height: 15),

                        
                        TextFormField(
                          controller: _userNameController,
                          onChanged: (_) => _validateForm(),
                          decoration: InputDecoration(
                            labelText: 'User Name',
                            labelStyle: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                color: violet,
                                fontSize: 17),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _emailController,
                          onChanged: (_) => _validateForm(),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            labelStyle: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                color: violet,
                                fontSize: 17),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _passwordController,
                          onChanged: (_) => _validateForm(),
                          obscureText: !_passwordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            labelText: 'Password',
                            labelStyle: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                color: violet,
                                fontSize: 17),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _confirmPasswordController,
                          onChanged: (_) => _validateForm(),
                          obscureText: !_confirmPasswordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmPasswordVisible =
                                      !_confirmPasswordVisible;
                                });
                              },
                            ),
                            labelText: 'Confirm Password',
                                                        labelStyle: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                color: violet,
                                fontSize: 17),
                          ),
                        ),
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: _isButtonDisabled ? null : _submitForm,
                          child: Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: _isButtonDisabled ? Colors.grey : violet,
                            ),
                            child: Center(
                              child: Text(
                                'SIGN UP',
                                style: GoogleFonts.openSans(
                                  color: _isButtonDisabled ? Colors.white : white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Already have an Account",
                                style: GoogleFonts.openSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                  color: violet,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                                child: Text(
                                  "Sign in",
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: violet,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _validateForm() {
    setState(() {
      _isButtonDisabled = _nameController.text.isEmpty ||
          _userNameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _confirmPasswordController.text.isEmpty ||
          _passwordController.text != _confirmPasswordController.text ||
          _passwordController.text.length < 8;
    });
  }
}

                           
