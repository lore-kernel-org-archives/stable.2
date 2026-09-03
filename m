Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528D4AF9CC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442592; cv=none; b=QFGTSEnpevJKqXrss5eTLD9SeW35ZqXkNBrinmq3Kmlp0qXVt2vxEbbWNYObb1fHO4qhjPvn1i5hBfgobDR9Kj5qS1IB2sb/qZduDmJxFNTjkY+lYa5VLFDnZynv/Ex6jTCWx+NO7nGIPlrJuymROQ+dvCotZzSi0LLugI2DqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442592; c=relaxed/simple;
	bh=tq90gUFUx+V2YEEvAH7rUatGzcTj4jVqxBKcW/MgnUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Drq9aAmTLq1TT943prb9vHl3ldrpwP7UyM1Wif+fw95LLxOUyZFpgyaePivxMEc+s+vZTYbfVLfEHkDEOb9oFKvI+xK1ICtaaqBZ3Zc/uT+nKXKds71MwE92myalq4DITDcdH2l87hrd1uatY/q2Y6kn3P+rW2aMYV672iFO17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrBtgFYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrBtgFYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF561F00A3A;
	Thu,  3 Sep 2026 13:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442577;
	bh=uaceigZGSAJEiZhOLgGwY5hfiz7k0WCTWahuHRXFgk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RrBtgFYw7TAV7ZMD9hJWHMUsjUh5SWCWqPvkHTore4s45U3+2FaFUkxsHNNUYqFjm
	 W08g/Z8kwlzm8w23n6f2F8evCOsOnAsKU9+R3UEpi7UxbGfTtoYkieh/u5rrnCZnE4
	 iHKIwAwow3XI0apzMKi9iVwq48YiGEiWRLWD7DjvEdq+PPQVvbztzDfvFBtxQGEI68
	 wXuAyYSuK9LJs42BVqQRN32GaNWzVxAbf0i2kJHBzyyA+6cSJVUz/iZ+tTBFn6qJG/
	 vJ6oP2VcVU3PGxgjfeKvF7IrnkeJPmoONLvc0RRoK78QczdWIkg0BIaPL5ILrKdHz6
	 Xk+jSr4J6Vdow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] rust: rust_is_available: remove warning for `bindgen` < 0.69.5 && libclang >= 19.1
Date: Thu,  3 Sep 2026 09:36:13 -0400
Message-ID: <20260903133614.760808-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903133614.760808-1-sashal@kernel.org>
References: <2026090302-mumbo-scorebook-4564@gregkh>
 <20260903133614.760808-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit ae64324ad5c1fdefe479d77ecee975bc6b37467b ]

It is not possible anymore to fall into the issue that this warning was
alerting about given the `bindgen` version bump.

Thus simplify by removing the machinery behind it, including tests.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Link: https://patch.msgid.link/20260405235309.418950-20-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Stable-dep-of: dc01dfb37b34 ("rust: rust_is_available: warn for `bindgen` < 0.72.1 && libclang >= 22")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/rust_is_available.sh                  | 15 --------
 ...ust_is_available_bindgen_libclang_concat.h |  3 --
 scripts/rust_is_available_test.py             | 34 +------------------
 3 files changed, 1 insertion(+), 51 deletions(-)
 delete mode 100644 scripts/rust_is_available_bindgen_libclang_concat.h

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index 77896e31dab50..cefc456c2503a 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -214,21 +214,6 @@ if [ "$bindgen_libclang_cversion" -lt "$bindgen_libclang_min_cversion" ]; then
 	exit 1
 fi
 
-if [ "$bindgen_libclang_cversion" -ge 1900100 ] &&
-	[ "$rust_bindings_generator_cversion" -lt 6905 ]; then
-	# Distributions may have patched the issue (e.g. Debian did).
-	if ! "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang_concat.h | grep -q foofoo; then
-		echo >&2 "***"
-		echo >&2 "*** Rust bindings generator '$BINDGEN' < 0.69.5 together with libclang >= 19.1"
-		echo >&2 "*** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2824),"
-		echo >&2 "*** unless patched (like Debian's)."
-		echo >&2 "***   Your bindgen version:  $rust_bindings_generator_version"
-		echo >&2 "***   Your libclang version: $bindgen_libclang_version"
-		echo >&2 "***"
-		warning=1
-	fi
-fi
-
 # If the C compiler is Clang, then we can also check whether its version
 # matches the `libclang` version used by the Rust bindings generator.
 #
