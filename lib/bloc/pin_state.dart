part of 'pin_bloc.dart';

abstract class PinState extends Equatable {
  const PinState();
}

class PinInitial extends PinState {
  const PinInitial();
  @override
  List<Object> get props => [];
}

class PinResultLoading extends PinState {
  const PinResultLoading();
  @override
  List<Object> get props => null;
}

class PinResultLoaded extends PinState {
  final Pin pinR;
  const PinResultLoaded(this.pinR);
  @override
  List<Object> get props => [pinR];
}

class PinError extends PinState {
  final String message;
  const PinError(this.message);
  @override
  List<Object> get props => [message];
}