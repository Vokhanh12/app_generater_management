import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rive/rive.dart';

class CustomModalProgressHub extends StatefulWidget {
  final Widget child;

  const CustomModalProgressHub({super.key, required this.child});

  @override
  State<CustomModalProgressHub> createState() => _CustomModalProgressHubState();
}

class _CustomModalProgressHubState extends State<CustomModalProgressHub> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: true,
      opacity: 0,
      progressIndicator: LayoutBuilder(
        builder: (context, constraints) {
          final double size = constraints.maxWidth.clamp(100.0, 300.0);
          return Center(
            child: SizedBox(
              width: size,
              height: size,
              child: RiveAnimation.asset(
                'assets/riv/material_loading.riv',
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
      child: widget.child,
    );
  }
}
