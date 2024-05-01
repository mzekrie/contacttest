import 'package:bloc/bloc.dart';
import 'package:contacttest/Shared/cache_helper.dart';
import 'package:contacttest/Shared/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'themes_state.dart';

class ThemesCubit extends Cubit<ThemesState> {
  ThemesCubit() : super(ThemesInitial());
  static ThemesCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  void changeTheme() {
    isDark = !isDark;
    //print(isDark);
    CacheHelper.putBool(key: SharedKeys.themeMood, value: isDark);
    emit(ChangeThemesState());
  }

  getTheme(){
    isDark = CacheHelper.getBool(key: SharedKeys.themeMood);
  }
}
