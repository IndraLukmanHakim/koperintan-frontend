import 'package:flutter/material.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class ChangePasswordPage extends StatelessWidget {
  // Define controllers for each TextFormField
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController new_passwordController = TextEditingController();

  ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Ganti Password',
        ),
        actions: [
          IconButton(
            onPressed: (() {}),
            icon: Icon(
              Icons.check,
              color: primaryColor,
            ),
          )
        ],
      );
    }

    Widget changePasswordbutton(BuildContext context) {
      final authProvider = Provider.of<AuthProvider>(context);

      return ElevatedButton(
        onPressed: () async {
          bool success = await authProvider.changePassword(
            password: passwordController.text,
            new_password: new_passwordController.text,
          );

          if (success) {
            // Profile edit successful
            Navigator.pop(context);
          } else {
            // Profile edit failed, show an error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ganti Password Gagal!'),
              ),
            );
          }
        },
        child: const Text('Ganti Password'),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password Lama',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Masukkan Password Lama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget new_passwordInput() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password Baru',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: new_passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Masukkan Password Baru',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/icon_profile.png'),
                ),
              ),
            ),
            passwordInput(),

            new_passwordInput(),
            // emailInput(),

            // add the button
            changePasswordbutton(context),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
      // appBar: header(),
      // body: content(),
    );
  }
}
