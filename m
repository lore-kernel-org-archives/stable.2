Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1973537C8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459535; cv=none; b=gEfPeNVhBR/s33G/Koxqa4Ufc31tuY3e0S56ttZogf/O2pdYERVqIbywVg4jqG5BW6mzD1sEH3ebIZOpF5RBNmjn5wbne+I1W6+drDeKfZvX4ltJ9egue7SPd0eFNd0o+xeZUP/+Cj4FjKUOxijdWLfGGRQ/iDx2tw74wVGsgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459535; c=relaxed/simple;
	bh=l8p8oIZ2hxL23VL/Mzu22ZzdOcgEQTB+0FNHZUwrDzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4DfNEpnlRVdRK2yMrsX/6JWwc6NDoVQ/76+pn8pPP1E1fgJGt9+bpqAc0+jrglX9lqaLzm8Ar5jnS8N4Jqms8KUBYV3kPRP0D0ZeDDoy69TxhiJmiLQMQgMc1tUeNjA2mzB7dnKsjKIDcqAU1S8D97gRoJsUhrdZ5gVCyMQpb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh+TyEfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh+TyEfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C39C1F000E9;
	Thu,  3 Sep 2026 18:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459534;
	bh=I09nr0uZFzcn2B5NHQPyzdhGnJrPnXEk0BKYIvwi9uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oh+TyEfwpSn80ZYcKrJR2G7OwK1dqxB1lAP5tB86fb2FUXhXJyXE7W7UCJIXrnhWo
	 t47MtKPlZnbX9k9/40WZw0nJfg35wI+eXaK0H3n4RfdApb9R09luUja3xFgzYgZSEv
	 Ev9RrFUSAg+Fnn4yCASBkoTcvCGd+TotMds4mjGWOLtot48Bsb0WbxGuwJKF13PD5e
	 A34ZYB0MhAmELGd06OJIYLVeWXqbXssTjzmolqhbPfggwGYq3adwfhMNoAXmfIsayK
	 YJmIOdlOpkQZtKBBXHHgL2wh24jLs7SzHK7Zpoc44nj4/USw2+ImwUjjKYX9DsRna1
	 LKb2ovE+cLKCw==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Burak Emir <burak.emir@gmail.com>
Subject: [PATCH 6.18.y] rust: rust_is_available: warn for `bindgen` < 0.72.1 && libclang >= 22
Date: Thu,  3 Sep 2026 20:18:37 +0200
Message-ID: <20260903181837.12025-1-ojeda@kernel.org>
In-Reply-To: <2026090302-mumbo-scorebook-4564@gregkh>
References: <2026090302-mumbo-scorebook-4564@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with LLVM 22, `clang_getTypeDeclaration()` may return a forward
declaration instead of the type definition. This made `bindgen` generate
opaque types [1][2], which in turn made us fail with e.g.

    error[E0609]: no field `__bindgen_anon_1` on type `bindings::kernel_param`
      --> rust/kernel/module_param.rs:78:46
       |
    78 |         let container = unsafe { &*((*param).__bindgen_anon_1.arg.cast::<SetOnce<T>>()) };
       |                                              ^^^^^^^^^^^^^^^^ unknown field
       |
       = note: available field is: `_address`

This was fixed in `bindgen` 0.72.1 [3].

In order to clarify what is going on and avoid confusion [4][5], add
a warning to `rust_is_available.sh` about it when the versions match,
similar to past warnings like the one removed in:

  commit ae64324ad5c1 ("rust: rust_is_available: remove warning for `bindgen` < 0.69.5 && libclang >= 19.1")

In addition, even if the versions match, check if the issue appears to
not reproduce with the given binaries, to avoid a warning in such a case.

Finally, include tests.

[ Nathan, in parallel, updated the instructions of the LLVM+Rust
  kernel.org toolchains [6] so that `--version` is not passed to
  `cargo` for `bindgen`, and thus the latest `bindgen` is installed
  by default, which should help to avoid some of these situations.

  Thanks!

    - Miguel ]

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust-bindgen/issues/3264 [1]
Link: https://github.com/Rust-for-Linux/linux/issues/353 [2] # "Missing fields in nested class with LLVM 22."
Link: https://github.com/rust-lang/rust-bindgen/pull/3278 [3]
Reported-by: Burak Emir <burak.emir@gmail.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1247 [4]
Link: https://lore.kernel.org/rust-for-linux/CABwQupNfMAJOGqRM9ke6tj4f53dCCsBDKU7Vp+zf8mwk7bqt8Q@mail.gmail.com/ [5]
Link: https://mirrors.edge.kernel.org/pub/tools/llvm/rust/ [6]
Tested-by: Burak Emir <burak.emir@gmail.com>
Link: https://patch.msgid.link/20260719120514.159914-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
(cherry picked from commit dc01dfb37b34beeefcfe1c3055364d41a4070c7e)
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rust_is_available.sh                  | 14 +++++++++
 .../rust_is_available_bindgen_libclang_22.h   |  5 ++++
 scripts/rust_is_available_test.py             | 30 ++++++++++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 scripts/rust_is_available_bindgen_libclang_22.h

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index d2323de0692c..82be88d44c18 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -242,6 +242,20 @@ if [ "$bindgen_libclang_cversion" -ge 1900100 ] &&
 	fi
 fi
 
