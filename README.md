## Usage

A package:test shim library for usage with `tester`[https://github.com/jonahwilliams/tester]. This allows using the expectations from `package:test` and `package:matcher`, but not the `group`, `test`, or related methods.

```dart
void testAddition() {
  expect(2, 1 + 1);
}
```