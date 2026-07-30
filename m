Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93638409270
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413765; cv=none; b=i4T8WDFFgl357VwPS2AFcSGoZKDr2oefRv5XPLjYfbLF+6mxOZ7i91nqr7nrO/2MxbhnH1geZ5V3LDxcOBACN5O3Fgh3PaRYK5Rt3ysCtQ929BbPc5/A5c2DXnvmVoJM57R5a4FdDG5U+0AEXINuD21jJ5Vazkh9CUuh1Zgl7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413765; c=relaxed/simple;
	bh=TnX97cw0XfC/amCyEhyvuf2titBpRNpMca8E2Jd4GJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guoOIZ2QSCpIEU3gLqUhCSgUePrOJicLc8+t3odzBvISG0rZQkLUO5QZVRKCPv7dJxQXU9GVA3jQBuDecy0PHQ0b/rUG6nROkSiZF6rtcgNiL9W7P+iZBuRyhJTu5J9vN/ZjONLnidudc6efu9wU0GpOij2r2U14m7+8KJr1LxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie34HWWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie34HWWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C9B1F00A3D;
	Thu, 30 Jul 2026 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413753;
	bh=NrBU+HS/XmCoCJOHlJQ1XRHYqrE6II10O3IsxEkYIz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ie34HWWPNqMh9oxKYYS4UG23rmi+JcexijZq04SO56d2sg3wITqPY7ZmCM1LLsZF6
	 UncoUzgte9zyM/v+Q2jlrx6SsT1BVKTf/ttOjpNtw1yREKf7TwnR2QRsFrTrklMqtn
	 PzOLOy/7izgx8YUgp5EqvLopVFS3VPv1Bd8/8xwEMo8Npm/eiiDTr5QZf8L10Jomia
	 JiT1zYuIwzs0o4xhox1JIRc2ZXHjFBU1xe3AtysNylac0h3jate+QfoYU8k+LB1RUM
	 EbnkA4hRaFt/5qM8qxEF8YmYRrcSpwH1jqz/yf760Od5SsvZVM9UWa8Dj5zAOchJUJ
	 zBq9NAcS8/1AA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] usb: gadget: udc: bdc: free IRQ and drain func_wake_notify before teardown
Date: Thu, 30 Jul 2026 08:15:49 -0400
Message-ID: <20260730121549.2211164-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730121549.2211164-1-sashal@kernel.org>
References: <2026072718-obtuse-smuggling-fc35@gregkh>
 <20260730121549.2211164-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb ]

The Broadcom BDC UDC driver registers its IRQ handler with
devm_request_irq() in bdc_udc_init(), so the IRQ is released by devm
only after bdc_remove() returns.  devm releases resources in reverse
LIFO order, but bdc_remove() runs bdc_udc_exit() and bdc_hw_exit() ->
bdc_mem_free() manually before returning: bdc_udc_exit() tears down
individual endpoint objects via bdc_free_ep(), while bdc_hw_exit() ->
bdc_mem_free() frees and NULLs the DMA-coherent status-report ring
(bdc->srr.sr_bds) and kfree()s bdc->bdc_ep_array.  Both happen while
the IRQ handler (bdc_udc_interrupt, requested with IRQF_SHARED)
remains deliverable in the window up to the post-remove devm
free_irq().

On receipt of a shared interrupt in that window, bdc_udc_interrupt()
dereferences bdc->srr.sr_bds[bdc->srr.dqp_index] (NULL or freed DMA)
and dispatches sr_handler callbacks that index into bdc_ep_array,
causing a NULL-deref or use-after-free.

The same window affects the delayed_work bdc->func_wake_notify, which is
armed from the IRQ handler via bdc_sr_uspc() -> handle_link_state_change()
-> schedule_delayed_work() and may self-rearm from its own callback
bdc_func_wake_timer().  No cancel exists anywhere in the driver, so a
queued work item that fires after bdc_remove() returns and the bdc
structure is devm-freed dereferences freed memory.

