Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F49231832
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072933; cv=none; b=Qj9eRa85XTOEzUoQzZAnBw/H7lBBqir2zodad2XKtYn40XCU+jj2ndvBUWyKVbtjNzhqidKWbPsqB0OlJvQ+13FyHeinSsVphI3bm8xtsHL+kyIp6xTSGl/EEgqOJ1YIJeGn/8O/hGAy5ifybI6tT8Bq/I3tdO32GG9JEhU9AGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072933; c=relaxed/simple;
	bh=PNbMsvvLqQwAjV6T1+uwiZ8S3WdR7CrD1xdrqwTWOnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfRqaGmGx4rTSqki5yiqR9K/F/9kqT0GJK+GiL2AuPypK//kG2yOXLapXhVVGBRCO+wbG00l5j0Fiw5mCr/WhIEilfqevS6QNypsx0Jhi4JKFJIKIUF4/iA9NEWV483ZlItw9wpU84IYIa4sgRu4LfTK0/mP4zCzNPkXnjGLmfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAqcdV93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAqcdV93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734ED1F00A3A;
	Sun, 26 Jul 2026 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785072932;
	bh=at8ZDEtwUGGo9SV8XSL5NhUwQ+/0IAPuPaJVl8gd5XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KAqcdV93HR9zljgKuNog0lrL2kPV7XtT/yMG/EFckeJ5NZbuDokIrKM9nItAn0L+W
	 KfpTcNvrrVw1f7PFmLK5Si+3WNsk4n1rokB7xYegS5+Up0GwQEYa+959SEG1qDpPUr
	 xMCWjjipNzRPtjnRSX+hhYvyKKGsiS0dq8sC84dnOlJ9UMi/hBPfHq30u8mdPvcdTG
	 qXFT9ySP20vdpJznUa/g8g5XyP1XOoN6lrzumZbAkZX4ARE38x5AB6FXIfD9GX3K0/
	 H1TxXcqrVK/6i/ogc7wy4dFAEkh9enEVsz8PwN66a27gVv8XZgKVZEkS3BQ2WJ+Dn6
	 Fz2UUJpVLZjhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Walle <mwalle@kernel.org>,
	Jean-Marc Ranger <jmranger@hotmail.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] mtd: spi-nor: Fix spi_nor_try_unlock_all()
Date: Sun, 26 Jul 2026 09:35:26 -0400
Message-ID: <20260726133527.364488-4-sashal@kernel.org>
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

From: Michael Walle <mwalle@kernel.org>

[ Upstream commit 2e3a7476ec3989e77270b9481e76e137824b17c0 ]

Commit ff67592cbdfc ("mtd: spi-nor: Introduce spi_nor_set_mtd_info()")
moved all initialization of the mtd fields at the end of spi_nor_scan().
Normally, the mtd info is only needed for the mtd ops on the device,
with one exception: spi_nor_try_unlock_all(), which will also make use
of the mtd->size parameter. With that commit, the size will always be
zero because it is not initialized. Fix that by not using the size of
the mtd_info struct, but use the size from struct spi_nor_flash_parameter.

Fixes: ff67592cbdfc ("mtd: spi-nor: Introduce spi_nor_set_mtd_info()")
Cc: stable@vger.kernel.org
Reported-by: Jean-Marc Ranger <jmranger@hotmail.com>
Closes: https://lore.kernel.org/all/DM6PR06MB561177323DC5207E34AF2A06C547A@DM6PR06MB5611.namprd06.prod.outlook.com/
Tested-by: Jean-Marc Ranger <jmranger@hotmail.com>
Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Link: https://lore.kernel.org/r/20250701140426.2355182-1-mwalle@kernel.org
Stable-dep-of: e1d456b26bf2 ("mtd: spi-nor: swp: Improve locking user experience")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/swp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index df573601fe85c6..8036073a199ee1 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -50,7 +50,6 @@ static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
 static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 					uint64_t *len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
 	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
@@ -71,13 +70,13 @@ static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 	min_prot_len = spi_nor_get_min_prot_length_sr(nor);
 	*len = min_prot_len << (bp - 1);
 
-	if (*len > mtd->size)
-		*len = mtd->size;
+	if (*len > nor->params->size)
+		*len = nor->params->size;
 
 	if (nor->flags & SNOR_F_HAS_SR_TB && sr & tb_mask)
 		*ofs = 0;
 	else
-		*ofs = mtd->size - *len;
+		*ofs = nor->params->size - *len;
 }
 
 /*
@@ -150,7 +149,6 @@ static int spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
  */
 static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	int ret, status_old, status_new;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
@@ -175,7 +173,7 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 		can_be_bottom = false;
 
 	/* If anything above us is unlocked, we can't use 'top' protection */
-	if (!spi_nor_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
+	if (!spi_nor_is_locked_sr(nor, ofs + len, nor->params->size - (ofs + len),
 				  status_old))
 		can_be_top = false;
 
@@ -187,11 +185,11 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 	/* lock_len: length of region that should end up locked */
 	if (use_top)
-		lock_len = mtd->size - ofs;
+		lock_len = nor->params->size - ofs;
 	else
 		lock_len = ofs + len;
 
-	if (lock_len == mtd->size) {
+	if (lock_len == nor->params->size) {
 		val = mask;
 	} else {
 		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
-- 
2.53.0

