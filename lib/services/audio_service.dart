import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioService._();
  static final instance = AudioService._();

  final AudioPlayer _player = AudioPlayer();

  Future<void> playAsset(String assetPath) async {
    // assetPath relative to assets/ (e.g. 'audio/alif.mp3' or 'audio/huruf/alif.mp3')
    await _player.stop();
    await _player.play(AssetSource(assetPath));
  }

  Future<void> stop() async => _player.stop();
}
