Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B027FD4F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090008; cv=none; b=PBB9VW3J7JJrpFpGuvBum0jNv32Ik/LT+/gEILl8kZP58tQ07PjNOEDXvgUfLTV/6uATPqkrDkcjAiCzRVhdVkT0oCbOX9u0oM7+GojLNT/CusqM4Az+ZPGxIvm+i0/1c2mOEOuLSq5/elLKqqoXzkqM9qSRYQUeXFSgidNPcP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090008; c=relaxed/simple;
	bh=i+IG0qMdb0QFhKBwNZT6OEDriaarrYOwD/ODdWW1CKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3vnr2v/77ouAHZSnk7+Wq+LZtpEATrvkCMJfWtO2pOHOHEeniqJPsdj78lnc5RwxEo+Bjt/L/mZErlV48wmrJjj+25NonkQmr3OrUX6OBz1m9lUdBnFk5W0SgrBMg+n7KPsATV9YNFol/dgS1RbY5XKDgaUYxT61ihO8d5pPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+8iQjpP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+8iQjpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7941F00893;
	Fri, 11 Sep 2026 01:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789090007;
	bh=jQdUsixfDy3b02gLSD9hSCoSP7VQjdKiiVLaLineriQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T+8iQjpPC8S1JETA9L5GEDkn6QflyCX7UAnCTtYYm+/CUNR6emr5DeDXu6gBTT8Ml
	 5EKHpjnW5V8Z35FaFSg+yzV8PUc4m02EHWSxW3ahccKTrW6/qjiiRylxsdfk+YqKNi
	 IO7V1592bsDm+oVg8ZGB81fSGzz2Bxx5wxjitSZ3n2s+s5QKPBuBwrDZjBCReKo92f
	 XJ5wGpUOE2yGrJ1LgDspayHFHixmasw77S3O1N49YWmjmOwQyqw01qdlRBWFV/Qqv/
	 qjkaa7s6jLUaQHZ6P5t3jBYfqOBveM4c7dGkb5CdeAiXQOwTQvDiUHApg26i92M0cG
	 4buXsuHMXg2Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>,
	Andrea Scian <andrea.scian@dave.eu>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses
Date: Thu, 10 Sep 2026 21:26:44 -0400
Message-ID: <20260911012644.4084201-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911012644.4084201-1-sashal@kernel.org>
References: <2026090928-hatchling-unvocal-7c09@gregkh>
 <20260911012644.4084201-1-sashal@kernel.org>
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

