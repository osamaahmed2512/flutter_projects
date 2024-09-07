import 'package:bloc/bloc.dart';
import 'bottom_navbar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(NoTabSelectedState());

  void selectTab(int index) {
    emit(TabSelectedState(index));
  }
}
