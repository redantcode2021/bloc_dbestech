import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/blocs/worksout_cubit.dart';
import 'package:flutter_bloc_app_complete/screens/edit_workout_screen.dart';
import 'package:flutter_bloc_app_complete/screens/home_page.dart';
import 'package:flutter_bloc_app_complete/screens/workout_progress_screen.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const WorkoutTime()),
    storage: storage,
  );
}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Workouts',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Color.fromARGB(255, 66, 74, 96)),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutsCubit>(create: (BuildContext context) {
            WorkoutsCubit workoutsCubit = WorkoutsCubit();
            if (workoutsCubit.state.isEmpty) {
              print("... loading json data since the state is empty.");
              workoutsCubit.getWorkouts();
            } else {
              print("... get the  data due to changes on state");
            }
            return workoutsCubit;
          }),
          BlocProvider<WorkoutCubit>(
              create: (BuildContext context) => WorkoutCubit())
        ],
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: ((context, state) {
            if (state is WorkoutInitial) {
              return const HomePage();
            } else if (state is WorkoutEditing) {
              return const EditWorkoutScreen();
            }
            return const WorkoutInProgressScreen();
          }),
        ),
      ),
    );
  }
}
