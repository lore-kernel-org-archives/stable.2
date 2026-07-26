Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62F3A5E71
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069529; cv=none; b=mLBCM3fIiEZ6kqAzw1J7tb/lZFVGLcdGt0d0bBul8izK0loVdMqfDXPDTI7R38ccsQ/91Pj9xFbMQ2KZJZ9kzGs/dpHdlABhSv6W0z/uoHAcUXuTXO8vCRvZGeZifXeIpXg0Hv235lFm2iHSnG2uVx7nSikBDQgKC5v+3JcfMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069529; c=relaxed/simple;
	bh=IjumMdX9ZwfFFUmSz1ZVOHU8G0wvM0IfHEzLidRR+os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue1GoOlfEK24TdO04dEfF6e1uqrNyOgAZ3t9QjakcutOBEXwevMhS9royVzn/uH0IMOHzeRUvC5KMELAizRQ/d2l385OyZ+rVlQATjB/Y92BXR5lCRgAMekhFNE+xjX0KQPb0KDiirmR0H86MwVKPUw1Q0zXOF3rwbvyl1KOa94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzMd1dxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzMd1dxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7541F00A3E;
	Sun, 26 Jul 2026 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069527;
	bh=Het0HFfQVjJw8mjad9eLDVFevAXPtLMP96yQTSWgdYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bzMd1dxCS6oPWQ1InJrjkqR4dTRN11zHNIWZcRei6W1XBPVG0Z5WejUJ0akWOtjvR
	 MB5EgcW1JAIk/QIT3ChsUVrPp+5DUqAh5hEYYvNs1d6x1bTCAgEnIqfK6ZEA1j9/rW
	 aD2z0KXUgjwun/H+BwsSwYOseO7Onu+UB4PgQI1aRSTAkC+jkuDkyoPtPi8JChBcnb
	 YgZQRFGqly8FimXo9EKP+RUnYP/Ptem7Weg9sCdE/NaxN1rOF2gHtAAUySJ6TcTNqI
	 Z7chR9+tsBbi79TLPaa/D8vTn9JxB8tbpejWW/CvfKYyjNAG70deIE4RWyTRDabuc/
	 iXbdKhyP/tL0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] mtd: rawnand: Pause continuous reads at block boundaries
Date: Sun, 26 Jul 2026 08:38:44 -0400
Message-ID: <20260726123844.64620-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726123844.64620-1-sashal@kernel.org>
References: <2026072021-compare-playpen-3ff7@gregkh>
 <20260726123844.64620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 8e4531667d718e2e9b193928cf9b2497fa0d01ef ]

Some chips do not support sequential cached reads past block
boundaries, like Winbond. In practice when using UBI, this should very
rarely happen, but let's make sure it never happens.

Cc: stable@vger.kernel.org
Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/nand_base.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 11b0fb4bde96f2..b2f56d89bfd367 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1212,32 +1212,32 @@ static int nand_lp_exec_read_page_op(struct nand_chip *chip, unsigned int page,
 	return nand_exec_op(chip, &op);
 }
 
-static unsigned int rawnand_last_page_of_lun(unsigned int pages_per_lun, unsigned int lun)
+static unsigned int rawnand_last_page_of_block(unsigned int ppb, unsigned int block)
 {
-	/* lun is expected to be very small */
-	return (lun * pages_per_lun) + pages_per_lun - 1;
+	/* block is expected to be very small */
+	return (block * ppb) + ppb - 1;
 }
 
 static void rawnand_cap_cont_reads(struct nand_chip *chip)
 {
 	struct nand_memory_organization *memorg;
-	unsigned int ppl, first_lun, last_lun;
+	unsigned int ppb, first_block, last_block;
 
 	memorg = nanddev_get_memorg(&chip->base);
-	ppl = memorg->pages_per_eraseblock * memorg->eraseblocks_per_lun;
-	first_lun = chip->cont_read.first_page / ppl;
-	last_lun = chip->cont_read.last_page / ppl;
+	ppb = memorg->pages_per_eraseblock;
+	first_block = chip->cont_read.first_page / ppb;
+	last_block = chip->cont_read.last_page / ppb;
 
-	/* Prevent sequential cache reads across LUN boundaries */
-	if (first_lun != last_lun)
-		chip->cont_read.pause_page = rawnand_last_page_of_lun(ppl, first_lun);
+	/* Prevent sequential cache reads across block boundaries */
+	if (first_block != last_block)
+		chip->cont_read.pause_page = rawnand_last_page_of_block(ppb, first_block);
 	else
 		chip->cont_read.pause_page = chip->cont_read.last_page;
 
 	if (chip->cont_read.first_page == chip->cont_read.pause_page) {
 		chip->cont_read.first_page++;
 		chip->cont_read.pause_page = min(chip->cont_read.last_page,
-						 rawnand_last_page_of_lun(ppl, first_lun + 1));
+						 rawnand_last_page_of_block(ppb, first_block + 1));
 	}
 
 	if (chip->cont_read.first_page >= chip->cont_read.last_page)
-- 
2.53.0

