part of 'pin_bloc.dart';

abstract class PinEvent extends Equatable {
  final String id;
  const PinEvent(this.id);
}

class GetPinResult extends PinEvent {
  GetPinResult(String id) : super(id);

  @override
  List<Object> get props => null;
}