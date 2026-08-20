Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58453339375;
	Thu, 20 Aug 2026 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191612; cv=none; b=JLw2xkUIl8DDtWSCc2djggIz9bquuHjtwSysMGv7slMMf4w8qx3pdbZkpIaO42viatadZZC7YqVaoGoj1KZrt+l4lJy/qDB1n5uE0PnlMuCDYOkwfq+826R1e1n45DbkxlXQYbRqFF75fvZ9HwYeOyh/NsE1IBDWkdP2mmNppRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191612; c=relaxed/simple;
	bh=89NUllVuLa13zA0UwZL5QumunVeP1IB2K3Tss1SVSSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IC97ZHwgHme/KL0NHUJrQL8jV1GmQRqRwrugTihJp7X2LrlK1A3uZ0cq9+WIrzAyDj3WS8JIAxJKK3WWFK3J4c4fEFr6vLAEmQjP1gyZkwFAuAPaVHO4qCGRN+o2y7PmkBcVlI5/56w8eF1pqqcti+o3d23NzGyxszAjgmiagdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=PymFJ986; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="PymFJ986"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4aa175c1e;
	Thu, 20 Aug 2026 10:06:41 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] can: hi311x: drop hi3110_lock before free_irq() on open failure
Date: Thu, 20 Aug 2026 10:06:31 +0800
Message-Id: <20260820020631.316418-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01ceba98e03a1kunmb6d33aac1563dd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGh9JVklIQksdSRhMHUpDHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PymFJ986qleGOpBYPed/cM+5dYgQXnWXvEiWMVaM3QPB4Bf/gIqYl2n7cUv38UnLive0Y4RpjkA01wzoJkZRWksf5CXQmlIq7sc6Pnb+luGYVp4YnAQJja7C5NLOm/tXYNuo+4W4pFn6AR2tW807STUpfrnSlEpbdLn1bO+brIQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=hLCx9DuAdssfq5Iq39uofghTJ6JX1al4g3GpOnyZgdw=;
	h=date:mime-version:subject:message-id:from;

hi3110_open() requests a threaded IRQ and then performs hardware
setup while holding priv->hi3110_lock. If reset, setup, or
normal-mode entry fails, the error path calls free_irq() while still
holding that mutex.

The threaded handler takes priv->hi3110_lock before checking
force_quit, while free_irq() waits for the threaded handler to finish.
That can deadlock the open() rollback path against a pending IRQ
thread.

Set force_quit, drop hi3110_lock before free_irq(), and take the
mutex again for the remaining hardware cleanup.

Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/can/spi/hi311x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index ae90e6716de5..2be851e8907d 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -787,7 +787,10 @@ static int hi3110_open(struct net_device *net)
 	return 0;
 
  out_free_irq:
+	priv->force_quit = 1;
+	mutex_unlock(&priv->hi3110_lock);
 	free_irq(spi->irq, priv);
+	mutex_lock(&priv->hi3110_lock);
 	hi3110_hw_sleep(spi);
  out_close:
 	hi3110_power_enable(priv->transceiver, 0);
-- 
2.34.1

