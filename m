Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050076;
	b=1Fwbkr2loLQ9Gyl/Xp4E41byTKNIq3/23xNi2Yd7TLtxbF5VCLe4m5tDZXIqK1o6+4/E
	 zwFVopO5gpnT7hWiBdPp8Mly4U2/YbxvgLK+sZzkpt+QrmnS0GGj2SZtKZJW4GLlbYUnB
	 aBepF7Un5PKtiw3/z7vyEr7G6QH5nr33HEVhPZnol7fbz6p6CrUOEYTyt568HYSTFxhx9
	 a0Al2cJcaW6FrZ3Jf22sC9iX41amrzmpflVb9vTwZFHrfhLRmtCE7mGH3jg6Pfja/J3nR
	 hLO+nBAbXM9u5xkyJLEZnXru+kXOdvYdswcj83BJC9XObSCpid3c/vneSUocCRNxddw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050076;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lY3BhE2N3l5hJcXocw65jXndg+TefZ1czuF48rFrR1s=;
	b=Xjt+o6v586Xz8u+4kPrdjs/vlFnmIKFFlcf3wVOOmaurr4IegvRN9Jo/aUdZjLbUrCE6
	 w6HqrCYQk9+yonOhgmEGnGd8LWMMeFab541pf3lVhxKqszwTBRut+66CvZzDF00J091Ff
	 SNuo/5Gc/JXD+G1fGuPhgxOy/ZrqyIrApaXWtDGaqDf9xlojh/488ixYWbCCUa6GrKxtu
	 8nYJwIdmWNmm0N7hDzwUB43oEn3+v+uq1XlziRWnVL4K/RXtiWtv+row8Pv9ks46xD3eT
	 /85pwKIkNU0Nf3LAcznbUbXmhlTSAfRK0dwWNs7jZSNy2E7nfdUXBpVsc900HRTQ8ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgUnX8jz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B0606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgUnX8jz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CF51F0089F;
	Sat,  7 Nov 2026 11:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050075;
	bh=lY3BhE2N3l5hJcXocw65jXndg+TefZ1czuF48rFrR1s=;
	h=From:To:Cc:Subject:Date;
	b=BgUnX8jzfgkM3XQsC6RsPc5E+h9H0qltnI9HuKGmuIao+qsngPc0NTYcnp4mLfGj8
	 DuUcoBI8jR7RyCn7B9qL/1CSnzOvyPci8tnMPd3slf/eRpLR12OUoPXNqXcmkcqoJz
	 7KjyKaALTugnBGBc8R3VRUqifMwp6mGGu/mdhbZPrf38JlvlJP3RyN4NkYc0G2cWWa
	 hi/1o7Cn88iRrLo5B47DwvaIBnBsqtpArJ6Supc1KvYjZsxnSh6ekMF6fLSqj4ouS6
	 ve6xbDXoUh33pq2SKBLBp0EyhfL2hoRzOrlh8ddoMJw0e7C2EFbflrBmcAIzsh+/TR
	 2xkQKv5i1KwOA==
From: Sasha Levin <sashal@kernel.org>
To: linux@yoavmoshe.com,
	ndesaulniers@google.com,
	samitolvanen@google.com,
	frank.li@nxp.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ARM: imx: Fix suspend/resume crash with Clang CFI" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:14:34 -0500
Message-ID: <20261107061433-failed-5.10-242757d109bd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 242757d109bd5c9b8fb7194fb4d44625be0b859a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061433-failed-5.10-242757d109bd@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 242757d109bd5c9b8fb7194fb4d44625be0b859a Mon Sep 17 00:00:00 2001
From: Yo'av Moshe <linux@yoavmoshe.com>
Date: Sun, 30 Aug 2026 17:51:00 +0200
Subject: [PATCH] ARM: imx: Fix suspend/resume crash with Clang CFI

The suspend code that runs from OCRAM is copied there with fncpy(),
which does not copy the kCFI type hash preceding the function. With
CONFIG_CFI=y the indirect call through imx6_suspend_in_ocram_fn
therefore panics.

Keep the call covered by CFI instead of exempting it:

- Add SYM_TYPED_FUNC_START_ALIGNED(), a variant of
  SYM_TYPED_FUNC_START() that aligns the function entry rather than
  the type hash preceding it, and use it to declare imx6_suspend():
  fncpy() requires the entry point of the function it copies to be
  8-byte aligned. The macro lives in arch/arm/include/asm/linkage.h
  since the requirement comes from arm's fncpy().

- Add a cfi_type member at the end of struct imx6_cpu_pm_info, which
  directly precedes the OCRAM copy of the function. It fits in the
  struct's tail padding, so no sizes or offsets change. Fill it using
  cfi_get_func_hash(), putting the hash where the caller's CFI check
  expects it: four bytes before the function entry.

