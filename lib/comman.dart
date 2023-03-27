import 'package:flutter/material.dart';

class ProgressLoader {
  BuildContext? _context, _dismissingContext;
  bool _barrierDismissible = true, _showLogs = false, _isShowing = false;

  final double _dialogElevation = 8.0, _borderRadius = 8.0;
  final Color _backgroundColor = Colors.green;
  final Curve _insetAnimCurve = Curves.easeInOut;

  ProgressLoader(BuildContext buildContext, {required bool isDismissible}) {
    _context = buildContext;
    _barrierDismissible = isDismissible;
  }

  bool isShowing() {
    return _isShowing;
  }

  Future<bool> hide() async {
    print("Here Fn Call");
    try {
      if (_isShowing) {
        print("Here if condition");
        _isShowing = false;
        Navigator.of(_dismissingContext!).pop();
        print("Here     2");
        if (_showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } else {
        print("Here else condition");
        if (_showLogs) debugPrint('ProgressDialog already dismissed');
        return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(err.toString());
      return Future.value(false);
    }
  }

  Future<bool> show() async {
    try {
      if (!_isShowing) {
        showDialog<dynamic>(
          context: _context!,
          barrierDismissible: _barrierDismissible,
          builder: (BuildContext context) {
            _dismissingContext = context;
            return WillPopScope(
              onWillPop: () async => _barrierDismissible,
              child: Dialog(
                  backgroundColor: _backgroundColor,
                  insetAnimationCurve: _insetAnimCurve,
                  insetAnimationDuration: const Duration(milliseconds: 100),
                  elevation: _dialogElevation,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_borderRadius))),
                  child: const LoaderBody()),
            );
          },
        );
        // Delaying the function for 200 milliseconds
        // [Default transitionDuration of DialogRoute]
        await Future.delayed(const Duration(milliseconds: 200));
        if (_showLogs) debugPrint('ProgressDialog shown');
        _isShowing = true;
        return true;
      } else {
        if (_showLogs) debugPrint("ProgressDialog already shown/showing");
        return false;
      }
    } catch (err) {
      _isShowing = false;
      debugPrint('Exception while showing the dialog');
      debugPrint(err.toString());
      return false;
    }
  }
}

class LoaderBody extends StatelessWidget {
  const LoaderBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              const SizedBox(
                width: 16.0,
              ),
              const Text(
                'Loading...',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
