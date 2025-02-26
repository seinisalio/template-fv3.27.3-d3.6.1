import 'package:flutter_bloc/flutter_bloc.dart';

import 'demo_event.dart';
import 'demo_state.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  
  DemoBloc()
    : super(DemoUpdateState(0)
  ) { 
    on<IncrementCounterEvent>(_onIncrementCounterEvent);
  }

  void _onIncrementCounterEvent(
    IncrementCounterEvent event,
    Emitter<DemoState> emit,
  ) async {
    var counter = state.counter;
    counter++;
    emit(DemoUpdateState(counter));
  }
}
