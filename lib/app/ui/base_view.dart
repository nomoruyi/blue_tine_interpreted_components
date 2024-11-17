import 'package:blue_tine_interpreted_components/app/ui/pages/analytics_view.dart';
import 'package:blue_tine_interpreted_components/app/ui/pages/dashboard_view.dart';
import 'package:blue_tine_interpreted_components/app/ui/pages/settings_view.dart';
import 'package:blue_tine_interpreted_components/app/ui/pages/store_view.dart';
import 'package:flutter/material.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  late final List<Widget> _pages;

  final PageController _pageController = PageController(initialPage: 1);
  final ValueNotifier<int> _navBarIndex = ValueNotifier<int>(1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController.addListener(() {
      _navBarIndex.value = _pageController.page?.toInt() ?? 1;
    });

    _pages = [
      const StoreView(),
      const DashboardView(),
      const AnalyticsView(),
      const SettingsView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePageView(pages:_pages, controller: _pageController),
      bottomNavigationBar: BaseNavigationBar(controller: _pageController, navBarIndex: _navBarIndex),
    );
  }
}

class BasePageView extends StatefulWidget {
  const BasePageView({super.key, required this.pages, required this.controller});

  final List<Widget> pages;
  final PageController controller;

  @override
  State<BasePageView> createState() => _BasePageViewState();
}

class _BasePageViewState extends State<BasePageView> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: widget.controller,
      children: widget.pages,
    );
  }
}

class BaseNavigationBar extends StatelessWidget {
  const BaseNavigationBar({super.key, required this.controller, required this.navBarIndex});

  final PageController controller;
  final ValueNotifier<int> navBarIndex;

  void _controlPage(int pageIndex) {
    controller.animateToPage(pageIndex, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: navBarIndex,
        builder: (context, value, _) {
          return BottomNavigationBar(
            currentIndex: value,
            onTap: _controlPage,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                tooltip: 'Store',
                label: 'Store',
                activeIcon: Icon(
                  Icons.store,
                  color: Theme.of(context).colorScheme.primary,
                  size: 36.0,
                ),
                icon: Icon(
                  Icons.store_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 36.0,
                ),
              ),
              BottomNavigationBarItem(
                tooltip: 'Dashboard',
                label: 'Dashboard',
                activeIcon: Icon(
                  Icons.dashboard_customize,
                  color: Theme.of(context).colorScheme.primary,
                  size: 36.0,
                ),
                icon: Icon(
                  Icons.dashboard_customize_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 36.0,
                ),
              ),
              BottomNavigationBarItem(
                tooltip: 'Analysis',
                label: 'Analysis',
                activeIcon: Icon(
                  Icons.analytics,
                  color: Theme.of(context).colorScheme.primary,
                  size: 36.0,
                ),
                icon: Icon(
                  Icons.analytics_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 36.0,
                ),
              ),
              BottomNavigationBarItem(
                tooltip: 'Settings',
                label: 'Settings',
                activeIcon: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                  size: 36.0,
                ),
                icon: Icon(
                  Icons.settings_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 36.0,
                ),
              ),
            ],
          );
        });
  }
}
