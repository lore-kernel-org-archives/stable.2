Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB77477281;
	Wed, 19 Aug 2026 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148238; cv=none; b=BItfBHfjSwUgLVeWbEXbNFY3GF8HQB2F6PKimNFBCVYJCqAcHmQw42hZjKLkge0o0rDrTtnPVackl750njaGG6Xt2U0zE0uRj4J1NPg37P+M5KopPoMpcNCGe8udyVtvN6r3oAt40krXXbxIzY4XXZmRUAH1AaQPkS8aKW6HDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148238; c=relaxed/simple;
	bh=gzr9qrQl9Xi6CYbBzzGDgrtxfPAZ72Ttt+Xk8B+5yy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EgOCTFpCqkiEG/Jcpy8R7fzTN6GKPXjV7EdIiagnGkGgldm7F5kNuun+JIbFEv08cVOYpdW1NkxfAHQwVDO9rj9ZWjAPKAVdwC4xd2o/Vj/MYi6LP02hjsBTxlSlApZ4RhEg5eDwcVGH7fWJ7uSJBLuEJBDXJiU4g4aNKXGLFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ayrdjv61; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ayrdjv61"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a93dedec;
	Wed, 19 Aug 2026 22:03:47 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v4 1/2] mtd: spi-nor: core: Fix mutex leak in spi_nor_rww_start_exclusive()
Date: Wed, 19 Aug 2026 22:03:36 +0800
Message-Id: <20260819140337.36775-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819140337.36775-1-runyu.xiao@seu.edu.cn>
References: <0a15f6e8-f1ca-4945-9bd5-2b64a2802a58@linaro.org>
 <20260819140337.36775-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01a55d45203a1kunm0db6d2d0140e28
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTU9KVh5KTkJNQ0wYTB9NTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ayrdjv61Na3LInCrwmOcPR3ii9Z02YiD3rL6lpx3+MK79et/zGZ25xqpw0oR1x2SsB9Cuu7QI/kIFz/H9C7LWVnFQXT/PX/c+nndU2yl85LOmK+rA4L+x2j60822tVC1F2quh7fABvLbfIYQQFEzrbW9JMs5rUFEsfaoy8//paQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=zGCg9rLuHCXctyeYGSM1cLTpJ4wS8crEseTBz4E8UT0=;
	h=date:mime-version:subject:message-id:from;

The RWW wait helpers must not block while evaluating the condition.
spi_nor_rww_start_exclusive() used mutex_lock() directly and could return
with nor->lock still held.

Switch the four RWW start helpers to conditional scoped mutex guards so
the wait condition never sleeps and nor->lock is released before return.

Fixes: 74df43b3f626 ("mtd: spi-nor: Enhance locking to support reads while writes")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Changes in v4:
- Use the original RWW locking commit in Fixes and update the subject.
- Apply the locking fix to all RWW start helpers used as wait conditions.
- Keep commit 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex
  cleanup helpers") as a stable prerequisite because it adds cleanup.h.
---
 drivers/mtd/spi-nor/core.c | 84 ++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ccf4396cdcd0..d5c6a925862e 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1273,14 +1273,15 @@ static bool spi_nor_rww_start_io(struct spi_nor *nor)
 {
 	struct spi_nor_rww *rww = &nor->rww;
 
-	guard(mutex)(&nor->lock);
-
-	if (rww->ongoing_io)
-		return false;
+	scoped_guard(mutex_try, &nor->lock) {
+		if (rww->ongoing_io)
+			return false;
 
-	rww->ongoing_io = true;
+		rww->ongoing_io = true;
+		return true;
+	}
 
-	return true;
+	return false;
 }
 
 static void spi_nor_rww_end_io(struct spi_nor *nor)
@@ -1310,16 +1311,17 @@ static bool spi_nor_rww_start_exclusive(struct spi_nor *nor)
 {
 	struct spi_nor_rww *rww = &nor->rww;
 
-	mutex_lock(&nor->lock);
-
-	if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
-		return false;
+	scoped_guard(mutex_try, &nor->lock) {
+		if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
+			return false;
 
-	rww->ongoing_io = true;
-	rww->ongoing_rd = true;
-	rww->ongoing_pe = true;
+		rww->ongoing_io = true;
+		rww->ongoing_rd = true;
+		rww->ongoing_pe = true;
+		return true;
+	}
 
-	return true;
+	return false;
 }
 
 static void spi_nor_rww_end_exclusive(struct spi_nor *nor)
@@ -1369,23 +1371,25 @@ static bool spi_nor_rww_start_pe(struct spi_nor *nor, loff_t start, size_t len)
 	u8 first, last;
 	int bank;
 
-	guard(mutex)(&nor->lock);
+	scoped_guard(mutex_try, &nor->lock) {
+		if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
+			return false;
 
-	if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
-		return false;
+		spi_nor_offset_to_banks(nor->params->bank_size, start, len,
+					&first, &last);
+		for (bank = first; bank <= last; bank++) {
+			if (rww->used_banks & BIT(bank))
+				return false;
 
-	spi_nor_offset_to_banks(nor->params->bank_size, start, len, &first, &last);
-	for (bank = first; bank <= last; bank++) {
-		if (rww->used_banks & BIT(bank))
-			return false;
+			used_banks |= BIT(bank);
+		}
 
-		used_banks |= BIT(bank);
+		rww->used_banks |= used_banks;
+		rww->ongoing_pe = true;
+		return true;
 	}
 
-	rww->used_banks |= used_banks;
-	rww->ongoing_pe = true;
-
-	return true;
+	return false;
 }
 
 static void spi_nor_rww_end_pe(struct spi_nor *nor, loff_t start, size_t len)
@@ -1440,24 +1444,26 @@ static bool spi_nor_rww_start_rd(struct spi_nor *nor, loff_t start, size_t len)
 	u8 first, last;
 	int bank;
 
-	guard(mutex)(&nor->lock);
+	scoped_guard(mutex_try, &nor->lock) {
+		if (rww->ongoing_io || rww->ongoing_rd)
+			return false;
 
-	if (rww->ongoing_io || rww->ongoing_rd)
-		return false;
+		spi_nor_offset_to_banks(nor->params->bank_size, start, len,
+					&first, &last);
+		for (bank = first; bank <= last; bank++) {
+			if (rww->used_banks & BIT(bank))
+				return false;
 
-	spi_nor_offset_to_banks(nor->params->bank_size, start, len, &first, &last);
-	for (bank = first; bank <= last; bank++) {
-		if (rww->used_banks & BIT(bank))
-			return false;
+			used_banks |= BIT(bank);
+		}
 
-		used_banks |= BIT(bank);
+		rww->used_banks |= used_banks;
+		rww->ongoing_io = true;
+		rww->ongoing_rd = true;
+		return true;
 	}
 
-	rww->used_banks |= used_banks;
-	rww->ongoing_io = true;
-	rww->ongoing_rd = true;
-
-	return true;
+	return false;
 }
 
 static void spi_nor_rww_end_rd(struct spi_nor *nor, loff_t start, size_t len)
-- 
2.34.1
