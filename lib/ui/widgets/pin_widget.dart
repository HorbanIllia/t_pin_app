import 'package:flutter/material.dart';

typedef Null PinChangedCallback(String code);

class PinCodeView extends StatefulWidget{

  final int length;
  final double width;
  final PinChangedCallback onTextChanged;

  PinCodeView({
    Key key,
    @required this.length,
    @required this.onTextChanged,
    this.width = 40,
  }) : super(key: key);

  @override
  PinCodeViewState createState() => new PinCodeViewState();
}

class PinCodeViewState extends State<PinCodeView>{

  List<TextEditingController> _con;
  List<FocusNode> _focusNodes;
  Map<int, String> _passCode = {};

  void initState() {
    _con = List.generate(widget.length, (i) => TextEditingController());
    _focusNodes = List.generate(widget.length, (i) => FocusNode());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildPins(context,widget.length),
    );
  }

  List<Widget> _buildPins(BuildContext context, int length){
    List<Widget> fields = [];

    for(int i=0; i<length; i++){
      fields.add(_pinField(context,i));
    }

    return fields;
  }

  Widget _pinField(BuildContext context, int i){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      width: widget.width,
      child: TextField(
        controller: _con[i],
        focusNode: _focusNodes[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        autofocus: false,
        maxLines: 1,
        onChanged: (text){

          if(text.length > 1){
            _con[i].text = text.substring(text.length - 1);
          }
          if(text==""){
            FocusScope.of(context).requestFocus(i-1!=-1?_focusNodes[i-1]:null);
            _passCode[i] = null;
          } else {
            if(i!=widget.length-1){
              FocusScope.of(context).requestFocus(_focusNodes[i+1]);
            } else FocusScope.of(context).unfocus();
          }

          if (text == "") {
            _passCode[i] = null;
          } else {
            _passCode[i] = text.substring(text.length - 1);
          }
          String currentPasscode = "";
          for (int i = 0; i < widget.length; i++) {
            if(_passCode[i]!=null){
              currentPasscode+=_passCode[i];
            }
          }
          widget.onTextChanged(currentPasscode);
        },
      ),
    );
  }

  clearPinView(){
    for(TextEditingController controller in _con){
      _passCode.clear();
      controller.clear();
    }
  }

}