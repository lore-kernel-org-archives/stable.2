Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1844CAF9;
	Tue, 11 Aug 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465379; cv=none; b=HXMPHOgYhuwprYvhNSO9lM+xxxan1sLYwzS9uPvqFa3a8zP3PNw0LYZ1Umfl+r0DiXWU6WkJywoKQUlKjVGirke42D9KIYBlkopnGK7+QcABhHBpOkr4Fm974M6BPLIhhlLxerjclbuPT1TQUl4hfTUVHrRU2F9dLfe+Xqb7FWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465379; c=relaxed/simple;
	bh=dIklY3UfrxdjUEYYWqpLDVjZe71HM6zRddPIFCZnKhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJaR1PAdjB3MmEPh9grprEX08pBKHZb8x2iW3XKtgTiaqjQWqd+G2yUS+R/gelF4yFyea3v1whICBUg13rj6T87jojn+IiQIHpGsEvyOywGoGykV8u1hFNn5fvZStyX7lzg6emELDktwTuKULD+G4v2eJV3wEgCHoqNHiTRJ1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=ed+aIs38; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="ed+aIs38"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1786464836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FB8jUzAk4vdr/He6IOGom269wrMDPlwN0Q03T1SXJcA=;
	b=ed+aIs38d2opKY7m9NHGGlutggYTEoU3swZhBgeiVJf8Yeq+ZIlg7GMcikNCzsOyUCqzpe
	o174B6SglLL+s9lsMCwgXM0GvZ4dJSWS5X5CBmIcLpcc0H+Gf7G5SqS2WuwWOT46o+VCmh
	q2i8uzqExjk8o/Ta7UYnBZ+uS6xODx/r2Nb5heIUVSMN96VmOMzWcf+lr2xjdVzpZFhpPe
	vxNOEP730V0Qm/QywRWcLdS2mbjzv6BVTloMrzgREnvwlZ/FNyaQuF2g3a9Q4ttDRGDcx3
	iEabvQOTwQNGq5sdjH90JIV6Vv7xD+z1Wn/oBKxyAyxmIwIJxquRZZzK/jBfqg==
To: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	stable@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	David LaPorte <dalaport@amazon.com>,
	Gabor Juhos <j4g8y7@gmail.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] mtd: spinand: repeat reading in regular mode if continuous reading fails
Date: Tue, 11 Aug 2026 18:13:38 +0200
Message-ID: <20260811161342.533280-4-frieder@fris.de>
In-Reply-To: <20260811161342.533280-1-frieder@fris.de>
References: <20260811161342.533280-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

[ Upstream commit 010dc7f2dd6a0078ade3f88f627ed5fbf45ceb94 ]

Continuous reading may result in multiple flash pages reading in one
operation. Unfortunately, not all spinand controllers support such
large reading. They will read less data. Unfortunately, the operation
can't be continued.

In this case:
 * disable continuous reading on this (not good enough) spi controller
 * repeat reading in regular mode.

Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 10339209e7322..bf16901b77b64 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -427,8 +427,16 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		 * Dirmap accesses are allowed to toggle the CS.
 		 * Toggling the CS during a continuous read is forbidden.
 		 */
-		if (nbytes && req->continuous)
-			return -EIO;
+		if (nbytes && req->continuous) {
+			/*
+			 * Spi controller with broken support of continuous
+			 * reading was detected. Disable future use of
+			 * continuous reading and return -EAGAIN to retry
+			 * reading within regular mode.
+			 */
+			spinand->cont_read_possible = false;
+			return -EAGAIN;
+		}
 	}
 
 	if (req->datalen)
@@ -849,10 +857,19 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	old_stats = mtd->ecc_stats;
 
-	if (spinand_use_cont_read(mtd, from, ops))
+	if (spinand_use_cont_read(mtd, from, ops)) {
 		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
-	else
+		if (ret == -EAGAIN && !spinand->cont_read_possible) {
+			/*
+			 * Spi controller with broken support of continuous
+			 * reading was detected (see spinand_read_from_cache_op()),
+			 * repeat reading in regular mode.
+			 */
+			ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+		}
+	} else {
 		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+	}
 
 	if (ops->stats) {
 		ops->stats->uncorrectable_errors +=
-- 
2.55.0

