abstract class InterfaceRepository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<T> save(T data);
  Future<void> delete( int id);
}