Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB753812EF
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069528; cv=none; b=OW6Y7A3RLXpNhTG4+FhYdvXuFBmX0Uq9+iRKve3jGBaf2GJHclSgaT8Jr7lJp6QOXPY24I+D3C+dXXjidLfn2WWppAu0Uz2/ZLHpdzwyA2PLkt4iwr3DloKQyrJuYVRMCcCS2fHtMO/xM6AXyt7eHhG4T5D9D/8+j9AIH9frWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069528; c=relaxed/simple;
	bh=oG+vVHqK9wHIxLgq1aFSiF+VCAnyFGOrWqkh+dwKkrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcVSIgBTWsg2Z/zHvTDl+rPeAcDh1soYmZx2JpZW04/oUYckOGt61culqb7n/Lle8QIA7q2qFIgiNOQ9TDM1Z0aQDZt06vlLzTsjADwwjrGZBGZUBeQXLAUy8GfZqJwNFtpMlmb+icH5Kmmwsyt+dqoGlS66YJu7ke4kbEHlx6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irl9kNyZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irl9kNyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291EF1F000E9;
	Sun, 26 Jul 2026 12:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069526;
	bh=h3kNIMqt5uoauC2zF5KTR6tLzntTPG4YHZwVUwrW+OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=irl9kNyZyzPtccOF7+AqJ+y+GlynMOL96cIbO8iVGd9uOfx4bEq5S+aXTpFBjInfo
	 uQoNRe/TGNYDGSjfYsgv2C7ok6BcgjocYNA4HGybX7NVQacgpfKUEgLthq4ryqlZ+d
	 q8z0hfkipwdwbsBUzHEo+qf3PRR449loursFp9gjb1ByQrXW/mMep+lnqxeJZfuUMc
	 b60MBr7DW80JhG7TafxP+EgAHf6a2k8TE+TIqPtv8UETvknobwSv8GhLYmPsSG1S2P
	 TBzUx7w2Je23RdrA8Xsb8vKXx1+5JL13HogcUmZhRN8VHaCNp5bbsbdWEXOCVRQfRl
	 PZaTu8oEOkgKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] mtd: rawnand: Add a helper for calculating a page index
Date: Sun, 26 Jul 2026 08:38:42 -0400
Message-ID: <20260726123844.64620-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072021-compare-playpen-3ff7@gregkh>
References: <2026072021-compare-playpen-3ff7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit df9803bf5a91e3599f12b53c94722f2c4e144a86 ]

For LUN crossing boundaries, it is handy to know what is the index of
the last page in a LUN. This helper will soon be reused. At the same
time I rename page_per_lun to ppl in the calling function to clarify the
lines.

Cc: stable@vger.kernel.org # v6.7
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240223115545.354541-3-miquel.raynal@bootlin.com
Stable-dep-of: 8e4531667d71 ("mtd: rawnand: Pause continuous reads at block boundaries")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/nand_base.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index e9e4ea87116c74..9c925439696047 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1212,19 +1212,25 @@ static int nand_lp_exec_read_page_op(struct nand_chip *chip, unsigned int page,
 	return nand_exec_op(chip, &op);
 }
 
+static unsigned int rawnand_last_page_of_lun(unsigned int pages_per_lun, unsigned int lun)
+{
+	/* lun is expected to be very small */
+	return (lun * pages_per_lun) + pages_per_lun - 1;
+}
+
 static void rawnand_cap_cont_reads(struct nand_chip *chip)
 {
 	struct nand_memory_organization *memorg;
-	unsigned int pages_per_lun, first_lun, last_lun;
+	unsigned int ppl, first_lun, last_lun;
 
 	memorg = nanddev_get_memorg(&chip->base);
-	pages_per_lun = memorg->pages_per_eraseblock * memorg->eraseblocks_per_lun;
-	first_lun = chip->cont_read.first_page / pages_per_lun;
-	last_lun = chip->cont_read.last_page / pages_per_lun;
+	ppl = memorg->pages_per_eraseblock * memorg->eraseblocks_per_lun;
+	first_lun = chip->cont_read.first_page / ppl;
+	last_lun = chip->cont_read.last_page / ppl;
 
 	/* Prevent sequential cache reads across LUN boundaries */
 	if (first_lun != last_lun)
-		chip->cont_read.pause_page = first_lun * pages_per_lun + pages_per_lun - 1;
+		chip->cont_read.pause_page = rawnand_last_page_of_lun(ppl, first_lun);
 	else
 		chip->cont_read.pause_page = chip->cont_read.last_page;
 }
-- 
2.53.0

