import 'package:flutter/material.dart';

class SuffixCloseIcon extends StatefulWidget {
  final TextEditingController? textController;
  final VoidCallback? iconClicked;
  final Widget? iconWidget;
  const SuffixCloseIcon({Key? key,this.textController,this.iconClicked,this.iconWidget}) : super(key: key);

  @override
  _IconClearTextFormFiledState createState() => _IconClearTextFormFiledState(textController:textController);
}

class _IconClearTextFormFiledState extends State<SuffixCloseIcon> {
  String enteredValue = "";
  TextEditingController? textController;
  _IconClearTextFormFiledState({this.textController}){
    if(textController!=null){
      enteredValue = textController!.text;
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(textController!=null) {
      textController!.addListener(() {
        setState(() {
          enteredValue = textController!.text;
        });
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void didUpdateWidget(covariant SuffixCloseIcon oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    setState(() {
    if(widget.textController!=null){
      enteredValue = widget.textController!.text;
    }
    });
  }

  @override
  Widget build(BuildContext context) {

    return enteredValue.isNotEmpty?InkWell(onTap: ()=> widget.iconClicked?.call(),child: Container(child: widget.iconWidget!=null? widget.iconWidget!: const Icon(Icons.close),)): const SizedBox(width: 0,height: 0,);
  }
}