Replace devm_request_irq() with request_irq() and add an explicit
free_irq(bdc->irq, bdc) in bdc_remove().  Clear BDC_GIE before
free_irq() to stop the device from asserting interrupts, then
free_irq() drains any in-flight handler, then cancel_delayed_work_sync()
drains the func_wake_notify delayed work.  This ordering ensures the
IRQ handler and delayed work cannot interfere with the subsequent
endpoint and DMA teardown in bdc_udc_exit() and bdc_hw_exit().  Wire the
matching free_irq() into the bdc_udc_init() error path so the IRQ is
released on probe failure, and route the bdc_init_ep() failure through
err0 instead of returning directly.

This issue was found by an in-house static analysis tool.

Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 device controller IP BDC")
Cc: stable <stable@kernel.org>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260709020904.502611-1-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 20 ++++++++++++++++++++
 drivers/usb/gadget/udc/bdc/bdc_udc.c  |  7 ++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 69d11b703c8d00..d9383b0f4d15e3 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -586,9 +586,29 @@ static int bdc_probe(struct platform_device *pdev)
 static int bdc_remove(struct platform_device *pdev)
 {
 	struct bdc *bdc;
+	unsigned long flags;
+	u32 temp;
 
 	bdc  = platform_get_drvdata(pdev);
 	dev_dbg(bdc->dev, "%s ()\n", __func__);
+	/*
+	 * Disable the device interrupt source before freeing the IRQ:
+	 * clear BDC_GIE so the controller stops asserting interrupts,
+	 * then free_irq drains any in-flight handler.
+	 */
+	spin_lock_irqsave(&bdc->lock, flags);
+	temp = bdc_readl(bdc->regs, BDC_BDCSC);
+	temp &= ~BDC_GIE;
+	bdc_writel(bdc->regs, BDC_BDCSC, temp);
+	spin_unlock_irqrestore(&bdc->lock, flags);
+	free_irq(bdc->irq, bdc);
+	/*
+	 * Drain func_wake_notify after free_irq: the IRQ handler arms this
+	 * delayed_work via bdc_sr_uspc -> handle_link_state_change ->
+	 * schedule_delayed_work (self-rearmed in bdc_func_wake_timer), so
+	 * the IRQ must be released first to prevent re-arm after cancel.
+	 */
+	cancel_delayed_work_sync(&bdc->func_wake_notify);
 	bdc_udc_exit(bdc);
 	bdc_hw_exit(bdc);
 	bdc_phy_exit(bdc);
diff --git a/drivers/usb/gadget/udc/bdc/bdc_udc.c b/drivers/usb/gadget/udc/bdc/bdc_udc.c
index 59ba6a8d69a1ff..5a0e011065c225 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_udc.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_udc.c
@@ -530,8 +530,8 @@ int bdc_udc_init(struct bdc *bdc)
 
 
 	bdc->gadget.name = BRCM_BDC_NAME;
-	ret = devm_request_irq(bdc->dev, bdc->irq, bdc_udc_interrupt,
-				IRQF_SHARED, BRCM_BDC_NAME, bdc);
+	ret = request_irq(bdc->irq, bdc_udc_interrupt, IRQF_SHARED,
+			  BRCM_BDC_NAME, bdc);
 	if (ret) {
 		dev_err(bdc->dev,
 			"failed to request irq #%d %d\n",
@@ -542,7 +542,7 @@ int bdc_udc_init(struct bdc *bdc)
 	ret = bdc_init_ep(bdc);
 	if (ret) {
 		dev_err(bdc->dev, "bdc init ep fail: %d\n", ret);
-		return ret;
+		goto err0;
 	}
 
 	ret = usb_add_gadget_udc(bdc->dev, &bdc->gadget);
@@ -571,6 +571,7 @@ int bdc_udc_init(struct bdc *bdc)
 err1:
 	usb_del_gadget_udc(&bdc->gadget);
 err0:
+	free_irq(bdc->irq, bdc);
 	bdc_free_ep(bdc);
 
 	return ret;
-- 
2.53.0

