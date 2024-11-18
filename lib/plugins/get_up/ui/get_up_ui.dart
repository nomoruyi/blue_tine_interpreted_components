const String get_up_ui = '''
import 'package:blue_tine_interpreted_components/interfaces/controller/plugin_controller.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/get_up.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin_manager.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:blue_tine_interpreted_components/utils/format_util.dart';
import 'package:flutter/material.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_step.dart';
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_step_data.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:blue_tine_interpreted_components/app/ui/widgets/blue_step_tile.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class GetUpView extends StatefulWidget {
  const GetUpView( {super.key});

  @override
  State<GetUpView> createState() => _PluginGetUpState();
}

class _PluginGetUpState extends State<GetUpView> {
  final PluginController routineCubit = PluginManager.controller(PluginEnum.getUp);
  final GetUpData data = GetUpData(PluginEnum.getUp, description: 'A routine for waking up');

  final GetUpRoutine routine = GetUp.getUpRoutine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(data.name),
          subtitle: Text(data.description),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () => print('Push "Step"'),
                  title: Text(routine.steps[index].name),
                  leading: const Icon(Icons.add),
                  trailing: Text(routine.steps[index].duration.formatDuration()),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 8.0),
            itemCount: routine.steps.length),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: IconButton.filled(
        onPressed: () => _startRoutine(context),
        icon: const Icon(Icons.play_arrow_rounded, size: 40.0),
      ),
    );
  }

  void _startRoutine(BuildContext context) async {
    GetUpRoutineData routineData = GetUpRoutineData(routine)
      ..start();

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetUpRoutineActive(routineData, stepIndex: 0)));
  }
}


class GetUpStep extends StatelessWidget {
  final GetUpRoutineStep data;

  const GetUpStep( this.data, {super.key, required});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Text(data.name))
          ],
        ),
      ),
    );
  }
}


class GetUpRoutineFinished extends StatefulWidget {
  const GetUpRoutineFinished(this.data, {super.key});

  final GetUpRoutineData data;

  @override
  State<GetUpRoutineFinished> createState() => _GetUpRoutineFinishedState();
}

class _GetUpRoutineFinishedState extends State<GetUpRoutineFinished> with AutomaticKeepAliveClientMixin {
  late final GetUpRoutineData routineData = widget.data;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        leading: const IconButton.filled(
          onPressed: null,
          icon: Icon(Icons.menu_rounded, size: 24.0),
        ),
        actions: [
          IconButton.filled(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded, size: 24.0),
          ),
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
                                        onTapOutside: (_) {
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
                ),
              ),
            ],
          );
        });
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
  final PluginController _routineCubit = PluginManager.controller(PluginEnum.getUp);

  void _back() {
    widget.pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  Future<void> _finish(BuildContext context) async {
    await _routineCubit.saveRoutine(widget.routineData);

    if (context.mounted) {
      Navigator.of(context).popUntil((s) => s.settings.name == '/');
    }
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
                    'Total Duration: ' + widget.routineData.duration.formatDuration(),
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
                onPressed: () => _finish(context),
                child: Text('Done', style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.bodyMedium!.color)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



class GetUpRoutineActive extends StatefulWidget {
  const GetUpRoutineActive(this.data, {super.key, required this.stepIndex});

  final GetUpRoutineData data;
  final int stepIndex;

  @override
  State<GetUpRoutineActive> createState() => _GetUpRoutineActiveState();
}

class _GetUpRoutineActiveState extends State<GetUpRoutineActive> {
  late final GetUpRoutineData routineData = widget.data;
  late final int stepIndex = widget.stepIndex;
  late final IPluginRoutineStepData stepData = GetUpRoutineStepData(routineData.routine.steps[stepIndex])..start();

  late final Size size = MediaQuery.of(context).size;

  final Stopwatch sw = Stopwatch();

  final CountDownController controller = CountDownController();

  @override
  void initState() {
    super.initState();

    _start();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              flex: 2,
              child: Text(
                stepData.step.name,
                style: const TextStyle(fontSize: 40.0),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.person_rounded, size: 56.0),
              ),
              CircularCountDownTimer(
                controller: controller,
                width: size.width * 2 / 3,
                height: size.width * 2 / 3,
                duration: stepData.step.duration.inSeconds,
                fillColor: Theme.of(context).colorScheme.primary,
                ringColor: Theme.of(context).colorScheme.onPrimary,
                strokeWidth: 24.0,
                strokeCap: StrokeCap.round,
                isReverse: true,
                isReverseAnimation: true,
                textStyle: TextStyle(fontSize: 40.0, color: Theme.of(context).textTheme.titleMedium?.color),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  sw.isRunning ? stepData.step.duration.formatDuration() : 'Paused',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  routineData.routine.steps.length > stepIndex + 1 ? 'Next: ' + routineData.routine.steps[stepIndex + 1].name : 'Last Step!',
                  style: const TextStyle(fontSize: 24.0),
                ),
              )
            ],
          ),
          Flexible(
            flex: 3,
            child: sw.isRunning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton.filled(onPressed: _pause, icon: const Icon(Icons.pause_rounded, size: 40.0)),
                      IconButton.filled(onPressed: _finish, icon: const Icon(Icons.check_rounded, size: 40.0)),
                      IconButton.filled(onPressed: _skip, icon: const Icon(Icons.skip_next_rounded, size: 40.0))
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton.filled(onPressed: _resume, icon: const Icon(Icons.play_arrow_rounded, size: 40.0)),
                      IconButton.filled(onPressed: _restart, icon: const Icon(Icons.restart_alt_rounded, size: 40.0)),
                      IconButton.filled(onPressed: _skip, icon: const Icon(Icons.skip_next_rounded, size: 40.0))
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void _start() {
    setState(() {
      sw.start();
      controller.start();
    });
  }

  void _pause() {
    setState(() {
      sw.stop();
      controller.pause();
    });
  }

  void _resume() {
    setState(() {
      sw.start();
      controller.resume();
    });
  }

  void _restart() {
    setState(() {
      sw.reset();
      sw.start();
      controller.restart();
    });
  }

  void _stop() {
    setState(() {
      sw.stop();
      controller.pause();
    });
  }

  void _skip() {
    _stop();

    stepData.skipped = true;

    routineData.stepsData.add(stepData);

    _navigate(context);
  }

  void _finish() {
    _stop();

    stepData.end(duration: sw.elapsed);

    routineData.stepsData.add(stepData);

    _navigate(context);
  }

  Future<void> _navigate(BuildContext context) async {
    if (routineData.routine.steps.length - 1 <= stepIndex) {
      routineData.end();

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetUpRoutineFinished(routineData)));
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetUpRoutineActive(routineData, stepIndex: stepIndex + 1)));
    }
  }
}


''';


