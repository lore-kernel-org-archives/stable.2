Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D864B0493;
	Sun,  9 Aug 2026 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786264995; cv=none; b=HjvsIJ2j25FFrx4kMfZ6A/Pym0UG9IakKJlE+u27uNKmBbOcZSWXqAgrqtL4GlBKWwhbt8x7GoNk0KmF4HgPq/Rnn2YskijM2fqQLTgoSbNK7jbirkY00uazSXpsCNZkCyOMGUvhU+vG37LRwal3QGiV4E49jSHj5LJOh1CTrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786264995; c=relaxed/simple;
	bh=g6ni9DxvGk0LieZTko0/TDS/+WIA8j5RzcFO27MwPYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jYGWDHIRF9VL6o2GhgJW41Swx8pZqtKsailurXlUm+KL4xiawy8cs/CtnE/aeBvq/2ikeSkLQWo9UifpKH9cZnGGB5XgOAx7v3BsnBE+zHOfEULTZ+hw5drcq4QgSVJjpE9bl7vNlUmvWQww22yZI2x2psqp25CecCqvwrSpof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ZZF7O/oJ; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ZZF7O/oJ"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 494c177b7;
	Sun, 9 Aug 2026 16:43:06 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: tudor.ambarus@linaro.org
Cc: pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: scope the exclusive RWW lock
Date: Sun,  9 Aug 2026 16:42:23 +0800
Message-Id: <20260809084223.3596259-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fe5b0a38f03a1kunm5a5ec2c57af50
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHhpJVk9NGk1OThpCSxlNT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZZF7O/oJRpUbMlkTsjS+9Cws+AZc4q8oCLYw9BpYB1OO2IN4uY2uYYYnN7HG4iZ7dFPtzJu/XZM6Cgg0GMnKkvO77koKaFU9KIrxw3Mfcvh9zieWvagBeqpzdS+AjFMKSrq2oZnS76MT7Z5wkZpaYSz5TLQT7dKfBl5x01abusQ=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=/HLUWOYWl3NIuNetNvUqiUL58b1bFtzurpO33MPK5T4=;
	h=date:mime-version:subject:message-id:from;

spi_nor_rww_start_exclusive() is used as a wait_event_killable()
condition. The raw mutex_lock() leaves nor->lock held when the busy
condition returns false, so the waiter can block the active operation that
must clear the RWW state.

Use the same scoped mutex guard as the other RWW start helpers so the
mutex is released on both the busy and successful condition paths. The
state flags remain the handoff to the caller, while
spi_nor_rww_end_exclusive() continues
to acquire the mutex when clearing them.

The change was checked by comparing the original and patched source.

A source-level check of the original wait condition found that it takes
`nor->lock` and returns false while an RWW operation is still active. The
patched source was checked for a scoped mutex guard that releases
`nor->lock` before the wait condition returns. A user-space pthread model
held `nor->lock` on the false-condition path and showed that the
operation-ending path then blocks when it needs the same mutex. No live
SPI-NOR test was run.

Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ccf4396cdcd0..8bc117b46e02 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1310,7 +1310,7 @@ static bool spi_nor_rww_start_exclusive(struct spi_nor *nor)
 {
 	struct spi_nor_rww *rww = &nor->rww;
 
-	mutex_lock(&nor->lock);
+	guard(mutex)(&nor->lock);
 
 	if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
 		return false;
-- 
2.34.1
