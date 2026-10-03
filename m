Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A341BA94
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791038542; cv=none; b=Zrns5o1c+BOh/APb2Bzrn61y6XT/AV0pkSkEFm2XUYZZ+QE5bBx2QQnQ2N0NRiZlYb1FXv489iw5x94Kg9i2YG62mQYaLuYBjumH9ZibVnHqJdu4JaAGOszggZUTVE9a/A3Q8oxpCXTL1tPQf3vXyavRhmgqEI1PZAFgeqEzpwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791038542; c=relaxed/simple;
	bh=pcSYZH6Ies06S02B6vepGcPN9pkkQEtbKpXNem2+n8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNtYdrFZYG95gha3JjYKRNCROdNj0lXiVOar7QidMBq6yNirlVBTCQ2rlM9I5XRhA4XebZau+LdBuXdxHsRgNJI4d2ieXudIUsahakYcPGsdWXbqSuY/Urjh08ZQSCfjmv+aL6Q0ZrOfGgepkDDehnHx7ruiXzAf2rM0vxgJIpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc64hMyO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc64hMyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6D91F0089B;
	Sat,  3 Oct 2026 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791038531;
	bh=GmWAOcdLSjYiwTPutSBrDvmZiRsVeXBhVouXC5i4oME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hc64hMyOdOwKy5Z/Ff4hgw4Imu9Wh0rfG12QyURbPcVEdPU0s6x9MmjLmOZwtnIK5
	 7lBuaooOjIpMqNEG8Iq8QxvHj1v/MxTjtbrKZanNH+EwqTeBXPkNVc9IP3OAGwX+9U
	 SAjawz/2zfuYBgh2Dnm2RsVNcWvriTHL51ra/FhKqr1o6uBwd91V6RfA92LSYZnscH
	 fBnKlqbYsgcFSBTsYkWJ6UEQ0L+E1noU6wG5EV3/BtWCp49yY7gWeiA1gxa8JwqU/w
	 xWLkmxgutuYO9nXWOeQfg8DIuR2VLOej8Hjr1x26Mjwj54SSqu0X2uSy1LCY4HRXkA
	 fEHquIvPEoKxg==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Jason@zx2c4.com,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.12.y] random: vDSO: avoid call to memset() when zeroing reserved parameter
Date: Sat,  3 Oct 2026 16:41:56 +0200
Message-ID: <20261003144155.1375966-2-nathan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026100346-hurt-purgatory-f0b6@gregkh>
References: <2026100346-hurt-purgatory-f0b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit eb13a1ff271b0d180687eebb30611b0b276d5193 upstream.

After a recent change in LLVM [1], builds with the random vDSO
implementation, such as PowerPC and RISC-V, fail when checking the vDSO:

  arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not supported
  arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported

memset() is now generated when zeroing params->reserved for some builds
because LLVM has an optimization (now run in more instances) that can
recognize at compile time when it is assigning a static value to a
contiguous area of memory and turn that into a call to memset(). Both
clang and GCC assume memset() is always available [2].

Clang has an internal fiddly hook, -max-store-memset, which we can set
to a high number, to disable generating out of line memset calls [3].
Similarly, GCC has -finline-stringops=memset to do the same [4], should
this issue ever hit future version of GCC. While these options wouldn't
make sense for normal kernel code, it is fine for the extremely limited
and intentionally compact vDSO code.

