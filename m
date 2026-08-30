Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197F70808;
	Sun, 30 Aug 2026 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788105104; cv=pass; b=q2GC4/wJEZhjT9rbnAYJqT5adSFPgryR7AzyeW5IGCRMunlEvfLd7SZLK4u/jDiU8qy4xPZ5QrQW1dy5hokxWPbQ8ji/xSGWJKYcUlVuH7q9Tru3O8lU45yBRpNGAvIgl35lt/43MoE4Ndhv700XFuHoBMKXsF3pdI3o/Kd55lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788105104; c=relaxed/simple;
	bh=myD5nT0mV1m39mAiqAVLQggFsA2w6w7gPQuIErWHkWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6n1QaWDcHPh7of4z2Q3suru9i0R2a4ZqhIsVAXQyXxQNUWl+YabIA9d8mw5qachtZXfusgMounMWUYd5o06FNTmiwccWTN1mMkdMqbWxXDP5g+R2XmT3y6ro3fLWKarQLkWgdamslIJcVasIaLdp8GR98rN/ZIL1cyiXEXZOl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com; spf=pass smtp.mailfrom=yoavmoshe.com; dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b=VpLOBF0H; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b="VpLOBF0H"
ARC-Seal: i=1; a=rsa-sha256; t=1788105072; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O3fz5ZmZ0tkgOiQsPKuaYKbPU+WqKIhDK0V3DbTbZqTFRbyuQCOPi1OqM4APBN61j1r1CIOWlad/pZjRx4Bm4kBwtmOOLWsr79MiDlWjKNBaNUZB11Gv9rZp+oRiJOl7WQ9r/WjTPrkwoeOf4CapeK0WKNxxhjjbnXDn/1clB5M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788105072; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pKdjrSSVrGvdDIKRSLZvow812lk5WfQrvfxQLIwcn68=; 
	b=YaHf/BZ8lXMvhWfCCGZlCPrTv4Mu9BNIT4V6dJitoi4+OMW5VCIBGpXTeUlxjrKTtoM9LFHpyUl8Iv86mVaFsWDhHSQoe/zYXPrt/3HFoYQb3KpZoqEf0z0ADDNPh2kpFoRN818jk9w97ESK7xsph2xKQI7zDxsoG2JRbhUKHwA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yoavmoshe.com;
	spf=pass  smtp.mailfrom=linux@yoavmoshe.com;
	dmarc=pass header.from=<linux@yoavmoshe.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788105072;
	s=zoho; d=yoavmoshe.com; i=linux@yoavmoshe.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pKdjrSSVrGvdDIKRSLZvow812lk5WfQrvfxQLIwcn68=;
	b=VpLOBF0HRKzgQr03ypUu0Q4A+LBNy4b5w9KcYXrjhLDbCpARQJkmB0fJiqAwt3Y7
	Dzq0q/G5OyGYHvIeZW/BxfL+MKGTvOUxxq9bBPG4Z038bG6sselv8RXplqu7LR0OZVT
	+RCUqR0yOkK1gHhmhYjETXE7HoskB2JTh6fDCmww=
Received: by mx.zohomail.com with SMTPS id 1788105070029960.294682886141;
	Sun, 30 Aug 2026 08:51:10 -0700 (PDT)
From: Yo'av Moshe <linux@yoavmoshe.com>
To: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yo'av Moshe <linux@yoavmoshe.com>
Subject: [PATCH v5] ARM: imx: Fix suspend/resume crash with Clang CFI
Date: Sun, 30 Aug 2026 17:51:00 +0200
Message-ID: <20260830155100.1020620-1-linux@yoavmoshe.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827194508.446733-1-linux@yoavmoshe.com>
References: <20260827194508.446733-1-linux@yoavmoshe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

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
---
Tested on a Kobo Clara HD (i.MX6SLL) running postmarketOS
(clang/LLVM, CONFIG_CFI=y): suspend and resume work.

Note that with CONFIG_CFI=y this depends on commit 979c294509f9
("cfi: Include uaccess.h for get_kernel_nofault()"), already in
mainline, which stable backports would need as well.

Changes in v5:
- Drop the linux/uaccess.h include workaround, obsoleted by commit
  979c294509f9 (Nick, Sami).
- Include linux/build_bug.h and linux/stddef.h for static_assert()
  and offsetofend() (Nick).
- Replace the open-coded alignment pad with a new
  SYM_TYPED_FUNC_START_ALIGNED() macro as sketched by Nick, placed in
  arch/arm/include/asm/linkage.h as suggested by Sami.

Changes in v4:
- Drop the v3 __nocfi wrapper; keep the indirect call CFI-checked.
- Store the hash in a cfi_type member in the struct's tail padding
  instead of open-coded pointer arithmetic.
- Use cfi_get_func_hash() instead of reading the hash manually.
- Use SYM_TYPED_FUNC_START()/SYM_FUNC_END() instead of ENTRY()/
  ENDPROC() with a hand-rolled __CFI_TYPE.

 arch/arm/include/asm/linkage.h   | 29 +++++++++++++++++++++++++++++
 arch/arm/mach-imx/pm-imx6.c      | 26 +++++++++++++++++++++++---
 arch/arm/mach-imx/suspend-imx6.S |  6 ++++--
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/linkage.h b/arch/arm/include/asm/linkage.h
index c467069..bba992f 100644
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
index a671ca4..3c73e2c 100644
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
index 63ccc2d..95d5f72 100644
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
2.55.0

