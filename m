Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294D947CA8A;
	Wed,  2 Sep 2026 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361452; cv=none; b=kzjkOqb1fMo3RAzM4W+yGRbBY2ggCLEzja9d8Qf6Lk3fePTHjI/Z21TA/uKwUpCai6kTmxeTf4UrxZG/V/C9Q6txc5QcuTdtKxFh+Mt7QZuAzBlKLJ6mkh8Bc0ulSh+mgy4TSgBqWBgnTE5RNNAuUzDj+2O+7dPD5K/RkefEPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361452; c=relaxed/simple;
	bh=qmGQlx6+a0ouQL3tb1CwwaE3xYK849vU9txQeuv77vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVYrADE2GET3hA8D+OEjFPT/kAV0uyKt2AjdHjkt6KIznkhry5XRgOvpuKZr72V7J3KjW9wqvMatSQ4AUfBny7uMGfw+VelpRPVjTBDck7CEJSMVqbZa+WutA0BuFtWrs/mY7tX64MwesF1HRtfruxINp5r1EmhpcDuHvk8AA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqBvJaGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqBvJaGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB90C1F00A3D;
	Wed,  2 Sep 2026 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361450;
	bh=2fFeMQ2cqsnJI8nCopA2k51L9oS0PMNZZZ2OK/H6tF4=;
	h=From:To:Cc:Subject:Date;
	b=UqBvJaGrwliYqJieZ9Ss0mD3STHmmOL/CM/bKVq8pdf/aXKPM6RLBHHm/kC5HC9h1
	 GSdNqrzEupPOfSpijc9YFgt+1Haf8fWVPt8Yxwj61TJ7jnBGWIfMsPR+TQsYe+3k/B
	 jqAoicJIuF3BzVdW5o1z6K36nXI7vCIUdaHedO/8aRJxhd5rP/V7E+AWfnDoo1SBrN
	 8ymhleV7iDQFrwpjAEqZ17wmBBZKis/A1OMRLLloB2c43BZs9Lz/C+x21js4VVJDwx
	 odXaA2IzxvtMCAvFcSfcK4JixO9QQLikZfW5usbHk9KuUiejMIFMFC/4pPLNADcG/W
	 o8bpxuceapw6w==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rust: kbuild: add intrinsics to fix Rust 1.100.0 builds
Date: Wed,  2 Sep 2026 17:03:53 +0200
Message-ID: <20260902150353.23666-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.100.0 (expected 2026-11-12), a kernel build may
fail at the final link with:

    ld.lld: error: undefined symbol: fmaximum_numf
    >>> referenced by core.1f440ee8661e09f9-cgu.0
    >>>               rust/core.o:(<core::ops::range::RangeFrom<f32> as core::cmp::clamp::ClampBounds<f32>>::clamp) in archive vmlinux.a

(and similar for `f{min,max}imum_num{f,}` and `__gt{s,d}f2`). The issue
reproduces on x86_64 and arm64.

This happens due to upstream Rust commit bd174e1b20a8 ("Implement
clamp_to") [1], which added concrete `ClampBounds` implementations for
floating-point ranges to `core`, and which, in turn, require the compiler
runtime symbols above.

Thus add those intrinsics to our usual workaround, i.e. redirect them
to weak panicking definitions.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust/commit/bd174e1b20a8 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
I sent a PR to upstream Rust to make the methods simply `#[inline]`
instead, and it seems like it will be merged, so we can most likely
skip this workaround:

  https://github.com/rust-lang/rust/pull/162191

But I am sending this so that it is archived in the list in case others
hit the same issue meanwhile.

 rust/Makefile             | 4 ++--
 rust/compiler_builtins.rs | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index da1a7409d984..51e5f83a44b8 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -679,8 +679,8 @@ rust-analyzer:
 		> rust-project.json

 redirect-intrinsics = \
-	__addsf3 __eqsf2 __extendsfdf2 __gesf2 __lesf2 __ltsf2 __mulsf3 __nesf2 __truncdfsf2 __unordsf2 \
-	__adddf3 __eqdf2 __ledf2 __ltdf2 __muldf3 __unorddf2 \
+	__addsf3 __eqsf2 __extendsfdf2 __gesf2 __gtsf2 __lesf2 __ltsf2 __mulsf3 __nesf2 __truncdfsf2 __unordsf2 fmaximum_numf fminimum_numf \
+	__adddf3 __eqdf2 __gtdf2 __ledf2 __ltdf2 __muldf3 __unorddf2 fmaximum_num fminimum_num \
 	__muloti4 __multi3 \
 	__udivmodti4 __udivti3 __umodti3

diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
index fc6b54636dd5..31b991e1619d 100644
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -42,21 +42,27 @@ pub extern "C" fn $ident() {
     __eqsf2,
     __extendsfdf2,
     __gesf2,
+    __gtsf2,
     __lesf2,
     __ltsf2,
     __mulsf3,
     __nesf2,
     __truncdfsf2,
     __unordsf2,
+    fmaximum_numf,
+    fminimum_numf,
 });

 define_panicking_intrinsics!("`f64` should not be used", {
     __adddf3,
     __eqdf2,
+    __gtdf2,
     __ledf2,
     __ltdf2,
     __muldf3,
     __unorddf2,
+    fmaximum_num,
+    fminimum_num,
 });

 define_panicking_intrinsics!("`i128` should not be used", {

base-commit: e510334fbaeaa016ac76d80b4c5f47611c5f7860
--
2.55.0
