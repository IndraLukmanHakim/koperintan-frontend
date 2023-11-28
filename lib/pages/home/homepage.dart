import 'package:flutter/material.dart';
import 'package:pos/models/user_model.dart';
import 'package:pos/pages/widgets/product_tile.dart';
import 'package:pos/providers/auth_provider.dart';
import 'package:pos/providers/category_provider.dart';
import 'package:pos/providers/page_provider.dart';
import 'package:pos/providers/product_provider.dart';
import 'package:pos/providers/wishlist_provider.dart';
import 'package:pos/theme.dart';
import 'package:pos/pages/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/transaction_provider.dart';
import '../widgets/category_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getInit();

    super.initState();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();

    await Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryList();

    // await Provider.of<WishlistProvider>(context, listen: false).loadWishlist();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    print(
        'Wishlist on startup: ${Provider.of<WishlistProvider>(context, listen: false).wishlist}');
    print(prefs.getString('token'));
    print(prefs.getString('wishlist'));
    print(prefs.containsKey('token'));
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;

    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);

    handlecategories(int index) async {
      setState(() {
        isLoading = true;
      });
      categoryProvider.selectCategory = index;

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Halo, ${user!.name} !",
                    style: primaryTextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold),
                  ),
                  Text(
                    "Poin anda : ${user.point}",
                    style: subtitleTextStyle.copyWith(
                        fontSize: 16, color: primaryTextColor),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                pageProvider.currentIndex = 3;
              },
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      user.profilePhotoUrl!,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget CategoriesTittle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Kategori',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget categories() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          top: defaultMargin,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categoryProvider.categoryLists
                .map(
                  (categoryList) => CategoryTile(categoryList),
                )
                .toList(),
          ),
        ),
      );
    }

    Widget popularProducts() {
      return Container(
          margin: const EdgeInsets.only(top: 14),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              // Text("${user!.name}"),
              SizedBox(
                width: defaultMargin,
              ),
              Row(
                // category set to current category

                children: categoryProvider.selectCategory == 0
                    ? productProvider.products
                        .map(
                          (product) => ProductCard(product),
                        )
                        .toList()
                    : productProvider.products
                        .where((product) =>
                            product.category!.id ==
                            categoryProvider.selectCategory)
                        .map(
                          (product) => ProductCard(product),
                        )
                        .toList(),

                // ],
              ),
            ]),
          ));
    }

    Widget newArrivalsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Produk Baru',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget newArrivals() {
      return Container(
        margin: const EdgeInsets.only(
          top: 14,
        ),
        child: Column(
          children: productProvider.products
              .map(
                (product) => ProductTile(product),
              )
              .toList(),
        ),
      );
    }

    getStatus() async {
      await Provider.of<TransactionProvider>(context, listen: false)
          .getStatus(authProvider.user!.token);
      await authProvider.updateuser(authProvider.user!.token);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 200));
        getStatus();
        pageProvider.currentIndex = 0;
      },
      child: ListView(
        children: [
          header(),
          CategoriesTittle(),
          categories(),
          popularProducts(),
          newArrivalsTitle(),
          newArrivals(),
        ],
      ),
    );
  }
}
