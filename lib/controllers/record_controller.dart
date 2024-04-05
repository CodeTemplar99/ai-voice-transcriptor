import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:web_socket_channel/io.dart';

import 'package:alindor_tech/configs/error_handler.dart';

class RecordController with ChangeNotifier {
  FlutterSoundRecorder controller = FlutterSoundRecorder();
  RecorderStream voiceStream = RecorderStream();

  final String serverUrl =
      'wss://api.deepgram.com/v1/listen?encoding=linear16&sample_rate=16000&language=en-GB';
  final String apiKey = '<YOUR_DEEPGRAM_API_KEY>';

  late StreamSubscription recorderStatus;
  late StreamSubscription audioStream;

  late IOWebSocketChannel channel;
  // late RecorderStream voiceStream;

  String savedRecordsPath = 'audio_example.aac';

  PermissionStatus? hasPermission;

  bool isRecording = false;
  bool? hasRecord;
  bool? hasFinishedRecording;

  String transcript = '';

  // Initialize the stream connection to the WebSocket channel with the provided server URL and API key in the headers.
  // Listen to the stream events, parse the JSON data, check for new transcripts, and update the transcript string accordingly.
  // Initialize the voice and audio streams, and wait for the initialization process to complete.
  Future<void> initStream() async {
    channel = IOWebSocketChannel.connect(Uri.parse(serverUrl),
        headers: {'Authorization': 'Token $apiKey'});

    channel.stream.listen((event) async {
      final parsedJson = jsonDecode(event);
      String newTranscript =
          parsedJson['channel']['alternatives'][0]['transcript'];
      List<String> transcriptsList = transcript.split('\n');

      if (!transcriptsList.contains(newTranscript)) {
        transcript += ('$newTranscript\n');
        // Add the new transcript to the existing string
        notifyListeners();
        log(newTranscript);
      }
    });
    voiceStream = RecorderStream();
    audioStream = voiceStream.audioStream.listen((data) {
      channel.sink.add(data);
    });

    await Future.wait([
      voiceStream.initialize(),
    ]);
  }

  // Initialize the audio controller by requesting microphone permission asynchronously.
  Future<void> initAudioController() async {
    hasPermission = await Permission.microphone.request();
  }

  // dispose audio controller
  void disposeAudioController() {
    controller.closeRecorder();
  }

  // Start the audio recording process with the given BuildContext.
  Future startAudioRecording(BuildContext context) async {
    transcript = '';
    hasRecord = null;
    notifyListeners();
    try {
      if (hasPermission!.isGranted) {
        await controller.openRecorder().then(
              (value) => controller.startRecorder(
                toFile: savedRecordsPath,
                codec: Codec.aacADTS,
              ),
            );
        voiceStream.start();
        hasRecord = true;
        hasFinishedRecording = false;
        isRecording = true;
        notifyListeners();
        log('message: Recording started');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      openSnackBar(context, 'Recording Permission Denied');
      log('Error occurred: $e');
    }
  }

  // A function to stop the audio recording. It is asynchronous and does not take any parameters. It returns a Future.
  Future stopAudioRecording() async {
    await controller.stopRecorder();
    voiceStream.stop();
    isRecording = false;
    hasRecord = true;
    hasFinishedRecording = true;
    notifyListeners();
    voiceStream = RecorderStream();
    log('message: Recording stopped');
  }

  toggleRecording(context) {
    if (controller.isRecording) {
      stopAudioRecording();
    } else {
      startAudioRecording(context);
    }
  }
}
