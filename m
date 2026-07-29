Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC5383C89;
	Wed, 29 Jul 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346704; cv=none; b=XULgGjWIFR3IvomGD3s73q2CigJZgPFMQeJNUPXSmZdH58QTbissEtOBbLUGk6zUbh5m5Ll1O5SDEm1IZ3jop5mcJuG2yZfQPOeM0qxQ3y+5z56DZkJ3VJcr7OAdgaR4UeZci4orWIOBCNblG84DMhWfjiWrc4ISFaUm/b2jDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346704; c=relaxed/simple;
	bh=bsLvFynu/CXBMzHlGGgM/SFQd72ZoIg57HRnqcar0O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I5avC22OjVDzEKSgwzIrBNQeaWYOZZ3nPygLxvARUPpquwliSDReMWpTc5V360gTdWb6eZONtC7C0XUlpYQSIjnhQxHCf6meNNOXaol3XKGjZ2SWmTQk7DJC6kq0MPE1eAcR6FXsk/nyD9bc172A07NHJK8l5fbSahhDaylvrlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2kYbAil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2kYbAil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480FF1F000E9;
	Wed, 29 Jul 2026 17:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785346697;
	bh=cz3Xwd0Y4aNXwEwh2ZkPURxr8/lpAyUMfh9PAUbMSNQ=;
	h=From:To:Cc:Subject:Date;
	b=o2kYbAilKOp8oNGZlW7MTddzfR7pp/8dz0PSNFo/Ffi4RNDGafA6HNJ+DcInk2f2x
	 b7ezGj1qX58jCgfqPLq6IEz7dxbous1YiX6ymgqAP51pvloyccDb8ySCrXzBKn7CH5
	 Urg4pxIZ744ztzD0dzcXWKcZiQsaX2dC8okA7KYCOS2mTpd+GX/ds8XYiASZMd/q57
	 UWOVjujp0xZeP9DMS1Rdr4L9WkCFDvweamu/BZhWoegkou2HOQEAYs0JLtxEGtJDjB
	 SDP07vcN4oFCL+LlCUltHSH+GandNvNSH42Q9Bnga6BcPq2smvgs7dZb8teX0/jCRv
	 THxao0tngdkSQ==
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
Subject: [PATCH] rust: kbuild: disambiguate `zerocopy` for `rusttest`
Date: Wed, 29 Jul 2026 19:38:03 +0200
Message-ID: <20260729173803.13459-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Antoni Boucher <bouanto@zoho.com>

Starting with Rust 1.76.0, `zerocopy` was added as an (indirect)
compiler dependency [1]. In turn, this meant that the `rustc-dev`
component started including a precompiled `zerocopy` crate in the sysroot.

This makes `rusttest` fail because the compiler finds several candidates:

    error[E0464]: multiple candidates for `rmeta` dependency `zerocopy` found
      --> rust/kernel/prelude.rs:64:9
       |
    64 | pub use zerocopy::{
       |         ^^^^^^^^
       |
       = note: candidate #1: .../lib/rustlib/x86_64-unknown-linux-gnu/lib/libzerocopy-dfef4cb07ca752aa.rmeta
       = note: candidate #2: ./rust/test/libzerocopy.rlib

We cannot use `--sysroot=/dev/null` for these, thus point to the dependency
explicitly.

Assisted-by: LLM
Not-yet-Signed-off-by: Antoni Boucher <bouanto@zoho.com>
Link: https://github.com/rust-lang/rust/pull/118546 [1]
Cc: stable@vger.kernel.org
Fixes: 567621523ab7 ("rust: zerocopy: enable support in kbuild")
[ Investigated when it started happening, reworded to add that and to
  follow our usual style and sent on behalf of Antoni, who found this
  during his work to support Rust for Linux with the GCC backend, i.e.
  with `rustc_codegen_gcc`. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 627ed79dc6f5..fbe0accc51a3 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -350,7 +350,7 @@ rusttestlib-pin_init: $(src)/pin-init/src/lib.rs rusttestlib-macros \
 rusttestlib-kernel: private rustc_target_flags = --extern ffi \
     --extern build_error --extern macros --extern pin_init \
     --extern bindings --extern uapi \
-    --extern zerocopy --extern zerocopy_derive
+    --extern zerocopy=$(objtree)/$(obj)/test/libzerocopy.rlib --extern zerocopy_derive
 rusttestlib-kernel: $(src)/kernel/lib.rs rusttestlib-bindings rusttestlib-uapi \
     rusttestlib-build_error rusttestlib-pin_init $(obj)/$(libmacros_name) \
     $(obj)/bindings.o rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE

base-commit: fc02acf6ac0ccde0c805c2daa9148683cdd01ba8
-- 
2.55.0

