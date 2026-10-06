Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B34AB1CA
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329126; cv=none; b=Y/LZQqg0zZUgrultE3/q8/nWlOvsShIZz/ftFcdLvNSIepC9hZ0zsBrW5Zxsl5HGdsvvS3GAz+V6xkKEsZa5d6+98LrZPTZqdLv8Ebna+Mp8GYNsrQkduuw2cMtSnM+8T4ojeXfRUyXNhzA3rqMtg7ypOc5a4i+UrftxzRcikK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329126; c=relaxed/simple;
	bh=q1OOoBieW7MKgdrLF8inLCJYdL1Av+E1K+SSenFM1SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgogWg9is4Ov8SnOcxtJznM2OBaL/rEmazr4jJYpKnwBNgBBMXjxTe9tAqu7COQc5dCe+yL5oMj2cR7levHcfx7BJX3OX+e4P8jYCfFPcaPRIlgxLdJd/cCkBpzcu0S4Ss7UgClUyoP5fgydy/PuMAskbt5OZKArIhDKTdaw7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl+WvrOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl+WvrOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268621F0089B;
	Tue,  6 Oct 2026 23:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791329119;
	bh=t5u4JgBqcc2NhD593/K5HqfHITy4NONOBxdg2N2YqYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cl+WvrOkBmT5hFxnwVOcXdmj6hBnkhpJJozbAwocOwnkXkGVRStB4JguLEh7wlPQ5
	 BJAzH/IMwhh4cjVUekcpyIUQZ+aeI4nwcXEzmIYtHnMjU+o1HSzCj7qR0XXxguPpMu
	 nKtOwlcjpymYScvs3Z2URtJtcIr7TztM6+duT7sI1KbtR2teNYpphkmwQNu+eJcugu
	 BO0FLJT86E/1eHY29prLQZmcNnAr4k0nMEXL6iVLxmTl6wPowlshMsfWVkCCxexcq2
	 /14ygCdu70KpigJo2NdTFKY0r0jCALePhHRLl2w/dTtNCD4C0FzuAaU3x86qVdgYQf
	 Kf30Ye2bOcoTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mtd: spinand: Enable QE on all dies
Date: Tue,  6 Oct 2026 19:25:16 -0400
Message-ID: <20261006232452.1126912-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100507-that-landed-061a@gregkh>
References: <2026100507-that-landed-061a@gregkh>
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
[ sashal: retained local enable detection in spinand_init_quad_enable() instead of using an enable parameter. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8794a1f6eacd9..953202e711da4 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -172,7 +172,10 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
+	unsigned int target;
 	bool enable = false;
+	int ret;
 
 	if (!(spinand->flags & SPINAND_HAS_QE_BIT))
 		return 0;
@@ -182,8 +185,22 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
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

