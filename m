Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A72E718B;
	Wed,  2 Sep 2026 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336212; cv=none; b=QTS1dxw6z0skvDKzC8op8fhJxk5IDSaxder4codT3SWrG6Hty9aErOI6rjJMx6HIo292O+IjSCnf3uLvK4GwfV6Sfq2L3YLSnTNC1dquXyNgwRTvyV6y0MHfp7J1TPxuf+GA5f6DbgIOdce4pf9ayCNGCyFKXjA+wBbO7DN0k4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336212; c=relaxed/simple;
	bh=QuRaZmfvbW4dbO/3sj72MSpFDjGgDGR/HpvcRLxC9kE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eWGwXOrI23t0IQ5OuHiatySpEsr6kJ+lCfc0UmO0cgmkfOCaj+jErR4HXn7xWOHpZamMGdhMaMVM9bEY6R6c4NvKo3PuVe7yloAoLHb8rBeOxPwR4aI8x/US12kSFeblv2Ls5/PUHv7JwCnk3/a0qhs1pT5rWtu49jkeANAoLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ix74g9sV; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ix74g9sV"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c3d26e96;
	Wed, 2 Sep 2026 16:03:25 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] rtc: spear: initialize IRQ state before requesting alarm IRQ
Date: Wed,  2 Sep 2026 16:03:18 +0800
Message-Id: <20260902080318.3498434-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06124ed2303a1kunme72af04319c897
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUIfVk8ZSENJGUNCGU4YTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ix74g9sVYjzqqGulnsqtwmMAK/SvkrOVfdKnAKNdD/n6SlxFrifyaRifNUEi3HkC4W1s7+fheDqmBCK4r9jXvrWOpaNuOPan988rcqEHycYs7sqUWxDP4OTiB4Z5Kh8PuvZr//yLYm4/YQMRJJGAt3HTX1njO4ibygozSMe37JU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=uGx+nLD4dDatJFlCXAcWUHdKHCS8hgeMxQMrqqKFkUY=;
	h=date:mime-version:subject:message-id:from;

devm_request_irq() enables the interrupt before it returns, so the handler
may run while probe is still initializing the device. Initialize the MMIO
address and spinlock before requesting the alarm IRQ.

Fixes: 0942a71e435f ("rtc: add support for spear rtc")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/rtc/rtc-spear.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index 959acff8f..d12bccb3c 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -363,6 +363,12 @@ static int spear_rtc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	config->ioaddr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(config->ioaddr))
+		return PTR_ERR(config->ioaddr);
+
+	spin_lock_init(&config->lock);
+
 	status = devm_request_irq(&pdev->dev, irq, spear_rtc_irq, 0, pdev->name,
 			config);
 	if (status) {
@@ -371,10 +377,6 @@ static int spear_rtc_probe(struct platform_device *pdev)
 		return status;
 	}
 
-	config->ioaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(config->ioaddr))
-		return PTR_ERR(config->ioaddr);
-
 	config->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(config->clk))
 		return PTR_ERR(config->clk);
@@ -383,7 +385,6 @@ static int spear_rtc_probe(struct platform_device *pdev)
 	if (status < 0)
 		return status;
 
-	spin_lock_init(&config->lock);
 	platform_set_drvdata(pdev, config);
 
 	config->rtc->ops = &spear_rtc_ops;
-- 
2.34.1
