import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';

class AudioPlayController with ChangeNotifier {
  FlutterSoundPlayer soundPlayController = FlutterSoundPlayer();

  String pathToAudio = 'audio_example.aac';
  bool isPlaying = false;

  // Initializes the audio controller asynchronously.
  Future initAudioController() async {
    await soundPlayController.openPlayer();
  }

  // Dispose the audio controller asynchronously.
  Future disposeAudioController() async {
    await soundPlayController.closePlayer();
  }

  // A function that plays audio and notifies listeners when finished.
  // 
  // Parameters:
  //   - whenFinished: a callback function to be executed when the audio finishes playing.
  Future playAudio(VoidCallback whenFinished) async {
    isPlaying = true;
    notifyListeners();
    await soundPlayController.startPlayer(
      fromURI: pathToAudio,
      codec: Codec.aacADTS,
      whenFinished: whenFinished,
    );
  }

  // A function that stops audio playback. It sets the isPlaying flag to false, stops the audio player, and notifies listeners of the change.
  Future stopAudio() async {
    isPlaying = false;
    await soundPlayController.stopPlayer();
    notifyListeners();
  }

  // Toggles the play state of the audio. If the audio is stopped, it starts playing and if it is playing, it stops.
  void togglePlay() async {
    if (soundPlayController.isStopped) {
      await playAudio(
        () {
          stopAudio();
        },
      );
    } else {
      await stopAudio();
    }
  }
}
