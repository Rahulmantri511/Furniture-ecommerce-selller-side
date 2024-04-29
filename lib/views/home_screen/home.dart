import 'package:furniture_seller_side/const/const.dart';
import 'package:furniture_seller_side/controllers/home_controller.dart';
import 'package:furniture_seller_side/views/order_screen/order_screen.dart';
import 'package:furniture_seller_side/views/products_screen/products_screen.dart';
import 'package:furniture_seller_side/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var controller =  Get.put(HomeController());

    var navScreens = [
      ProductsScreen(),OrderScreen(),ProfileScreen()
    ];

    var bottomNavbar = [
      BottomBarItem(
          icon: Image.asset(icproducts,color: darkGrey,width: 26,),title: Text(products),backgroundColor: purpleColor),
      BottomBarItem(
          icon: Image.asset(icorders,color: darkGrey,width: 26),title: Text(orders),backgroundColor: purpleColor),
      BottomBarItem(
          icon: Image.asset(icgeneral_setting,color: darkGrey,width: 26),title: Text(settings),backgroundColor: purpleColor),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
            () =>StylishBottomBar(
          onTap: (index){
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          items: bottomNavbar,
          option: BubbleBarOptions(
              barStyle: BubbleBarStyle.vertical,
              bubbleFillStyle: BubbleFillStyle.fill,
              opacity: 0.3,
          ),
        ),
      ),
      body: Obx(() => Column(
        children: [
          Expanded(child: navScreens.elementAt(controller.navIndex.value)),
        ],
      )),
    );
  }
}
