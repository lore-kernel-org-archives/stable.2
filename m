Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C93F1040;
	Thu, 27 Aug 2026 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860001; cv=pass; b=EZNr1l9aYrsS2xFhQihKdQmhhwQCoSFsGe8bq/+nOKldkQ1tZTIA8HkHMEMJgfeXq+xUJPmqJp+d3ZFouAMKAZMtlfoS0UDatHlKYDQFM9Kjj8Ktmn3jc9SyGBlL1u7lUUmF+pFXgpTOMEcp99EaQsw/L2IJYEf410MIYWK6DOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860001; c=relaxed/simple;
	bh=P2X3GwP9E9st5R30tBs9c9j15BLonB6IeIiAYCrVgkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJfRVOkWm/mITi4lvfaifYicCKyUl3adZjt8B8cjhdgodP5z3+0YX3/sjebvMqL/9Y/AsO6WrZJJ1ThwLXqAa9iPfA+8GgN5l22kMOu3bdvDffRUaGFIdbAYxPK/DCCrQr99aXuXNU67YmaumGqLOgv2RcRsiUtmpMzaXWzEy64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com; spf=pass smtp.mailfrom=yoavmoshe.com; dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b=VFa2RcbY; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b="VFa2RcbY"
ARC-Seal: i=1; a=rsa-sha256; t=1787859972; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YwxxdA+sDCyxi7mXigxThpPiP/drwo4YzvrMqfX+N9a5y1kgSBvhJq3HrvoG2zZ+k2LvaMf6jrTreRdA74YfdIZCpJBGjoGLpDH3czgSKL91OMOJcWOixEg6RGGhkn05RFHOemXkZs3DaU050mjcddYD7TO55HZJY3CK7rwz9D4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787859972; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D9Ddv1MKk0Ua+UBkqvgckAr84VTg8X9FPDDbUuH7WWk=; 
	b=Q375y/jTXI9ggWvo/fBtuO9vSRA80PVo776QPgy5wwZ76qogvNdFJdRkqk2+W8kYnRVugiIDE5m8CcJFUnmCF9XMeWjv+JpOnh5VNJC3tPthXm6pSPkoCXpyLIOrQRSq2TjOIKCwOg53Ho7ACOF07mItBCjmmJuF8+ZvmHOvMT8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yoavmoshe.com;
	spf=pass  smtp.mailfrom=linux@yoavmoshe.com;
	dmarc=pass header.from=<linux@yoavmoshe.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787859972;
	s=zoho; d=yoavmoshe.com; i=linux@yoavmoshe.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=D9Ddv1MKk0Ua+UBkqvgckAr84VTg8X9FPDDbUuH7WWk=;
	b=VFa2RcbYgv6RksBUo9H3TawIU44ZP0InZhFN6Ml77GFPkJS6hK+N7F/8zJQQ+UnI
	LlELh9mGJwF8R6ZFqx5+Trz3G9OTelU625O6G4cX9yymxmtaYmvg77RAPSefSF2WZGB
	qNn20JvfmYkBLBihAdo6eZ4OXlx+lQoTJkwP31iM=
Received: by mx.zohomail.com with SMTPS id 1787859968747447.95251486025677;
	Thu, 27 Aug 2026 12:46:08 -0700 (PDT)
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
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yo'av Moshe <linux@yoavmoshe.com>
Subject: [PATCH v4] ARM: imx: Fix suspend/resume crash with Clang CFI
Date: Thu, 27 Aug 2026 21:45:08 +0200
Message-ID: <20260827194508.446733-1-linux@yoavmoshe.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718111340.159896-1-linux@yoavmoshe.com>
References: <20260718111340.159896-1-linux@yoavmoshe.com>
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

- Declare imx6_suspend() with SYM_TYPED_FUNC_START() so a type hash
  is emitted for it. fncpy() requires the entry point to be 8-byte
  aligned, and the macro's alignment applies to the hash rather than
  the entry that follows it, so pad manually before the macro.

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

Changes in v4, all following Nick's suggestions:
- Drop the v3 __nocfi wrapper; keep the indirect call CFI-checked.
- Store the hash in a cfi_type member in the struct's tail padding
  instead of open-coded pointer arithmetic.
- Use cfi_get_func_hash() instead of reading the hash manually.
- Use SYM_TYPED_FUNC_START()/SYM_FUNC_END() instead of ENTRY()/
  ENDPROC() with a hand-rolled __CFI_TYPE.

Note: linux/uaccess.h is included before linux/cfi.h because
cfi_get_func_hash() uses get_kernel_nofault() and cfi.h does not
include uaccess.h itself.

 arch/arm/mach-imx/pm-imx6.c      | 25 ++++++++++++++++++++++---
 arch/arm/mach-imx/suspend-imx6.S | 14 ++++++++++++--
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index a671ca4..2d3d3cd 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -4,6 +4,8 @@
  * Copyright 2011 Linaro Ltd.
  */
 
+#include <linux/uaccess.h>
+#include <linux/cfi.h>
 #include <linux/clk/imx.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -61,9 +63,9 @@
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
@@ -229,8 +231,18 @@ struct imx6_cpu_pm_info {
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
@@ -568,6 +580,13 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
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
index 63ccc2d..f60c4e5 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -3,6 +3,7 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
+#include <linux/cfi_types.h>
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
@@ -148,7 +149,16 @@
 
 	.endm
 
-ENTRY(imx6_suspend)
+#ifdef CONFIG_CFI
+	/*
+	 * Pad the location counter so that the type hash emitted by
+	 * SYM_TYPED_FUNC_START() below ends on an 8-byte boundary:
+	 * fncpy() requires the function entry to be 8-byte aligned.
+	 */
+	.align	3
+	.4byte	0
+#endif
+SYM_TYPED_FUNC_START(imx6_suspend)
 	ldr	r1, [r0, #PM_INFO_PBASE_OFFSET]
 	ldr	r2, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
 	ldr	r3, [r0, #PM_INFO_DDR_TYPE_OFFSET]
@@ -329,4 +339,4 @@ resume:
 	resume_mmdc
 
 	ret	lr
-ENDPROC(imx6_suspend)
+SYM_FUNC_END(imx6_suspend)
-- 
2.55.0

