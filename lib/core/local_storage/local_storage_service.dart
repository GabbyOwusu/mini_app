abstract class LocalStorageService {
  Future<void> init();

  Future<void> assertBox();

  Future<T> getValue<T>(String key, {T? defaultValue});

  Future<void> setValue<T>(String key, T value);
}
