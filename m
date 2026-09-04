Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80338443AA8
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515407; cv=none; b=RmsA6IXz+NW8iOohJvo/mxl8VqpUAGmNgkaLVUiDJyEOG8X86P0wERLrfStVpGHAg2QtO5jgBoG2kkfzYTYuKaCrAErn6FXhzB8frgKYZoTOBjzuikwjPeKyh6wysfAcMSLbwCe8o/SWkLFzf1t/OOYJtIgPOWL7Yzu1YxYnRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515407; c=relaxed/simple;
	bh=7LZNr5EymMreJO15LQCSegO6Ph9b90NPHcIf0ue6hS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmO8l6zdrrE6StYvdHwOzWNCjlY3csZu6bh4jMMZcnWlJRa/+uxp1Z0TjtQL83o6+koCRSyHbE82MNetQqrDMMNHfW85sYtG42yM66DRww2j0ABI2pjMW/CHk+zdNG4DJPNuapTco6vpgD/0Lgb0NFWbDyrBkmtdYM+1Wo8i3WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rchDHi1d; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rchDHi1d"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so751314a91.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788515404; x=1789120204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1qImERb+huKRUK637W/UgHB8qD07aHVEl+CJL7SWo3o=;
        b=rchDHi1duRJcWLDWdMyxTiykia6jpAHn8ijcvaVYNNb9E515G6iZPF9hJyRu8EeRwA
         j94OzOBlNBqWDPmPu/qZsk5wHXLAkDqJHp2qL71Mj/wfmIAW73FkXa4EKrWySNZu18/5
         6CwQTGrcIb/TbJpKrLFeYGqFph/v2eu+594OVa4QUSDBI8GRqUhEMmy+3SRqFQ/QidXw
         ItcNIg36hFmmyM1UNxA3WYg189xl1Wye28bkDuf/dfto98Rf+To7a2GRbBPzX3hcbpJo
         NeHbuTLSL8bPWVikemufa9Qdi7YuerVYE8VAAgwEdYFBfxqNzCGqS0nf2GeMyHb9H5sg
         BX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515404; x=1789120204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1qImERb+huKRUK637W/UgHB8qD07aHVEl+CJL7SWo3o=;
        b=lgrNdLSLAnkse/1Iu9rBxHcjUCtMw4ORjTfiNfOLnxaQ8F6ZkLQO5arp5nmM0WUIHO
         C51JewqNdHl0aNDkgh24GQvt8N8Dm8eGcoTDlx85SyUEBNU5hHXfjX+f+plPaCQDNoGM
         wE2dbiek2LyWdiTGRqR/68Kq0h4Id43IGtgMW6fVSKAevyNXG+0Uo0u+HOIZnpk/5SDe
         zYcOinufuHS2MyXhgoFALey0/eMbZXS7sfN64xbtcia5J1oVqNcwN3B17ZUys5iaiQ4f
         abA3EcXbLxbVyaipEQZO50mieIgihIu7RSOdRwzYBD9/uILo2RLmS7ABcAwV+7TGlGLH
         kScw==
X-Forwarded-Encrypted: i=1; AKwUvBw2g7Nrj3NbhzLowJfMaccgV4X1oBO2jneo1T4JqxCsO+BRtYkB4Q+6m/YAXJmPhDgSCBCKVYA=@vger.kernel.org
X-Gm-Message-State: AFuF++lqC4CFF+iUOKvVk/QC4YprxsHAgKLqcgLFR6A6uTIC78V3NlYn
	Jg6PMu65yHNWMd+dfXfmzn5B9ebQFPoI51172mXs9K/H8MQhUW4n1Rkk
X-Gm-Gg: AYBFou2v/+QVS87ZEBqMEw0CKls9DRDNAnr3Kqfom1am8DIRkD/5Kb1NH02H0Yau2xL
	ua7zePiEsZvxUchoQvUEL1EL0xXTMIQCmlbp006UyxCo7nSA96T92znZ/yzVyyTUj0Yt7aEeqsC
	trRm/ZiZI5qJ9aIaC6r+CQ4N4VVSCkT2nigqPfStzq5j1n9bh+0wyrOV8H+F9uycgHeIyqeqoJZ
	Lm07fkHr1cqFC+euZsJlnWSSHdjirfmPAcfyFIhUMH2WEBDz9t714MKNnrDudLGogLzUn0ror5+
	6/Tiev0bAuCuMak251GnI4pVx/mNDTdp1j9LD9HZuCujx09aVBA1AOfVa6Y6ewzNccaW2C2lHZo
	wP2KuA8Jq+o5NSVR+4fxkgQoiagNSTA42ja/+djDJ36Cpkf7TMnGRsaant8zhUpoFhRTkVVbKDD
	7YEtQJnFuMDJ2SY5gb1NRIuknNx1vOG1p/G2x4pJ+mQJJg4yQjWTMWxzV9jTbiYjPW1dHLsWnQ9
	vF6gqzExlKrJR+gIPeKVj7JOtjupW7C5Tcfyzxa3pCBDbYk0Ua4X1J+UUh2WbTfhinh1ERHieHg
	bw==