diff --git a/scripts/rust_is_available_bindgen_libclang_concat.h b/scripts/rust_is_available_bindgen_libclang_concat.h
deleted file mode 100644
index efc6e98d0f1d0..0000000000000
--- a/scripts/rust_is_available_bindgen_libclang_concat.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#define F(x) int x##x
-F(foo);
diff --git a/scripts/rust_is_available_test.py b/scripts/rust_is_available_test.py
index b66fa59338443..d6d54b7ea42a0 100755
--- a/scripts/rust_is_available_test.py
+++ b/scripts/rust_is_available_test.py
@@ -54,23 +54,16 @@ else:
 """)
 
     @classmethod
-    def generate_bindgen(cls, version_stdout, libclang_stderr, libclang_concat_patched=False):
+    def generate_bindgen(cls, version_stdout, libclang_stderr):
         if libclang_stderr is None:
             libclang_case = f"raise SystemExit({cls.bindgen_default_bindgen_libclang_failure_exit_code})"
         else:
             libclang_case = f"print({repr(libclang_stderr)}, file=sys.stderr)"
 
-        if libclang_concat_patched:
-            libclang_concat_case = "print('pub static mut foofoo: ::std::os::raw::c_int;')"
-        else:
-            libclang_concat_case = "pass"
-
         return cls.generate_executable(f"""#!/usr/bin/env python3
 import sys
 if "rust_is_available_bindgen_libclang.h" in " ".join(sys.argv):
     {libclang_case}
-elif "rust_is_available_bindgen_libclang_concat.h" in " ".join(sys.argv):
-    {libclang_concat_case}
 else:
     print({repr(version_stdout)})
 """)
@@ -255,31 +248,6 @@ else:
         result = self.run_script(self.Expected.FAILURE, { "BINDGEN": bindgen })
         self.assertIn(f"libclang (used by the Rust bindings generator '{bindgen}') is too old.", result.stderr)
 
-    def test_bindgen_bad_libclang_concat(self):
-        for (bindgen_version, libclang_version, expected_not_patched) in (
-            ("0.69.4", "18.0.0", self.Expected.SUCCESS),
-            ("0.69.4", "19.1.0", self.Expected.SUCCESS_WITH_WARNINGS),
-            ("0.69.4", "19.2.0", self.Expected.SUCCESS_WITH_WARNINGS),
-
-            ("0.69.5", "18.0.0", self.Expected.SUCCESS),
-            ("0.69.5", "19.1.0", self.Expected.SUCCESS),
-            ("0.69.5", "19.2.0", self.Expected.SUCCESS),
-
-            ("0.70.0", "18.0.0", self.Expected.SUCCESS),
-            ("0.70.0", "19.1.0", self.Expected.SUCCESS),
-            ("0.70.0", "19.2.0", self.Expected.SUCCESS),
-        ):
-            with self.subTest(bindgen_version=bindgen_version, libclang_version=libclang_version):
-                cc = self.generate_clang(f"clang version {libclang_version}")
-                libclang_stderr = f"scripts/rust_is_available_bindgen_libclang.h:2:9: warning: clang version {libclang_version} [-W#pragma-messages], err: false"
-                bindgen = self.generate_bindgen(f"bindgen {bindgen_version}", libclang_stderr)
-                result = self.run_script(expected_not_patched, { "BINDGEN": bindgen, "CC": cc })
-                if expected_not_patched == self.Expected.SUCCESS_WITH_WARNINGS:
-                    self.assertIn(f"Rust bindings generator '{bindgen}' < 0.69.5 together with libclang >= 19.1", result.stderr)
-
-                bindgen = self.generate_bindgen(f"bindgen {bindgen_version}", libclang_stderr, libclang_concat_patched=True)
-                result = self.run_script(self.Expected.SUCCESS, { "BINDGEN": bindgen, "CC": cc })
-
     def test_clang_matches_bindgen_libclang_different_bindgen(self):
         bindgen = self.generate_bindgen_libclang("scripts/rust_is_available_bindgen_libclang.h:2:9: warning: clang version 999.0.0 [-W#pragma-messages], err: false")
         result = self.run_script(self.Expected.SUCCESS_WITH_WARNINGS, { "BINDGEN": bindgen })
-- 
2.53.0

