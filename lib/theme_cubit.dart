import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState());

  Future<void> changeMode(Set<ThemeMode> value) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString("theme", value.firstOrNull?.name ?? "");
    emit(state.copyWith(themeMode: value.firstOrNull));
  }

  Future<void> init() async {
    final sp = await SharedPreferences.getInstance();

    final String? themeName = sp.getString("theme");

    if (themeName != null && themeName.isNotEmpty) {
      changeMode({
        ThemeMode.values.firstWhere((element) => element.name == themeName),
      });
    } else {
      // TODO: @kubicki - add proper logger
      if (kDebugMode) {
        print("Did not find previously saved theme");
      }
    }
  }
}
