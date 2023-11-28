import 'package:flutter/material.dart';
import 'package:pos/pages/home/chat_page.dart';
import 'package:pos/pages/home/homepage.dart';
import 'package:pos/pages/home/profile_page.dart';
import 'package:pos/pages/home/wishlist_page.dart';
import 'package:pos/providers/auth_provider.dart';
import 'package:pos/providers/page_provider.dart';
import 'package:pos/theme.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../providers/transaction_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // int currentIndex = 0;

  @override
  // void initState()

  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    getStatus() async {
      // await Provider.of<TransactionProvider>(context, listen: false)
      //     .getStatus(authProvider.user!.token);
      await Provider.of<TransactionProvider>(context, listen: false)
          .getStatus(authProvider.getuserToken());
      await authProvider.updateuser(authProvider.user?.token);
    }

    Widget cartButton() {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        backgroundColor: secondaryColor,
        child: Image.asset(
          'assets/icon_cart.png',
          width: 20,
        ),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: blackColor,
                ),
              ),
            ),
            child: BottomNavigationBar(
                backgroundColor: backgroundColor4,
                // add border color

                currentIndex: pageProvider.currentIndex,
                onTap: (value) {
                  print(value);
                  pageProvider.currentIndex = value;
                  // setState(() {
                  //   currentIndex = value;
                  // });
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Image.asset(
                          'assets/icon_home.png',
                          width: 21,
                          color: pageProvider.currentIndex == 0
                              ? primaryColor
                              : const Color(0xff808191),
                        ),
                      ),
                      label: 'Beranda'),
                  BottomNavigationBarItem(
                      icon: Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Image.asset(
                          'assets/icon_wishlist.png',
                          width: 20,
                          color: pageProvider.currentIndex == 1
                              ? primaryColor
                              : const Color(0xff808191),
                        ),
                      ),
                      label: 'Favorit'),
                  BottomNavigationBarItem(
                      icon: badges.Badge(
                        showBadge:
                            transactionProvider.status.isEmpty ? false : true,
                        badgeContent: Text(
                          transactionProvider.totalstatus().toString(),
                          style: primaryTextStyle.copyWith(
                              fontSize: 10, fontWeight: medium),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Image.asset(
                            'assets/icon_chat.png',
                            width: 20,
                            color: pageProvider.currentIndex == 2
                                ? primaryColor
                                : const Color(0xff808191),
                          ),
                        ),
                      ),
                      label: 'Status'),
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Image.asset(
                        'assets/icon_profile.png',
                        width: 20,
                        color: pageProvider.currentIndex == 3
                            ? primaryColor
                            : const Color(0xff808191),
                      ),
                    ),
                    label: 'Profil',
                  ),
                ]),
          ),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          getStatus();

          return const HomePage();
          break;

        case 1:
          return const WhislistPage();
          break;
        case 2:
          return const ChatPage();
          break;
        case 3:
          return const ProfilPage();
          break;

        default:
          return const HomePage();
      }
    }

    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content:
          //         Text('Pop Screen Disabled. You cannot go to previous screen.'),
          //     backgroundColor: Colors.red,
          //   ),
          // );
          // return false;
        },
        child: Scaffold(
          backgroundColor: pageProvider.currentIndex == 0
              ? backgroundColor1
              : backgroundColor3,
          floatingActionButton: cartButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: customBottomNav(),
          body: body(),
        ));
    // return Scaffold(
    //   backgroundColor:
    //       pageProvider.currentIndex == 0 ? backgroundColor1 : backgroundColor3,
    //   floatingActionButton: cartButton(),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    //   bottomNavigationBar: customBottomNav(),
    //   body: body(),
    // );
  }
}
