Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF9417D77
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159093; cv=none; b=qQrtAaljfqDbrH+qTKUviWtX0Ur0mIrrmbR/QWYhbIYGbGS1U/MHFPk1PZmASpq1mCspWLalvoEvonoipZuegMMtYIpLwA9g2TdMdxd8by7jS97jQV8z9ULMKgzZVWqARHRRsJrYryIWYP/WT7RHRi0DjnDsDLXTSsY2fVoOyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159093; c=relaxed/simple;
	bh=inNQsbpsFVORuqroKwwUv5suDEBnm9BrQzGMF0evDiw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b+6mJKs89D8o8oDOPMoonw+GKFoLeyaFVRZJupPIUH/vtVgFR3Eusli2dqmJL1uqA5HKuf0QTLn5v4/8C1ULRBV4zejxCzvu2fH661pP+5bNS7KNCit6Q4HGdye+dYXXBURe9vuZqOikqWc0H+++ZPxaphJwGhEl4qWVw5SZIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R1T0iYXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R1T0iYXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6935B1F000E9;
	Mon, 27 Jul 2026 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785159090;
	bh=Oj0m2DPUuPGAGwVD/R3BHcFOvNgTgDbKzyaKlI57RbA=;
	h=Subject:To:Cc:From:Date;
	b=R1T0iYXfDs2Dphb8J2xpWeF/e4HRU9RNOsDhfO4FV7QAEjSvaj9A1BmcQ4YFkomBS
	 xa9QVdeFrPRV2g7wqmD4yvbPmaS5UDyk/vRYsonLGrcVYHhTzcAZX/eEeZISTCFsmp
	 /+iQnIBBMCHDyVrMVQ9Z7HT9Nr2itOJWo0lEDT9A=
Subject: FAILED: patch "[PATCH] usb: gadget: udc: bdc: free IRQ and drain func_wake_notify" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Jul 2026 15:31:18 +0200
Message-ID: <2026072718-obtuse-smuggling-fc35@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072718-obtuse-smuggling-fc35@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0583f2fbf8f86ae3a0ce054f96783dd83e65d9bb Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Thu, 9 Jul 2026 02:09:04 +0000
Subject: [PATCH] usb: gadget: udc: bdc: free IRQ and drain func_wake_notify
 before teardown

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

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 438201dc96ca..a8dbaef54aba 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -585,9 +585,29 @@ static int bdc_probe(struct platform_device *pdev)
 static void bdc_remove(struct platform_device *pdev)
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
index 23826fd7a8e6..7a12219edac6 100644
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

