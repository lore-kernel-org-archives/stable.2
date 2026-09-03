Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FCE383991
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442760; cv=none; b=ZxO8MeGxMymPzZ9gp/owaS6Ti6WCqBjWNZFQN4SKoqRaluj3kAzVNqww9yJjDXCLRx1trLagOlEG4lYLy4vFlTCnxoq95HzYISU5UW19j2SUP2NYInfWZ1TaQHDV1Klv6m+pK3KXu99/97ASaaVKSn200J/ksGkSi0gPIsG/+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442760; c=relaxed/simple;
	bh=9VDC+M2GVI4Z9SExQKedEXeqb38zlRf3JKQs61Vv3t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jp3o7B3GDLPdOsrtBulai1FcdbEpBoVkGVjGt7a0OSiE5FNWq/+MjEgwrghvB8SeEEM87axthDU8SFq9r0u0lkd8DMWvuHOeBE+Mje4P5mp6mFRyu+fL1D7U4qNcCgZY5vpqVXZJD4ElqnR4zzd9NLkvkearQb6ACg2sU2ZLfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uzt69k1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uzt69k1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C0F1F00AC4;
	Thu,  3 Sep 2026 13:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442744;
	bh=s681rQg1sgSGFW3Ra5LMGxp5IcJUGO1zil+eBbsrURs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uzt69k1uB6DvlnvBFh42CjIV71m16O0Moxkd81gwvrkKWQzSw+oayRcJQ3etAv16H
	 xV8zKFHxWZ7gQSIpdQuW+66R45oBTxHQ8UyLwzT0rkCArVn9qbq/54NMiBu9RVKS/O
	 9NWh9hdBj9DhnWIjlvPdIQ5qHusWwCJhQE0H5sxGl1e/HGp1HT+1XFgHitTEfX02LO
	 +7xUMZP8kF6rzSfau0WjuchC6GHkNtDAIEE1JOX45MlWVRfYESBbGiOIdeaGE4aciA
	 wP6dEbt+r23CV9up14FSdcd0weRocRYXjBB2Mm6x+6M4qAhQThyQxBeGFi0fQa7VOe
	 eMLSpSPG9QYDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] rust: rust_is_available: remove warning for `bindgen` 0.66.[01]
Date: Thu,  3 Sep 2026 09:39:00 -0400
Message-ID: <20260903133902.763984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090303-moonshine-study-20ce@gregkh>
References: <2026090303-moonshine-study-20ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit 41cfbb4295cf9fcdffa6c89ddc84dca2fa392c98 ]

It is not possible anymore to fall into the issue that this warning was
alerting about given the `bindgen` version bump.

