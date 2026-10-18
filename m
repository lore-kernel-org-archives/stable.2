Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11BE3DB319;
	Sun, 18 Oct 2026 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792346121; cv=none; b=KLKg3Zm0h/N9tbhyklpVXc3SCfeXiOXurSTrUMqTgs4Dtm1VeSJJlrwVOirVug5SctWJuF5dmWYULOYwFtqL+DhNiOsDotxGycXY8fRpOVEBVcQSs3NsZCt2yDpkSRPYNBT5ip049Sq6DcBbA1geQMauEKb9jirCv1xxIHXvsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792346121; c=relaxed/simple;
	bh=7l2sFAOA+riNLnQy8/2UhOtgqkntq568HwEiS8C5NOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZV6DYXLASMIXub/O9pCKZJIDTqQuZ0lIxonNFg/3C2odCNEkHGs1tUS7cuAZrlpJIfOx5VEtkvkbjsyqUxRrv9EOQ6Wunrp7IYSuNUO2nB3fj8wPbpqx4S3bz8Ku0VU2GUcAAPFbpsw5hDJMwnIvGV7llUT4wsWqhUJTFVBoJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USjHVZ9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USjHVZ9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538241F000C4;
	Sun, 18 Oct 2026 17:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792346116;
	bh=GJPWC7Dv/8Zu9VFBB9DaMsNp4lUWVw8pVcd4e33MU34=;
	h=From:To:Cc:Subject:Date;
	b=USjHVZ9kTGj8Lgd/AJ577Xvr7miuvKYM/INRj98JRpTI81yvkGFt0XpBeeMVBfNXS
	 Lgz371uasIFIk9Xb5/7m/EocWeAL2O9BBO+us4H39uKGCalyaMUM4R+GyQe5RdjBol
	 qYUmph1i0LIuSHCpPIte82PAUEdDpMWLdlQ5zr1K5psmuTBkEEIMJa4ExJ/LvdTs5Z
	 BprFel0+mFWzgRGcqQ2Zzg1zCCiiKydsgv9Cn/KdSueeSiyTpJVdsnxfm1Gf6NNCqm
	 KHR0p+3PNHWpmCWf1pvOYgCM3x0l8PIctdN5fuWLoR5jCYxKexSn7GhDMbZkWCPakz
	 dpgJrZ1MOP1SA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Boqun Feng <boqun@kernel.org>,
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
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] x86/rust: use `-Zindirect-branch-cs-prefix` for RETPOLINE builds
Date: Sun, 18 Oct 2026 19:54:57 +0200
Message-ID: <20261018175457.87803-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C compiler is asked to add a `cs` prefix to the `call` and `jmp`
instructions that go through the indirect thunks for the `r8`-`r15`
registers, which makes them 6 bytes long instead of 5. That gives
`patch_retpoline()` enough room to inline them, e.g. as `lfence; call
*%r11` for `spectre_v2=retpoline,lfence`.

However, Rust code does not get the prefix, e.g. for a
`CONFIG_MITIGATION_RETPOLINE=y` build:

    $ objdump -dr rust/kernel.o
    ...
      e2b: e8 00 00 00 00        call   e30 <...>
                e2c: R_X86_64_PLT32  __x86_indirect_thunk_r11-0x4

Moreover, since commit 4a1e02b15ac1 ("x86,retpoline: Optimize
patch_retpoline()"), `emit_indirect()` assumes there is enough room
for the inlined sequence -- e.g. with `spectre_v2=retpoline,lfence`,
the kernel warns and dies while patching a site inside `core`:

    WARNING: arch/x86/kernel/alternative.c:736 at apply_retpolines+0x2ee/0x400, CPU#0: swapper/0/0
    ...
    Call Trace:
     <TASK>
     ? _RNvMs6_NtNtCshS2CUL9MEDn_4core3fmt8buildersNtB5_9DebugList21finish_non_exhaustive+0x5b/0xd0
     ...
     alternative_instructions+0x1d/0x60
     arch_cpu_finalize_init+0x5a/0xb0
     start_kernel+0x1f4/0x280

Similarly, paranoid FineIBT rewrites each kCFI call site into a fixed
20-byte sequence, i.e. the 14 bytes of the kCFI check plus a 6-byte
call. For a 5-byte call, that overwrites the first byte of the next
instruction, corrupting Rust code:

    SMP alternatives: Using paranoid FineIBT CFI
    ...
    Oops: double fault: 0000 [#1]
    ...
    RIP: 0010:_RNvNtCsdVypMZsLRAh_4core3fmt5write+0x1e9/0x210
    Code: ... b8 68 81 16 9f 41 3b 43 f5 2e 4d 8d 5b f0 75 fd 41 ff e3 <cc> c0 eb 02 b0 01 ...
    ...
    Kernel panic - not syncing: Fatal exception in interrupt

Non-paranoid FineIBT is not affected, since it only rewrites the kCFI
check and leaves the call itself to `apply_retpolines()`.

We added support for `-Zindirect-branch-cs-prefix` [1][2] in Rust 1.91.0
[3]. Thus pass it for `RETPOLINE` builds when possible, which makes all
sites indeed get the prefix:

      e3c: 2e e8 00 00 00 00     cs call e42 <...>
                e3e: R_X86_64_PLT32  __x86_indirect_thunk_r11-0x4

The kernel above boots fine with `spectre_v2=retpoline,lfence`, inlining
the Rust sites as well.

For older Rust compilers, set the LLVM module flag instead, which
has the same code-generation effect. This means that every Rust version
that the kernel supports gets the prefix, that the kernel boots fine with
`spectre_v2=retpoline,lfence`, and that paranoid FineIBT no longer
corrupts.

In addition, add it to our target modifier workaround for `rustdoc`.

Cc: stable@vger.kernel.org # 6.18.y+
Link: https://github.com/rust-lang/rust/issues/116852 [1]
Link: https://github.com/rust-lang/compiler-team/issues/899 [2]
Link: https://github.com/rust-lang/rust/pull/140740 [3]
Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Assisted-by: LLM
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 arch/x86/Makefile | 1 +
 rust/Makefile     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 8af6b80cffdd..01c848855f99 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -21,6 +21,7 @@ RETPOLINE_CFLAGS	:= -mretpoline-external-thunk
 RETPOLINE_VDSO_CFLAGS	:= -mretpoline
 endif
 RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)
+RETPOLINE_RUSTFLAGS	+= $(if $(call rustc-min-version,109100),-Zindirect-branch-cs-prefix,-Zllvm_module_flag=indirect_branch_cs_prefix:u32:1:override)
 
 ifdef CONFIG_MITIGATION_RETHUNK
 RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
diff --git a/rust/Makefile b/rust/Makefile
index da1a7409d984..35868a47e18b 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -167,7 +167,7 @@ pin_init-flags := \
 rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),-Cunsafe-allow-abi-mismatch=fixed-x18)
 
 # Similarly, for doctests (https://github.com/rust-lang/rust/issues/146465).
-doctests_modifiers_workaround := $(rustdoc_modifiers_workaround)$(if $(call rustc-min-version,109100),$(comma)sanitizer)
+doctests_modifiers_workaround := $(rustdoc_modifiers_workaround)$(if $(call rustc-min-version,109100),$(comma)sanitizer$(comma)indirect-branch-cs-prefix)
 
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.56.0

