Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67537EFE5;
	Tue, 11 Aug 2026 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437087; cv=none; b=HX4bRrPdC3Rqv7PRKJ06OEkbsoUXc8srPA4vIR+OS2NjzbZoG13C9kaeXjjwDrS9gDuphKm+A7/WdfUSStzU3qfUYmOb/mOF7PTlGPevJVG67OfTEm4XhaDwbI+7Bpfp4k8z41RD/QYpeGdJFTs+P/Cwzu0OMrp5AhI4m775xkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437087; c=relaxed/simple;
	bh=hw2QCBUe8Xm1hz7KEqVZS+4RXFzrm9MTa2Kk7rnrTfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cfEFjnJqTZfW0uAL0QJyTi93ToLFVwQqKzusf9vw/c8GwUha2qE8nrKyd/gTFvJ1PtVpgOgA7I3iQmFqBBqPUPNTSnvmZ6W2C+AhbWtiX1sb4OTOU+78ko/hIdyRSoQeM+xWIfcCG8EdoXfb60k2hSYkteX9+047uFm9gfZscdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=PF1Rb1sA; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="PF1Rb1sA"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 498cc46c1;
	Tue, 11 Aug 2026 16:31:17 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH v3] mtd: spi-nor: use guard() in spi_nor_rww_start_exclusive
Date: Tue, 11 Aug 2026 16:31:11 +0800
Message-Id: <20260811083111.403453-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811041349.333176-1-runyu.xiao@seu.edu.cn>
References: <20260811041349.333176-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9feff2880903a1kunmefe39414d7ca4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBkdVhhCGE9KT0tIHR1ITVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PF1Rb1sA3ShyJ+G10WSaZ3RLTvm7dIzLN2f+XE1+92ZQMohgm/yHrbtR+lV6rfYta9lleRPHQZn60p8Vlo04iQPXDT0ufxDViLwiJE9SSJ4Nrkqxo7g9aFm12zuMHF2cZzOjQAtBw4A21VXsKqyOcwKdEAOTA/6u/nxEz6fMGmg=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=1B3HkixR4JIMuhN8lZdHL+sI1WrlOm70bK7D3bmLLq4=;
	h=date:mime-version:subject:message-id:from;

Commit 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup
helpers") converted the RWW start helpers to scoped mutex cleanup, but
left spi_nor_rww_start_exclusive() using a plain mutex_lock().

spi_nor_rww_start_exclusive() is used as a wait_event_killable()
condition. When it returns false on the busy path, the raw mutex_lock()
leaves nor->lock held and blocks the operation that must clear the RWW
state in spi_nor_rww_end_exclusive().

Use guard(mutex) here as well so this helper matches the other RWW
start helpers and releases nor->lock on the false return path.

Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Changes in v3:
- Reframe the changelog around the scoped-helper conversion that missed
  spi_nor_rww_start_exclusive().

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
