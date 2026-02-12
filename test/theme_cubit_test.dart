import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendings_tracker/theme_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeCubit', () {
    late ThemeCubit themeCubit;

    setUp(() {
      themeCubit = ThemeCubit();
    });

    tearDown(() {
      themeCubit.close();
    });

    test('initial state has null themeMode', () {
      expect(themeCubit.state.themeMode, isNull);
    });

    group('changeMode', () {
      blocTest<ThemeCubit, ThemeState>(
        'emits ThemeState with light mode when light mode is selected',
        setUp: () {
          SharedPreferences.setMockInitialValues({});
        },
        build: () => ThemeCubit(),
        act: (cubit) => cubit.changeMode({ThemeMode.light}),
        expect: () => [ThemeState(themeMode: ThemeMode.light)],
        verify: (_) async {
          final sp = await SharedPreferences.getInstance();
          expect(sp.getString('theme'), 'light');
        },
      );

      blocTest<ThemeCubit, ThemeState>(
        'emits ThemeState with dark mode when dark mode is selected',
        setUp: () {
          SharedPreferences.setMockInitialValues({});
        },
        build: () => ThemeCubit(),
        act: (cubit) => cubit.changeMode({ThemeMode.dark}),
        expect: () => [ThemeState(themeMode: ThemeMode.dark)],
        verify: (_) async {
          final sp = await SharedPreferences.getInstance();
          expect(sp.getString('theme'), 'dark');
        },
      );

      blocTest<ThemeCubit, ThemeState>(
        'emits ThemeState with system mode when system mode is selected',
        setUp: () {
          SharedPreferences.setMockInitialValues({});
        },
        build: () => ThemeCubit(),
        act: (cubit) => cubit.changeMode({ThemeMode.system}),
        expect: () => [ThemeState(themeMode: ThemeMode.system)],
        verify: (_) async {
          final sp = await SharedPreferences.getInstance();
          expect(sp.getString('theme'), 'system');
        },
      );

      blocTest<ThemeCubit, ThemeState>(
        'emits ThemeState with null when empty set is provided',
        setUp: () {
          SharedPreferences.setMockInitialValues({});
        },
        build: () => ThemeCubit(),
        act: (cubit) => cubit.changeMode({}),
        expect: () => [ThemeState(themeMode: null)],
        verify: (_) async {
          final sp = await SharedPreferences.getInstance();
          expect(sp.getString('theme'), '');
        },
      );

      blocTest<ThemeCubit, ThemeState>(
        'persists theme mode to SharedPreferences',
        setUp: () {
          SharedPreferences.setMockInitialValues({});
        },
        build: () => ThemeCubit(),
        act: (cubit) async {
          await cubit.changeMode({ThemeMode.dark});
          await cubit.changeMode({ThemeMode.light});
        },
        expect: () => [
          ThemeState(themeMode: ThemeMode.dark),
          ThemeState(themeMode: ThemeMode.light),
        ],
        verify: (_) async {
          final sp = await SharedPreferences.getInstance();
          expect(sp.getString('theme'), 'light');
        },
      );
    });

    group('init', () {
      blocTest<ThemeCubit, ThemeState>(
        'loads saved light theme from SharedPreferences',
        setUp: () {
          SharedPreferences.setMockInitialValues({'theme': 'light'});
        },
        build: () => ThemeCubit(),
        act: (cubit) => cubit.init(),
        expect: () => [ThemeState(themeMode: ThemeMode.light)],
      );

      blocTest<ThemeCubit, ThemeState>(
        'loads saved dark theme from SharedPreferences',
        setUp: () {
          SharedPreferences.setMockInitialValues({'theme': 'dark'});
        },
        build: () => ThemeCubit(),
        act: (cubit) => cubit.init(),
        expect: () => [ThemeState(themeMode: ThemeMode.dark)],
      );

      blocTest<ThemeCubit, ThemeState>(
        'loads saved system theme from SharedPreferences',
        setUp: () {
          SharedPreferences.setMockInitialValues({'theme': 'system'});
        },
        build: () => ThemeCubit(),
        act: (cubit) => cubit.init(),
        expect: () => [ThemeState(themeMode: ThemeMode.system)],
      );

      blocTest<ThemeCubit, ThemeState>(
        'does not emit when no theme is saved',
        setUp: () {
          SharedPreferences.setMockInitialValues({});
        },
        build: () => ThemeCubit(),
        act: (cubit) => cubit.init(),
        expect: () => [],
      );

      blocTest<ThemeCubit, ThemeState>(
        'does not emit when empty theme string is saved',
        setUp: () {
          SharedPreferences.setMockInitialValues({'theme': ''});
        },
        build: () => ThemeCubit(),
        act: (cubit) => cubit.init(),
        expect: () => [],
      );
    });

    group('integration tests', () {
      blocTest<ThemeCubit, ThemeState>(
        'changing mode and reinitializing restores the saved theme',
        setUp: () {
          SharedPreferences.setMockInitialValues({});
        },
        build: () => ThemeCubit(),
        act: (cubit) async {
          await cubit.changeMode({ThemeMode.dark});
          await cubit.close();

          // Create new cubit instance to simulate app restart
          final newCubit = ThemeCubit();
          await newCubit.init();
          return newCubit;
        },
        skip: 1,
        verify: (cubit) async {
          expect(cubit.state.themeMode, ThemeMode.dark);
        },
      );
    });
  });
}
