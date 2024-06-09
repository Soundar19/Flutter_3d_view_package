





import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/src/controllers/flutter_3d_controller.dart';
import 'package:flutter_3d_controller/src/data/datasources/i_flutter_3d_datasource.dart';
import 'package:flutter_3d_controller/src/data/repositories/flutter_3d_repository.dart';
import 'package:flutter_3d_controller/src/modules/model_viewer/model_viewer.dart';
import 'package:flutter_3d_controller/src/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Flutter3DViewer extends StatefulWidget {

  final String src;
  final String? animationName;
  final Flutter3DController? controller;
  final bool? cameraControls;
  final bool? autoPlay;
  final bool? autoRotate;
  final String? cameraTarget;
  final String? cameraOrbit;
  //"0m 1.5m -0.5m"
  const Flutter3DViewer({super.key,required this.src,this.controller,this.autoPlay,this.autoRotate,this.cameraControls,this.animationName,this.cameraTarget,this.cameraOrbit});

  @override
  State<Flutter3DViewer> createState() => _Flutter3DViewerState();

}

class _Flutter3DViewerState extends State<Flutter3DViewer> {

  Flutter3DController? _controller;
  late String _id;
  final Utils _utils = Utils();

  @override
  void initState() {
    _id = _utils.generateId();
    _controller = widget.controller;
    _controller = widget.controller ?? Flutter3DController();
    if(kIsWeb){
      _controller?.init(Flutter3DRepository(IFlutter3DDatasource(null)));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      id: _id,
      src: widget.src,
      relatedJs: _utils.injectedJS(),
      ar: false,
      autoPlay: widget.autoPlay,
      autoRotate: widget.autoRotate,cameraOrbit:widget.cameraOrbit ,cameraTarget: widget.cameraTarget,
      debugLogging: false,cameraControls:widget.cameraControls,
      interactionPrompt: InteractionPrompt.none,animationName: widget.animationName,
      onWebViewCreated: kIsWeb ? null : (WebViewController value) {
        _controller?.init(Flutter3DRepository(IFlutter3DDatasource(value)));
      },
    );
  }

}

