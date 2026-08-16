Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80413C9C4;
	Sun, 16 Aug 2026 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786887185; cv=none; b=cVkRTKmcqKiXrbCt3XfYiLMMyTcofs3wuxVHg7qQCzulyKdBld0NRz0KYkxVIBLzTdnwdRlrHJ5ke3/bfSIxgO/rbGVW/mb0EtG5QaYrbhbxtMM0FHGAvJ3lyXBRo4LIRb3omCWpdCU32To/JabR/GqYIcHuIhHLsIMgXw0SLfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786887185; c=relaxed/simple;
	bh=MLfjsw0JBZcRdlxPiHziUwx3knMdv7Gn2SVbgTKsXU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCMxWXXH/rxOD2b/qZODY0YB/CjoLyQQ2M+FeMiWdrTuH+4ygRL28CNNKwfwp9RLCAogpknkont8PXRjVh7ziRY5r7fD4ZmpcLs59bF0VQyBHeQwv7gNCwE3axwUztMp9xqm4JGSGmc2iuO72bg3mqndsWQvPaEc0gx82WJ5YWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glvWrGfd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glvWrGfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03CB1F00A3E;
	Sun, 16 Aug 2026 13:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786887183;
	bh=luwyQJXB1GN1RlasPEWtbpJ2thGqpf94w7Kfk4/+644=;
	h=From:To:Cc:Subject:Date;
	b=glvWrGfdwUPorodlSB6tdapQXvVKorzwOmr3Eqx9sBEC0x3Xd5otY0bCTeK2dy3Fq
	 qb+wCW6b80Y/UwziNt7B4X31mVUrnlemMsw2Go1aE79uLbM74y7Ckw3mcyFe/7tEQC
	 VeKymMolDNTt1HI2S3QpN0msix4ELbeJxQg37P1Z4uzBSKCUrmmzSafQElNw/bYzBj
	 B6CCfHss9sg9mLhm8BsFa5aukNYX2jBOEBbB5/mlsj0racHyzCPMXfa7dJTXtN+oTq
	 Qj8REPI43wkbbENNIQiM4Aj1KAWotri8DSHo+1runr1wiWDJ1GmJSdfTudktTEXgVk
	 zC+i/RyAlAhQg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Matthew Maurer <mmaurer@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kbuild@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] kbuild: rust: preserve unreachable traps with inline helpers
Date: Sun, 16 Aug 2026 15:32:32 +0200
Message-ID: <20260816133233.197500-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `CONFIG_RUST_INLINE_HELPERS` is enabled, it is possible to hit
`objtool` warnings like:

    vmlinux.o: warning: objtool: _R..._4cmdq12CommandToGsp4init()
    falls through to next function _R..._4core5array4iter8IntoIterRShKj3_EEEBa_()

`rustc` normally emits traps for unreachable paths. However, under
`CONFIG_RUST_INLINE_HELPERS=y`, `rustc` emits LLVM bitcode and Clang
performs final code generation after the helper bitcode is linked,
but Clang does not trap unreachable IR by default.

In turn, this means `objtool` follows compiler-generated impossible Rust
`enum` paths through alignment padding into the next function, resulting
in fallthrough warnings.

Thus pass the LLVM `trap-unreachable` option to the final Clang invocation
and suppress traps immediately after `noreturn` calls, which `objtool`
already recognizes as dead ends. The combination of both flags makes it
match `rustc`'s behavior.

Rust 1.85.0 (the minimum supported one) supports LLVM >= 18, and both
flags are available in LLVM 18.

Assisted-by: LLM
Cc: Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Matthew Maurer <mmaurer@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Fixes: 3a2486cc1da5 ("kbuild: rust: provide an option to inline C helpers into Rust")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
I pinged Gary offline to ask if he had to deal with these `unreachable`
cases back when he sent the patch, and he didn't. So it looks like we
simply did not hit the case until now.

 Makefile               | 10 ++++++++++
 rust/Makefile          |  3 ++-
 scripts/Makefile.build |  3 ++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 902f3f3d54b7..85b84d895781 100644
--- a/Makefile
+++ b/Makefile
@@ -1083,6 +1083,16 @@ endif
 export CC_FLAGS_SCS
 endif

+ifdef CONFIG_RUST_INLINE_HELPERS
+# `rustc` normally emits traps for unreachable paths during code generation.
+# With inline helpers, Clang performs code generation from the linked bitcode
+# instead, so request the same behavior explicitly. Otherwise `objtool` may
+# follow an impossible Rust path into the next function.
+CC_FLAGS_RUST_INLINE_HELPERS := -mllvm -trap-unreachable \
+				-mllvm -no-trap-after-noreturn
+export CC_FLAGS_RUST_INLINE_HELPERS
+endif
+
 ifdef CONFIG_LTO_CLANG
 ifdef CONFIG_LTO_CLANG_FULL
 CC_FLAGS_LTO	:= -flto
diff --git a/rust/Makefile b/rust/Makefile
index fbe0accc51a3..f871d94f6af2 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -644,7 +644,8 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 		-Zunstable-options \
 	$(if $(link_helper),;$(LLVM_LINK) --internalize --suppress-warnings $(patsubst %.o,%.bc,$@) \
 		$(obj)/helpers/helpers$(if $(part-of-module),_module).bc -o $(patsubst %.o,%.m.bc,$@); \
-		$(CC) $(CLANG_FLAGS) $(KBUILD_CFLAGS) -Wno-override-module -c $(patsubst %.o,%.m.bc,$@) -o $@ \
+		$(CC) $(CLANG_FLAGS) $(KBUILD_CFLAGS) \
+		$(CC_FLAGS_RUST_INLINE_HELPERS) -Wno-override-module -c $(patsubst %.o,%.m.bc,$@) -o $@ \
 		$(cmd_ld_single)) \
 	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@) \
 	$(cmd_objtool)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 911745743246..0b3b81f4a652 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -346,7 +346,8 @@ quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_o_rs = $(rust_common_cmd) --emit=$(if $(CONFIG_RUST_INLINE_HELPERS),llvm-bc=$(patsubst %.o,%.bc,$@),obj=$@) $< \
 	$(if $(CONFIG_RUST_INLINE_HELPERS),;$(LLVM_LINK) --internalize --suppress-warnings $(patsubst %.o,%.bc,$@) \
 		$(objtree)/rust/helpers/helpers$(if $(part-of-module),_module).bc -o $(patsubst %.o,%.m.bc,$@); \
-		$(CC) $(CLANG_FLAGS) $(KBUILD_CFLAGS) -Wno-override-module -c $(patsubst %.o,%.m.bc,$@) -o $@ \
+		$(CC) $(CLANG_FLAGS) $(KBUILD_CFLAGS) \
+		$(CC_FLAGS_RUST_INLINE_HELPERS) -Wno-override-module -c $(patsubst %.o,%.m.bc,$@) -o $@ \
 		$(cmd_ld_single)) \
 	$(cmd_objtool)


base-commit: 47f27155f17498fccb1f222f79089642337498a9
--
2.55.0
