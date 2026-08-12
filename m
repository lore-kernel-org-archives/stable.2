Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7BB330B0E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522912; cv=none; b=V7rHCpeFGzRkkAXH9PmzwlJIkgV9KB9X24OEt1YHGveen/lAPcl/aoTPjPabH4unKW4iy7s69bV9jziUkcb7f3Jq2mT/c2GizVSa/XtYon1ux1y5b7Y9dPB+R56Nd15OPNIYU7QevVXGxp/9XG9prxNdlvqwg+ProPXw0g4didU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522912; c=relaxed/simple;
	bh=FBYMXzm/9qgd59ANdaZgQARfVOQfiv5uHwv1ToHWrak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J68WTJYw8B7Dbt8JFXyn90C/mgSG55f0K6o8EGF7XD80Pgw+lDtZ5YrzMKE/vTyZYffeBuHelZuycJwJDmTSpxkRE4KWJADhNhQyc8MA0/sJUlO5Fzeb9Gbx8ax6D9/7cao2uHQMy6YEF/y2l07XgRuFbShcscr4Pmtk/OGdgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVupkjcC; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVupkjcC"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dcbade417so836732a91.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 01:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786522910; x=1787127710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nflQk1ynJ2NMOg/4B1vzQ7rLRCrtvqb920yEH95lTXY=;
        b=VVupkjcC9D7lOzIxyJzO63zKuAuP6w9e3jX/wDHfG/Z82F/R7pM6ZlJRNZJML7PpmF
         be6GxEE5ySRDndGTI50PAT6ed4F4yKy9ldAK8BsUy8qjZIxdxb6M4b5W5H8gKKmbIkg2
         Ez0wFhR4TnxeD1+62QJuSE8JsexMkcTFU75L18NFS8NmpKu/lyE2FXDAszP9RZKR0v0y
         CEOxBXW1rus5N/7RZJaplI+3tp82P9uww/dUt4FUWQ1YIjwb4nWgLCiUFbmRyOn/1n8b
         JJQamoxGiHyqRljuj4EVeTQ7pukquYU0IuSuSlz1YC0rQllmh3slYLJlCFMa7Z0/kXyk
         Rs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522910; x=1787127710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nflQk1ynJ2NMOg/4B1vzQ7rLRCrtvqb920yEH95lTXY=;
        b=NlEfPH0ZT0CmrdLB8XsQvxaVFrJcjh098B53X07+vr00WMMFgJC6WvS4g7EK+oHlN0
         v/DAYFH2129hHFgude9HrFBjGG1kSKKnJKJicz0sHkzVazQaFQ+6UCaKUU+xVhaB7evL
         nwvaNVdCN1Z8WrmCexdc7e31SQMY9fz/lJ1v4DmLmmx6ruzNdrfPR/QEke3+/64VrPIp
         t1ZESCmGEoAE9qwCRGFOJ1WeABCswaSKtGyJoxL8mBIsqBYAM9k2BN1W5Ur6Ik68ly26
         sQK0sKrECi6/i3vpMf4MhxR8fIxakX0vBCaTXKp4ifrZU5ZeuNcum8NInkSgajMxz7iu
         RkUg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9mg2jaajcF9VHiveO6QFzT/sdljkAQXqZFV6LHVk7fFfzCjd0ZBhe9/eUwEpKw9Ac/ir7Nmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV+6YcHZtXISYHKBfjMD4RbX8fMoQTH57KHsvDd7oPsSr/Rixz
	PhCRDn3uPeEQ3tb16kH5ShO/Nwgxz34YYunaBf0Wrh5YCuhCmNAxLzs0
X-Gm-Gg: AR+sD12G/d6awQiX0nPEk8v5P8Pv9/TaFZIHCsGDdKgrvWuyrUtjpMHRmXFExOWjR3D
	94RE/SwWhdlaIBjEDNa/GxOEhmiWpsl/IpDPQ0TXVKotiFv2bHiOj6TwhFq54zIrl5TZdvt6uXT
	ZZXY7S0qVFN7q+ASnpm+G75rdGJGbOVe3tYVSmqDB12KqWuv4k9IMgwNhWG0dWtn0fTpXYbN6f7
	uq4a0jMj9vR4v2+YQtNOayNppcsLREoYTuzj16+Sr8fkgFqzCGuwE7l2IOYL4F+LF4eGWnORnhT
	J+0az5XTt4NNEOufEiut9zUsOMoTQHjjhBBCBRjVmpPOiGlQqWQ0Ir8WHCEOJXQZoTOZQk+XNPu
	0cPzkWIf4xN/WWGtAHyWDZNTclE7dn2XhJySHDwY9yRHfvim4esXn75Osd64zPCx+FmuO3H3eda
	vFphtvAYMNuOOeGiXzW26KVFTe69a1e5WTrnfCb/Ztw8X8aGX2GtMK3oYkvB7ggOUn4HI4aN6F+
	A4z9EU6GZosE0yz7xAXgRPklL00xDzZFGfiKAAMWcNcA0hNMMTeN4QOY+zfXCvn2UC2Bij5TOm8
	F9Y=
