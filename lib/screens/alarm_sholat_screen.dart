import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';

class AlarmSholatScreen extends StatefulWidget {
  const AlarmSholatScreen({super.key});
  @override
  State<AlarmSholatScreen> createState() => _AlarmSholatScreenState();
}

class _AlarmSholatScreenState extends State<AlarmSholatScreen> {
  final _notif = NotificationService.instance;
  Map<String, TimeOfDay> _times = {
    "Subuh": const TimeOfDay(hour: 4, minute: 30),
    "Dzuhur": const TimeOfDay(hour: 12, minute: 0),
    "Ashar": const TimeOfDay(hour: 15, minute: 30),
    "Maghrib": const TimeOfDay(hour: 18, minute: 0),
    "Isya": const TimeOfDay(hour: 19, minute: 30),
  };
  Map<String,bool> _on = {"Subuh":false,"Dzuhur":false,"Ashar":false,"Maghrib":false,"Isya":false};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final sp = await SharedPreferences.getInstance();
    for (final k in _times.keys) {
      final h = sp.getInt('alarm_${k}_h');
      final m = sp.getInt('alarm_${k}_m');
      final on = sp.getBool('alarm_${k}_on') ?? false;
      if (h!=null && m!=null) _times[k] = TimeOfDay(hour: h, minute: m);
      _on[k] = on;
    }
    if (!mounted) return;
    setState((){});
  }

  Future<void> _save() async {
    final sp = await SharedPreferences.getInstance();
    for (final k in _times.keys) {
      await sp.setInt('alarm_${k}_h', _times[k]!.hour);
      await sp.setInt('alarm_${k}_m', _times[k]!.minute);
      await sp.setBool('alarm_${k}_on', _on[k]!);
    }
  }

  int _idFor(String name) {
    switch(name) {
      case "Subuh": return 401;
      case "Dzuhur": return 402;
      case "Ashar": return 403;
      case "Maghrib": return 404;
      case "Isya": return 405;
      default: return 499;
    }
  }

  Future<void> _schedule(String name) async {
    final t = _times[name]!;
    await _notif.scheduleDaily(id: _idFor(name), hour: t.hour, minute: t.minute, title: 'Pengingat Sholat $name', body: 'Waktunya sholat $name', playSound: true);
  }

  Future<void> _cancel(String name) => _notif.cancel(_idFor(name));

  Future<void> _pick(String name) async {
    final picked = await showTimePicker(context: context, initialTime: _times[name]!);
    if (picked != null) {
      setState(()=>_times[name]=picked);
      await _save();
      if (_on[name] == true) await _schedule(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Alarm Sholat')), body: ListView(padding: const EdgeInsets.all(12), children: _times.keys.map((k){
      final t=_times[k]!;
      final on=_on[k]!;
      return Card(child: ListTile(leading: const Icon(Icons.alarm), title: Text('Sholat $k'), subtitle: Text(t.format(context)), trailing: Switch(value: on, onChanged: (v) async {
        setState(()=>_on[k]=v);
        await _save();
        if (v) await _schedule(k); else await _cancel(k);
      }), onTap: ()=>_pick(k)));
    }).toList()));
  }
}
