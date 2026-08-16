Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148081F427C;
	Sun, 16 Aug 2026 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786887190; cv=none; b=aBD4+jhJsloJoycUAKr3nAIg1NBrGw+0gJPll8gOGP8PJp0RBHjPex73yPa9ppVFeQj0CwnWGIZvYKO4deqW9TNv3knuLugByTGJAvZJOQwEdy15cT82eOPTPuM32oQI8mtpr0Tc/J6z38Apjhz6AIFjVs4B8OyzPdNxA0nM/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786887190; c=relaxed/simple;
	bh=5iViqrtuiYjowEv84cPsF4YhtQkTdlKxLPMIseafVhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cix8V/Ixgsaa0aeXjMOS9RpdoGDhS5T5CKvGbgxtuQbBVqeVrP7QW3UwSvB2hwXWPI6S0HJHqXMzsza9OiF6ZAqFReQnVYOeuSsGuNSMApVj5a6y1V2CRDVl/4iG488sjfCPuy+Vu8Sibq58l8jGuqnjFJE6Q7eMtrG8dFVrMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz3QNuui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz3QNuui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036E01F00ACA;
	Sun, 16 Aug 2026 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786887188;
	bh=ynufwqLeA6bQ7foSOOmJD2OeEh+eIuScndOhi6Sfq5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dz3QNuui+oLNC+qkkeCSURUCXpPHwgEWoY3l30qzHqYuhqUrQ4kX8v04XZgfhTfUr
	 cw2RBfTFNUsVlcnnQMrZeKb3XpyfRCOYvOlgMtYDup2LE6dClWnlrOTqm1RuskRE4r
	 KuUexx7m7a/KgQtsNDAsAg490Uc5zDEXtpik5CG8QGjf7pPUexGrPVGUt9+NsYxLQ3
	 wcShIjhmBvFkggkey3eY7Yz3G5ntGhe0IXfDaC5JbYsugt8q9iyvrtIXkdixYSQbT8
	 9QKySLgfFNeY3cSAkUhSzWDAUAtduKbE/OerurC4yhlZIG3lcp5iBNqw12omjfFhdS
	 OamESoKhIiHFQ==
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
Subject: [PATCH 2/2] kbuild: rust: keep Rust objects out of Clang LTO with inline helpers
Date: Sun, 16 Aug 2026 15:32:33 +0200
Message-ID: <20260816133233.197500-2-ojeda@kernel.org>
In-Reply-To: <20260816133233.197500-1-ojeda@kernel.org>
References: <20260816133233.197500-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under `CONFIG_LTO_CLANG` + `CONFIG_RUST_INLINE_HELPERS`, one may hit
`objtool` errors such as:

    vmlinux.o: error: objtool: _R..._3Gsp4boot+0xd6a:
    can't find jump dest instruction at .text._R..._3Gsp4boot+0x1dfd

The reason is that in such builds, the Clang invocation that compiles
the combined Rust plus helpers bitcode emits LLVM bitcode (again) --
the final code generation happens in the linker's LTO step, which the
`-mllvm` trap options passed to Clang do not reach.

This, in turn, means that unreachable traps are missing, and the
impossible paths do not merely fallthrough to the next symbol, but past
the end of their own section, since LTO builds place each function in
its own section.

Thus filter `CC_FLAGS_LTO` out of the Clang invocation, so that it always
emits machine code directly, with the traps in place.

Assisted-by: LLM
Cc: Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Matthew Maurer <mmaurer@google.com>
Cc: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 3a2486cc1da5 ("kbuild: rust: provide an option to inline C helpers into Rust")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
This is like the previous patch, but for the LTO case.

Another possible alternative that Gary suggested is to turn the flags on
globally for C, whether only when inline helpers are enabled or in all
cases, but it may be intended that in C we expect not to generate the
`unreachable`s.

Even if we do that later, we may want to still land this as the minimal
fix for backporting, since it only affects the experimental option and
only the Rust side.

 rust/Makefile          | 2 +-
 scripts/Makefile.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index f871d94f6af2..3afaad4a4a3a 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -644,7 +644,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 		-Zunstable-options \
 	$(if $(link_helper),;$(LLVM_LINK) --internalize --suppress-warnings $(patsubst %.o,%.bc,$@) \
 		$(obj)/helpers/helpers$(if $(part-of-module),_module).bc -o $(patsubst %.o,%.m.bc,$@); \
-		$(CC) $(CLANG_FLAGS) $(KBUILD_CFLAGS) \
+		$(CC) $(CLANG_FLAGS) $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS)) \
 		$(CC_FLAGS_RUST_INLINE_HELPERS) -Wno-override-module -c $(patsubst %.o,%.m.bc,$@) -o $@ \
 		$(cmd_ld_single)) \
 	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@) \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0b3b81f4a652..0b71f759eb5c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -346,7 +346,7 @@ quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_o_rs = $(rust_common_cmd) --emit=$(if $(CONFIG_RUST_INLINE_HELPERS),llvm-bc=$(patsubst %.o,%.bc,$@),obj=$@) $< \
 	$(if $(CONFIG_RUST_INLINE_HELPERS),;$(LLVM_LINK) --internalize --suppress-warnings $(patsubst %.o,%.bc,$@) \
 		$(objtree)/rust/helpers/helpers$(if $(part-of-module),_module).bc -o $(patsubst %.o,%.m.bc,$@); \
-		$(CC) $(CLANG_FLAGS) $(KBUILD_CFLAGS) \
+		$(CC) $(CLANG_FLAGS) $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS)) \
 		$(CC_FLAGS_RUST_INLINE_HELPERS) -Wno-override-module -c $(patsubst %.o,%.m.bc,$@) -o $@ \
 		$(cmd_ld_single)) \
 	$(cmd_objtool)
--
2.55.0
