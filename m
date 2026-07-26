Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2593630B5
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072934; cv=none; b=XR8i9S3NsBl3YRZ4Hgqw5CeKoIYuecRyerGKaKzUaMFM9HEtIlPwVPcAcbCE68SXAfLW2b3o6RFPgYjvjKpQms/oQpG78lVTtaqADyC/BUvAkAgtgPBcG+vJAkxIdT0aWcwv80YEqF5p3WMzjdBBWomWkR1QfnvaeRoi21qdhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072934; c=relaxed/simple;
	bh=cJIc22/WJEomsBRoxgw399DzVEOSM7AXLmP/c+Fhs6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahNU9WZw8+Bq1Vfd5SVmfkUMyekz++yI9mqRnm12MnX18lZywk7kYcy85XgIOjlfRqJ+LgcMNw1mX6EzqfVh4NcTADyebFLGwbr83fcXbxKnhwoBBUmHdv20/zeH5uQXWVsvuQL8YVpadMtcaJXtPZzTQwxC6XpGyWTsS9M9E3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEjg5voN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEjg5voN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A61E1F00A3E;
	Sun, 26 Jul 2026 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785072933;
	bh=iGj0vPA+iQ31UX77VS9UAm5EOX06V4+zH2Sz06Und0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HEjg5voNrRRS6g0dRqg7YVmm+uoIX/yaIzji0ZKJsfpp1CvVTqJms119hn/ulfUcb
	 1y1Y5tjY+2pP7VlbxMtmDwtGoNMPchPIHzUqbQ0jXTJtuQjS8XhMwNijfReTttiuoS
	 5LrCGs59vhwppq4e8yfbXjIIFDqRVjbshfCxpNjhP2snuG+4PKjcaQsbiawqfO2em1
	 vRsNF8Zio1WtKZBGeEjqEygJwwusBjKKJBbcyojXzuIkU90JCqzVcJS2WmVYtWzq6b
	 tSBFNBM1yrSnpmrC4D2HcbdKIgygyPTLqLJVOkr/np57zByDaVYeRUMWy7LQXVQjfZ
	 edeW8xVbi872A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@kernel.org,
	Michael Walle <mwalle@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] mtd: spi-nor: swp: Improve locking user experience
Date: Sun, 26 Jul 2026 09:35:27 -0400
Message-ID: <20260726133527.364488-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726133527.364488-1-sashal@kernel.org>
References: <2026072003-borrowing-opium-38cc@gregkh>
 <20260726133527.364488-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit e1d456b26bf23e30db305a6184e8abd9ab68bbf2 ]

In the case of the first block being locked (or the few first blocks),
if the user want to fully unlock the device it has two possibilities:
- either it asks to unlock the entire device, and this works;
- or it asks to unlock just the block(s) that are currently locked,
  which fails.

It fails because the conditions "can_be_top" and "can_be_bottom" are
true. Indeed, in this case, we unlock everything, so the TB bit does not
matter. However in the current implementation, use_top would be true (as
this is the favourite option) and lock_len, which in practice should be
reduced down to 0, is set to "nor->params->size - (ofs + len)" which is
a positive number. This is wrong.

An easy way is to simply add an extra condition. In the unlock() path,
if we can achieve the same result from both sides, it means we unlock
everything and lock_len must simply be 0. A comment is added to clarify
that logic.

Fixes: 3dd8012a8eeb ("mtd: spi-nor: add TB (Top/Bottom) protect support")
Cc: stable@kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/swp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 8036073a199ee1..8aca0203a62157 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -267,8 +267,15 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	/* Prefer top, if both are valid */
 	use_top = can_be_top;
 
-	/* lock_len: length of region that should remain locked */
-	if (use_top)
+	/*
+	 * lock_len: length of region that should remain locked.
+	 *
+	 * When can_be_top and can_be_bottom booleans are true, both adjacent
+	 * regions are unlocked, thus the entire flash can be unlocked.
+	 */
+	if (can_be_top && can_be_bottom)
+		lock_len = 0;
+	else if (use_top)
 		lock_len = nor->params->size - (ofs + len);
 	else
 		lock_len = ofs;
-- 
2.53.0

