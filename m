Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F613630AE
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392703; cv=none; b=KrUmLhEf5WdCh76Qwrif2XehXTnGlWhdnlgQhFIdIuLWkKj867ilaeAQAxn0RNE6kmKlugtDScwQYBmOpZOcui/lTfTqFta5NH07R5ZeHzXX25zk/uyBY7xXx1BljmLHb8NLCrTgSA4EoVrSEpMxtu1/HP1VWn/CL12G4/CF3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392703; c=relaxed/simple;
	bh=cxi+/3HVHtcRbICZrKR9YaQjkwE8Tf5p2ZuuvgkHc9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3q4/dnpLqTDnAYLeMmuuWpdJMzUfWrQ/QbpDlYvCHFuzPtYzDxZhKgSNGtZAb8v66HwzfD0sIWozHskCkZrsOA0v4xbNi1v2O+6T+11SlENB/qXZxfG9Vkr2DEB6OXXg9w+l028hUjCt33crXv2beRrI2lcL65emDxcJiyby6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7m1sQH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7m1sQH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09971F00A3A;
	Thu, 30 Jul 2026 06:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785392701;
	bh=RIhSW9s2cj405axXbpioXessvk/tDk0Vl/C3BaoolnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V7m1sQH425SnOzPSWQRJQR3n7gqCvhAdfh1CQ8c509kMC9dl549J0FLPBihuBZsjM
	 ySseq8v35edC8NhaoKfEzfwxn2nNuFJ24yMcsCi3PW9ENHwKWickUbw+zVx8yA0UrY
	 2zT9QqMCcWIB6g9qMgd6UMs4f2WB44dD9VmdbXf5Q72T+yYS2j7ENFabQ4a4g9sK9V
	 xRl6xPZi7drCiogCkvB4WwvKP2yd7l2hiZFQ7iqqR5t0bG/FZ6FSllgOnHNRVi+miI
	 eSGQuo02UVej5RT7CADY6L0lA6UJeJjeU9W7RNpsCcDZQ2BOzFPzHWOdKah/ppPYEW
	 WmQyY/XEdFdiw==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Urgau <urgau@numericable.fr>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH 6.18.y] rust: allow `suspicious_runtime_symbol_definitions` lint for Rust >= 1.98
Date: Thu, 30 Jul 2026 08:24:52 +0200
Message-ID: <20260730062452.54973-1-ojeda@kernel.org>
In-Reply-To: <2026072920-prorate-semifinal-1bca@gregkh>
References: <2026072920-prorate-semifinal-1bca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.98.0 (expected 2026-08-20), Rust is introducing a
couple new lints, `invalid_runtime_symbol_definitions` (deny-by-default)
and `suspicious_runtime_symbol_definitions` (warn-by-default), which check
the signature of items whose symbol name is a runtime symbol expected by
`core`.

Our build hits the second one, i.e. the warning:

    error: suspicious definition of the runtime `strlen` symbol used by the standard library
         --> rust/bindings/bindings_generated.rs:20018:5
          |
    20018 |     pub fn strlen(s: *const ffi::c_char) -> usize;
          |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          |
          = note: expected `unsafe extern "C" fn(*const i8) -> usize`
                  found    `unsafe extern "C" fn(*const u8) -> usize`
          = help: either fix the signature or remove any attributes like `#[unsafe(no_mangle)]`, `#[unsafe(export_name = "strlen")]`, or `#[link_name = "strlen"]`
          = help: allow this lint if the signature is compatible
          = note: `-D suspicious-runtime-symbol-definitions` implied by `-D warnings`
          = help: to override `-D warnings` add `#[allow(suspicious_runtime_symbol_definitions)]`

    error: suspicious definition of the runtime `strlen` symbol used by the standard library
         --> rust/uapi/uapi_generated.rs:14236:5
          |
    14236 |     pub fn strlen(s: *const ffi::c_char) -> usize;
          |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          |
          = note: expected `unsafe extern "C" fn(*const i8) -> usize`
                  found    `unsafe extern "C" fn(*const u8) -> usize`
          = help: either fix the signature or remove any attributes like `#[unsafe(no_mangle)]`, `#[unsafe(export_name = "strlen")]`, or `#[link_name = "strlen"]`
          = help: allow this lint if the signature is compatible
          = note: `-D suspicious-runtime-symbol-definitions` implied by `-D warnings`
          = help: to override `-D warnings` add `#[allow(suspicious_runtime_symbol_definitions)]`

Thus `allow` the lint in `bindings` and `uapi`.

A more targeted alternative to avoid `allow`ing it would be to pass
`--blocklist-function strlen` to `bindgen`, but we would perhaps need
to adjust if other C headers end up adding more (or Rust checking more).
Since it is just the less critical one that we hit, and since eventually
this should be properly fixed by getting upstream Rust to provide a flag
like GCC/Clang's `-funsigned-char` [2][3], just `allow` it for now.

Cc: Urgau <urgau@numericable.fr>
Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust/pull/155521 [1]
Link: https://github.com/rust-lang/rust/issues/138446 [2]
Link: https://github.com/Rust-for-Linux/linux/issues/355 [3]
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Link: https://patch.msgid.link/20260615143225.471756-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
(cherry picked from commit 608045a91d9176d66b2114d0006bc8b57dff2ca9)
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 init/Kconfig         | 3 +++
 rust/bindings/lib.rs | 4 ++++
 rust/uapi/lib.rs     | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 0c25e78e10f4..6ce315af48c1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -162,6 +162,9 @@ config RUSTC_HAS_FILE_WITH_NUL
 config RUSTC_HAS_FILE_AS_C_STR
 	def_bool RUSTC_VERSION >= 109100
 
+config RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS
+	def_bool RUSTC_VERSION >= 109800
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 0c57cf9b4004..5e208064d46c 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -30,6 +30,10 @@
 #[allow(clippy::ref_as_ptr)]
 #[allow(clippy::undocumented_unsafe_blocks)]
 #[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
+#[cfg_attr(
+    CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,
+    allow(suspicious_runtime_symbol_definitions)
+)]
 mod bindings_raw {
     use pin_init::{MaybeZeroable, Zeroable};
 
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 1d5fd9efb93e..bec80b1dba23 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -28,6 +28,10 @@
     unsafe_op_in_unsafe_fn
 )]
 #![cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
+#![cfg_attr(
+    CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,
+    allow(suspicious_runtime_symbol_definitions)
+)]
 
 // Manual definition of blocklisted types.
 type __kernel_size_t = usize;
-- 
2.55.0

