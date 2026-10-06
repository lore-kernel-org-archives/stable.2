Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290591A6822
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322377; cv=none; b=Zk3XMKqrnX3c6hiAN8WGgw+lJQNnxXqp+HO5Es8JSEtCBpLCvtk/eNz5Aj615rT9VWL5fHeCef3KTSBahYrI7lE0TU+henau93Gd/9nMzGYTnkPDkLGQ/OyMsMI7NIqPJxoFKXZCkVsLGspv8id1PV6S47342grt80oml67aV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322377; c=relaxed/simple;
	bh=4hK9BYF+rDGGlvYD1tKlTmcb+ddrWwWtee0j1sBoYGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eruHw2d7DVO1+q/RBICdiqbrqGveX+HWAbL81GZ3PnaR9YyqScGaHmb4wnS+qiKMCggtrjuwV+XdKRrpNX8xv/fDpYDlmhL5bPrYKet7KYDtTeBP+OiyjXwFNdBw5JI2xzF5SikqdO6GDpTAKrtcLE9FlfmtlU2Tm5WOZewcRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAfF65ON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAfF65ON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44D01F0089B;
	Tue,  6 Oct 2026 21:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322375;
	bh=X/IGwTo/p6gHeH5vwynBZ8t+SE+EX12OoH0pJ53BKII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lAfF65ONWdAtEaXDZnXSgd2HSWKVNKpYTibNQhz6cgVCxaBT5+ej7Z2/roezZYKWL
	 PCY3uZEIb+1EHRmOOiiiVIgyPcEItpeaIFEQgWMlT7+gEm3aSSX4af+rSlq1Y/5Ja8
	 65GkFkZcIv46ovW4InSWbWjT2YSEG6jxppbCwV7eceYZ6k4Srr7cQ6A5o2TCZN064c
	 EIFyHwYYa7weryJ1xyEdRITjKSqtf1wwv5W9r+SZu0Kaa98Lzgy/dJZ1Ya5/xO5aO2
	 JAHfxflKI+EP40QseI7sIV+Lzu42+Z/RRVApRiMvP6ZzD6mD+mca/qVmFWwF7lbhjs
	 PeXVovKFBxWuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mtd: spinand: Enable QE on all dies
Date: Tue,  6 Oct 2026 17:32:51 -0400
Message-ID: <20261006213142.983906-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100506-sliver-crafty-6b50@gregkh>
References: <2026100506-sliver-crafty-6b50@gregkh>
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
[ sashal: adapted spinand_init_quad_enable() to use its internally computed enable flag instead of a parameter ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 39f9826342966..2ee90663b5e9b 100644
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

