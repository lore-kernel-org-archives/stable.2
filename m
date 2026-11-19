Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127291;
	b=ooLuIhzdXwpIvOwTlq9pQHaaIvn+YpYUqHf6KSMrqpgIQZjWf6Dq3dL3zBKH64sqfbC1
	 V1Sfufe1dL2F5zaiWg2z9lx2MNMijnNFhVkQKZt8DsVKYHoY0orBS/2/Mm/9jFx+ht6U4
	 chhf6+2utKfaWyeu31n0WsYL799TRjsSNZfgN3AfO6VWdvvG1U9ETB0GfMVDrdeR+7MvW
	 7H6pjfb5tbL7ZUK7ZJXowbpfL+kB/qFZ8XU87KxJvxEy8R+McLg90ZEeSXwKhf8lv1kG8
	 7sDG6u9ztxOO+hGR3ACWNpqJHEgoeyZUpZyrxfSXIof2sroqZMtuS32hqq3w+Wf+CwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127291;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=OCZOn+cqE7e8uuH9fPsFEjtoD65VvfhvTdGx7l8MCeE=;
	b=AhKipun0jFbFoTjG8fdthHAPmG2zZsH2E7EASvlLH5zXE3JW5KtMS+i4z09p47weZQhc
	 U5CeI+gsB6+yvSI50Wa6frExw9uH/EZxNTNSGFEkzAionf/MoWn9ah7YpqHxRkgcJQTcP
	 emUuhVHFsBgH8sbZdcOTM38fST9Z7km21ZrIA+KUHNIH8l0SVc66vL/mW0abGHHysn2fa
	 ty3XLxrsSdnY1V/btIw+dd2kcrK9BnPBMcleHkeSH6/kjgwOf2UnThuEQ7lkYo/oD0/XF
	 D+cPH/evWi9LZUy+r0NB3SqMiRa8h1mmp478Ijmead2vnInAA/Gudo9YF2iAQepqbOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ejJJG9h+;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF0D606A326;
	Thu, 19 Nov 2026 22:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAF0D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ejJJG9h+
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6F9FC1A172D;
	Thu, 19 Nov 2026 22:28:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 44ADC6035B;
	Thu, 19 Nov 2026 22:28:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 755CD11BC0F19;
	Thu, 19 Nov 2026 23:28:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795127284; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OCZOn+cqE7e8uuH9fPsFEjtoD65VvfhvTdGx7l8MCeE=;
	b=ejJJG9h+HwUK1ruKz7msG2z2+KZiCuHu+/LuJRCDjTxiG+ln/m1h7zzMAr/l5m6cm7g8v3
	9pWW1sOHtVfpbL53NT8N5s75EmLycspO3iuooUJy12AKgqkhPe0MpHZShlVqdbv5sYx+qZ
	vhNYoHCDgFUP8BvcmaB+aKXG7N/o9xbA3x1Yx7dtLCPBz8VcANS2KZVEdU5ISPq9JrtIzz
	axCioZR/BJM+rGSRnsQIIH3wbGoYDcm31hYJN/mTCX5n/WHSOWKf0Ts00akWpiCoXouxDs
	tx4Eeq9Yuc9G517J2l800omstzX6YcpL1njtoPJo18OJDKxqnW0EfBU7lW9pQA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 19 Nov 2026 23:27:56 +0100
Subject: [PATCH 1/2] mtd: rawnand: cadence: Fix DMA device dereference when
 DMA is disabled
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-perso-upstreaming-rawnand-fixes-v1-1-0c95641b550c@bootlin.com>
References: <20261119-perso-upstreaming-rawnand-fixes-v1-0-0c95641b550c@bootlin.com>
In-Reply-To: <20261119-perso-upstreaming-rawnand-fixes-v1-0-0c95641b550c@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Move the DMA resource mapping into the has_dma branch and only unmap the
resource when a DMA channel was actually acquired.

Fixes: 5c56bf214af8 ("mtd: rawnand: cadence: fix DMA device NULL pointer dereference")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202603252339.fQzI6oc8-lkp@intel.com/
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/all/202609010758.3N8tYZdG-lkp@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index e19ceb2d5dfc..42cc62b36457 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -3168,17 +3168,17 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 					    "%d: Failed to get a DMA channel\n", ret);
 			goto disable_irq;
 		}
-	}
 
-	dma_dev = cdns_ctrl->dmac->device;
-	cdns_ctrl->io.iova_dma = dma_map_resource(dma_dev->dev, cdns_ctrl->io.dma,
-						  cdns_ctrl->io.size,
-						  DMA_BIDIRECTIONAL, 0);
+		dma_dev = cdns_ctrl->dmac->device;
+		cdns_ctrl->io.iova_dma = dma_map_resource(dma_dev->dev, cdns_ctrl->io.dma,
+							  cdns_ctrl->io.size,
+							  DMA_BIDIRECTIONAL, 0);
 
-	ret = dma_mapping_error(dma_dev->dev, cdns_ctrl->io.iova_dma);
-	if (ret) {
-		dev_err(cdns_ctrl->dev, "Failed to map I/O resource to DMA\n");
-		goto dma_release_chnl;
+		ret = dma_mapping_error(dma_dev->dev, cdns_ctrl->io.iova_dma);
+		if (ret) {
+			dev_err(cdns_ctrl->dev, "Failed to map I/O resource to DMA\n");
+			goto dma_release_chnl;
+		}
 	}
 
 	nand_controller_init(&cdns_ctrl->controller);
@@ -3204,8 +3204,9 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 	return 0;
 
 unmap_dma_resource:
-	dma_unmap_resource(dma_dev->dev, cdns_ctrl->io.iova_dma,
-			   cdns_ctrl->io.size, DMA_BIDIRECTIONAL, 0);
+	if (cdns_ctrl->dmac)
+		dma_unmap_resource(dma_dev->dev, cdns_ctrl->io.iova_dma,
+				   cdns_ctrl->io.size, DMA_BIDIRECTIONAL, 0);
 
 dma_release_chnl:
 	if (cdns_ctrl->dmac)

-- 
2.56.0

