Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D63630AE
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392617; cv=none; b=XsSzjNsMYx5JL2ufr+w6SyiZegT/8jlVQtD5ECDejOQnAGVyPz4OFMrycg0x8sVj/XAfd/VcC90L+tqvew4UwKOph16d42zng3xzhRBLlEZy2U04G0DLRYVdTSc5lBt+Z3w67RJKWpLMMFFczK3+6NMvtrPbmeXqq2eIE6x7aOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392617; c=relaxed/simple;
	bh=tGDYJMdSnRMuTa1PVE8PCB4DBKgv1yzZx/FL3zc9czc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCLuuF2YxEpTLgiaRdVHMqJrIDmDLW0uKPgJFtMYTBxdggFQTroNC52kSe3k3H7Z5vCLKw50qinM22ajzyo0IRkcFQjX2aMV2j40tILkqDATth81sz8soEFgATxf9bibfcCJBWgPK/b56Lz9b1o/vvbjb8kk6surSsdzXLFmt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW8w/6hF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW8w/6hF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE221F000E9;
	Thu, 30 Jul 2026 06:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785392616;
	bh=B2f8VlX4ekMGsbi2BbDW96Ed1JhEO9+1AX4d8910yYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GW8w/6hFnxWG+aRC+nnaPPzKGN6e1m2srHfGUn1YFeNHBcRf4peMWk3VagPuqV2Tg
	 3/AINdpqa5pJJEbCXFz0vNZ1rEfxZ4nR32RxTJG2GEBDNMnoBmAMDj69uunoIHvzuf
	 zMDAE05wS7HiS1rf/uhGDciCfL62j1Il9OBlSxkBgnDYmW7n+msmglAMBtRD4MJWbC
	 DB8/lRvulKrGtztNpBS4los7vuWtPASzuoOa5kkNN8cb8YtrKtXwze/4eANglD2eva
	 EA8+xTLUNcush2MSMbc1b8iLQudfrLkjB5qRuudBF/Nu9NPxUx+SEJj6rO88txpt5x
	 cCCEN6Yo96aKg==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Urgau <urgau@numericable.fr>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH 6.12.y] rust: allow `suspicious_runtime_symbol_definitions` lint for Rust >= 1.98
Date: Thu, 30 Jul 2026 08:23:20 +0200
Message-ID: <20260730062320.54448-1-ojeda@kernel.org>
In-Reply-To: <2026072921-ecosphere-nearest-8804@gregkh>
References: <2026072921-ecosphere-nearest-8804@gregkh>
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
index 53eba5cd88ff..f0e708b4226d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -140,6 +140,9 @@ config LD_CAN_USE_KEEP_IN_OVERLAY
 config RUSTC_HAS_UNNECESSARY_TRANSMUTES
 	def_bool RUSTC_VERSION >= 108800
 
+config RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS
+	def_bool RUSTC_VERSION >= 109800
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index a08eb5518cac..363f06b17240 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -27,6 +27,10 @@
 #[allow(dead_code)]
 #[allow(clippy::undocumented_unsafe_blocks)]
 #[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
+#[cfg_attr(
+    CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,
+    allow(suspicious_runtime_symbol_definitions)
+)]
 mod bindings_raw {
     // Manual definition for blocklisted types.
     type __kernel_size_t = usize;
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index c98d7a8cde77..f5c47f9cad10 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -25,6 +25,10 @@
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

