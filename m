Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27A4772A4;
	Wed, 19 Aug 2026 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148235; cv=none; b=IpLFhSxG6DneZQMPX9XwkdGl4TEPCenDTcxDropCPkDj/9x9nbLvzvAP7rXHkCF5/GWtCzfIb8wqE7p2kAp+jm/ysn/zux39Tt17Mq6llz3v1t1qGjJ4P8ZsKmA4hfYPqtNU54rEiXobnAbR5qVwQNfzHblrEJHTgiDsFDCoxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148235; c=relaxed/simple;
	bh=kzNWiLHM/1/Z7GUe8dG0cndFY4pFa401S1+/zmMM9JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=puhvtVA85QV0W0ujhMV2osmIu/sL/bC8uuR2UmOSRoYqeBMWsyclWjH1T1ScuC+ylsI4ftUvWTOoWHKCMNelSesNVOEua0lCnCJu4K5XLvxN72aD6tuIr1+lNl3JahDDTRmqjMMrNBaoHvLvl0FkfHJ1+A/9pB8jPtYAF8VVkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=eyZfHJPA; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="eyZfHJPA"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a93deded;
	Wed, 19 Aug 2026 22:03:48 +0800 (GMT+08:00)
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
Subject: [PATCH v4 2/2] mtd: spi-nor: core: Unprepare after interrupted RWW wait
Date: Wed, 19 Aug 2026 22:03:37 +0800
Message-Id: <20260819140337.36775-3-runyu.xiao@seu.edu.cn>
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
X-HM-Tid: 0aa01a55d98003a1kunm0db6d2d0140e2c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTR5MVhlNHhlDSExPGR9MS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=eyZfHJPA1IC/3LJrlNuQCRVbVAuGSsWmfIeEf2gvORk3JeFrlP66I8OMWCSZA2lDM0veBsbvZLZHgkIkZUfu+A4uj5JlMaeQYaP1kJnkJq2Dcs97DRO8UkSB7LiLGLnaw1La4nvB46J+IaHjPlWYgez+BgLYPSdefsOv8Zt+Y5Y=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=YzavkBzAhnxid9s07HfUC9Bg5vaUt0KhGfcnHKf2bjQ=;
	h=date:mime-version:subject:message-id:from;

spi_nor_prep_and_lock() calls spi_nor_prep() before waiting. If the wait
is interrupted, the controller setup is left active.

Call spi_nor_unprep() before returning an error from each helper.

Fixes: 74df43b3f626 ("mtd: spi-nor: Enhance locking to support reads while writes")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Changes in v4:
- Add the cleanup for interrupted RWW waits as a separate patch.
- Use the original RWW locking commit in Fixes.
---
 drivers/mtd/spi-nor/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d5c6a925862e..52264e24eb4b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1348,6 +1348,9 @@ int spi_nor_prep_and_lock(struct spi_nor *nor)
 		ret = wait_event_killable(nor->rww.wait,
 					  spi_nor_rww_start_exclusive(nor));
 
+	if (ret)
+		spi_nor_unprep(nor);
+
 	return ret;
 }
 
@@ -1421,6 +1424,9 @@ static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, size_t le
 		ret = wait_event_killable(nor->rww.wait,
 					  spi_nor_rww_start_pe(nor, start, len));
 
+	if (ret)
+		spi_nor_unprep(nor);
+
 	return ret;
 }
 
@@ -1496,6 +1502,9 @@ static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, size_t le
 		ret = wait_event_killable(nor->rww.wait,
 					  spi_nor_rww_start_rd(nor, start, len));
 
+	if (ret)
+		spi_nor_unprep(nor);
+
 	return ret;
 }
 
-- 
2.34.1

