Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFA8392C2A;
	Sun, 23 Aug 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513757; cv=none; b=BnECSMULYWHhxgMEnZBFooKokfH/swystKld98EWEIeTjmeJsmZOrDgHv86alojK5Ym2cWMnzpNwtbdx1PMBQyBMqTN5fvCzv0msvBNWzXdF/j9MzscESAIlShN6H1ZZdbwSIFC25IUKZxh3EJg63OUkaS5cQKopHSLHbUIWlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513757; c=relaxed/simple;
	bh=B0EHy5luBwpbyVkzNvJNHLHYVgfhcpDnZmTQmLL3YP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJHpoJrHwMUnYqJplCFXzZx9MKWNbVsCFza0gsQZ1XiAQpv7fi/nwNONTeza89zJL2nH3vS5Rk0+wE55ClPolw8nczTup5uA6E9Vcv6WDAVkh08+O2t7Nwf2C5oOoYxiIJEwNp6kSM+mOtUk+5RxI9PxXFIplHKVjGfOHM3YYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmPHkESJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmPHkESJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4112A1F000E9;
	Sun, 23 Aug 2026 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787513755;
	bh=GyaiaqYBOLAIDvcsIPioUD4VrBP8Th+NKRAqNY6Pp3o=;
	h=From:To:Cc:Subject:Date;
	b=nmPHkESJSxbNFBvzH/Tdk5p7a431mlLs9C60STZAfwyo+p94T6D/DyPLyqPRhzl/e
	 QU/NfvGanAFLhFFX3t9MeWoGvJRyVjA6z0oKEFGqDqEd5xIjcN9gWSdLBxeNdWIwlX
	 e7Nsg9NIlpWpvDbvVDFtvk3JLp8WB7ZJUf4zjC9wHumjMkaAc1mNa4RV0eUwkQWlnm
	 RYJPmjoZnlQ5aSgcPMqViNgVDcHPx4wxKisXoFWMK9mfivA6dkjlv9Z289gXcqdYDD
	 kzZQ9syfGR3LiLG63LQJpHak6gkYpG1pXwbGaxz7rtQUcRYaVTFRmILPU6RIOM8McH
	 F/HJY621U5wAQ==
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
	Antoni Boucher <bouanto@zoho.com>,
	stable@vger.kernel.org
Subject: [PATCH] rust: kbuild: disambiguate `zerocopy_derive` for `rusttest`
Date: Sun, 23 Aug 2026 21:35:29 +0200
Message-ID: <20260823193529.156066-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `rustc-dev` components for Rust 1.82.0 through 1.87.0 include a
precompiled `zerocopy_derive` procedural macro in the sysroot. This
range includes Rust 1.85.0, our minimum supported version.

This makes `rusttest` fail because the compiler finds both the sysroot
copy and the copy built in `rust/test`:

    error[E0464]: multiple candidates for `dylib` dependency `zerocopy_derive` found
      --> rust/kernel/prelude.rs:70:9
       |
    70 | pub use zerocopy_derive::{
       |         ^^^^^^^^^^^^^^^
       |
       = note: candidate #1: .../lib/rustlib/x86_64-unknown-linux-gnu/lib/libzerocopy_derive-54d2b38896fa6bc5.so
       = note: candidate #2: .../rust/test/libzerocopy_derive.so

Commit fe39a233ea52 ("rust: kbuild: disambiguate `zerocopy` for
`rusttest`") fixed the equivalent ambiguity for `zerocopy`.

Thus point to the dependency explicitly in this case too.

Cc: Antoni Boucher <bouanto@zoho.com>
Cc: stable@vger.kernel.org
Fixes: 506054980429 ("rust: zerocopy-derive: enable support in kbuild")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index fbe0accc51a3..a346a01bb3eb 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -350,7 +350,8 @@ rusttestlib-pin_init: $(src)/pin-init/src/lib.rs rusttestlib-macros \
 rusttestlib-kernel: private rustc_target_flags = --extern ffi \
     --extern build_error --extern macros --extern pin_init \
     --extern bindings --extern uapi \
-    --extern zerocopy=$(objtree)/$(obj)/test/libzerocopy.rlib --extern zerocopy_derive
+    --extern zerocopy=$(objtree)/$(obj)/test/libzerocopy.rlib \
+    --extern zerocopy_derive=$(objtree)/$(obj)/test/libzerocopy_derive.so
 rusttestlib-kernel: $(src)/kernel/lib.rs rusttestlib-bindings rusttestlib-uapi \
     rusttestlib-build_error rusttestlib-pin_init $(obj)/$(libmacros_name) \
     $(obj)/bindings.o rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE

base-commit: d24f5cdbeff8b6a063fca92d0a1f94122a799b59
-- 
2.55.0

