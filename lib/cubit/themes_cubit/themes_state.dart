part of 'themes_cubit.dart';

@immutable
sealed class ThemesState {}

final class ThemesInitial extends ThemesState {}
class ChangeThemesState extends ThemesState {}
