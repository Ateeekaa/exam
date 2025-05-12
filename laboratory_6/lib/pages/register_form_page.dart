import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laboratory_6/bloc/auth/auth_bloc.dart';
import 'package:laboratory_6/pages/main_navigation_page.dart';


class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}


class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  InputDecoration _inputDecoration({
    required String label,
    String? hint,
    IconData? icon,
    IconData? suffix,
    VoidCallback? onSuffixTap,
    required FocusNode focusNode,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(color: focusNode.hasFocus ? Colors.orange : Colors.green[900]),
      icon: icon != null ? Icon(icon, color: Colors.green[900]) : null,
      suffixIcon: suffix != null
          ? GestureDetector(
              onTap: onSuffixTap,
              child: Icon(suffix, color: Colors.red),
            )
          : null,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.green, width: 1.5),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: Colors.orange, width: 2.0),
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
  title: Text('register_form'.tr()),
  centerTitle: true,
  leading: PopupMenuButton<Locale>(
    onSelected: (Locale locale) {
      context.setLocale(locale);
       },
    icon: const Icon(Icons.language),
    itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
      const PopupMenuItem<Locale>(
        value: Locale('kk'),
        child: Text('Қазақша'),
      ),
      const PopupMenuItem<Locale>(
        value: Locale('en'),
        child: Text('English'),
      ),
    ],
  ),
),

    body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpeg'),
          fit: BoxFit.cover,
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('register_form'.tr()),
          centerTitle: true,
          leading: PopupMenuButton<Locale>(
            onSelected: (Locale locale) {
              context.setLocale(locale);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fullName', newUser.name);
    prefs.setString('email', newUser.email);
    prefs.setString('phone', newUser.phone);
    prefs.setString('country', newUser.country);
    prefs.setString('password', newUser.password);
    prefs.setBool('isAuthenticated', true);

    widget.onRegistered(newUser);

    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (_) => const MainPage()),
    );
  } else {
    _showMessage(message: 'Form is not valid! Please review and correct');
  }
}




  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message, style: const TextStyle(color: Colors.white)),
    ));
  }

  // ignore: unused_element
  void _showDialog({required String name}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration successful', style: TextStyle(color: Colors.green)),
        content: Text('$name is now a verified register form'),
        actions: [
          TextButton(
            child: const Text('Verified', style: TextStyle(color: Colors.green)),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => UserInfoPage(userInfo: newUser)),
              );
            },
          ),
        ],
      ),
    );
  }

  String? validateName(String? value) {
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null || value.isEmpty) return 'Name is required.';
    if (!nameExp.hasMatch(value)) return 'Please enter alphabetical characters.';
    return null;
  }

  bool validatePhoneNumber(String input) => RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$').hasMatch(input);

  String? _validatePassword(String? value) {
    if (_passController.text.length != 8) return '8 characters required';
    if (_confirmPassController.text != _passController.text) return 'Passwords do not match';
    return null;
  }
}
