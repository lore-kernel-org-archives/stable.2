Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A63BE163;
	Sun, 30 Aug 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788105839; cv=none; b=P3vCdwnVxKCgSxXeruUtk9FN3peq9tt/EWmjhVnNkN4Otme/k5p0bYZO/tDBaKHHiscDh2BPhbtu/gF/3CXRcwoIh4aMxEbShjQJZBLm5CZUhjQdJWC0TzbEjqDEReoctbi3bIEjDqXcy7c5tKBQhcw+rBXMMOQQ2aK678aNxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788105839; c=relaxed/simple;
	bh=fVk+dpBQMnUa9wCjBx/IcrDTh42iXyeZjf40wv9wQBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T8fOkjnQDy+LKSDTqSRCOmxwySKaVW74n3e0lLAsdAtfFO+BteIyIU2+v4ZR46g6GPcfdcPYm7MdQ+bbuoV7ZyX3pO7032XIClUiQmJiMjhWiyE7/Yo5EwY4XrvSejDIjn1oalcg+wOjLdKtLjBJc/EafSxGvi1xCXWvg+bSk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Jrsttch5; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Jrsttch5"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd7e9710;
	Mon, 31 Aug 2026 00:03:52 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: sre@kernel.org
Cc: carlos.chinea@nokia.com,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] HSI: omap_ssi: Initialize lock before requesting IRQ
Date: Mon, 31 Aug 2026 00:03:46 +0800
Message-Id: <20260830160346.2716091-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa05369b93403a1kunmcba1369d106a69
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGB4ZVh5LTUtPH0pKSElJSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Jrsttch5uw8Y6UFo2bXxCPTGj7oCBs/SRwaV8JvX97KsZu71yhUi2hbslKkuKld5GehsK/ebMds7Xh4evtapEhIQQeiDTAGcP3mHJx8fmh5XvyqrIqlxB7GWNWY8KiRxz6nwjBzN10QPMlxyuFS97HQ2S8lYiTdht7l0iocmD1g=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=yS2pRrlvssh39k9LK/xUes/1U4jcuXwF42KC2ORiREE=;
	h=date:mime-version:subject:message-id:from;

The GDD interrupt handler schedules a tasklet which can eventually use
the controller lock. Initialize the lock before registering the handler
so an early interrupt cannot reach the tasklet with an uninitialized lock.

Fixes: b209e047bc74 ("HSI: Introduce OMAP SSI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/hsi/controllers/omap_ssi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 0f5a6f752..dbbb56e81 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -366,6 +366,7 @@ static int ssi_add_controller(struct hsi_controller *ssi,
 	if (err < 0)
 		goto out_err;
 	omap_ssi->gdd_irq = err;
+	spin_lock_init(&omap_ssi->lock);
 	tasklet_init(&omap_ssi->gdd_tasklet, ssi_gdd_tasklet,
 							(unsigned long)ssi);
 	err = devm_request_irq(&ssi->device, omap_ssi->gdd_irq, ssi_gdd_isr,
@@ -396,7 +397,6 @@ static int ssi_add_controller(struct hsi_controller *ssi,
 	omap_ssi->get_loss = NULL;
 
 	omap_ssi->max_speed = UINT_MAX;
-	spin_lock_init(&omap_ssi->lock);
 	err = hsi_register_controller(ssi);
 
 	if (err < 0)
-- 
2.34.1
