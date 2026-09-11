Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA0313E00
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089475; cv=none; b=GkhKGNMpJLGLXeJZ1tPhmQSJdbg1bNjGI2++dMwBFeWl5xUGztttsjDpbUwaf4hImFuQ5d5iJ8GIgBtcb3PhEVf0+mHmZryBBZImEIhxDEZCHwzydP78ebyi6yVZhI9CAPyTgvasXTU7EmkURfBJr0+ObfI2tqfuATlMZiiedio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089475; c=relaxed/simple;
	bh=TrssMvChGQte0xYOBSJ9qa3UKGIzhkXHJYRIq0/hhfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEwcZLHOfkbjLOJPtDX8qnPDQEN2lcWacHynueSNnURVe4lKuVcPAgOxULLAhhDzshD+TV+9lVku7l8KOSMd+ZiSU7AeEDJXPaLImi54OwIPhcGv7a5IsDOcgp0hh7of2DhVIt1NLQ7YjOWXgpqRdNeEz2SMAke1yNXFDlZEYKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8K4Giw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8K4Giw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B1B1F000FF;
	Fri, 11 Sep 2026 01:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089473;
	bh=fyKZtAuXKokYUr+UdysXtsKq/3/z0QxR6OkIcHZxsTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K8K4Giw8jueQODWYLWfYlSsWCzIAqu3PRZdjj7LNIMqq+n01wVIr84AiUrWRisNDq
	 3MYp3F3KHQBe/Tori9x18vTEDNmt/dwRm7H45LwySDHC0CvFAAVXv9/sDOMf0eXRoH
	 JYHpEopRC+BzKC0h8DXuLw6lHYIJrriTA05T5kXBdCSMai6S0vGA34u8ZNbEFA8eFU
	 vt11GeRgfSf3paTPJCqQodOKkv5s9lJlbFXzIR94IFcc8OEsHb3z/fbP+U7MnoTRJl
	 ftlkfZFokBVd1sQ7ZygVZgCMiCl0wlS3QjRmhsvCiHIdVcXZ9FJI7uSNucWBy00eHs
	 RRPNbkBMYw1vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Scian <andrea.scian@dave.eu>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mtd: rawnand: pl353: Add message about ECC mode
Date: Thu, 10 Sep 2026 21:17:50 -0400
Message-ID: <20260911011751.4049598-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090927-freehand-voice-e7f2@gregkh>
References: <2026090927-freehand-voice-e7f2@gregkh>
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
index 198bffa25db8b..56c789ab8c1a1 100644
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

