Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE71CDFCA
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789087323; cv=none; b=BFMXdmhIZasCgCiWyU/4zVLCLrAk5pV1R1QDlOPxXkNqQmcKb1EhVA4g4dcgdfIYyB7x/znqTJuARjTtiBC6UmQD64gzzWVGaFpvl/FqgjPrD+g3OflKAt35D0weYyS8GJYP1Wrpk6Q26CtaOuPzVxdq271JlnmblB+jhA9UyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789087323; c=relaxed/simple;
	bh=4kt2mpdeEm9bIqDxsUmBHA4RJaP/OA+sP4MJ6VPv2K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M335HECS0286dT7xA2B0nmxTmLpK5TZqr5g40cE69X3XIIorkrn878E53O6l8I2VBE/5qFDFzsZsTeA4N5Ewkx3SMBFaBoCsRNnX7wLaEhjgooXNEC+A7KQGY9zrdaGEeqUCWZqPUWMuZL+0u4UQcM7mfpJuew+QgpvqIAfduVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhiqjOYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhiqjOYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313FC1F00893;
	Fri, 11 Sep 2026 00:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789087321;
	bh=qJkFyqT/nFGrHNJStHve7Wb+WBnmc4ttw7nlfkmrqGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MhiqjOYHfR2e8WqUumNLTK2wKP6Q82o+5/TwakHbNfh6aG9vDBUo7CIcOBGcH4u9L
	 Hhl+/at90/VvfYqG6Zvf3NUEhXeeDUMCSmk/gTY9ERDN5X4YDQwqhqj3kt95v9641a
	 TXgZuxO9J7j6pMnZbBu+SL9cMaHFFtYHbkb9bK5FwvRVoltocOLlUlB2QEx10zwl74
	 HRrV/IjdycQWVALZjxQDTyE7VhnrEgB0Qtx9taP2o7vNglWdUyvXpsy6kIrsI5/EHL
	 iVx0CjxHMvHceiHHlGXMjNhE74KwB1lqO6w6GCfTF10bbQoewjEsIZOAqZmcTIcs+H
	 H+9DiMJdmZsgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>,
	Andrea Scian <andrea.scian@dave.eu>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses
Date: Thu, 10 Sep 2026 20:41:58 -0400
Message-ID: <20260911004158.3575108-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911004158.3575108-1-sashal@kernel.org>
References: <2026090927-cavity-motion-43b7@gregkh>
 <20260911004158.3575108-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>

[ Upstream commit 80ecacd054ffeb60cd28e46ed5cd6bd0d2de318b ]

Any access not using the hardware ECC engine should be monolithic
because the controller has its very own way of handling the end of a
transaction during operation configuration, so we cannot easily make
repeated reads.

This has the side effect of fixing support for software ECC engines.

Suggested-by: Andrea Scian <andrea.scian@dave.eu>
Cc: stable@vger.kernel.org
Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
Signed-off-by: Miquel Raynal (DAVE) <miquel.raynal@bootlin.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 06f8f1e14b9c2..7d43506b1654d 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -914,7 +914,6 @@ static int pl35x_nand_init_hw_ecc_controller(struct pl35x_nandc *nfc,
 	chip->ecc.steps = mtd->writesize / chip->ecc.size;
 	chip->ecc.read_page = pl35x_nand_read_page_hwecc;
 	chip->ecc.write_page = pl35x_nand_write_page_hwecc;
-	chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
 	pl35x_smc_set_ecc_pg_size(nfc, chip, mtd->writesize);
 
 	nfc->ecc_buf = devm_kmalloc(nfc->dev, chip->ecc.bytes * chip->ecc.steps,
@@ -981,7 +980,6 @@ static int pl35x_nand_attach_chip(struct nand_chip *chip)
 	case NAND_ECC_ENGINE_TYPE_NONE:
 	case NAND_ECC_ENGINE_TYPE_SOFT:
 		dev_dbg(nfc->dev, "Using software ECC (Hamming 1-bit/512B)\n");
-		chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
 		break;
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
 		dev_dbg(nfc->dev, "Using hardware ECC\n");
@@ -995,6 +993,9 @@ static int pl35x_nand_attach_chip(struct nand_chip *chip)
 		return -EINVAL;
 	}
 
+	chip->ecc.read_page_raw = nand_monolithic_read_page_raw;
+	chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
+
 	return 0;
 }
 
-- 
2.53.0

