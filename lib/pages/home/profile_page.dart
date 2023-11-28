// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pos/providers/page_provider.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;

    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(
              defaultMargin,
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/icon_profile.png',
                    width: 64,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hallo, ${user?.name}!',
                        style: primaryTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        'Point anda: ${user?.point}',
                        style: subtitleTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    authProvider.logout(authProvider.user!.token!);
                    print(authProvider.user!.token!);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/sign-in', (route) => false);
                  },
                  child: Image.asset(
                    'assets/button_exit.png',
                    width: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem(String text) {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            Icon(
              Icons.chevron_right,
              color: primaryTextColor,
            )
          ],
        ),
      );
    }

    launchWhatsapp() async {
      var text = "Hello,  "
          " Saya ${authProvider.user?.name} dengan nopol ${authProvider.user?.nopol} ingin bertanya mengenai produk yang saya beli melalui aplikasi Koper Intan";
      var whatsapp = "6285171701900";
      var whatsappAndroid =
          Uri.parse("whatsapp://send?phone=$whatsapp&text=$text");
      if (await canLaunchUrl(whatsappAndroid)) {
        await launchUrl(whatsappAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("WhatsApp is not installed on the device"),
          ),
        );
      }
    }

    Widget content() {
      return Expanded(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        decoration: BoxDecoration(color: backgroundColor3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Account',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/edit-profile');
              },
              child: menuItem('Edit Profile'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/change-password');
              },
              child: menuItem(
                'Ganti Password',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/status-order');
              },
              child: menuItem(
                'Pesanan Anda',
              ),
            ),
            GestureDetector(
              onTap: () {
                launchWhatsapp();
              },
              child: menuItem(
                'Help',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Text(
            //   'General',
            //   style:
            //       primaryTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            // ),
            // menuItem(
            // 'Privacy & Policy',
            // ),
            // // menuItem(
            //   'Term of Service',
            // ),
            // menuItem(
            //   'Contact',
            // ),
          ],
        ),
      ));
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
