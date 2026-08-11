Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5644CAE4;
	Tue, 11 Aug 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465379; cv=none; b=IrB8WYz9+Dyah5/p6KH+Q5epwKLjnkn7pA/fjxoJIe7pX7ccAE0ORHoHbuux9PllGoA+fGMxKIwbmdo2wtx8zGvhdUG2kWOt752y27E6bZ7TCzXK45C8u6h8Dx/RHo1VL7yErkN85RTfmv8vKGpSLpC1m7LVOzNTO2Dk1NEHDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465379; c=relaxed/simple;
	bh=SAz60KA6fPW0pMBKmcoL8uUAuWXd11PScU2zfii4/LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImRnrJhjLjrT4kuU8u4x4Kk8sTOp/8ccrkNvugqMfpNl749MlclAL1Bahtplzr9bMj0FesSI3gPeG5Kk6Dg664z6sHyCMZnUwM2eMGBFpJ/2Uvsse/adDt/BzrhxqvlkOMXx9aecTwaT3s1cXC6zK6O5RZiFI7IeJPs847hd+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=2BDPjDrU; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="2BDPjDrU"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1786464835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a29yc6HZhwWPN+sxY5uQGFTrpGPENuXFgdlITogn3PI=;
	b=2BDPjDrU3f8zXBhPZ7lXvkPqeAOAXQzbjmFj9AgmUpJX3/774+T4mcOfM2/LR6teQlYcAX
	G1DV6SYMLiFZPTstxrLO9WvfgEJ41W6zhHP/NIX5gatLqyQTFQxChTS3bMgpRUyFlKkRpR
	ppJDBIBME3au3nflhUSBhHCvL/Y8wxwGdmAHlRQkGm6IP0yJ9F//4rEn4Mvf4SUk5/6JsO
	DBhsm3QNza9P3coK1DQ6iKySGOwzmjZIlSTHebV6tcr232gRlODA3Iz6R/CwrbGwQuQwBc
	OezsoPz7RRHSaVu/02y0mOl3ocxTTqrpDKh6e08KgfLagaDG66uMngLEyxTylg==
To: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	stable@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	David LaPorte <dalaport@amazon.com>,
	Gabor Juhos <j4g8y7@gmail.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] mtd: spinand: try a regular dirmap if creating a dirmap for continuous reading fails
Date: Tue, 11 Aug 2026 18:13:37 +0200
Message-ID: <20260811161342.533280-3-frieder@fris.de>
In-Reply-To: <20260811161342.533280-1-frieder@fris.de>
References: <20260811161342.533280-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

[ Upstream commit 004f8ea0d9917398aabff7388b3bf62a84a4088b ]

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi controller
to read up to 512 Kb in one operation without toggling CS in beetween.

Roughly speaking spi controllers can be divided on 2 categories:
 * spi controllers without dirmap acceleration support
 * spi controllers with dirmap acceleration support

Firt of them will have issues with continuous reading if restriction on
the transfer length is implemented in the adjust_op_size() handler.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi controller refuses to create it.

Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 43 ++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a480243385e2e..10339209e7322 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1032,6 +1032,39 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static struct spi_mem_dirmap_desc *spinand_create_rdesc(
+					struct spinand_device *spinand,
+					struct spi_mem_dirmap_info *info)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_desc *desc = NULL;
+
+	if (spinand->cont_read_possible) {
+		/*
+		 * spi controller may return an error if info->length is
+		 * too large
+		 */
+		info->length = nanddev_eraseblock_size(nand);
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, info);
+	}
+
+	if (IS_ERR_OR_NULL(desc)) {
+		/*
+		 * continuous reading is not supported by flash or
+		 * its spi controller, use regular reading
+		 */
+		spinand->cont_read_possible = false;
+
+		info->length = nanddev_page_size(nand) +
+			       nanddev_per_page_oobsize(nand);
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, info);
+	}
+
+	return desc;
+}
+
 static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
@@ -1051,11 +1084,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
+	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
@@ -1078,12 +1108,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc_ecc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	info.op_tmpl.data.ecc = true;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
+	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-- 
2.55.0