X-Received: by 2002:a17:90b:390c:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-3930119eff3mr3400014a91.1.1786522910251;
        Wed, 12 Aug 2026 01:21:50 -0700 (PDT)
Received: from 7cf34ddc0813.ant.amazon.com ([54.222.46.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94d5cb7sm2614417a91.15.2026.08.12.01.21.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 01:21:49 -0700 (PDT)
From: Jiazi Liu <jiazi.liu1984@gmail.com>
X-Google-Original-From: Jiazi Liu <liujiazi@amazon.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	Jiazi Liu <jiazi.liu1984@gmail.com>,
	Jiazi Liu <liujiazi@amazon.com>
Subject: [PATCH v2 1/1] usb: dwc3: gadget: fix IRQ storm on invalid event buffer count
Date: Wed, 12 Aug 2026 16:21:27 +0800
Message-ID: <20260812082127.79610-1-liujiazi@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260727092258.1121-1-liujiazi@amazon.com>
References: <20260727092258.1121-1-liujiazi@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiazi Liu <jiazi.liu1984@gmail.com>

When dwc3_check_event_buf() reads a GEVNTCOUNT value exceeding the
event buffer length, commit 63ccd26cd1f6 ("usb: dwc3: gadget: check
that event count does not exceed event buffer length") returns IRQ_NONE
without writing back GEVNTCOUNT. Since the DWC3 interrupt is
level-triggered, the uncleared IRQ source keeps the line asserted,
causing a tight IRQ storm that accumulates 99,900 unhandled interrupts
and triggers spurious.c:184 BUG -> kernel panic.

The resulting call stack:
  __report_bad_irq+0xac/0xc8
  note_interrupt+0x340/0x468
  handle_irq_event+0xac/0xc0
  handle_fasteoi_irq+0x120/0x228
  gic_handle_irq+0x68/0x108
  ...
  kernel BUG at kernel/irq/spurious.c:184

To reproduce, write a bogus value exceeding the event buffer length
directly to the GEVNTCOUNT register:

  devmem <DWC3_BASE + 0xc40c> 4 0x1004

Write the bogus count back to GEVNTCOUNT to clear the IRQ source,
consistent with the stale event clearing pattern in
dwc3_event_buffers_setup(), and schedule error recovery to
reinitialize the controller.

Fixes: 63ccd26cd1f6 ("usb: dwc3: gadget: check that event count does not
exceed event buffer length")
Cc: stable@vger.kernel.org
Signed-off-by: Jiazi Liu <liujiazi@amazon.com>
---
Changes in v2:
  - Rename softcon_work to err_recovery_work
  - Use dev_err instead of dev_err_ratelimited
  - Update comment to document driver/controller out-of-sync fatal error
    condition rather than describing IRQ storm behavior
  - Remove dev_err from work handler; error message belongs at the call
    site where the specific failure is known
  - Follow dwc3_gadget_suspend/resume logic in recovery work handler
  - Add err_dying state to reject gadget driver requests during recovery
  - Add err_recovery_count counter and stop scheduling recovery after
    DWC3_ERR_RECOVERY_MAX attempts to prevent infinite retry loops
  - Add synchronize_irq() before soft_disconnect to ensure IRQ handler
    has completed before reinitializing the controller
  - Define DWC3_ERR_RECOVERY_MAX in core.h alongside other global constants
  - Fix sparse warning: use dwc as first argument to dwc3_writel, not dwc->regs
---
 drivers/usb/dwc3/core.h   |  7 +++++++
 drivers/usb/dwc3/gadget.c | 41 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 608daeb7ef10..b1cd888eca77 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -49,6 +49,7 @@
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
 #define DWC3_ISOC_MAX_RETRIES	5
+#define DWC3_ERR_RECOVERY_MAX	3
 
 #define DWC3_SCRATCHBUF_SIZE	4096	/* each buffer is assumed to be 4KiB */
 #define DWC3_EVENT_BUFFERS_SIZE	4096
@@ -1004,6 +1005,7 @@ struct dwc3_glue_ops {
 /**
  * struct dwc3 - representation of our controller
  * @drd_work: workqueue used for role swapping
+ * @err_recovery_work: workqueue used for controller error recovery
  * @ep0_trb: trb which is used for the ctrl_req
  * @bounce: address of bounce buffer
  * @setup_buf: used while precessing STD USB requests
@@ -1171,6 +1173,7 @@ struct dwc3_glue_ops {
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
  * @susphy_state: state of DWC3_GUSB2PHYCFG_SUSPHY + DWC3_GUSB3PIPECTL_SUSPHY
+ * @err_dying: true when controller is in error recovery, reject all requests
  *		  before PM suspend.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
@@ -1186,9 +1189,11 @@ struct dwc3_glue_ops {
  * @wakeup_pending_funcs: Indicates whether any interface has requested for
  *			 function wakeup in bitmap format where bit position
  *			 represents interface_id.
+ * @err_recovery_count: number of consecutive error recovery attempts
  */
 struct dwc3 {
 	struct work_struct	drd_work;
+	struct work_struct	err_recovery_work;
 	struct dwc3_trb		*ep0_trb;
 	void			*bounce;
 	u8			*setup_buf;
@@ -1420,6 +1425,7 @@ struct dwc3 {
 	unsigned		wakeup_configured:1;
 	unsigned		suspended:1;
 	unsigned		susphy_state:1;
+	unsigned		err_dying:1;
 
 	u16			imod_interval;
 
@@ -1429,6 +1435,7 @@ struct dwc3 {
 	struct dentry		*debug_root;
 	u32			gsbuscfg0_reqinfo;
 	u32			wakeup_pending_funcs;
+	u32			err_recovery_count;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fa0f16ffafef..05f3ffab6e47 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2054,6 +2054,9 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 
 	int				ret;
 
+	if (dwc->err_dying)
+		return -ESHUTDOWN;
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_queue(dep, req);
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -4667,9 +4670,22 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 		return IRQ_NONE;
 
 	if (count > evt->length) {
-		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+		dev_err(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
 			count, evt->length);
-		return IRQ_NONE;
+		/*
+		 * This is a fatal error - the driver and controller are out of
+		 * sync on which event has been consumed. Reinitializing the
+		 * controller is required to recover. Write the bogus count back
+		 * to GEVNTCOUNT to clear the IRQ source, consistent with the
+		 * stale event clearing in dwc3_event_buffers_setup(), then
+		 * schedule error recovery.
+		 */
+		dwc3_writel(dwc, DWC3_GEVNTCOUNT(0), count);
+		dwc->err_dying = true;
+		dwc->err_recovery_count++;
+		if (dwc->err_recovery_count <= DWC3_ERR_RECOVERY_MAX)
+			schedule_work(&dwc->err_recovery_work);
+		return IRQ_HANDLED;
 	}
 
 	evt->count = count;
@@ -4729,6 +4745,25 @@ static void dwc_gadget_release(struct device *dev)
 	kfree(gadget);
 }
 
+static void dwc3_err_recovery_work(struct work_struct *work)
+{
+	struct dwc3 *dwc = container_of(work, struct dwc3, err_recovery_work);
+	int ret;
+
+	synchronize_irq(dwc->irq_gadget);
+
+	ret = dwc3_gadget_soft_disconnect(dwc);
+	if (ret)
+		return;
+
+	dwc3_disconnect_gadget_sleepable(dwc);
+
+	dwc->err_dying = false;
+
+	if (dwc->softconnect)
+		dwc3_gadget_soft_connect(dwc);
+}
+
 /**
  * dwc3_gadget_init - initializes gadget related registers
  * @dwc: pointer to our controller context structure
@@ -4772,6 +4807,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	}
 
 	init_completion(&dwc->ep0_in_setup);
+	INIT_WORK(&dwc->err_recovery_work, dwc3_err_recovery_work);
 	dwc->gadget = kzalloc_obj(struct usb_gadget);
 	if (!dwc->gadget) {
 		ret = -ENOMEM;
@@ -4868,6 +4904,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
+	cancel_work_sync(&dwc->err_recovery_work);
 	dwc3_enable_susphy(dwc, true);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
-- 
2.50.1 (Apple Git-155)

