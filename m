Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881A344D9B;
	Fri,  9 Oct 2026 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791515616; cv=none; b=EzdnlkcrLMVsvxfkmnjcxNtn9tdeXEYboILAWeyarDP4mRjN8uMVME8jQYFhejnQR5x+0hh6DBtWslLj+u1epU3CIlJDTHVwsAiFNOIMYs52HOIBIz4Gl2oF3VKAVIncOlsJxyUdxfFSJIOvRleO8/wuff5JhxO+fbK57zOcz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791515616; c=relaxed/simple;
	bh=YGJ/YuFtOpApRmIjcAg+eUkIF40aIyFKvEDDOWAlWVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=szOlXnyVxZxr5CjOB5ljoklOSbZppAI0Y/aXJMYuMpFq3CBDE8hVMmwU6K6j6AaptzH3doABbiYuQgB8jpBO1Th96zkjEcNk80yeqZjZj4016/AjZPe7i9aq+9MGoFReIS/aE/EW+/rb1nTN5x341v3U0QM7e5lWqtcwOWd6YBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=bcSfLQjh; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="bcSfLQjh"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 50622db01;
	Fri, 9 Oct 2026 11:13:25 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] usb: gadget: pxa25x: mark the watchdog timer IRQ-safe
Date: Fri,  9 Oct 2026 11:13:18 +0800
Message-Id: <20261009031318.1122589-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa11ea6b86503a1kunm2290a5e1430986
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkkeVkpCGkJCSB1CSx4dQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bcSfLQjh4BTRg43Eyh/AtX3mKz0+pVTtRZS6sjLjvU5FF6Tz++1E+48c/SGtaOtYOE33rQg/aawOo26rq60Dj14/HBkrE2cRQZZaeJh6Dv+iuPup0Y5DZYVTVPkAiRHa0wSy76LDIo32f89moZhcvluoejcw8Sd1HjTgFJ8FcoU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=JSSC87nfxfspDKDrjTT3iXE48aOn32ItDe2Aa1070uI=;
	h=date:mime-version:subject:message-id:from;

The PXA25x UDC reset path runs from its hard-IRQ handler and calls
timer_delete_sync() for the watchdog. The timer is currently initialized
without TIMER_IRQSAFE, so timer_delete_sync() warns and can deadlock when
the reset races with the watchdog callback.

Mark the timer IRQ-safe. Since IRQ-safe callbacks run with interrupts
disabled and remain so on return, remove the callback's local IRQ disable
and enable pair; local_irq_enable() would otherwise re-enable interrupts
before the callback returns.

Fixes: 8fa7292fee5c ("treewide: Switch/rename to timer_delete[_sync]()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/usb/gadget/udc/pxa25x_udc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 594d67193..41076ecca 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1563,7 +1563,6 @@ static void udc_watchdog(struct timer_list *t)
 {
 	struct pxa25x_udc	*dev = timer_container_of(dev, t, timer);
 
-	local_irq_disable();
 	if (dev->ep0state == EP0_STALL
 			&& (udc_ep0_get_UDCCS(dev) & UDCCS0_FST) == 0
 			&& (udc_ep0_get_UDCCS(dev) & UDCCS0_SST) == 0) {
@@ -1571,7 +1570,6 @@ static void udc_watchdog(struct timer_list *t)
 		DBG(DBG_VERBOSE, "ep0 re-stall\n");
 		start_watchdog(dev);
 	}
-	local_irq_enable();
 }
 
 static void handle_ep0 (struct pxa25x_udc *dev)
@@ -2343,7 +2341,7 @@ static int pxa25x_udc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	timer_setup(&dev->timer, udc_watchdog, 0);
+	timer_setup(&dev->timer, udc_watchdog, TIMER_IRQSAFE);
 
 	the_controller = dev;
 	platform_set_drvdata(pdev, dev);
-- 
2.34.1
