import 'package:chatrify/features/auth/domain/entity/user_entity.dart';
import 'package:chatrify/features/auth/domain/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<UserEntity> call(String username, String email, String password) {
    return repository.register(username, email, password);
  }
}
