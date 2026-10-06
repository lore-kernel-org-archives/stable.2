Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6D49C4A0
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302174; cv=none; b=XMXahU7o7KZOcosI+3KQNDLhH/v06KoqxI4DTc2jeeNVKye0dU9DU6Zk15ad5pYZ92/I07ehUaSLr21Cvr0FiUb9QXHWyvPncXiolqsrVBgJpE1SYMU6k+BqSwrFBzf5sGm5K8h0AhexG0jhE63DE2RfPSZ00HYnM5KRQx0hDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302174; c=relaxed/simple;
	bh=wipU4ZcgSuajV5Ai0jrviL2iYL5UCABpeWXCQ4EqM0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Umkbffsf85pM0CHRPLkHZ2e2geXQsYwsaTLN1N7Qcwbnhmyx5QtRd4M+uyYtxfGnUpj45ogIvp3AbRi/mh1pcKffay0Cxapp8mdBJUFV6cPj2FenrqhU98kpyMmOsyoJ3lRv6h8zbIHMdcn+iDSC0e2Qnd4i8wO0hpbIbTE87HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg/EJnas; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg/EJnas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51FB1F0089B;
	Tue,  6 Oct 2026 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302172;
	bh=pRMnk2OwhFHx/X2wjBkoURknfRV8xg6IpVCkL7gAUwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gg/EJnasPlq8wJaxd8COdImI+d9Nhh0dUHDyBbHy0A8HFuwdmbfuRcvixtEOmI13u
	 A4g/lmjBtYW5m7SoLtbAIwjHtiJMSdfod8yrhJWCpPwhKfZc92L/XaoKxJEBNKUs8/
	 DJGo9GJA6SHs7SCvC4GEIPPxs+47By2pOiEVc30KM26ASeFi4zXuzELpSdWlGahIfE
	 EQ6oeq9m1opmi//J+QyZduOSsZWcEQJw9bPmEkomXPWBF+m/qzqkd54/Kr3wscgweD
	 7t7SPLB+94UJc2RoKR43V63pXmNOtmEvtkRffv81r2FkGuaBU6EFYGNctjZzPKYdTm
	 UMSmiq6FRCV3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mtd: spinand: Enable QE on all dies
Date: Tue,  6 Oct 2026 11:56:09 -0400
Message-ID: <20261006155527.762373-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100506-frenzied-eliminate-613a@gregkh>
References: <2026100506-frenzied-eliminate-613a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Han Xu <han.xu@nxp.com>

[ Upstream commit 63d6cace2c4a7f36c1cb44f1bb5e0f3ef19e5c7f ]

The QUAD ENABLE (QE) bit is stored in a per-die configuration
register on some SPI-NAND devices. When a device contains multiple
dies, updating the QE bit only on the currently selected die can
leave the remaining dies operating in non-quad mode.
 
Iterate over all targets and update the QE setting on each die
during initialization to ensure consistent quad I/O operation
across the entire device.

Tested on ISSI IS38SMW04G8B.

Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
Cc: stable@vger.kernel.org
Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[ sashal: Retained spinand_init_quad_enable()’s internal QE decision instead of using the upstream enable parameter. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a41f2fd47379c..ae9019659ba6a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -179,7 +179,10 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
+	unsigned int target;
 	bool enable = false;
+	int ret;
 
 	if (!(spinand->flags & SPINAND_HAS_QE_BIT))
 		return 0;
@@ -189,8 +192,22 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
 	    spinand->op_templates.update_cache->data.buswidth == 4)
 		enable = true;
 
-	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
-			       enable ? CFG_QUAD_ENABLE : 0);
+	/*
+	 * QE is a per-die setting on some devices. Program each target
+	 * individually when enabling or disabling quad I/O mode.
+	 */
+	for (target = 0; target < nand->memorg.ntargets; target++) {
+		ret = spinand_select_target(spinand, target);
+		if (ret)
+			return ret;
+
+		ret = spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
+				      enable ? CFG_QUAD_ENABLE : 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int spinand_ecc_enable(struct spinand_device *spinand,
-- 
2.53.0