Thus simplify by removing the machinery behind it, including tests.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Link: https://patch.msgid.link/20260405235309.418950-19-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Stable-dep-of: dc01dfb37b34 ("rust: rust_is_available: warn for `bindgen` < 0.72.1 && libclang >= 22")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/rust_is_available.sh             | 13 ------------
 scripts/rust_is_available_bindgen_0_66.h |  2 --
 scripts/rust_is_available_test.py        | 26 +++---------------------
 3 files changed, 3 insertions(+), 38 deletions(-)
 delete mode 100644 scripts/rust_is_available_bindgen_0_66.h

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index 93c0ef7fb3fb2..127f20950743d 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -161,19 +161,6 @@ if [ "$rust_bindings_generator_cversion" -lt "$rust_bindings_generator_min_cvers
 	echo >&2 "***"
 	exit 1
 fi
-if [ "$rust_bindings_generator_cversion" -eq 6600 ] ||
-	[ "$rust_bindings_generator_cversion" -eq 6601 ]; then
-	# Distributions may have patched the issue (e.g. Debian did).
-	if ! "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_0_66.h >/dev/null; then
-		echo >&2 "***"
-		echo >&2 "*** Rust bindings generator '$BINDGEN' versions 0.66.0 and 0.66.1 may not"
-		echo >&2 "*** work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2567),"
-		echo >&2 "*** unless patched (like Debian's)."
-		echo >&2 "***   Your version:     $rust_bindings_generator_version"
-		echo >&2 "***"
-		warning=1
-	fi
-fi
 
 # Check that the `libclang` used by the Rust bindings generator is suitable.
 #
diff --git a/scripts/rust_is_available_bindgen_0_66.h b/scripts/rust_is_available_bindgen_0_66.h
deleted file mode 100644
index c0431293421c8..0000000000000
--- a/scripts/rust_is_available_bindgen_0_66.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#define A "\0"
diff --git a/scripts/rust_is_available_test.py b/scripts/rust_is_available_test.py
index 4fcc319dea84e..b66fa59338443 100755
--- a/scripts/rust_is_available_test.py
+++ b/scripts/rust_is_available_test.py
@@ -54,17 +54,12 @@ else:
 """)
 
     @classmethod
-    def generate_bindgen(cls, version_stdout, libclang_stderr, version_0_66_patched=False, libclang_concat_patched=False):
+    def generate_bindgen(cls, version_stdout, libclang_stderr, libclang_concat_patched=False):
         if libclang_stderr is None:
             libclang_case = f"raise SystemExit({cls.bindgen_default_bindgen_libclang_failure_exit_code})"
         else:
             libclang_case = f"print({repr(libclang_stderr)}, file=sys.stderr)"
 
-        if version_0_66_patched:
-            version_0_66_case = "pass"
-        else:
-            version_0_66_case = "raise SystemExit(1)"
-
         if libclang_concat_patched:
             libclang_concat_case = "print('pub static mut foofoo: ::std::os::raw::c_int;')"
         else:
@@ -74,8 +69,6 @@ else:
 import sys
 if "rust_is_available_bindgen_libclang.h" in " ".join(sys.argv):
     {libclang_case}
-elif "rust_is_available_bindgen_0_66.h" in " ".join(sys.argv):
-    {version_0_66_case}
 elif "rust_is_available_bindgen_libclang_concat.h" in " ".join(sys.argv):
     {libclang_concat_case}
 else:
@@ -83,8 +76,8 @@ else:
 """)
 
     @classmethod
-    def generate_bindgen_version(cls, stdout, version_0_66_patched=False):
-        return cls.generate_bindgen(stdout, cls.bindgen_default_bindgen_libclang_stderr, version_0_66_patched)
+    def generate_bindgen_version(cls, stdout):
+        return cls.generate_bindgen(stdout, cls.bindgen_default_bindgen_libclang_stderr)
 
     @classmethod
     def generate_bindgen_libclang_failure(cls):
@@ -245,19 +238,6 @@ else:
         result = self.run_script(self.Expected.FAILURE, { "BINDGEN": bindgen })
         self.assertIn(f"Rust bindings generator '{bindgen}' is too old.", result.stderr)
 
-    def test_bindgen_bad_version_0_66_0_and_0_66_1(self):
-        for version in ("0.66.0", "0.66.1"):
-            with self.subTest(version=version):
-                bindgen = self.generate_bindgen_version(f"bindgen {version}")
-                result = self.run_script(self.Expected.SUCCESS_WITH_WARNINGS, { "BINDGEN": bindgen })
-                self.assertIn(f"Rust bindings generator '{bindgen}' versions 0.66.0 and 0.66.1 may not", result.stderr)
-
-    def test_bindgen_bad_version_0_66_0_and_0_66_1_patched(self):
-        for version in ("0.66.0", "0.66.1"):
-            with self.subTest(version=version):
-                bindgen = self.generate_bindgen_version(f"bindgen {version}", True)
-                result = self.run_script(self.Expected.SUCCESS, { "BINDGEN": bindgen })
-
     def test_bindgen_libclang_failure(self):
         bindgen = self.generate_bindgen_libclang_failure()
         result = self.run_script(self.Expected.FAILURE, { "BINDGEN": bindgen })
-- 
2.53.0

