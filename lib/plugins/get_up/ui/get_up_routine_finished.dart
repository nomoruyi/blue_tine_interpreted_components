const String getUpRoutineFinished = '''
import 'package:blue_tine_interpreted_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_interpreted_components/app/ui/widgets/blue_step_tile.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/get_up_main.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin_manager.dart';
import 'package:blue_tine_interpreted_components/utils/_utils.export.dart';
import 'package:blue_tine_interpreted_components/interfaces/ui/i_plugin_stateful_widget.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GetUpRoutineFinished extends IPluginStatefulWidget {
  const GetUpRoutineFinished(super.plugin, this.data, {super.key});

  final GetUpRoutineData data;

  @override
  State<GetUpRoutineFinished> createState() => _GetUpRoutineFinishedState();
}

class _GetUpRoutineFinishedState extends State<GetUpRoutineFinished> with AutomaticKeepAliveClientMixin {
  final PluginController _routineCubit = PluginManager.plugins[GetUpP]!;
  late final GetUpRoutineData routineData = widget.data;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        leading: const IconButton.filled(
            onPressed: null,
            icon: Icon(
              Icons.menu_rounded,
              size: 24.0,
            )),
        actions: [
          IconButton.filled(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.close_rounded,
                size: 24.0,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: PageView(
          controller: _pageController,
          children: [
            _RatingPage(routineData, pageController: _pageController),
            _ResultPage(
              routineData,
              pageController: _pageController,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _RatingPage extends StatefulWidget {
  const _RatingPage(this.routineData, {required this.pageController});

  final GetUpRoutineData routineData;
  final PageController pageController;

  @override
  State<_RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<_RatingPage> {
  final ValueNotifier<bool> _ratedNotifier = ValueNotifier(false);
 late final TextEditingController _commentController = TextEditingController(text: widget.routineData.comment);

  void _next() {
    FocusManager.instance.primaryFocus?.unfocus();

    widget.pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
valueListenable: _ratedNotifier,
      builder: (context, rated, _) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Flexible(flex: 2, child: Text('How was your routine?', style: TextStyle(fontSize: 40.0), textAlign: TextAlign.center)),
            const Divider(height: 40.0, thickness: 0),
            Flexible(
                flex: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RatingBar.builder(
                            initialRating: widget.routineData.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            wrapAlignment: WrapAlignment.center,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemSize: 56.0,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber.getShadeColor(),
                            ),
                            onRatingUpdate: (double rating) {
                              if (!_ratedNotifier.value) _ratedNotifier.value = true;

                              widget.routineData.rating = rating;

                              if (kDebugMode) {
                                print(rating);
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 500),
                              reverseDuration: const Duration(milliseconds: 500),
                              curve: Curves.easeOutCirc,
                              child: rated
                                  ? TextField(
                                key: const ValueKey<bool>(true),
                                minLines: 3,
                                maxLines: 7,
                                controller: _commentController,
                                onTapOutside: (_){
                                  FocusManager.instance.primaryFocus?.unfocus();

                                },
                                onChanged: (String value) {
                                  widget.routineData.comment = value;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Take note of what you liked and how you can improve',
                                    hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5))),
                              )
                                  : const Text(
                                key: ValueKey<bool>(false),
                                'Please rate this Session',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            Flexible(
                flex: 1,
                child: ElevatedButton(
                  onPressed: rated ? _next : null,
                  child: Text('Next', style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.bodyMedium!.color)),
                )),
          ],
        );
      }
    );
  }
}

class _ResultPage extends StatefulWidget {
  const _ResultPage(this.routineData, {required this.pageController});

  final GetUpRoutineData routineData;
  final PageController pageController;

  @override
  State<_ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<_ResultPage> {
  final PluginController _routineCubit = PluginManager.plugins[GetUpP]!;

  void _back() {
    widget.pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  Future<void> _finish() async {

    _routineCubit.saveRoutine(widget.routineData).then((_){
      Navigator.of(context).popUntil((s)=> s.settings.name == '/');
   });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(flex: 2, child: Text(widget.routineData.routine.name, style: const TextStyle(fontSize: 40.0), textAlign: TextAlign.center)),
                Expanded(
                  flex: 3,
                  child: Scrollbar(
                    trackVisibility: false,
                    thumbVisibility: true,
                    thickness: 4.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.routineData.stepsData.length,
                      itemBuilder: (BuildContext context, int index) {
                        IPluginRoutineStepData stepData = widget.routineData.stepsData[index];

                        return BlueStepTile(stepData: stepData);
                      },
                    ),
                  ),
                ),
                const Flexible(flex: 0, child: Divider(height: 40.0, thickness: 4.0)),
                Flexible(
                  flex: 1,
                  child: Text(
                    'Total Duration: widget.routineData.duration.formatDuration().toString()',
                    style: const TextStyle(fontSize: 32.0),
                  ),
                ),
              ],
            )),
        Flexible(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _back,
                  child: Text('Back', style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.bodyMedium!.color)),
                ),
                ElevatedButton(
                  onPressed: _finish,
                  child: Text('Done', style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.bodyMedium!.color)),
                ),
              ],
            )),
      ],
    );
  }
}
''';