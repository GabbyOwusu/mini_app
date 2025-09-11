import 'package:hive/hive.dart';
import 'package:mini_app/core/local_storage/local_storage_service.dart';
import 'package:path_provider/path_provider.dart';

class HiveKeys {
  static const String BOX = 'box';
  static const String BUSINESSES = 'businesses';
}

class LocalStorageImplementation extends LocalStorageService {
  Box? box;

  @override
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox(HiveKeys.BOX).then((b) => box = b);
  }

  @override
  Future<void> assertBox() async {
    if (box?.isOpen ?? false) return;
    return await init();
  }

  @override
  Future<T> getValue<T>(String key, {T? defaultValue}) async {
    await assertBox();
    return box?.get(key, defaultValue: defaultValue) ?? defaultValue;
  }

  @override
  Future<void> setValue<T>(String key, T value) async {
    await assertBox();
    return box?.put(key, value);
  }
}
