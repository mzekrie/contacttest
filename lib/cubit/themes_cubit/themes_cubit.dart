import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'themes_state.dart';

class ThemesCubit extends Cubit<ThemesState> {
  ThemesCubit() : super(ThemesInitial());
  static ThemesCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  void changeTheme() {
    isDark = !isDark;
    emit(ChangeThemesState());
  }
}
