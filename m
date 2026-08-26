Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58635A38C;
	Wed, 26 Aug 2026 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775338; cv=none; b=F7C8EoixRA2bVF5gFoqmZrwfI50hnDsq6diTecGcgGAptS1SCzxz5vVfa0wTDokMD5KXgPH/5zQGsuJ/0T7uRJiihvPKxH1sSFvzereEBGbI4KP/M8/6y2Tqmlr2ApMGJ/2GTGgIdX0xjH8csDln03bAd3tmLdrCvQVIJYP5Nzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775338; c=relaxed/simple;
	bh=r3xfd7rKy07m13lJEaNX7L3L+7CbfZ1B+hhmDUr+dnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmmYKgVrgmEvndLoUBU4G9v5JwpkOVX5oILnaxCRp7hdT41KWIf28M+KP12yoNRfz0I3+LXa1n0MjjReY7L7WfYbUtQgxq9R2vCo/FRSddFcRQWYgd4wx1DxEOg+8H0MTb4y6ATweMf/ZqHjGQBfycagjjnVIsM6iv0vJanEHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=tYX65OTf; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="tYX65OTf"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id EAEACC001505;
	Wed, 26 Aug 2026 13:15:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com EAEACC001505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1787775336;
	bh=r3xfd7rKy07m13lJEaNX7L3L+7CbfZ1B+hhmDUr+dnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYX65OTfglmiZ/I4ArvU9G/KVHg3yh2CaN7Tptggt/1Gq2bKvYPlsNoOT8jbdJssz
	 6WVGkm7MlxU1WW2PgsgosCkm4Rj46vdN8EJPidBefc8f9/VBjULLTbTzM+MKS1lVwA
	 uDZeUtp42xvXG2b7DUU8wdn/sRGyhXDi+Cin1MLw=
Received: from bse-build-07.ric.broadcom.net (unknown [10.136.28.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 4C841A9A;
	Wed, 26 Aug 2026 13:15:35 -0700 (PDT)
From: Danesh Petigara <danesh.petigara@broadcom.com>
To: mmayer@broadcom.com,
	krzk@kernel.org,
	florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Justin Chen <justin.chen@broadcom.com>,
	stable@vger.kernel.org,
	Danesh Petigara <danesh.petigara@broadcom.com>
Subject: [PATCH 1/2] memory: brcmstb_dpfe: Fix out-of-bounds access due to DCPU offset
Date: Wed, 26 Aug 2026 13:14:58 -0700
Message-ID: <20260826201500.3000125-2-danesh.petigara@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260826201500.3000125-1-danesh.petigara@broadcom.com>
References: <20260826201500.3000125-1-danesh.petigara@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Justin Chen <justin.chen@broadcom.com>

On API v1/v2 boards, the DCPU coprocessor can steer kernel readl_relaxed()
and writel_relaxed() to any address within 256 MB of the ioremapped DPFE
dmem or regs base. The DCPU firmware provides a 28-bit offset which the
driver adds to the ioremap base without any bounds checking in
get_msg_ptr().

This allows a compromised DCPU firmware to trick the host kernel into
reading or writing arbitrary memory-mapped I/O registers in vmalloc
space. When combined with a root-writable sysfs file like dpfe_refresh,
it provides an arbitrary MMIO write primitive. Similarly, world-readable
sysfs files can be used to leak other devices' register contents.

Fix this by recording the resource_size() of the dmem and regs ioremaps
at probe time, and rejecting any offset that, along with the largest
field accessed (DRAM_VENDOR_ERROR + sizeof(u32)), exceeds the recorded
mapping size.

Fixes: fee5f1ef6cf7 ("memory: brcmstb: dpfe: support new way of passing data from the DCPU")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Assisted-by: Gemini:gemini-3.1-pro-preview cursor
Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 08d9e05b1b33..66343205f585 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -182,6 +182,8 @@ struct brcmstb_dpfe_priv {
 	void __iomem *regs;
 	void __iomem *dmem;
 	void __iomem *imem;
+	resource_size_t regs_size;
+	resource_size_t dmem_size;
 	struct device *dev;
 	const struct dpfe_api *dpfe_api;
 	struct mutex lock;
@@ -401,9 +403,14 @@ static void __iomem *get_msg_ptr(struct brcmstb_dpfe_priv *priv, u32 response,
 	 */
 	switch (msg_type) {
 	case 1:
+		if (DCPU_MSG_RAM_START + offset + DRAM_VENDOR_ERROR +
+		    sizeof(u32) > priv->regs_size)
+			goto bad_offset;
 		ptr = priv->regs + DCPU_MSG_RAM_START + offset;
 		break;
 	case 0:
+		if (offset + DRAM_VENDOR_ERROR + sizeof(u32) > priv->dmem_size)
+			goto bad_offset;
 		ptr = priv->dmem + offset;
 		break;
 	default:
@@ -415,6 +422,12 @@ static void __iomem *get_msg_ptr(struct brcmstb_dpfe_priv *priv, u32 response,
 	}
 
 	return ptr;
+
+bad_offset:
+	dev_err(priv->dev, "DCPU returned out-of-range offset %#x\n", offset);
+	if (buf && size)
+		*size = sprintf(buf, "ERROR: DCPU offset out of range\n");
+	return NULL;
 }
 
 static void __finalize_command(struct brcmstb_dpfe_priv *priv)
@@ -858,6 +871,7 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct brcmstb_dpfe_priv *priv;
+	struct resource *res;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -869,17 +883,21 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 	mutex_init(&priv->lock);
 	platform_set_drvdata(pdev, priv);
 
-	priv->regs = devm_platform_ioremap_resource_byname(pdev, "dpfe-cpu");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dpfe-cpu");
+	priv->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(priv->regs)) {
 		dev_err(dev, "couldn't map DCPU registers\n");
 		return -ENODEV;
 	}
+	priv->regs_size = resource_size(res);
 
-	priv->dmem = devm_platform_ioremap_resource_byname(pdev, "dpfe-dmem");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dpfe-dmem");
+	priv->dmem = devm_ioremap_resource(dev, res);
 	if (IS_ERR(priv->dmem)) {
 		dev_err(dev, "Couldn't map DCPU data memory\n");
 		return -ENOENT;
 	}
+	priv->dmem_size = resource_size(res);
 
 	priv->imem = devm_platform_ioremap_resource_byname(pdev, "dpfe-imem");
 	if (IS_ERR(priv->imem)) {
-- 
2.54.0

