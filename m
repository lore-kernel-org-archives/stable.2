Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B453B3BEF;
	Wed, 26 Aug 2026 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774148; cv=none; b=eHjMYgDE203Zj5cb3dbQEj8SpisB1tDZvdaIpRkhDMpzwHvL3hsuzjTXlhk/XWVdLYGRD8PFAtivsgDMDuYzskNuaOv5CnwvxOTJ6Qt/Zpoy4WhbMUamwKs3xaeHB2XC8ymhKQBcF68XMWlaiCLXik41GRHuGjHgYtpt3VlJVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774148; c=relaxed/simple;
	bh=hYgWRduNyAO3dp6CkGTfRSUHfMbOyGeaavjY3kfkW2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3oxSsuUJdeKxQFd5OdB7qmW4a65wHpQnF5Dm269LRuE82PlgrB1GofjwUherCKlEwkUi+N3LAovH2M0BoRq8rmJ985+woIxMJ34diHPCTHpBp3UYMIcsD5FCLKqK4WPeaAfcP8jjw5nMe3wrWX5eQsTmBwMoI+PfMv/KQXkjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TMgh4/sv; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TMgh4/sv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=oz
	EVgNAPqGaijdplBS6VrYOY20Ejo09KRjCHLGuu6So=; b=TMgh4/sv61C/sQb+26
	RpYJFfHMdyuQAj8aFPkIoSD+9Nictuewn1klXlNTK2frwaH3N3d+17o81RAHgnnt
	x18DvZfVjtslwS+L6piD1aEN3IRdonwsa1QSMRuYe8FGnGcQO+MRHCw0KEzk06HJ
	nVMQm8k4E/wfzkgtP8usiQf6w=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBHCiaqRI9qXCSUOQ--.35168S2;
	Thu, 27 Aug 2026 03:55:23 +0800 (CST)
From: microfish <f13208471983@163.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	microfish <f13208471983@163.com>,
	microfish <microfish@kernel.org>
Subject: [PATCH] tpm: crb: handle ACPI NVS memory region overlap
Date: Thu, 27 Aug 2026 11:55:11 +0800
Message-ID: <20260827035511.49582-1-f13208471983@163.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBHCiaqRI9qXCSUOQ--.35168S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurWDKF4xWF4UWr4xZFyxKrg_yoWrAFWkpF
	n7Ca13Crs5XF47XwsxJF1kuFWfZa4Iyay3trWfJwnavanxGry5Zr4DAFyj9F15Jry8tw15
	trWkAryxuFWDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEiSd-UUUUU=
X-CM-SenderInfo: birtjiyyuximiyt6il2tof0z/xtbC0Qu5EGqPRKutrAAA34

On certain Lenovo/AMD systems, the BIOS declares an ACPI NVS region
that covers a large memory range (e.g. 0xccc40000-0xccd3efff) which
includes the TPM CRB MMIO area (0xccd35000-0xccd38fff). The E820
subsystem registers this NVS region with IORESOURCE_BUSY in the
iomem_resource tree.

When tpm_crb probes, it calls devm_ioremap_resource() to map the CRB
registers, which internally calls devm_request_mem_region(). This fails
with -EBUSY because the NVS region already claims that address range.

Fix this by adding a crb_try_nvs_fallback() helper that detects the
ACPI NVS overlap using region_intersects() and falls back to
devm_memremap() when the resource falls inside ACPI NVS.
devm_memremap() does not require exclusive resource reservation,
making it safe to use on NVS-overlapping regions. This approach is
identical to the one used by the WDAT watchdog driver (wdat_wdt_map_mem).

The NVS fallback is applied in both code paths of crb_map_res():
1. When iores is NULL (no ACPI resource encompasses the target address)
2. When iores is non-NULL but devm_ioremap_resource() fails with EBUSY

Before this patch:
  tpm_crb MSFT0101:00: error -EBUSY: can't request region for resource
  [mem 0xccd35000-0xccd38fff]
  tpm_crb MSFT0101:00: probe with driver tpm_crb failed with error -16

After this patch:
  tpm_crb MSFT0101:00: [mem 0xccd35000-0xccd38fff] is inside ACPI NVS,
  mapping without reservation
  tpm_crb MSFT0101:00: of device registration complete, result 0: 0

Signed-off-by: microfish <microfish@kernel.org>
Signed-off-by: microfish <f13208471983@163.com>
---
 drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index ceb4100ba..c4e8b925c 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -13,6 +13,7 @@
 
 #include <linux/acpi.h>
 #include <linux/highmem.h>
+#include <linux/mm.h>
 #include <linux/rculist.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -557,6 +558,39 @@ static int crb_check_resource(struct acpi_resource *ares, void *data)
 	return 1;
 }
 
+/*
+ * Try to map a resource region. If devm_ioremap_resource() fails with
+ * -EBUSY because the region falls inside an ACPI NVS area (common on
+ * certain Lenovo/AMD firmware), fall back to devm_memremap() which
+ * does not require exclusive resource reservation. This is analogous
+ * to the approach used by the WDAT watchdog driver (wdat_wdt_map_mem).
+ */
+static void __iomem *crb_try_nvs_fallback(struct device *dev, u64 start,
+					   u32 size)
+{
+	struct resource res = {
+		.start	= start,
+		.end	= start + size - 1,
+		.flags	= IORESOURCE_MEM,
+	};
+	void *addr;
+
+	if (region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
+			     IORES_DESC_ACPI_NV_STORAGE) !=
+			     REGION_INTERSECTS)
+		return NULL;
+
+	dev_warn(dev,
+		 "%pR is inside ACPI NVS, mapping without reservation\n",
+		 &res);
+
+	addr = devm_memremap(dev, res.start, resource_size(&res), MEMREMAP_WB);
+	if (IS_ERR(addr))
+		return IOMEM_ERR_PTR(PTR_ERR(addr));
+
+	return (void __iomem __force *)addr;
+}
+
 static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
 				 void __iomem **iobase_ptr, u64 start, u32 size)
 {
@@ -565,18 +599,30 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
 		.end	= start + size - 1,
 		.flags	= IORESOURCE_MEM,
 	};
+	void __iomem *p;
 
 	/* Detect a 64 bit address on a 32 bit system */
 	if (start != new_res.start)
 		return IOMEM_ERR_PTR(-EINVAL);
 
-	if (!iores)
+	if (!iores) {
+		p = crb_try_nvs_fallback(dev, start, size);
+		if (p)
+			return p;
 		return devm_ioremap_resource(dev, &new_res);
+	}
 
 	if (!*iobase_ptr) {
 		*iobase_ptr = devm_ioremap_resource(dev, iores);
-		if (IS_ERR(*iobase_ptr))
+		if (IS_ERR(*iobase_ptr)) {
+			p = crb_try_nvs_fallback(dev, iores->start,
+						 resource_size(iores));
+			if (p) {
+				*iobase_ptr = p;
+				return p + (new_res.start - iores->start);
+			}
 			return *iobase_ptr;
+		}
 	}
 
 	return *iobase_ptr + (new_res.start - iores->start);
-- 
2.47.3

