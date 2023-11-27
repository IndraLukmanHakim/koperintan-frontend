import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/providers/auth_provider.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController(text: '');

  TextEditingController usernameController = TextEditingController(text: '');

  TextEditingController nopolController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });
      if (await authProvider.register(
        name: nameController.text,
        // username: usernameController.text,
        nopol: nopolController.text,
        password: passwordController.text,
        phone: phoneController.text,
      )) {
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Gagal Daftar!, Pastikan Data yang anda masukan benar. Nama Lengkap, Nopol: KT1234KT , Password : 8 Karakter',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DAFTAR",
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Daftar dengan mengisi data dibawah ini",
              style: subtitleTextStyle.copyWith(),
            ),
          ],
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Lengkap',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Row(
                children: [
                  Image.asset(
                    'assets/icon_name.png',
                    width: 17,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: primaryTextStyle,
                      controller: nameController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Nama Lengkap',
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      );
    }

    Widget nopolInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor Polisi',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Row(
                children: [
                  Image.asset(
                    'assets/icon_email.png',
                    width: 17,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: primaryTextStyle,
                      controller: nopolController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'KT1234JR',
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      );
    }

    Widget phoneinput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor Telepon',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Row(
                children: [
                  Image.asset(
                    'assets/icon_chat.png',
                    width: 17,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: primaryTextStyle,
                      controller: phoneController,
                      decoration: InputDecoration.collapsed(
                        hintText: '08123456789',
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Row(
                children: [
                  Image.asset(
                    'assets/icon_password.png',
                    width: 17,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: primaryTextStyle,
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Password anda',
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      );
    }

    Widget signUpButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: handleSignUp,
          // () {
          //   Navigator.pushNamed(context, '/home');
          // },
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          child: Text(
            'Daftar',
            style:
                primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
        ),
      );
    }

    Widget loadingButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: handleSignUp,
          // () {
          //   Navigator.pushNamed(context, '/home');
          // },
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          child: Text(
            'Loading..',
            style:
                primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Sudah punya Akun? ',
            style: subtitleTextStyle.copyWith(fontSize: 12, fontWeight: medium),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Log in',
              style: purpleTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
          )
        ]),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              nameInput(),
              phoneinput(),
              nopolInput(),
              passwordInput(),
              isLoading ? loadingButton() : signUpButton(),
              Spacer(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}



// class SignInPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor1,
//       body: Center(
//         child: Container(
//           width: 130,
//           height: 150,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(
//                 'assets/logo.png',
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   };
// }