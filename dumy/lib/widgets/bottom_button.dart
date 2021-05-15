import 'package:flutter/material.dart';

class BottomBarButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;

  BottomBarButton({this.onPressed, this.buttonName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Expanded(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                this.onPressed();
              },
              child: this.buttonName != ""
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        this.buttonName,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Transform.scale(
                          scale: 0.7,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ]),
      ),
    );
  }
}
