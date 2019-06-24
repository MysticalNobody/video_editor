import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';

class DualAnimationLoopController implements FlareController {
  final String _startAnimationName;
  final String _loopAnimationName;
  final double _mix;

  DualAnimationLoopController(this._startAnimationName, this._loopAnimationName,
      [this._mix = 1.0]);
  bool firstActive = true;
  double _duration = 0.0;
  ActorAnimation _startAnimation;
  ActorAnimation _loopAnimation;

  @override
  void initialize(FlutterActorArtboard artboard) {
    _startAnimation = artboard.getAnimation(_startAnimationName);
    _loopAnimation = artboard.getAnimation(_loopAnimationName);
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _duration += elapsed;
    if (firstActive) if (_duration < _startAnimation.duration) {
      _startAnimation.apply(_duration, artboard, _mix);
    } else
      firstActive = false;
    _duration %= _loopAnimation.duration;
    _loopAnimation.apply(_duration, artboard, _mix);

    return true;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  @override
  ValueNotifier<bool> isActive = ValueNotifier<bool>(true);
}
