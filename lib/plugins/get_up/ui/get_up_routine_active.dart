const String getUpRoutineActive  = '''
import 'package:blue_tine_interpreted_components/interfaces/data/i_plugin_routine_step_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/data/get_up_routine_step_data.dart';
import 'package:blue_tine_interpreted_components/plugins/get_up/ui/get_up_routine_finished.dart';
import 'package:blue_tine_interpreted_components/plugins/plugin.enum.dart';
import 'package:blue_tine_interpreted_components/utils/_utils.export.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

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

  // final ValueNotifier<bool> stopwatchNotifier = ValueNotifier(false);

  final CountDownController controller = CountDownController();

  // final CountdownController newController = CountdownController();
  // late final CountdownTimer cd = CountdownTimer(data.routine.steps[stepIndex].duration, const Duration(seconds: 1), stopwatch: sw);

  // late final ValueNotifier<double> stepTime = ValueNotifier(data.routine.steps[stepIndex].duration.inSeconds.toDouble());

  @override
  void initState() {
    // TODO: implement initState
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
              /*
                  Countdown(
                    controller: newController,
                    seconds: routine.steps[stepIndex].duration.inSeconds,
                    interval: const Duration(milliseconds: 1000),
                    build: (BuildContext context, double time) {
                      stepTime.value = time.toInt();

                      return Text(time.toInt().toString());
                    },
                  )
              */
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
              /*                    SimpleCircularProgressBar(
                    size: size.shortestSide / 3 * 2,
                    progressStrokeWidth: 24,
                    backStrokeWidth: 24,
                    animationDuration: data.routine.steps[stepIndex].duration.inSeconds,
                    maxValue: data.routine.steps[stepIndex].duration.inSeconds.toDouble(),
                    mergeMode: true,
                    onGetText: (double time) => Text(
                      _getRemainingDuration(time.toInt()),
                      style: const TextStyle(fontSize: 40.0),
                    ),
                  )*/
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
                  routineData.routine.steps.length > stepIndex + 1 ? 'Next: routineData.routine.steps[stepIndex + 1].name.toString()' : 'Last Step!',
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
              )),
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

    _navigate();
  }

  void _finish() {
    _stop();

    stepData.end(duration: sw.elapsed);

    routineData.stepsData.add(stepData);

    _navigate();
  }

  _navigate() {
    if (routineData.routine.steps.length - 1 <= stepIndex) {
      routineData.end();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetUpRoutineFinished(PluginEnum.getUp, routineData)));

      return;
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetUpRoutineActive(routineData, stepIndex: stepIndex + 1)));
  }
}

''';