X-Received: by 2002:a17:90b:1e03:b0:398:b17b:3bd2 with SMTP id 98e67ed59e1d1-39b260dda6emr6821206a91.4.1788515404470;
        Fri, 04 Sep 2026 02:50:04 -0700 (PDT)
Received: from 7cf34ddc0813.ant.amazon.com ([54.222.46.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd2aasm3575678a91.3.2026.09.04.02.50.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 02:50:04 -0700 (PDT)
From: Jiazi Liu <jiazi.liu1984@gmail.com>
X-Google-Original-From: Jiazi Liu <liujiazi@amazon.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org
Cc: frode@meta.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jiazi Liu <jiazi.liu1984@gmail.com>,
	Jiazi Liu <liujiazi@amazon.com>
Subject: [PATCH v3] usb: dwc3: gadget: fix IRQ storm on invalid event buffer count
Date: Fri,  4 Sep 2026 17:49:34 +0800
Message-ID: <20260904094934.12341-1-liujiazi@amazon.com>
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

Fixes: 63ccd26cd1f6 ("usb: dwc3: gadget: check that event count does not exceed event buffer length")
Cc: stable@vger.kernel.org
Tested-by: Jiazi Liu <liujiazi@amazon.com>
Signed-off-by: Jiazi Liu <liujiazi@amazon.com>
---
 drivers/usb/dwc3/core.h   |  19 +++++++
 drivers/usb/dwc3/ep0.c    |   9 ++++
 drivers/usb/dwc3/gadget.c | 104 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 608daeb7ef10..f3dabb37f806 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -49,6 +49,7 @@
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
 #define DWC3_ISOC_MAX_RETRIES	5
+#define DWC3_ERR_RECOVERY_MAX	3
 
 #define DWC3_SCRATCHBUF_SIZE	4096	/* each buffer is assumed to be 4KiB */
 #define DWC3_EVENT_BUFFERS_SIZE	4096
@@ -841,6 +842,12 @@ enum dwc3_link_state {
 	DWC3_LINK_STATE_MASK		= 0x0f,
 };
 
+enum dwc3_err_state {
+	DWC3_ERR_NONE = 0,
+	DWC3_ERR_RECOVERY,
+	DWC3_ERR_UNRECOVERABLE,
+};
+
 /* TRB Length, PCM and Status */
 #define DWC3_TRB_SIZE_MASK	(0x00ffffff)
 #define DWC3_TRB_SIZE_LENGTH(n)	((n) & DWC3_TRB_SIZE_MASK)
@@ -1004,6 +1011,7 @@ struct dwc3_glue_ops {
 /**
  * struct dwc3 - representation of our controller
  * @drd_work: workqueue used for role swapping
+ * @err_recovery_work: workqueue used for controller error recovery
  * @ep0_trb: trb which is used for the ctrl_req
  * @bounce: address of bounce buffer
  * @setup_buf: used while precessing STD USB requests
@@ -1013,6 +1021,7 @@ struct dwc3_glue_ops {
  * @ep0_in_setup: one control transfer is completed and enter setup phase
  * @lock: for synchronizing
  * @mutex: for mode switching
+ * @connect_mutex: for the pull-up and err_recovery_work
  * @dev: pointer to our struct device
  * @sysdev: pointer to the DMA-capable device
  * @xhci: pointer to our xHCI child
@@ -1079,6 +1088,9 @@ struct dwc3_glue_ops {
  * @ep0_next_event: hold the next expected event
  * @ep0state: state of endpoint zero
  * @link_state: link state
+ * @err_state: current error recovery state.
+ * @err_recovery_count: number of consecutive error recovery attempts until
+ *		confirmed healthy and reset to 0 on reset event.
  * @speed: device speed (super, high, full, low)
  * @hwparams: copy of hwparams registers
  * @regset: debugfs pointer to regdump file
@@ -1189,6 +1201,7 @@ struct dwc3_glue_ops {
  */
 struct dwc3 {
 	struct work_struct	drd_work;
+	struct work_struct	err_recovery_work;
 	struct dwc3_trb		*ep0_trb;
 	void			*bounce;
 	u8			*setup_buf;
@@ -1203,6 +1216,9 @@ struct dwc3 {
 	/* mode switching lock */
 	struct mutex		mutex;
 
+	/* serializes pull-up run/stop vs error recovery */
+	struct mutex		connect_mutex;
+
 	struct device		*dev;
 	struct device		*sysdev;
 
@@ -1332,6 +1348,9 @@ struct dwc3 {
 	enum dwc3_ep0_next	ep0_next_event;
 	enum dwc3_ep0_state	ep0state;
 	enum dwc3_link_state	link_state;
+	enum dwc3_err_state	err_state;
+
+	u32			err_recovery_count;
 
 	u16			u2sel;
 	u16			u2pel;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index bfe616194dfa..fa3d8b9f6f8e 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -200,6 +200,11 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
 	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
@@ -271,6 +276,10 @@ int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep0_set_halt(ep, value);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fa0f16ffafef..dbfff5e691e6 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1149,6 +1149,10 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 		return 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2055,6 +2059,10 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep_queue(dep, req);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2287,6 +2295,10 @@ static int dwc3_gadget_ep_set_halt(struct usb_ep *ep, int value)
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep_set_halt(dep, value, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2301,6 +2313,10 @@ static int dwc3_gadget_ep_set_wedge(struct usb_ep *ep)
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	dep->flags |= DWC3_EP_WEDGE;
 
 	if (dep->number == 0 || dep->number == 1)
@@ -2432,6 +2448,10 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	if (!dwc->gadget->wakeup_armed) {
 		dev_err(dwc->dev, "not armed for remote wakeup\n");
 		spin_unlock_irqrestore(&dwc->lock, flags);
@@ -2459,6 +2479,10 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
 	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	/*
 	 * If the link is in U3, signal for remote wakeup and wait for the
 	 * link to transition to U0 before sending device notification.
@@ -2828,10 +2852,13 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	synchronize_irq(dwc->irq_gadget);
 
+	/* Serialize against dwc3_err_recovery_work() */
+	mutex_lock(&dwc->connect_mutex);
 	if (!is_on)
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	else
 		ret = dwc3_gadget_soft_connect(dwc);
+	mutex_unlock(&dwc->connect_mutex);
 
 	pm_runtime_put(dwc->dev);
 
@@ -4147,6 +4174,10 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 
 	dwc->suspended = false;
 
+	/* The controller is recovered. */
+	if (dwc->err_state == DWC3_ERR_NONE)
+		dwc->err_recovery_count = 0;
+
 	/*
 	 * Ideally, dwc3_reset_gadget() would trigger the function
 	 * drivers to stop any active transfers through ep disable.
@@ -4634,6 +4665,12 @@ static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 	return ret;
 }
 
+static void dwc3_schedule_err_recovery(struct dwc3 *dwc)
+{
+	dwc->err_state = DWC3_ERR_RECOVERY;
+	schedule_work(&dwc->err_recovery_work);
+}
+
 static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 {
 	struct dwc3 *dwc = evt->dwc;
@@ -4667,9 +4704,21 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
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
+		spin_lock(&dwc->lock);
+		dwc3_schedule_err_recovery(dwc);
+		spin_unlock(&dwc->lock);
+		dwc3_writel(dwc, DWC3_GEVNTCOUNT(0), count);
+		return IRQ_HANDLED;
 	}
 
 	evt->count = count;
@@ -4729,6 +4778,53 @@ static void dwc_gadget_release(struct device *dev)
 	kfree(gadget);
 }
 
+static void dwc3_err_recovery_work(struct work_struct *work)
+{
+	struct dwc3 *dwc = container_of(work, struct dwc3, err_recovery_work);
+	unsigned long flags;
+	int ret;
+
+	dwc->err_recovery_count++;
+
+	/* serializes against dwc3_gadget_pullup() */
+	mutex_lock(&dwc->connect_mutex);
+
+	ret = dwc3_gadget_soft_disconnect(dwc);
+	if (ret)
+		goto err_unrecoverable;
+
+	dwc3_disconnect_gadget_sleepable(dwc);
+
+	if (dwc->err_recovery_count > DWC3_ERR_RECOVERY_MAX)
+		goto err_unrecoverable;
+
+	if (dwc->softconnect) {
+		/*
+		 * Wait irq to finish before soft_connect resets evt->lpos and
+		 * the event buffer registers to avoid racing with
+		 * dwc3_process_event_buf().
+		 */
+		synchronize_irq(dwc->irq_gadget);
+
+		ret = dwc3_gadget_soft_connect(dwc);
+		if (ret)
+			goto err_unrecoverable;
+	}
+	mutex_unlock(&dwc->connect_mutex);
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->err_state = DWC3_ERR_NONE;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+	return;
+
+err_unrecoverable:
+	dev_err(dwc->dev, "Unable to recover the controller\n");
+	mutex_unlock(&dwc->connect_mutex);
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->err_state = DWC3_ERR_UNRECOVERABLE;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 /**
  * dwc3_gadget_init - initializes gadget related registers
  * @dwc: pointer to our controller context structure
@@ -4772,6 +4868,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	}
 
 	init_completion(&dwc->ep0_in_setup);
+	INIT_WORK(&dwc->err_recovery_work, dwc3_err_recovery_work);
+	mutex_init(&dwc->connect_mutex);
 	dwc->gadget = kzalloc_obj(struct usb_gadget);
 	if (!dwc->gadget) {
 		ret = -ENOMEM;
@@ -4868,6 +4966,8 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
+	cancel_work_sync(&dwc->err_recovery_work);
+	mutex_destroy(&dwc->connect_mutex);
 	dwc3_enable_susphy(dwc, true);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
-- 
2.50.1 (Apple Git-155)

