Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512276;
	b=iLblysR+9RUCcsHmxvaIBTTjmCfnV27W2ISBK+27RtpERCBd6y5LrtUAv88t3yfpStnQ
	 z86zL/estq6iWHB8GAhwmNN6hJJDsWYn9SSnKYjYONjFT06rWI3C7heGhshwt78KLgPpf
	 P3rhhCFuYeYuaxyTPMbPl6LEmRe7gaH92r3UqQzkVvLjF911dzaPXOn5o8+2vv+gpwW0q
	 bvDoHoKhgrnoBWTYtCWAek2SJzbqgDviaXduksKTGOUmEkMqHEgmAsH2BWmkGVLZh2QRf
	 /ARguQq8ppwSDzsDm8BuiYx/pIsC4s6IiMDFu+iYmWWLb/UDMQAqCWgJYOomxAEuLAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512276;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=aoI8AlSI3VF7hQCQWNsK0cPXv5qsgsj2161PVO/bKVs=;
	b=NvLvgCninbpEjj9EdnbX58uYkasWZd60CIcsY4tEKC5ckhF0dmzu/bcUEYZee+NDLEpe
	 84Oyl+ix5xRMsYF1WyArKAgVQzTZJZxn6xpIRFXL2eo9csAibUlPzEGTmalAGbdystd47
	 enEdrHKjxsMreBxQbOWR1jRbv60Mjab6RKStJwspah5PRYNwVmEGNpSAH9mK0A1vURypO
	 9D1BbDioD76DFLwdCT8POcHV+LHY9zv2lIgKFH+XcdUowGoH0z2VjJ0WhQJAVYC61aBHj
	 qjbAad5PG3FWGS2MgXzAZGNxTUhWCDClKvyWPtPNgTal7yhaVRG5xHNHyEGHg99devg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ip0+fvPH;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58789606A683
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58789606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ip0+fvPH
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 72D0CC4CBEC;
	Tue, 24 Nov 2026 09:24:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1ABBA601E1;
	Tue, 24 Nov 2026 09:24:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2218111E6A9B3;
	Tue, 24 Nov 2026 10:24:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795512273; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aoI8AlSI3VF7hQCQWNsK0cPXv5qsgsj2161PVO/bKVs=;
	b=Ip0+fvPHtXLgnCo+SM/S6acz+lzzOI2el35iIWyX2xi4rAK9gb3vRfvcvlvXPPDKYDc4pt
	f+PAElG4w5jIS5GbdLpOd83QRbfjcDZeV3udvjURNFvdrNEzGgXU0Ctajj0KyfnEV2NUdH
	VBOl338USGubER0qQInlPiieVM4PtCJBv47K/kXWaMRhwQVCiKcyF1y6BzWXCRPV2Of3Rw
	VuGTcAkLAaQBlGfRlNpJR0LxVscdRbIKXDa7vtxt90DQr9o4TH59WISWZ33QnWUhXxI4SV
	qZ65R6dd9vXt2+oKXji30m6KeBZWPEi7i+YRYMJEOVXFAKs24WUkWEo4tpd60g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Nov 2026 10:24:23 +0100
Subject: [PATCH v2 2/3] mtd: rawnand: cadence: Resize the bounce buffer
 before the BBT scan
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
Message-Id: <20261124-perso-upstreaming-rawnand-fixes-v2-2-69db17ad07bd@bootlin.com>
References: <20261124-perso-upstreaming-rawnand-fixes-v2-0-69db17ad07bd@bootlin.com>
In-Reply-To: <20261124-perso-upstreaming-rawnand-fixes-v2-0-69db17ad07bd@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The bounce buffer is allocated with a default size and only resized to
the actual page + OOB size once all the chips have been
scanned. However, the bad block table is scanned during nand_scan(),
before that resize happens, using the same bounce buffer. Chips with a
page + OOB size larger than the default size may therefore overflow the
heap buffer.

In practice, this default is safe since it is set to 16kiB and I
currently know no chip with a bigger page size, but chances are that
this is not a future-proof bet, so let's resize the bounce buffer
whenever we attach a chip whose geometry needs a bigger buffer.

Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 42cc62b36457..912148f90ece 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2970,8 +2970,17 @@ static int cadence_nand_attach_chip(struct nand_chip *chip)
 	chip->ecc.read_oob_raw = cadence_nand_read_oob_raw;
 	chip->ecc.write_oob_raw = cadence_nand_write_oob_raw;
 
-	if ((mtd->writesize + mtd->oobsize) > cdns_ctrl->buf_size)
+	if ((mtd->writesize + mtd->oobsize) > cdns_ctrl->buf_size) {
+		u8 *buf;
+
+		buf = krealloc(cdns_ctrl->buf, mtd->writesize + mtd->oobsize,
+			       GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		cdns_ctrl->buf = buf;
 		cdns_ctrl->buf_size = mtd->writesize + mtd->oobsize;
+	}
 
 	/* Is 32-bit DMA supported? */
 	ret = dma_set_mask(cdns_ctrl->dev, DMA_BIT_MASK(32));
@@ -3136,8 +3145,11 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 	if (!cdns_ctrl->cdma_desc)
 		return -ENOMEM;
 
-	cdns_ctrl->buf_size = SZ_16K;
-	cdns_ctrl->buf = kmalloc(cdns_ctrl->buf_size, GFP_KERNEL);
+	/*
+	 * Allocate a scratch buffer for the identification phase. It gets
+	 * resized to the actual chip geometry in ->attach_chip().
+	 */
+	cdns_ctrl->buf = kmalloc(SZ_16K, GFP_KERNEL);
 	if (!cdns_ctrl->buf) {
 		ret = -ENOMEM;
 		goto free_buf_desc;
@@ -3194,13 +3206,6 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 		goto unmap_dma_resource;
 	}
 
-	kfree(cdns_ctrl->buf);
-	cdns_ctrl->buf = kzalloc(cdns_ctrl->buf_size, GFP_KERNEL);
-	if (!cdns_ctrl->buf) {
-		ret = -ENOMEM;
-		goto unmap_dma_resource;
-	}
-
 	return 0;
 
 unmap_dma_resource:

-- 
2.56.0