+if [ "$bindgen_libclang_cversion" -ge 2200000 ] &&
+	[ "$rust_bindings_generator_cversion" -lt 7201 ]; then
+	# Distributions may have patched the issue.
+	if ! "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang_22.h | grep -q 'pub foo'; then
+		echo >&2 "***"
+		echo >&2 "*** Rust bindings generator '$BINDGEN' < 0.72.1 together with libclang >= 22"
+		echo >&2 "*** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/3278)."
+		echo >&2 "***   Your bindgen version:  $rust_bindings_generator_version"
+		echo >&2 "***   Your libclang version: $bindgen_libclang_version"
+		echo >&2 "***"
+		warning=1
+	fi
+fi
+
 # If the C compiler is Clang, then we can also check whether its version
 # matches the `libclang` version used by the Rust bindings generator.
 #
diff --git a/scripts/rust_is_available_bindgen_libclang_22.h b/scripts/rust_is_available_bindgen_libclang_22.h
new file mode 100644
index 000000000000..6b33544c14a8
--- /dev/null
+++ b/scripts/rust_is_available_bindgen_libclang_22.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+struct S;
+struct S {
+	int foo;
+};
diff --git a/scripts/rust_is_available_test.py b/scripts/rust_is_available_test.py
index 4fcc319dea84..a5fadef98132 100755
--- a/scripts/rust_is_available_test.py
+++ b/scripts/rust_is_available_test.py
@@ -54,7 +54,7 @@ else:
 """)
 
     @classmethod
-    def generate_bindgen(cls, version_stdout, libclang_stderr, version_0_66_patched=False, libclang_concat_patched=False):
+    def generate_bindgen(cls, version_stdout, libclang_stderr, version_0_66_patched=False, libclang_concat_patched=False, libclang_22_patched=False):
         if libclang_stderr is None:
             libclang_case = f"raise SystemExit({cls.bindgen_default_bindgen_libclang_failure_exit_code})"
         else:
@@ -70,6 +70,11 @@ else:
         else:
             libclang_concat_case = "pass"
 
+        if libclang_22_patched:
+            libclang_22_case = "print('pub foo: ::std::os::raw::c_int,')"
+        else:
+            libclang_22_case = "pass"
+
         return cls.generate_executable(f"""#!/usr/bin/env python3
 import sys
 if "rust_is_available_bindgen_libclang.h" in " ".join(sys.argv):
@@ -78,6 +83,8 @@ elif "rust_is_available_bindgen_0_66.h" in " ".join(sys.argv):
     {version_0_66_case}
 elif "rust_is_available_bindgen_libclang_concat.h" in " ".join(sys.argv):
     {libclang_concat_case}
+elif "rust_is_available_bindgen_libclang_22.h" in " ".join(sys.argv):
+    {libclang_22_case}
 else:
     print({repr(version_stdout)})
 """)
@@ -300,6 +307,27 @@ else:
                 bindgen = self.generate_bindgen(f"bindgen {bindgen_version}", libclang_stderr, libclang_concat_patched=True)
                 result = self.run_script(self.Expected.SUCCESS, { "BINDGEN": bindgen, "CC": cc })
 
+    def test_bindgen_bad_libclang_22(self):
+        for (bindgen_version, libclang_version, expected_not_patched) in (
+            ("0.71.1", "21.1.0", self.Expected.SUCCESS),
+            ("0.71.1", "22.0.0", self.Expected.SUCCESS_WITH_WARNINGS),
+            ("0.71.1", "22.1.0", self.Expected.SUCCESS_WITH_WARNINGS),
+
+            ("0.72.0", "22.0.0", self.Expected.SUCCESS_WITH_WARNINGS),
+
+            ("0.72.1", "22.0.0", self.Expected.SUCCESS),
+        ):
+            with self.subTest(bindgen_version=bindgen_version, libclang_version=libclang_version):
+                cc = self.generate_clang(f"clang version {libclang_version}")
+                libclang_stderr = f"scripts/rust_is_available_bindgen_libclang.h:2:9: warning: clang version {libclang_version} [-W#pragma-messages], err: false"
+                bindgen = self.generate_bindgen(f"bindgen {bindgen_version}", libclang_stderr)
+                result = self.run_script(expected_not_patched, { "BINDGEN": bindgen, "CC": cc })
+                if expected_not_patched == self.Expected.SUCCESS_WITH_WARNINGS:
+                    self.assertIn(f"Rust bindings generator '{bindgen}' < 0.72.1 together with libclang >= 22", result.stderr)
+
+                bindgen = self.generate_bindgen(f"bindgen {bindgen_version}", libclang_stderr, libclang_22_patched=True)
+                result = self.run_script(self.Expected.SUCCESS, { "BINDGEN": bindgen, "CC": cc })
+
     def test_clang_matches_bindgen_libclang_different_bindgen(self):
         bindgen = self.generate_bindgen_libclang("scripts/rust_is_available_bindgen_libclang.h:2:9: warning: clang version 999.0.0 [-W#pragma-messages], err: false")
         result = self.run_script(self.Expected.SUCCESS_WITH_WARNINGS, { "BINDGEN": bindgen })
-- 
2.55.0

