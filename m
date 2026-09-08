Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C857269E;
	Tue,  8 Sep 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887168; cv=none; b=mhORzMorO4rBMwwLmKJA3oKYMA0UIKBaBhF8WCKawBrJ6XSq1K8iSUrv3PZZoY9WVy4QJl7KTYa+V7aeZCXWYgpRUdlq4fZG3/h9yGVn2VM3LyGuyFClxrbvWEpsmz7EiGoKcrPOPfw3Ck/m8ixKzIWmAfErC/D8eERopoEdzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887168; c=relaxed/simple;
	bh=DmEcGIuIViBHOha3ytewODV0Ikb5MB58pqUxXeUM82g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IRpTMTAbN5qu/XOZOfX6n9im7y+b3EhEiVuAuAsIFGmYwVVdEyNf800jY0pE1aZ0wB142hhyx/A3lAi5gjbPM4twHgxBpcdj73Vf6vZw/JFR8coFkfileSB9r31l983vtjdkkHINLplb72TaYLWwiCpEcWAKkcqW3Xc3cr8+OaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVSpAPYN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVSpAPYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D271F00A3A;
	Tue,  8 Sep 2026 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887167;
	bh=+7xs9pGKZgdoziLh6xyiceOfRslnYaDU2pz1U7G3dSI=;
	h=From:To:Cc:Subject:Date;
	b=WVSpAPYNxRe6LcTsDo+lu312p9poJqbRtg25DQgyFu6qkfNoo+FFRw9WzS6eZ98oV
	 Jhl7Yqm1DGo+zAdYooA7dv/Ep1Mok+a6dp+URkggUjn8lyseBlZPQ63WmF53CcldtU
	 WFe58HWrrU5y7+NL3k1xAXiJvJjRV9h2nM/ZXmNWmGUVJa+g0lNp1fTMQmvOHtjjvM
	 3KeFyFDHGvzeTUTPLA8cDCVvGClwxLElm8rzVdHDYHTxJ/hSk4lKCd+s75Jee/+GCL
	 MuBBfl1n5aM/v3v8oKwL/yMV0zyTeiry4vKC68/r8GMs/8o1QcDSwivv019hhSPvIt
	 gOdhqCPyeyTug==
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
	stable@vger.kernel.org,
	=?UTF-8?q?Emilio=20Cobos=20=C3=81lvarez?= <emilio@crisal.io>
Subject: [PATCH] rust: allow `unknown_lints` in generated bindings for Rust < 1.88
Date: Tue,  8 Sep 2026 19:05:39 +0200
Message-ID: <20260908170539.345207-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Starting with bindgen 0.73.2 [1], `#[allow(unnecessary_transmutes)]`
are used, even when `--rust-target 1.85` is passed.

However, the lint was introduced in Rust 1.88.0. Thus building with
older Rust versions warns like:

    error: unknown lint: `unnecessary_transmutes`
         --> rust/uapi/uapi_generated.rs:26294:13
          |
    26294 |     #[allow(unnecessary_transmutes)]
          |             ^^^^^^^^^^^^^^^^^^^^^^
          |
          = note: `-D unknown-lints` implied by `-D warnings`
          = help: to override `-D warnings` add `#[allow(unknown_lints)]`

Thus allow `unknown_lints` in the generated bindings -- only when building
with older Rust versions.

I have asked upstream if this is intentional [1], i.e. if we are supposed
to always allow unknown lints in case `bindgen` uses such attributes,
or whether it is an oversight.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Cc: Emilio Cobos Álvarez <emilio@crisal.io>
Link: https://github.com/rust-lang/rust-bindgen/pull/3455 [1]
Assisted-by: LLM
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/bindings/lib.rs | 1 +
 rust/uapi/lib.rs     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index ad24c920b919..9e2c9a8e7e6c 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -27,6 +27,7 @@
 #[allow(clippy::ptr_as_ptr)]
 #[allow(clippy::ref_as_ptr)]
 #[allow(clippy::undocumented_unsafe_blocks)]
+#[cfg_attr(not(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES), allow(unknown_lints))]
 #[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
 #[cfg_attr(
     CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 2df0340e63d1..c1e27192ecce 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -24,6 +24,7 @@
     unreachable_pub,
     unsafe_op_in_unsafe_fn
 )]
+#![cfg_attr(not(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES), allow(unknown_lints))]
 #![cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
 #![cfg_attr(
     CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,

base-commit: 2ac74c6db40adaa29c50cbb281ae9a6f63de18e1
-- 
2.55.0

