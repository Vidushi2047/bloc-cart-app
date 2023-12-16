// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  ThemeData themeData;
  ThemeState({
    required this.themeData,
  });

  ThemeState copyWith({
    ThemeData? themeData,
  }) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
    );
  }

  @override
  String toString() => 'ThemeState(themeData: $themeData)';

  @override
  // TODO: implement props
  List<Object?> get props => [themeData];
}
