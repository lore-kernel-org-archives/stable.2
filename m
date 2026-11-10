Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283095;
	b=gyME2+QFYS/RvOlRzpB4vo2WcklBXaO2m6/xB+pGGj6NZ6tvmCgzaAHeQY9CUrJBsZTz
	 0cyrG+/D416JUGYOocnMwWqCbgirj3Luxx1fIFMvUEPWI3VF7MCD2akllWUlwia9FQFg1
	 E8if2vRGgDtBsT5DVst+vJekuTf7CY9Mh246n1FZ8kRIiCLZGJq5W3ZWpl48Lsm96Puxe
	 UZfk+LRBsY7hvH3ceKw/csqMw9E4w323AX4aEHwDun2nN/h8+WksBoBotaDqm1SegC20K
	 KpGoc+ibEPKGWljphEy37t8dMdRNiSX/W5G+SvLyzveb+AcaOl3rp4Fa5WbHopX7wbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283095;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pm4xqdJtsbEDmgF0AMd+gzTvnpYTTRwdZX+9JGd1O8g=;
	b=l9GwEvweF4TIlJoqJ+wO8vCu+fP+90RjytqGicftErf5FQhSOwyJ6BjETIvhKylT3XUB
	 pv45DZT+qpSFzgeJvDvVoLTzCSnOd50TFjbEmeM6AD4SpuTrjAWHEnVwsAYzTA1NVbRxm
	 bLuUW1RTZ5oVB35wDHaFzI/o4nwTKZhuUE61BH7LyvDIF/43vdUOc4AhM4MZBj+erVDiV
	 mEPbdxVridi6Nyf/f5VFmgNXk4MZTBiU9yZLGy0NGxGTWzwNBeN8NhjiP1UWj888cxdSz
	 e+Mx/y67FoTrqQP4OvZf+CMJsOOE2qvRfmNyEHauB5fKSkI0F/lIpD+MjPvgyyD2SLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZx9rt4t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3408360A5BE7
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZx9rt4t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541AF1F0089F;
	Tue, 10 Nov 2026 03:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283094;
	bh=pm4xqdJtsbEDmgF0AMd+gzTvnpYTTRwdZX+9JGd1O8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZx9rt4tJMO87LLni1j5aYJyMT6w8FiCu15DVFRKhQAuN6N+3wlsTc76hHtoTZoRL
	 BYKpUMa15zybBMU1H9Yya4GiTAh8wNJAHiitCVynYpNU8ciRKLj7A9aJysbZZsyoKf
	 0xC+tlRmUatCdGOWnCk5QSFldTwRctJWd/cn3wuUPJPkQ8GqL5L2mLPpxJCzq+1kd1
	 cNmU9hkP33RMJZQ2hzlVUqfE3WRQKDiA4m471cyevNi2qIz1qsjKb2TxaSOQ+AuRRz
	 LoRZaXRa4QyiG8z92jdkUB+gdU6JW+UwOdfs0sfELNP0ZKpRQnKAGh5EJpTZgVwnZY
	 2Tzg974aMww+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] mtd: rawnand: ndfc: use devm_platform_ioremap_resource()
Date: Mon,  9 Nov 2026 22:58:11 -0500
Message-ID: <20261110035754.265724-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110035754.265724-1-sashal@kernel.org>
References: <20261107061443-failed-5.10-0d66f9895f28@kernel.org>
 <20261110035754.265724-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit 0d66f9895f286d2fab396a71e6efeb95c4a7e5a6 ]

Replace the open-coded of_iomap()/iounmap() with the managed
devm_platform_ioremap_resource() helper. This fixes a mapping leak on
driver remove (the old code never called iounmap()) and simplifies the
error path by dropping the manual cleanup in ndfc_probe().

There is no overlapping memory-region concern introduced by this
change: each supported board DT describes a single ndfc node with a
unique 0x2000 register region, and the EBC parent uses dcr-reg rather
than a MEM reg resource, so the newly added request_mem_region() cannot
conflict with an existing reservation. Distinct chip selects map to
distinct 64-bit physical addresses, so CS instances do not overlap.

Fixes: a808ad3b0d28 ("[MTD] [NAND] ndfc driver")
Cc: stable@vger.kernel.org
Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/ndfc.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index b9223cdaa8e34..97a2e36d812ac 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -185,10 +185,15 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 static int ndfc_probe(struct platform_device *ofdev)
 {
 	struct ndfc_controller *ndfc;
+	void __iomem *ndfcbase;
 	const __be32 *reg;
 	u32 ccr;
 	u32 cs;
-	int err, len = 0;
+	int len = 0;
+
+	ndfcbase = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(ndfcbase))
+		return PTR_ERR(ndfcbase);
 
 	/* Read the reg property to get the chip select */
 	reg = of_get_property(ofdev->dev.of_node, "reg", &len);
@@ -210,11 +215,7 @@ static int ndfc_probe(struct platform_device *ofdev)
 	ndfc->ofdev = ofdev;
 	dev_set_drvdata(&ofdev->dev, ndfc);
 
-	ndfc->ndfcbase = of_iomap(ofdev->dev.of_node, 0);
-	if (!ndfc->ndfcbase) {
-		dev_err(&ofdev->dev, "failed to get memory\n");
-		return -EIO;
-	}
+	ndfc->ndfcbase = ndfcbase;
 
 	ccr = NDFC_CCR_BS(ndfc->chip_select);
 
@@ -232,13 +233,7 @@ static int ndfc_probe(struct platform_device *ofdev)
 		out_be32(ndfc->ndfcbase + offset, be32_to_cpup(reg));
 	}
 
-	err = ndfc_chip_init(ndfc, ofdev->dev.of_node);
-	if (err) {
-		iounmap(ndfc->ndfcbase);
-		return err;
-	}
-
-	return 0;
+	return ndfc_chip_init(ndfc, ofdev->dev.of_node);
 }
 
 static int ndfc_remove(struct platform_device *ofdev)
-- 
2.53.0

