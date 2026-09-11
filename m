Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522081A6813
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789087322; cv=none; b=Yw9287VMvyuEhiHjIsGDxoOEQDwEqQhecFK2l/HU/dopPsSI/Sazyb5Yrlo+jlxPfbFKwp9tAbI3yq5b1amIEZyqjFephVTUio5/TUUG/ytWi8kxxgN98xUXuGBffzweECKCyY+73w6L9kgLENjOjxWosvgbYHKmf2dxLYcHDE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789087322; c=relaxed/simple;
	bh=GqAgzlu4u9tG06XGQl0bf7qJ5/MTY8HWImvo4ETVCSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJLYPj4FX8sOJ6ZvRs51y0AmbS+NuFAgsg9767ZeqSkBsVzFgR108PeHKj/p9v64i2ZNT/Etlxlg5/98sVloIL+WBd/7lmZRPkiZ73eyJDbdUoKRIFbeXFg1tcunydnH2fpL1B1+QSYNkUPu36zUIrEgOMO8/VSS5KzLI7I5GX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+PcBNi3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+PcBNi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF9F1F000FF;
	Fri, 11 Sep 2026 00:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789087320;
	bh=9HmT4ldFIQubAMTTMAknDvZR8G9SKHQ9VOh0Jj1HqLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+PcBNi3VyRF2pMCq4s9pUU2DQLEgYIQcKwRUmTXxTgVoLjVPUKNLfuE7v/osWSUl
	 vUHhnIXLkulf3tMX3CV9rt6aPcAcyVWP/EMMJMTbfkJ+7UskMDk7qz41Ft2xiP0VfS
	 wjucfVJ7aO8WHgWqGfaaoYLfUC9lB26JhnR9Z1qVIX499RMzlmgdFQ6A86gw1tjIDy
	 cVyUfgz4xENU7MIpSwACAzgc8OXGtMQtWVzH9cpt97UNu2KQpHuEqHHjgrP2amm/aw
	 vH74RBw5zrKaTktkpYMRp1yr7DjorByzzmIzjCXB/g9NOUS8TYq/nwa2wPRHpc87fA
	 6gSNnL+d9J3RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Scian <andrea.scian@dave.eu>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] mtd: rawnand: pl353: Add message about ECC mode
Date: Thu, 10 Sep 2026 20:41:57 -0400
Message-ID: <20260911004158.3575108-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090927-cavity-motion-43b7@gregkh>
References: <2026090927-cavity-motion-43b7@gregkh>
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
index 81dde993ee9b0..06f8f1e14b9c2 100644
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

