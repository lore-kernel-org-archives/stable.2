Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8333B2AA
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089475; cv=none; b=OS7iOvfukAWqlAxoVSB8q1MATK9RyzorIfqdNzxdx398P/K8XNf6TInTzfnYFijEjUf7ZrnQfYu4zrhAgJ6H2H3NUzOz10crXQxIocXN1Fzq2IAV18RjgAOUTjZ9uA3XZ7JRuu/AJrt9x2tL1vyERpevH2Dz9g3J7l9C5+PnR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089475; c=relaxed/simple;
	bh=JZX4L0bWxSfQdwJ27FesbbCb7IcTeXR9/MubLI+3o9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDPH3hTKHY953BRXb1aMgFL0SwfMsvwP8IQPzVENuv+nBukAO0aZ2kpimyxq7+TAHtEXiYQ50ZKa6PJlV0D3BrcfQMvDdSNaDPnxjtTFha/svdXxOueUfxrEDd8NFmgYP5iA7KgiPSd63Wik6ohOdaQaJ7rzFBIyABr7MQyAi2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCT8bVdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCT8bVdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B693A1F00898;
	Fri, 11 Sep 2026 01:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089474;
	bh=a4n/83idsyuWahv9Oy0/n5nWxngPY435h2zQyT94QOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oCT8bVdmtxC1QSyoWlv/83C+GuOE/uJzBn/+AsBqJnt1XiTpLOZDB8ibihjEEndPG
	 d+w7B78V+rcVdtYNsVtfXXPhGmEiSVXb+xhMjNjRZp/VvcTQZpI28EPz88DjRLgxAy
	 boboztcAFeBqH+GirjoTYo2fMEeFk0ppUfPzqvTLabaVWTBRYpeto8xoLfBnMBwTkl
	 /FLCs1FPcnOTPtdt24lRZ+Yrd+jcag+UF4+GjVImJmKhoDbE2nnL3vcIxocVrzwElH
	 y7BexWLnKPbnI/oxlPlQf4cQdC1wRT7DWyiHd7hgD+8YgHOfCgo2Ov3YCq2DS04Rji
	 4edsAihSHg1Kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>,
	Andrea Scian <andrea.scian@dave.eu>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses
Date: Thu, 10 Sep 2026 21:17:51 -0400
Message-ID: <20260911011751.4049598-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911011751.4049598-1-sashal@kernel.org>
References: <2026090927-freehand-voice-e7f2@gregkh>
 <20260911011751.4049598-1-sashal@kernel.org>
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
index 56c789ab8c1a1..771bda7612864 100644
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

