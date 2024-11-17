import 'package:blue_tine_interpreted_components/interfaces/controller/plugin_controller.dart';
import 'package:blue_tine_interpreted_components/app/ui/pages/analytics/plugin_analysis_view.dart';
import 'package:blue_tine_interpreted_components/app/ui/pages/analytics/summery_view.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin_manager.dart';
import 'package:flutter/material.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  List<Widget> tabs = [];
  List<Widget> pages = [];

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();

    tabs = getTabs();
    pages = getPages();
  }

  List<Widget> getTabs() {
    return [
      Tab(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Summery', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
        ),
      ),
      ...PluginManager.installedPlugins.map(( PluginController p) => Tab(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(p.plugin.name.toUpperCase(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900))))),
    ];
  }

  List<Widget> getPages() {
    return [
      const SummeryView(),
      ...PluginManager.installedPlugins.map(( PluginController p) => PluginAnalyticsView(p.plugin)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Analytics', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900)),
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(24.0)),
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: pages,
        ),
      ),
    );
  }
}
