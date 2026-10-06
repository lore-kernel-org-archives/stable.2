Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1033123D
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324656; cv=none; b=tskTrqJ77eGJ60f5nDvDC29j46y4UErSRz1rU0ynWd8Z05esawuQ7Hn4psC2fVca3FQumEHDD0T5Fx2HeyrwJqp/01bj5mTTGbEc2d01Jz7E42AYFnpvWYXrlgvHbovI1POt7mQoiVCjn0d5pqACYeS+3j9iUnz6BauEZMy0YmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324656; c=relaxed/simple;
	bh=rLMD6usYaKU9bHcGbMKg0GvSjZRqHGi2v2Kh+TCWgpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJdfIYZqAIoyw+dWEaSJ8QweO1Fo45JPuqSOZgx1EBzoGJJebqS5FEt3IOjWuAahvgIMfI0pUe50ZSti0f3xIKNth1LXxa3dkw5V44zsb3Uyh1ySw1iy6pbyFz2fn++H/AfYRv//v3P/fJEPd0xDWx4alCB7C8o2IRVyUh36qmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKXqTk0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKXqTk0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28E31F0089B;
	Tue,  6 Oct 2026 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791324655;
	bh=roLuOgkid8AmUZKKPN0zh7TNO75bhSlScedluF34VvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fKXqTk0p8qy7eejO41pjzseDisDLo+qjjYOuvbMf8culJdpzPvq2u/mGojkrjGXIS
	 ujp8gvTvOQFdxaEVVvgisuyG13wkTqHxKhj4TcxT95c5plIGeidIu/Hd1B8RsKCmth
	 RCvFojWnrFToTOS4TVYUWQLOrTPRVpxAiVsBaY24a1CSmWWJCu0l98/HwehwaduxJk
	 HP2bNeKhf027N4TPPPnoueD8Bp5WCanCYH5S0vXVewRQsGjxUzoFRLH9YiJOBeP+xH
	 rHaNtuhzjfs6DF1SiQYROgx7sbcL8KQ2t0LRRi53BbUgAQcZTZXHpEh34L5Y86ib+P
	 VdLAoAD82SMNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mtd: spinand: Enable QE on all dies
Date: Tue,  6 Oct 2026 18:10:51 -0400
Message-ID: <20261006221028.1044867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100507-ventricle-congenial-44f0@gregkh>
References: <2026100507-ventricle-congenial-44f0@gregkh>
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
[ sashal: adapted to spinand_init_quad_enable() computing enable internally instead of accepting a boolean argument ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 0adb15c5fd0ad..ef8b0d9accb9e 100644
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

