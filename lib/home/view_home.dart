import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/home/page/laman_utama.dart';
import 'package:grave_apps/home/page/pengurusan_jenazah.dart';
import 'package:grave_apps/home/page/tetapan_view.dart';

import 'controller/home_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            User? user = snapshot.data;

            if (user == null) {
              debugPrint('User has been logout! Sign in anonymous');
            } else {
              debugPrint('User has been login');
            }
            return Obx(() => IndexedStack(
                  index: controller.index.value,
                  children: [
                    LamanUtamaView(controller: controller),
                    const PengurusanJenazahView(),
                    TetapanView(user: user),
                  ],
                ));
          }),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: (value) => controller.index.value = value,
          selectedIndex: controller.index.value,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Laman Utama',
            ),
            const NavigationDestination(
              icon: Icon(Icons.manage_accounts),
              selectedIcon: Icon(Icons.manage_accounts),
              label: 'Pengurusan',
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: 'Tetapan'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
