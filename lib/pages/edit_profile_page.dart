import 'package:flutter/material.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class EditProfilePage extends StatelessWidget {
  // Define controllers for each TextFormField
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  EditProfilePage({super.key});

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
          'Edit Profile',
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

    Widget editProfileButton(BuildContext context) {
      final authProvider = Provider.of<AuthProvider>(context);

      return ElevatedButton(
        onPressed: () async {
          if (await authProvider.editProfile(
            name: nameController.text,
            // nopol: usernameController.text,
            phone: phoneNumberController.text,
          )) {
            // Profile edit successful
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Berhasil edit profile'),
              ),
            );
            Navigator.pop(context);
          } else {
            // Profile edit failed, show an error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Gagal edit profile'),
              ),
            );
          }
        },
        child: const Text('Edit Profile'),
      );
    }

    Widget nameInput() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: nameController, // Assign the controller
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: 'Nama',
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
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

    Widget usernameInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor Polisi',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: usernameController, // Assign the controller
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: 'KT-1234-JR',
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
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

    Widget phoneNumberInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor Handphone',
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: phoneNumberController, // Assign the controller
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: 'Nomor Handphone',
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
              keyboardType: TextInputType.phone,
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
            nameInput(),
            // usernameInput(),
            // emailInput(),
            phoneNumberInput(), // Add the phone number input field

            // add the button
            const SizedBox(height: 30),
            editProfileButton(context),
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
