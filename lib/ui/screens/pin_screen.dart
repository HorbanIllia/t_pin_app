import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_pin_app/bloc/pin_bloc.dart';
import 'package:t_pin_app/ui/widgets/pin_widget.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => new _PinScreenState();
}

class _PinScreenState extends State<PinScreen>{

  final GlobalKey<PinCodeViewState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {

    PinBloc _pinBloc = PinBloc();
    _pinBloc.listen((state) {
      if (state is PinInitial) {
        return _buildLoading();
      } else if (state is PinResultLoading) {
        return _buildLoading();
      } else if (state is PinResultLoaded) {
        Navigator.of(context).pop();
        return showMessage(state.pinR.message);
      } else if (state is PinError) {
        return print("error");
      }
    });

    String _code;

    return BlocProvider(
      create: (_)=>_pinBloc,
      child: Builder(
        builder: (context){
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Enter the code to access"),
                    PinCodeView(
                      key: _key,
                      length: 4,
                      width: 50,
                      onTextChanged: (code){
                        _code = code;
                      },),
                    TextButton(
                        onPressed: (){
                          _code!=null?BlocProvider.of<PinBloc>(context).add(GetPinResult(_code))
                              :showMessage("The pin code must not be empty");
                        },
                        child: Text("ok")),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showMessage(String message){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: (){
                  _key.currentState.clearPinView();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _buildLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

}