Also mark ccm_base, suspend_ocram_base and imx6_suspend_in_ocram_fn
as __ro_after_init: they are only written during __init, and the
function pointer in particular should not be writable afterwards.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Yo'av Moshe <linux@yoavmoshe.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/include/asm/linkage.h   | 29 +++++++++++++++++++++++++++++
 arch/arm/mach-imx/pm-imx6.c      | 26 +++++++++++++++++++++++---
 arch/arm/mach-imx/suspend-imx6.S |  6 ++++--
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/linkage.h b/arch/arm/include/asm/linkage.h
index c4670694ada79..bba992f5d7a80 100644
--- a/arch/arm/include/asm/linkage.h
+++ b/arch/arm/include/asm/linkage.h
@@ -9,4 +9,33 @@
   .type name, %function; \
   END(name)
 
+#ifdef __ASSEMBLY__
+
+/*
+ * Variants of SYM_TYPED_START/SYM_TYPED_FUNC_START that align the
+ * function entry itself instead of the kCFI type hash preceding it,
+ * for functions whose entry point must meet an alignment requirement,
+ * such as the 8-byte alignment fncpy() demands of its source.
+ */
+#ifdef CONFIG_CFI
+
+#define SYM_TYPED_START_ALIGNED(name, linkage, align)	\
+	linkage(name) ASM_NL				\
+	.balign align ASM_NL				\
+	.fill (align) - 4, 1, 0 ASM_NL			\
+	__CFI_TYPE(name) ASM_NL				\
+	name:
+
+#else /* CONFIG_CFI */
+
+#define SYM_TYPED_START_ALIGNED(name, linkage, align)	\
+	SYM_START(name, linkage, .balign align)
+
+#endif /* CONFIG_CFI */
+
+#define SYM_TYPED_FUNC_START_ALIGNED(name, align)	\
+	SYM_TYPED_START_ALIGNED(name, SYM_L_GLOBAL, align)
+
+#endif /* __ASSEMBLY__ */
+
 #endif
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index a671ca498f887..3c73e2cdb8ceb 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -4,6 +4,8 @@
  * Copyright 2011 Linaro Ltd.
  */
 
+#include <linux/build_bug.h>
+#include <linux/cfi.h>
 #include <linux/clk/imx.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -18,6 +20,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/stddef.h>
 #include <linux/suspend.h>
 #include <asm/cacheflush.h>
 #include <asm/fncpy.h>
@@ -61,9 +64,9 @@
 #define MX6Q_SUSPEND_OCRAM_SIZE		0x1000
 #define MX6_MAX_MMDC_IO_NUM		33
 
-static void __iomem *ccm_base;
-static void __iomem *suspend_ocram_base;
-static void (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
+static void __iomem *ccm_base __ro_after_init;
+static void __iomem *suspend_ocram_base __ro_after_init;
+static void (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase) __ro_after_init;
 
 /*
  * suspend ocram space layout:
@@ -229,8 +232,18 @@ struct imx6_cpu_pm_info {
 	struct imx6_pm_base l2_base;
 	u32 mmdc_io_num; /* Number of MMDC IOs which need saved/restored. */
 	u32 mmdc_io_val[MX6_MAX_MMDC_IO_NUM][2]; /* To save offset and value */
+	u32 cfi_type; /* kCFI type hash of imx6_suspend() */
 } __aligned(8);
 
+/*
+ * The ocram copy of imx6_suspend() starts right after struct imx6_cpu_pm_info,
+ * and the CFI check on the indirect call reads the kCFI type hash from the
+ * four bytes preceding the function entry, so cfi_type must occupy the last
+ * four bytes of the struct, i.e. fit into its tail padding.
+ */
+static_assert(offsetofend(struct imx6_cpu_pm_info, cfi_type) ==
+	      sizeof(struct imx6_cpu_pm_info));
+
 void imx6_set_int_mem_clk_lpm(bool enable)
 {
 	u32 val = readl_relaxed(ccm_base + CGPR);
@@ -568,6 +581,13 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 			mmdc_offset_array[i]);
 	}
 
+	/*
+	 * Mask out the Thumb bit, as cfi_get_func_hash() expects the
+	 * function's actual start address. Returns 0 if CONFIG_CFI=n.
+	 */
+	pm_info->cfi_type =
+		cfi_get_func_hash((void *)((uintptr_t)&imx6_suspend & ~1UL));
+
 	imx6_suspend_in_ocram_fn = fncpy(
 		suspend_ocram_base + sizeof(*pm_info),
 		&imx6_suspend,
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index 63ccc2d0e920a..95d5f723ea0ed 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -3,6 +3,7 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
+#include <linux/cfi_types.h>
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
@@ -148,7 +149,8 @@
 
 	.endm
 
-ENTRY(imx6_suspend)
+/* fncpy() requires an 8-byte-aligned entry; see arch/arm/include/asm/fncpy.h */
+SYM_TYPED_FUNC_START_ALIGNED(imx6_suspend, 8)
 	ldr	r1, [r0, #PM_INFO_PBASE_OFFSET]
 	ldr	r2, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
 	ldr	r3, [r0, #PM_INFO_DDR_TYPE_OFFSET]
@@ -329,4 +331,4 @@ resume:
 	resume_mmdc
 
 	ret	lr
-ENDPROC(imx6_suspend)
+SYM_FUNC_END(imx6_suspend)
-- 
2.53.0




