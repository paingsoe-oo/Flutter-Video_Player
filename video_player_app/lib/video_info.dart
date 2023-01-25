import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {


  List info = [];
  bool _playArea = false;
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;

  _initData() async {
    await DefaultAssetBundle.of(context).loadString("json/videoinfo.json").then((value){
      setState(() {
        info = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }


  @override
  void dispose() {
    super.dispose();
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _playArea == false ? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.AppColor.gradientFirst.withOpacity(0.8),
              color.AppColor.gradientSecond,
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          )
        ) : BoxDecoration(
          color: color.AppColor.gradientSecond,
        ),
        child: Column(
          children: [
            _playArea == false ? Container(
              padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios, size: 20,
                          color: color.AppColor.secondPageIconColor
                        ),
                      ),
                      Expanded(child: Container()),
                      Icon(
                          Icons.info_outline, size: 20,
                          color: color.AppColor.secondPageIconColor
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text(
                    "Legs Toning",
                    style: TextStyle(
                      fontSize: 25,
                      color: color.AppColor.secondPageTitleColor,
                    )
                  ),
                  SizedBox(height: 5),
                  Text(
                      "and Glutes Workout",
                      style: TextStyle(
                        fontSize: 25,
                        color: color.AppColor.secondPageTitleColor,
                      )
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.AppColor.secondPageContainerGradient1stColor,
                              color.AppColor.secondPageContainerGradient2ndColor,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer,
                              size: 20,
                              color: color.AppColor.secondPageIconColor,
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "60 min",
                              style: TextStyle(
                                fontSize: 16,
                              )
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 10, ),
                      Container(
                        width: 250,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.AppColor.secondPageContainerGradient1stColor,
                              color.AppColor.secondPageContainerGradient2ndColor,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.handyman_outlined,
                              size: 20,
                              color: color.AppColor.secondPageIconColor,
                            ),
                            SizedBox(height: 5,),
                            Text(
                                "Resistent band, kettebell",
                                style: TextStyle(
                                  fontSize: 16,
                                )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ) : Container(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 30,
                      right: 30,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            debugPrint("tapped");
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: color.AppColor.secondPageTopIconColor,
                          ),
                        ),
                        Expanded(child: Container(),),
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: color.AppColor.secondPageTopIconColor,
                        )
                      ],
                    ),
                  ),
                  _playView(context),
                  _controlView(context),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  )
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Text(
                          "Circuit 1: Legs Toning",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: color.AppColor.circuitsColor,
                          )
                        ),
                        Expanded(child: Container(),),
                        Row(
                          children: [
                            Icon(
                              Icons.loop,
                              size: 30,
                              color: color.AppColor.loopColor
                            ),
                            SizedBox(width: 10, ),
                            Text(
                              "3 sets",
                              style: TextStyle(
                                fontSize: 15,
                                color: color.AppColor.setsColor,
                              )
                            ),
                            SizedBox(width: 20,)
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 20,),
                    Expanded(
                      child: _listView(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;

    if(controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16/9,
        child: VideoPlayer(
          controller
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16/9,
        child: Center(
          child: Text(
            "Preparing....",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white60,
            )
          ),
        ),
      );
    }
  }

  Widget _controlView(BuildContext context) {

    final noMute = (_controller?.value?.volume??0) > 0;

    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      color: color.AppColor.gradientSecond,
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(50, 0, 0, 0),
                    )
                  ]
                ),
                child: Icon(
                  noMute?Icons.volume_up:Icons.volume_off,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              if(noMute) {
                _controller?.setVolume(0);
              } else {
                _controller?.setVolume(1.0);
              }
              setState(() {

              });
            },
          ),
          FlatButton(
            onPressed: () async {
              final index = _isPlayingIndex - 1;
              if(index >= 0 && info.length >= 0) {
                _onTapVideo(index);
              } else {
                Get.snackbar(
                    "Video List",
                    "",
                    snackPosition: SnackPosition.BOTTOM,
                    icon: Icon(
                      Icons.face,
                      size: 30,
                      color: Colors.white,
                    ),
                    backgroundColor: color.AppColor.gradientSecond,
                    colorText: Colors.white,
                    messageText: Text(
                      "No videos ahead !",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )
                );
              }
            },
            child: Icon(
              Icons.fast_rewind,
              size: 36,
              color: Colors.white,
            ),
          ),
          FlatButton(
            onPressed: () async {
              if(_isPlaying) {
                setState(() {
                  _isPlaying = false;
                });
                _controller?.pause();
              }else{
                setState(() {
                  _isPlaying = true;
                });
                _controller?.play();
              }
            },
            child: Icon( _isPlaying ? Icons.pause :
              Icons.play_arrow,
              size: 36,
              color: Colors.white,
            ),
          ),
          FlatButton(
            onPressed: () async {
              final index = _isPlayingIndex + 1;
              if(index <= info.length - 1) {
                _onTapVideo(index);
              } else {
                Get.snackbar(
                    "Video List",
                    "",
                    snackPosition: SnackPosition.BOTTOM,
                    icon: Icon(
                      Icons.face,
                      size: 30,
                      color: Colors.white,
                    ),
                  backgroundColor: color.AppColor.gradientSecond,
                  colorText: Colors.white,
                  messageText: Text(
                    "No more videos in the list",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                );
              }
            },
            child: Icon(
              Icons.fast_forward,
              size: 36,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  var _onUpdateControllerTime;
  void _onControllerUpdate() async {

    if(_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().microsecondsSinceEpoch;
    if(_onUpdateControllerTime > now) {
      return;
    }

    _onUpdateControllerTime = now + 500;

    final controller = _controller;

    if(controller == null) {
      debugPrint("controller is null");
      return;
    }
    if(!controller.value.isInitialized) {
      debugPrint("controller can not be initialized");
      return;
    }

    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _onTapVideo(int i) {
    final controller = VideoPlayerController.network(
      info[i]["videoUrl"]
    );

    final old = _controller;

    _controller = controller;

    if(old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }

    setState(() {

    });

    controller..initialize().then((_){
      old?.dispose();
      _isPlayingIndex = i;
      controller.addListener(_onControllerUpdate);
      controller.play();
      setState(() {

      });
    });

  }

  _listView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      itemCount: info.length,
      itemBuilder: (_, i) {
        return GestureDetector(
          onTap: () {
            _onTapVideo(i);
            debugPrint(i.toString());
            setState(() {
              if(_playArea == false) {
                _playArea = true;
              }
            });
          },
          child: _buildCard(i),
        );
      },
    );
  }

  _buildCard(int i) {
    return Container(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                          info[i]["thumbnail"]
                      ),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info[i]["title"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      info[i]['time'],
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "15s rest",
                    style: TextStyle(
                      color: Color(0xFF839fed),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  for(int i = 0; i < 70; i++)
                    i.isEven ? Container(
                      width: 3,
                      height: 1,
                      decoration: BoxDecoration(
                        color: Color(0xFF839fed),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ) :
                    Container(
                      width: 3,
                      height: 1,
                      color: Colors.white,
                    )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
