// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library tester_test;

import 'package:test/test.dart' as test;

/// Assert that [actual] matches [matcher].
///
/// This is the main assertion function. [reason] is optional and is typically
/// not supplied, as a reason is generated from [matcher]; if [reason]
/// is included it is appended to the reason generated by the matcher.
///
/// [matcher] can be a value in which case it will be wrapped in an
/// [equals] matcher.
///
/// If the assertion fails a [TestFailure] is thrown.
void expect(dynamic actual, dynamic matcher) {
  var wrappedMatcher = test.wrapMatcher(matcher);
  var matchState = {};
  try {
    if (wrappedMatcher.matches(actual, matchState)) {
      return;
    }
  } catch (_) {
    // Do nothing
  }
  var mismatchDescription = test.StringDescription();
  wrappedMatcher.describeMismatch(
    actual,
    mismatchDescription,
    matchState,
    false,
  );
  var buffer = StringBuffer()
    ..write('Expected: ')
    ..writeln(_prettyPrint(wrappedMatcher))
    ..write('  Actual: ')
    ..writeln(_prettyPrint(actual));
  var which = mismatchDescription.toString();
  if (which.isNotEmpty) {
    buffer
      ..write('   Which: ')
      ..writeln(which);
  }
  throw buffer.toString();
}

String _prettyPrint(value) =>
    test.StringDescription().addDescriptionOf(value).toString();
