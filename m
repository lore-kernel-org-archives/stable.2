Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A430C157;
	Tue, 11 Aug 2026 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421648; cv=none; b=BGXj0dApR0/XjgDGVeu7khErfZN73d53LU8sGf6Oz5sSPvQnMGJRSmMgDFzpKHboOir191Y8AvahRJFZYPbKSb6i1N0VhR5VtKDTx5E5NP1vk1ae3sBHjmJYOku1/NCBsYZUv+sQ2Y+APiytC6uaqgYy0Polord4Qg35YCkOqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421648; c=relaxed/simple;
	bh=6rC5Foagke1uj+9g5Kec+wduoePWQKqkT6nwPFmFH2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LBk8CAgpaGdjpZGg2hRJ271KBWQSe+dRimRqGeVSX7uRuUF4Ki1ImDKlA2BMHrBIS3BLDZ4zSjj1c/spMo6y7WEl3HhQbTP3Whr+eakca4fvqtBZ8UTtw6AoVIXj1z/zL47LBlVBhQPLZ9N5dpThqFkQAu+Hk9u7FRyIeshW+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=JFLZ96Sd; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="JFLZ96Sd"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 49839a3dd;
	Tue, 11 Aug 2026 12:14:01 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: [PATCH v2] mtd: spi-nor: scope the exclusive RWW lock
Date: Tue, 11 Aug 2026 12:13:49 +0800
Message-Id: <20260811041349.333176-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DKL4CBQNKCO2.3NAZ6S25Q60XN@kernel.org>
References: <DKL4CBQNKCO2.3NAZ6S25Q60XN@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fef07002203a1kunm3038573ccf371
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHUsaVkNPS0IeHx0fHxhNSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=JFLZ96SdvX1KS98OSuUfXksu69enBfi9qs1wYdw3DXKqzr9kkoVdmKlKev29rnBK9sBv86s5RxYSbpbWcBjMhx3FFUg1JoMTBNLQ8Z7rpaLPq/1AYDsrURxqR+QOeH2PYqi5jpmHDXZ5jCwAINdV+/3YSE83Q2ETIQd22/b3Uh8=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=YBfIz6+uNJCCf9NNN7opXSjgJhc46dkV8CxB1hCFr7Y=;
	h=date:mime-version:subject:message-id:from;

spi_nor_rww_start_exclusive() is used as the wait_event_killable()
condition for RWW access. When RWW is busy, it can return false while
still holding nor->lock, which blocks spi_nor_rww_end_exclusive() from
clearing the RWW state.

Use guard(mutex) here so nor->lock is released before the condition
returns, while the state flags still hand off ownership to the caller.
This keeps the mutex scope aligned with the other RWW start helpers.

Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Changes in v2:
- Replace the analysis-style explanation with a short maintainer-facing
  description of the busy-path lock hold.
- Keep the fix focused on using guard(mutex) so the mutex is released on
  both paths.

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