Link: https://github.com/llvm/llvm-project/commit/90cebef1411617fc3eedd359bdf00cb44b1c2439 [1]
Link: https://gcc.gnu.org/onlinedocs/gcc-16.2.0/gcc/Standards.html#index-ffreestanding [2]
Link: https://github.com/llvm/llvm-project/commit/b28eeb28bea39148738dc375e8a97072a1907e64 [3]
Link: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#index-finline-stringops [4]
Closes: https://github.com/ClangBuiltLinux/linux/issues/2183
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
[nathan: Backport to 6.12]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/kernel/vdso/Makefile   | 2 +-
 arch/loongarch/vdso/Makefile      | 1 +
 arch/powerpc/kernel/vdso/Makefile | 1 +
 arch/s390/kernel/vdso64/Makefile  | 1 +
 arch/x86/entry/vdso/Makefile      | 1 +
 init/Kconfig                      | 5 +++++
 6 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 35685c036044..c4934b22d5e9 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -40,7 +40,7 @@ CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
 			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
 			-Wmissing-prototypes -Wmissing-declarations
 
-CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
+CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables $(CONFIG_CC_OPT_INLINE_MEMSET)
 
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_REMOVE_VDSO)
 CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_REMOVE_VDSO)
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index b37cda634644..60fa1a8d80e6 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -13,6 +13,7 @@ ccflags-vdso := \
 	$(filter -E%,$(KBUILD_CFLAGS)) \
 	$(filter -march=%,$(KBUILD_CFLAGS)) \
 	$(filter -m%-float,$(KBUILD_CFLAGS)) \
+	$(CONFIG_CC_OPT_INLINE_MEMSET) \
 	$(CLANG_FLAGS) \
 	-D__VDSO__
 
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 6ba68b28ed87..0d29880e3b15 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -43,6 +43,7 @@ ccflags-y := -fno-common -fno-builtin -DBUILD_VDSO
 ccflags-y += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 ccflags-y += $(call cc-option, -fno-stack-protector)
 ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += $(CONFIG_CC_OPT_INLINE_MEMSET)
 ccflags-y += -ffreestanding -fasynchronous-unwind-tables
 ccflags-remove-y := $(CC_FLAGS_FTRACE)
 ldflags-y := -Wl,--hash-style=both -nostdlib -shared -z noexecstack $(CLANG_FLAGS)
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 37bb4b761229..1f0fdb785ca7 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -32,6 +32,7 @@ KBUILD_CFLAGS_64 := $(filter-out -mno-pic-data-is-text-relative,$(KBUILD_CFLAGS_
 KBUILD_CFLAGS_64 := $(filter-out -munaligned-symbols,$(KBUILD_CFLAGS_64))
 KBUILD_CFLAGS_64 := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_64))
 KBUILD_CFLAGS_64 += -m64 -fPIC -fno-common -fno-builtin -fasynchronous-unwind-tables
+KBUILD_CFLAGS_64 += $(CONFIG_CC_OPT_INLINE_MEMSET)
 ldflags-y := -shared -soname=linux-vdso64.so.1 \
 	     --hash-style=both --build-id=sha1 -T
 
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac4fb1e..e5ade5e89e7e 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -54,6 +54,7 @@ $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
        $(filter -g%,$(KBUILD_CFLAGS)) -fno-stack-protector \
        -fno-omit-frame-pointer -foptimize-sibling-calls \
+       $(CONFIG_CC_OPT_INLINE_MEMSET) \
        -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
 ifdef CONFIG_MITIGATION_RETPOLINE
diff --git a/init/Kconfig b/init/Kconfig
index f0e708b4226d..7b3d72f3a14d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -132,6 +132,11 @@ config CC_HAS_COUNTED_BY
 	# https://github.com/llvm/llvm-project/pull/112636
 	depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)
 
+config CC_OPT_INLINE_MEMSET
+	string
+	default "-finline-stringops=memset" if $(cc-option,-finline-stringops=memset)
+	default "-mllvm -max-store-memset=4294967294" if $(cc-option,-mllvm -max-store-memset=4294967294)
+
 config LD_CAN_USE_KEEP_IN_OVERLAY
 	# ld.lld prior to 21.0.0 did not support KEEP within an overlay description
 	# https://github.com/llvm/llvm-project/pull/130661

base-commit: 7aba70ab2e8d8ab3cd45abcaa15e1119a00dc42a
-- 
2.55.0

