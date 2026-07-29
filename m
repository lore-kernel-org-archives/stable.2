Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8D42AFB7
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331595; cv=none; b=M5ak+zZIDo7Kobwp6khZkJ4YO+BfqyE5qn+lFlaSo4wY9ogb1IfKJjraX7NsZa6/m80F2Se1kpdYffuV1+0o2B/saRExbdGj1PKYK8eWcS3hcoVdVzQ5fKO5Zhb3o2qxuROE1TEC7S1PhVqEqockth/xf67zhBrLyEzqxhHUhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331595; c=relaxed/simple;
	bh=mxanZ0pRd6Fn2hEOynYzEaTlLcWDHSCCcKxp7lkv1Yg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nh09cJ4K0QPMt6S+YqAvW+OxnB8516aRYuAmJCAMaEL+mpWq6m9A3/XIwOMHJWi9liqlbMLbZ/EmFn/ysNP8b5V9N/EGesOIE3//NV6CZKGBaTSkWc0BOeaT2dL2Z/sibtCVHWxK8jBRnDx1pxuwZuMf4kDKP8+i/Zd6Tf+GXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xxZrumpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xxZrumpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808171F000E9;
	Wed, 29 Jul 2026 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331594;
	bh=vQ97Wg2Qlbuv0aM71H8KYbVSDFNR9n4W9c87pRPAhiA=;
	h=Subject:To:Cc:From:Date;
	b=xxZrumpvWs/8idxdJuH35Edb7PNUxt0MVQc/cfgrj20L2THQSmulvsEzBi5UxUoQO
	 i2V9/LXjCPGag0uHSALCi0r/JQ5Tu5PYV7xrf9iV1rNJ2TiBm04nJy5beehC2kBaaf
	 ovndZpL5ODZUzmonB9OrfmaNpyqtfP3Fl8dU73ZA=
Subject: FAILED: patch "[PATCH] rust: allow `suspicious_runtime_symbol_definitions` lint for" failed to apply to 6.18-stable tree
To: ojeda@kernel.org,aliceryhl@google.com,gary@garyguo.net,tamird@kernel.org,urgau@numericable.fr
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:26:20 +0200
Message-ID: <2026072920-prorate-semifinal-1bca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 608045a91d9176d66b2114d0006bc8b57dff2ca9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072920-prorate-semifinal-1bca@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 608045a91d9176d66b2114d0006bc8b57dff2ca9 Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Mon, 15 Jun 2026 16:32:25 +0200
Subject: [PATCH] rust: allow `suspicious_runtime_symbol_definitions` lint for
 Rust >= 1.98

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

diff --git a/init/Kconfig b/init/Kconfig
index 5230d4879b1c..10f2013b5321 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -190,6 +190,9 @@ config RUSTC_HAS_FILE_WITH_NUL
 config RUSTC_HAS_FILE_AS_C_STR
 	def_bool RUSTC_VERSION >= 109100
 
+config RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS
+	def_bool RUSTC_VERSION >= 109800
+
 config PAHOLE_VERSION
 	int
 	default "$(PAHOLE_VERSION)"
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 854e7c471434..812f8e5a08d5 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -27,6 +27,10 @@
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
index b8a515de31ca..797ead5b5626 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -24,6 +24,10 @@
     unsafe_op_in_unsafe_fn
 )]
 #![cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
+#![cfg_attr(
+    CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,
+    allow(suspicious_runtime_symbol_definitions)
+)]
 #![feature(cfi_encoding)]
 
 // Manual definition of blocklisted types.

