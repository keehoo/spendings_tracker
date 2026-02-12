import 'package:domain/usecases/income_usecases.dart';
import 'package:domain/usecases/save_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendings_tracker/di/service_locator.dart';
import 'package:spendings_tracker/features/home_page/home_page.dart';
import 'package:spendings_tracker/features/home_page/home_page_cubit.dart';
import 'package:spendings_tracker/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(
    BlocProvider(create: (context) => ThemeCubit()..init(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (p, c) => p.themeMode != c.themeMode,
      builder: (context, state) {
        return MaterialApp(
          initialRoute: "/",
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
          themeMode: state.themeMode ?? ThemeMode.system,
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                HomePageCubit(
                    saveTransaction: sl<SaveTransaction>(),
                    saveIncome: sl<SaveIncome>(),
                    getTransactions: sl<GetTransactions>(),
                    getIncomes: sl<GetIncomes>(),
                  )
                  // Please let me explain why I do it like this :)
                  ..getAllTransactions(),
            child: const HomePage(),
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    // TODO: see what's best design for errors state
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text('ERROR')),
        );
      },
    );
  }
}
