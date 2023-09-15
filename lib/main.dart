import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'credentials.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dialer(),
    ),
  );
}

class Dialer extends StatefulWidget {
  const Dialer({Key? key}) : super(key: key);

  @override
  State<Dialer> createState() => _DialerState();
}

class _DialerState extends State<Dialer> {
  static final TextEditingController _username = TextEditingController();
  static final TextEditingController _roomId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                controller: _username,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Room Id",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                controller: _roomId,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text("Join Room"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallPage(
                        username: _username.text,
                        callRoomId: _roomId.text,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  final String username;
  final String callRoomId;

  const CallPage({
    super.key,
    required this.username,
    required this.callRoomId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltVideoConference(
          appID: Credentials.appId,
          appSign: Credentials.appSignIn,
          userID: const Uuid().v4(),
          userName: username,
          conferenceID: callRoomId,
          config: videoConferenceConfiguration(),
        ),
      ),
    );
  }

  ZegoUIKitPrebuiltVideoConferenceConfig videoConferenceConfiguration() {
    return ZegoUIKitPrebuiltVideoConferenceConfig()
      ..turnOnCameraWhenJoining = false
      ..turnOnMicrophoneWhenJoining = false;
  }

  // ZegoUIKitPrebuiltCallConfig callConfiguration() {
  //   return ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
  //     ..turnOnMicrophoneWhenJoining = true
  //     ..onOnlySelfInRoom = (context) => Navigator.pop(context);
  // }
}
