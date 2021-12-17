import 'package:flutter/material.dart';
import 'dart:io';

import 'package:travel_journal_app/widgets/auth/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      bool isLogin, File imageFile) submitFn;

  final bool isLoading;

  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLogin = true;
  final _form = GlobalKey<FormState>();
  String _userEmail;
  String _userName = '';
  String _userPassword;
  File _getImage;

  void _imagePickFn(File pickedImage) {
    _getImage = pickedImage;
  }

  void _submitForm() {
    final isValid = _form.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_getImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please Pick an Image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _form.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin, _getImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_imagePickFn),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (newValue) {
                      _userEmail = newValue;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('userName'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                      onSaved: (newValue) {
                        _userName = newValue;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (newValue) {
                      _userPassword = newValue;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin ? 'Create New Account' : 'I have an Account',
                      ),
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
