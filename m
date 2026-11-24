Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512275;
	b=gXG2SxdiUsJA2MgVJUyI99xqtCUmS8L2gvBZ+qCdK/gAB5w/hKw51pD5OuCtK+1XY5w7
	 Ee/1fHp9ePDaV+2ekyFcqOJu2y9eVZjhmL1APCu+B1ylxD1yiPj1L9INj9LYCNTBZwia7
	 VyeO3ACCxtFd64FG/md0g0K19bLp/gtXvLsGZF4kK1u4hQ0z1MW65Fa3PUBVWL7B7iLF9
	 rMTsfoBY964KIjKxVZs4CbdG2aRADzv2WRyptQEmn50kM+MKQHpePQjb/DNy/SA2KarSq
	 f992/1Vx3Weq8ZOd+ChU2a8MQ7KexxX9TO/ITsU6lLcyQJ5RGAK34OaDmtv7OyekUag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512275;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=OCZOn+cqE7e8uuH9fPsFEjtoD65VvfhvTdGx7l8MCeE=;
	b=ztAMYTSjNEbam2r2juH4fCpeq+LcZIBWgBUqiVa/mci6UFZjvTM2ZCrlvSFDncsOK+/l
	 VyX1mHAMPOYyAisoAZYedys1HKdVBzmW/TJGhokTlkZr1YE1p0NYFd8RE7XS6b9pEKQ25
	 k6zwl+zVJxPLqnTJ1v9cv8CU59zdIZB8Re/maKfSMBkY55Uym7npCdys4G9pUEaXzc3SD
	 updqF/XCXeTBDQQZQM7yEYYPV92SzkDIZMgCkTW0H35DNRiTxVWk+hnNqRLKYgFNhaY7k
	 kXmESy8CFRWK1JmbJPsG4mSBNNp0Ismrjg5VABAKn1+aWkBeUxXSRG4JDXmJeqVSZfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=dNW5k8sX;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85617606A680
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85617606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=dNW5k8sX
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2CC91C4CBED;
	Tue, 24 Nov 2026 09:24:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C7B31601E1;
	Tue, 24 Nov 2026 09:24:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 673A611E6A5BF;
	Tue, 24 Nov 2026 10:24:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795512271; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OCZOn+cqE7e8uuH9fPsFEjtoD65VvfhvTdGx7l8MCeE=;
	b=dNW5k8sXvh1W/kPRuVNQeI14Vqtp//01RcYQiJNKcHQ+cK4q/r5fWeRlzqFIOpo0bjHetP
	0hJ8I8v/bmuluyuXhqU7600QkyVnBXLK8IEipLHfvut5iSfR3D98wWqAdrwD5gSaq/Ngq5
	7bU2hLB2I3i+6avpvAcAyKQuKau56fhCwvYpfVo+wW9OD5A50aPorrB9b+voL6AmL06XfO
	GuLchSnHqPwBlgKleYiF2I+fhPJ7w29Ets0mm1q6+bNMB8aMryqso+I1NXZioO5k9nMTzC
	1EkvTda2kNdhIWlg4BfUES6buUZI+I14THRKDTdI1+3U6LmsWSn3s6vHV9r0BA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Nov 2026 10:24:22 +0100
Subject: [PATCH v2 1/3] mtd: rawnand: cadence: Fix DMA device dereference
 when DMA is disabled
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
Message-Id: <20261124-perso-upstreaming-rawnand-fixes-v2-1-69db17ad07bd@bootlin.com>
References: <20261124-perso-upstreaming-rawnand-fixes-v2-0-69db17ad07bd@bootlin.com>
In-Reply-To: <20261124-perso-upstreaming-rawnand-fixes-v2-0-69db17ad07bd@bootlin.com>
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

