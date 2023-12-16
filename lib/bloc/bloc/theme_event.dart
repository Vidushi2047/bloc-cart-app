// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_bloc.dart';

class ThemeEvent extends Equatable {
  AppTheme appTheme;
  ThemeEvent({
    required this.appTheme,
  });

  @override
  List<Object?> get props => [appTheme];
}
