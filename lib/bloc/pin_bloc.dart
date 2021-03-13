import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:t_pin_app/models/pin_model.dart';
import 'package:t_pin_app/util/api_repository.dart';

part 'pin_event.dart';
part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  final ApiRepository _apiRepository = ApiRepository();

  PinBloc() : super(null);

  @override
  PinState get initialState => PinInitial();

  @override
  Stream<PinState> mapEventToState(PinEvent event,) async* {
    if (event is GetPinResult) {
      try {
        yield PinResultLoading();
        final mPost = await _apiRepository.checkPin(event.id);
        yield PinResultLoaded(mPost);
        if (mPost == null)
        {
          yield PinError("error mapEvent");
        }
      } on NetworkError {
        yield PinError("Failed to fetch data. Please check your internet connection");
      }
    }
  }
}