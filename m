Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF382D7380
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089842; cv=none; b=ZBa7f5FH3bTy1/vLbBUZ+ArpCElVxhff1tLZV7+NZPXR4D1ur7FdYMTVNA6mitgdR+eHPGin3IdQ/qTxbvX86uQpGblNJll/xGnpTap/BPmXqmcJchsQqb0NzqMZOOIM3Sh9YCyGk1Y0QnPHoSNLI2Y9/TJfnCYJaAcQFgGB+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089842; c=relaxed/simple;
	bh=i+IG0qMdb0QFhKBwNZT6OEDriaarrYOwD/ODdWW1CKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCZeoKexe2aObttcVNn8S2Kx24zbdKUCBrnFY5quD7wT7Y1UnTZLqm3NHBSJ2LovPPL7Yw0XL6Dtuc32NFqAR8oNNkBnA5hv7+0dswmX2oIPFe+tfHARe7vIXHm+qVBzZuzMP04p63Ly6sTFEuQcsBUrP5FAk4qhpKbgGWja5QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVM+Dbns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVM+Dbns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29FC1F00899;
	Fri, 11 Sep 2026 01:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089841;
	bh=jQdUsixfDy3b02gLSD9hSCoSP7VQjdKiiVLaLineriQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AVM+DbnsflTQ+cPBNXl0WBqla6v4iE7Rraa/HZD3u6vZRqLacPwCD64GPnX4KUYG7
	 59Edm4p6JNP6BRRibZuVSWNeV68Os8pBuv7WIJOffq8q9E2UMdo5QOVIQNMkt9n43D
	 GETUKZhOz5LyIvlfOBR05snxYcaRKnTzFnidhiw9ingpjzKEcM7R1V6VGCTPE2Z0+1
	 AzupIrhZJL11CG84tKJiTqyf/llA+nxn/x4ZfvpGfJzk322ZYaXux7wPPncx4h0xOW
	 Qoutr8BMxtCqrmWQ2lQEJbxvAngKL6Sn3dCpOD53nOjn9v+X/xTErwXWyO0g30hKGm
	 IiNfXSWB1qeig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>,
	Andrea Scian <andrea.scian@dave.eu>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses
Date: Thu, 10 Sep 2026 21:23:58 -0400
Message-ID: <20260911012358.4072377-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911012358.4072377-1-sashal@kernel.org>
References: <2026090928-shrubs-fax-9803@gregkh>
 <20260911012358.4072377-1-sashal@kernel.org>
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
index 929dc759c6b24..1c23ad74b225c 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -916,7 +916,6 @@ static int pl35x_nand_init_hw_ecc_controller(struct pl35x_nandc *nfc,
 	chip->ecc.steps = mtd->writesize / chip->ecc.size;
 	chip->ecc.read_page = pl35x_nand_read_page_hwecc;
 	chip->ecc.write_page = pl35x_nand_write_page_hwecc;
-	chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
 	pl35x_smc_set_ecc_pg_size(nfc, chip, mtd->writesize);
 
 	nfc->ecc_buf = devm_kmalloc(nfc->dev, chip->ecc.bytes * chip->ecc.steps,
@@ -983,7 +982,6 @@ static int pl35x_nand_attach_chip(struct nand_chip *chip)
 	case NAND_ECC_ENGINE_TYPE_NONE:
 	case NAND_ECC_ENGINE_TYPE_SOFT:
 		dev_dbg(nfc->dev, "Using software ECC (Hamming 1-bit/512B)\n");
-		chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
 		break;
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
 		dev_dbg(nfc->dev, "Using hardware ECC\n");
@@ -997,6 +995,9 @@ static int pl35x_nand_attach_chip(struct nand_chip *chip)
 		return -EINVAL;
 	}
 
+	chip->ecc.read_page_raw = nand_monolithic_read_page_raw;
+	chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
+
 	return 0;
 }
 
-- 
2.53.0

