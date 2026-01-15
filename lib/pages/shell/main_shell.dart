import 'package:dinhhaitrieu/core/theme/colorSystem.dart';
import 'package:dinhhaitrieu/pages/home/home_screen.dart';
import 'package:dinhhaitrieu/pages/search/searchScreen.dart';
import 'package:flutter/material.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final _pages = const [
    HomeScreen(),
    Searchscreen(),
    _ComingSoonPage(title: "Saved"),
    _ComingSoonPage(title: "Profile"),
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary500, AppColors.primary600],
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   // MaterialPageRoute(builder: (context) => const onboarding()),
            // );
          },
          shape: const CircleBorder(),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const Icon(Icons.add, color: Colors.white, size: 35),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: _BottomBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final inactive = Colors.grey.shade400;
    const active = Color(0xFFD6B000);

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 20,
      elevation: 8,
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 12),
                _NavItem(
                  icon: Icons.home_rounded,
                  isActive: currentIndex == 0,
                  activeColor: active,
                  inactiveColor: inactive,
                  onTap: () => onTap(0),
                ),
                _NavItem(
                  icon: Icons.search_rounded,
                  isActive: currentIndex == 1,
                  activeColor: active,
                  inactiveColor: inactive,
                  onTap: () => onTap(1),
                ),
              ],
            ),

            Row(
              children: [
                _NavItem(
                  icon: Icons.bookmark_border_rounded,
                  isActive: currentIndex == 2,
                  activeColor: active,
                  inactiveColor: inactive,
                  onTap: () => onTap(2),
                ),
                _NavItem(
                  icon: Icons.person_outline_rounded,
                  isActive: currentIndex == 3,
                  activeColor: active,
                  inactiveColor: inactive,
                  onTap: () => onTap(3),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeColor;
  final Color inactiveColor;

  const _NavItem({
    required this.icon,
    required this.isActive,
    required this.onTap,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      splashRadius: 22,
      icon: Icon(icon, size: 26, color: isActive ? activeColor : inactiveColor),
    );
  }
}

class _ComingSoonPage extends StatelessWidget {
  final String title;
  const _ComingSoonPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          "$title (Coming soon)",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
