import 'package:equatable/equatable.dart';

abstract class BottomNavBarState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoTabSelectedState extends BottomNavBarState {}

class TabSelectedState extends BottomNavBarState {
  final int tabIndex;

  TabSelectedState(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
