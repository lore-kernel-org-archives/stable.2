Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981637BE7E;
	Mon,  6 Jul 2026 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304380; cv=none; b=bODIVFVgrbr5QKlaYnjDSTOEnkurNuP0vfRgkHoHpo8WMycFTzqIAjjyygebZCSkWaG6/bDbacjlZOJi2JKTVbvSade4HzxvKJlfzxq0xnzHtjos1/neGZ24IGASt8NECMXa5vM87fc0+8e14OaOF279Q4vAf/5qNmdfV3lFGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304380; c=relaxed/simple;
	bh=IobvKxkbFJ5qT7MyauMU1AGgh84gAbCRuxoVLRGQ5cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYTqrGwo+eVt2oVREr+YJUFkC/jjg+JZ8NSmR02G8ix4svexJc6gHZSS+fMt9KmZkVVpMEO/uwK2mEOQvw6lszBT2Tl0KLkvM7H8M3Bw8apejgbphrZ2jekrcjkLqtFeHPdGMfLqg4PR+hHGwDkW1YF5WGTd37glCLzFietxnuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.155])
	by gateway (Coremail) with SMTP id _____8Cx5+q0EEtqPD8AAA--.1205S3;
	Mon, 06 Jul 2026 10:19:32 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.155])
	by front1 (Coremail) with SMTP id qMiowJCxIuSlEEtqqqYBAA--.10129S2;
	Mon, 06 Jul 2026 10:19:18 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Lee Jones <lee@kernel.org>,
	Corey Minyard <minyard@acm.org>,
	Chong Qiao <qiaochong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	jeffbai@aosc.io,
	zhuyunfei@loongson.cn,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] mfd: ls2kbmc: mfd: ls2kbmc: Fix iomem pointer handling in video mode parsing
Date: Mon,  6 Jul 2026 10:19:09 +0800
Message-ID: <20260706021909.2346535-1-zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxIuSlEEtqqqYBAA--.10129S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEACGpJ200Q5wAAsK
X-Coremail-Antispam: 1Uk129KBj93XoWxZFy5Aw13Wr1UXryfAFy7urX_yoW5ur4kpa
	yrZ34Y9ry5tFWxXa9ayr4fuF9Yyw1FqrWUGF4fAwn8Zwn8uayjyw1Skan8XF90gFykKFy5
	trs5JF1I9a45ZFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

Use pointers annotated with the __iomem marker for all iomem map calls,
and creates a local copy of the mapped IO memory for future access in
the code. memcpy_fromio() and memcpy_toio() are used to read/write data
from/to mapped IO memory

Cc: stable@vger.kernel.org # v6.18+
Fixes: 0d64f6d1ffe9 ("mfd: ls2kbmc: Introduce Loongson-2K BMC core driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603021730.Yy3QXYTw-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202606120639.WG6eb8VU-lkp@intel.com/
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
V3:
 - Reduce the range of `ioremap` from `SZ_16M` to `SZ_64`;
 - Define a new variable `pos` to iterate through the string;
 - Add failure handling for `strncmp()`.

Link to V2:
https://lore.kernel.org/all/20260624085550.1508771-1-zhoubinbin@loongson.cn/

V2:
 - Add the missing memcpy_fromio();
 - Drop the unnecessary `buf` variable.

Link to V1:
https://lore.kernel.org/all/20260616115530.4012675-1-zhoubinbin@loongson.cn/

 drivers/mfd/ls2k-bmc-core.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 408056bfb2fe..a2aee2131529 100644
--- a/drivers/mfd/ls2k-bmc-core.c
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -66,6 +66,9 @@
 /* Maximum time to wait for U-Boot and DDR to be ready with ms. */
 #define LS2K_BMC_RESET_WAIT_TIME	10000
 
+/* The length of the LS2K BMC display resolution string stored in PCI BAR0 */
+#define LS2K_RESOLUTION_STR_LEN		SZ_64
+
 /* It's an experience value */
 #define LS7A_BAR0_CHECK_MAX_TIMES	2000
 
@@ -427,27 +430,39 @@ static int ls2k_bmc_init(struct ls2k_bmc_ddata *ddata)
  */
 static int ls2k_bmc_parse_mode(struct pci_dev *pdev, struct simplefb_platform_data *pd)
 {
-	char *mode;
+	char *mode __free(kfree) = NULL;
+	void __iomem *base;
+	char *pos = NULL;
 	int depth, ret;
 
 	/* The last 16M of PCI BAR0 is used to store the resolution string. */
-	mode = devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0) + SZ_16M, SZ_16M);
+	base = devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0) + SZ_16M,
+			    LS2K_RESOLUTION_STR_LEN);
+	if (!base)
+		return -ENOMEM;
+
+	mode = kmalloc(LS2K_RESOLUTION_STR_LEN, GFP_KERNEL);
 	if (!mode)
 		return -ENOMEM;
 
+	memcpy_fromio(mode, base, LS2K_RESOLUTION_STR_LEN);
+
 	/* The resolution field starts with the flag "video=". */
-	if (!strncmp(mode, "video=", 6))
-		mode = mode + 6;
+	if (strncmp(mode, "video=", 6)) {
+		dev_err(&pdev->dev, "Simpledrm resolution missing or corrupt!\n");
+		return -EINVAL;
+	}
 
-	ret = kstrtoint(strsep(&mode, "x"), 10, &pd->width);
+	pos = mode + 6;
+	ret = kstrtoint(strsep(&pos, "x"), 10, &pd->width);
 	if (ret)
 		return ret;
 
-	ret = kstrtoint(strsep(&mode, "-"), 10, &pd->height);
+	ret = kstrtoint(strsep(&pos, "-"), 10, &pd->height);
 	if (ret)
 		return ret;
 
-	ret = kstrtoint(strsep(&mode, "@"), 10, &depth);
+	ret = kstrtoint(strsep(&pos, "@"), 10, &depth);
 	if (ret)
 		return ret;
 

base-commit: d5d2d7a8d8be18681a0864f58e3875f1c639e11c
-- 
2.52.0

