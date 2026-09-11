Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B6214A84
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089841; cv=none; b=aPyQnVuuzuX+BxcspLvXaAS9+o8AZ4STTDiSeOBCfEnacQdmcheJA8BPE6O5qf987Xm1OrBwewonKCF4G1oODWZsKOs/klfEBd7yjRHeuxYICQbuIHNR4oK4AV/vWHZ8LfjymuSYhULFLOqu0Bd6EtEPKY60TqfHPzX6NnKGm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089841; c=relaxed/simple;
	bh=Gmkvt/D8slQQ4UKNOohNSO5ACWV7EVWCjdtvpNWdQbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcHw1winDVwK6vspZM5J/cynlbR8vY/TO4w7na5CK37xBdqMDRZMgHF6koHkp7qqs/Nm8SrMkM4RkqkL55uHJ6rV4izlTNGBSUHiMc4HuM5z5pNjRj86bXlPPWqUX1rtEwpooGMaBdL61gJUbmT8aNR02vqTO5JcMCPymcKQ7Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtXR4Zec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtXR4Zec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDC91F00893;
	Fri, 11 Sep 2026 01:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089840;
	bh=4geSr4HqaAGeUyXFXXeSFHlkZQbnj37y/5IT5pyYwsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gtXR4ZecWITsOHopT+kyw5WLLwKqVvkDTOKKnr6C5uDvho6iW4xMEkH4q7rfzZ08K
	 G637vhkxIw8JT/Yh5/ELCa+k4xP1lMumXwIhD81LGtjlyQ1YhBXkXyUO8idqvHdSN9
	 ZwI/dikDcX/CC4VhCa6Kk6wMTHpzRWTKyklxTvPCM0Q//L5x4VpoWG1zqt7OeBiTKJ
	 nMrr4PBnJk40TInZqKgpYuKtEgsPiFTXXtWs90uecrKJ5S2KZyd2SW8nndLXqLe+7X
	 YY6K+RHxLf8alA18djYtynZ4JtdFo+BlDjmK2N8CGsm5dvn5q4FY/Hx+fwiM4+fjlg
	 C+eVAhYrhXeww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Scian <andrea.scian@dave.eu>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mtd: rawnand: pl353: Add message about ECC mode
Date: Thu, 10 Sep 2026 21:23:57 -0400
Message-ID: <20260911012358.4072377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090928-shrubs-fax-9803@gregkh>
References: <2026090928-shrubs-fax-9803@gregkh>
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
index 04e62c3ab5975..929dc759c6b24 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -975,15 +975,18 @@ static int pl35x_nand_attach_chip(struct nand_chip *chip)
 
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

