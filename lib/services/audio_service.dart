import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioService._();
  static final AudioService instance = AudioService._();

  final AudioPlayer _player = AudioPlayer();

  Future<void> playAsset(String path) async {
    // path relatif terhadap assets/audio/, contoh: "alif.mp3"
    await _player.stop();
    await _player.play(AssetSource('audio/$path'));
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
