
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/account_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/models/User.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:flutter_api_rest/utils/logs.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;

class HomePage extends StatefulWidget {
  static String routeName = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  final _accountApi = GetIt.instance<AccountApi>();
  final Logger _logger = Logger();
  User? _user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    final response = await _accountApi.getUserInfo();
    if (response.data != null) {
      Logs.p.i(response.data!.createdAt);
      _user = response.data!;
      setState(() {});
    }
  }

  Future<void> _signOut() async {
    _authenticationClient.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (route) => false,
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final Uint8List bytes = await pickedFile.readAsBytes();
      final filename = path.basename(pickedFile.path);
      final response = await _accountApi.updateAvatar(bytes, filename);
      if (response != null) {
        _user = _user!.copyWith(avatar: response.data);
        final String imageUrl = 'http://192.168.1.65:9000${response.data}';
        Logs.p.i(imageUrl);
        setState(() {});
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_user == null) CircularProgressIndicator(),
            if (_user != null)
              Column(
                children: [
                  if (_user!.avatar != null)
                    ClipOval(
                      child: Image.network(
                          'http://192.168.1.65:9000${_user!.avatar}',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Text(_user!.id),
                  Text(_user!.email),
                  Text(_user!.username),
                  Text(_user!.createdAt.toIso8601String())
                ],
              ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Update avatar'),
            ),
            ElevatedButton(
              onPressed: _signOut,
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
