Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E731195B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089205; cv=none; b=e8dzc6fPrsQad6iKEkA5RWX3PEAvxKPeYPK26RHn3YhJLAWu0mjFYn9qRanDwXMRLhCiKg6JuCmljBzwZ6Ip8iDT3qTFszpjVS8syf+UGUz2agiZePvVNEuIPXZo7lqEDmN7Xuiv9Lo3uP5kv0/pAv6YMCLBLpcheGr0TgBt8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089205; c=relaxed/simple;
	bh=0ECtBVqow8bGmG0+Fp1vCrxXAX5NgJqoOqJ7EQXsb1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D07FdpV37LkLB7f2NOGgAtoTslwnDHiN4mKoQJMKfzKKhJZHPMgwyziyNf5R8SDHStdp0YkCRg/KIuyvaEGQbS2uwQ1A4AoNAcsJmcrOdleVg2Bgl+3aT/EZhuQk/immRa9xITv8y3wivBkwgTVrJqKz17T2AnTR2mQ0vWGBeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1zhtNZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1zhtNZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA681F000FF;
	Fri, 11 Sep 2026 01:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089202;
	bh=6s8QVxXz3R8xSd/AnDSQXv44p6XXMHNZLQsentPhUCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1zhtNZRyX7R2/JeDaX8AumxufXXmV9gfnj2eUAOB1t/ODgjNFjXedhqmnqmMdyCY
	 y9l6tvOs34vruQGOuR5vv2fQXXsJ6ynDWo2sqnGSn4XHoUvGJudqbUTbWhdDaIk3B8
	 WxJGSyFt2ndwfSzWlektyprZr5zNg+ceFO7+Q///jGJ/W9pJiz3E9SVgxG4UCWM28r
	 78WBYncu581vaF61l+H71WJ/MdWuztK8VSEKiuYEiBZJc0UrsJLXNnwiIYbvAtBtxw
	 bgnjESXVT4nH6IDkfFQXwXjlMTZMToVgOIN5Dmpi3kMUGfaqtpYUawA56A2IoDk9sA
	 +12Wwi9AtIhSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Scian <andrea.scian@dave.eu>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mtd: rawnand: pl353: Add message about ECC mode
Date: Thu, 10 Sep 2026 21:13:19 -0400
Message-ID: <20260911011320.4035300-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090927-ocelot-praising-df87@gregkh>
References: <2026090927-ocelot-praising-df87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrea Scian <andrea.scian@dave.eu>

[ Upstream commit 1e06dbfdfb851170b243d6498e442b449324c664 ]

This just add some information on kernel log about the selected ECC

Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Stable-dep-of: 80ecacd054ff ("mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 5691d78cab98e..c7407e9bda85a 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -973,15 +973,18 @@ static int pl35x_nand_attach_chip(struct nand_chip *chip)
 
 	switch (chip->ecc.engine_type) {
 	case NAND_ECC_ENGINE_TYPE_ON_DIE:
+		dev_dbg(nfc->dev, "Using on-die ECC\n");
 		/* Keep these legacy BBT descriptors for ON_DIE situations */
 		chip->bbt_td = &bbt_main_descr;
 		chip->bbt_md = &bbt_mirror_descr;
 		fallthrough;
 	case NAND_ECC_ENGINE_TYPE_NONE:
 	case NAND_ECC_ENGINE_TYPE_SOFT:
+		dev_dbg(nfc->dev, "Using software ECC (Hamming 1-bit/512B)\n");
 		chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
 		break;
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		dev_dbg(nfc->dev, "Using hardware ECC\n");
 		ret = pl35x_nand_init_hw_ecc_controller(nfc, chip);
 		if (ret)
 			return ret;
-- 
2.53.0

