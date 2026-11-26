Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675041;
	b=HqQGn5YkM96P+B8TKxvm6iXieDfCxnp65KEqcZN1oA9eNPp2zUnqheIHHPas90pJmpy2
	 gzUc/KfIQzfv2NL+YY55D1nMYmijZrcrBl9/mBOUSIeO0aTljpzLopHRwDdG+wjraWvCt
	 PSLPZL6SglJw4yp/6M3jbAB6b/3hs40kpScM+R9RDoXCGjGlxwxZiVw1N70piOue92xCq
	 pk807aa6lSHhdKc1wFHD0Vmc9Ofpu+JIkSQyyRKAS7FDhVcDBqftK/jXv4L60xixNQ4kp
	 Pa00IKnWqocelPX0sWkKZLaoHBLJqbtQHWrvxDfYty3r4fyRYsL07vSkozuXklsqNrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675041;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ie7rNp36i5eFBqsWROeyYRiJ5w1XR4jUvQktgsLbp2A=;
	b=oefbLjhs5i+hdSKpVxNtaa0ioCM0ymRaTB1LFZZ3hi7OW5OYIzErQGVJ3uz4wuOJqDlL
	 H693MZWdDRuVvhcSR2b/sF6Yb2dNe6YbjJAwMwx3ctsk9IEUQ4s/xTNez8aGEvch45OcY
	 RFANkb/t3Swilr75wcA4l5Mjspe3rRZhxdiG1dViXaX0TZHjoHyg8BnZLLei+3YwoBMq0
	 86JauAzSP/3yUeY10GJpexcNNx/YZm1rXMkcxEhdDCVMfeXkWni3OjRA5efutlVC8eylv
	 IBkUnPKsBya15LRDnYoCrNBkJqyzZuhTJJ1vPDSXOjM1oG3A5KPj1Oe+ovILrqgm4jQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFSeQ5hy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E48606A682;
	Thu, 26 Nov 2026 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFSeQ5hy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795675041;
	b=b5+pFgXsiTHsy+xoIOHb4BJEn/Os1Cz7fehsyGW2qhXzAir+1KPnq235FZ8eGfc9l5L9
	 Hkj+tTz0O1+DgKoNgbEbSA8wapKI3rOBf7hcVZS7XoZyba24XaPg9g0/w+P038DC4jya8
	 w9hiIcdhjRzqbVghjhep+DpftcamDib4UmytxphCKeoG/pUiAWWbE1G5W7qX5UVer/xjK
	 D1SwwwrnZXZN/g5GA5SZg8oestKwSRzeFN1qoqDx3t2wrISAfSr6+J1Fr6BL3zJ1NkhJq
	 YB1eObxL1Sxo6pFI1bt+NDkNNs8kp/1V7qyPViMu0dtgSMPI7zcX8LAw8nJEg5vD2aQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675041;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ie7rNp36i5eFBqsWROeyYRiJ5w1XR4jUvQktgsLbp2A=;
	b=3dhjhb9lA2Gp7/wnt20iHyV4pITQbtWFHb8vG1hLhe6zoxQh+LlydJyVty4Olp82iaKz
	 TAqr5qd4GO/HaIeMaFi1v3kEmwE1C+iR+XPS1loJQ/Myui9AFpu5N7Y/Y8KdBp4d1IvR9
	 lunxWfjmzju2kUbOpnv6QhBxdN4L6DYqYsGwUUPw9nDd4tHVmO8ef11U7AQEroyBidH+r
	 lCu3i+Xk7hQx+Oo7jJicdAldB+8To7kg9C6UaQZ0IrAjvqD9VLMapbGGY6gt5XgOafQH8
	 hDqI0cKyWHbVn1f+CY3prpMs42wk8Tfs5w+GOgaCFvF+LvV4XViXHdVnc5fkO7PjXJw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A9E6D1F000D0;
	Thu, 26 Nov 2026 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675041;
	bh=Ie7rNp36i5eFBqsWROeyYRiJ5w1XR4jUvQktgsLbp2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EFSeQ5hy70/RpcAjlT+VdAw+2M1CAtF1Drdkara8eqA1/1+WiJQG5xeiikcceqb5G
	 VX4w6r2GvMnMo7L/gpRAfK6e+EQuj2momYyNEU0XQW08To7jhGji48ejFU16X7BqaN
	 3FAvr5/JOjXavCZjQO145Estfr3W15bC8PQ7XE3Puq0SABN9j6O7RgiHyltljDqpBN
	 iNnk/AZi9WdU8rJN/HmPkPGgx7MSW2XK0SM2f7yZwNy9wFotfxfixU2muQt3o8xVsT
	 iisNWkutNIWlHB4aWn7Qp1iRrs49tq3jX+kXZXkUnqOW/a4UYWv/NaWhFT9qbmu8bS
	 r35bVbhUiLybQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3BEF14D29C;
	Thu, 26 Nov 2026 06:37:07 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:37:07 +0800
Subject: [PATCH v9 4/6] usb: gadget: gadgetfs: NAK new setups until
 control-OUT data is read
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-gadgetfs-ep0-v9-4-81b464c6e641@gmail.com>
References: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
In-Reply-To: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795675025; l=12677;
 i=kayano050408@gmail.com; s=20261126; h=from:subject:message-id;
 bh=28xcZcGUas0op1ZrnBH6sNbkNCV4CYbjaiZ+szAWzqw=;
 b=KZ1i0O5cCwGSqECsFb78yrf2nl2TM42LEdo1SXrj/hwOmd0uHnv8COSIEX1M+tEmdFHBELnBl
 DOz3PjrULtyAhoU7gao05wo6X3ZmyIZ53hmFA1xz3Cfvs4t6pSfwrO8
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=40M3hugIx++9w3nkAoFXGcN/vLWsPMGDYdbduV+lUlI=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/20261126 with
 auth_id=1648
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

For a delegated 3-stage control-OUT transfer, gadgetfs_setup() submits
the data-stage request immediately and the controller acknowledges the
transfer to the host as soon as it completes, before userspace calls
ep0_read() to collect the payload.  If another control transfer arrives
in the meantime, aborting the earlier state erases the completed
transfer before userspace ever receives it, and reuses dev->req and
dev->rbuf while ep0_read() may be copying to userspace.

When a new setup packet arrives while a properly completed control-OUT
payload has not yet been read by userspace, save the setup packet in
dev->pending_setup and return without submitting an ep0 request so the
controller NAKs the new transfer until ep0_read() finishes copying the
completed payload.  Once the copy completes, replay dev->pending_setup
and stall ep0 with usb_ep_set_halt() if it fails.

Also check dev->setup_wLength == 0 for zero-length status acknowledgments
in ep0_read() and complete them with dev_req_complete() so zero-length
transfers never set setup_out_ready.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 178 ++++++++++++++++++++++++++++++--------
 1 file changed, 140 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 4915906d782c..12ae17f45898 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -143,6 +143,10 @@ struct dev_data {
 	bool				ep0_req_queued;
 	void				*ep0_req_buf;
 	unsigned int			setup_generation;
+	unsigned int			setup_out_len;
+	bool				setup_out_copying;
+	bool				setup_pending;
+	struct usb_ctrlrequest		pending_setup;
 
 	/* the rest is basically write-once */
 	struct usb_config_descriptor	*config, *hs_config;
@@ -1021,23 +1025,25 @@ static void ep0_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct dev_data		*dev = req->context;
 	unsigned long		flags;
-	int			free = 1;
 
 	/* for control OUT, data must still get to userspace */
 	spin_lock_irqsave(&dev->lock, flags);
-	if (!dev->setup_in) {
+	if (dev->state == STATE_DEV_CONNECTED ||
+	    dev->state == STATE_DEV_SETUP) {
 		dev->setup_out_error = (req->status != 0);
-		if (!dev->setup_out_error)
-			free = 0;
+		if (dev->setup_out_error) {
+			dev->setup_out_len = 0;
+			clean_req(ep, req);
+		} else {
+			dev->setup_out_len = min_t(unsigned int, req->actual,
+						   sizeof(dev->rbuf));
+			req->complete = dev_req_complete;
+		}
 		dev->setup_out_ready = 1;
 		ep0_readable(dev);
-	}
-
-	/* clean up as appropriate */
-	if (free)
+	} else {
 		clean_req(ep, req);
-	else
-		req->complete = dev_req_complete;
+	}
 	dev->ep0_req_queued = false;
 	wake_up(&dev->wait);
 	spin_unlock_irqrestore(&dev->lock, flags);
@@ -1047,7 +1053,8 @@ static int setup_req(struct usb_ep *ep, struct usb_request *req, u16 len)
 {
 	struct dev_data	*dev = ep->driver_data;
 
-	if (dev->setup_out_ready || dev->ep0_req_queued) {
+	if (dev->setup_out_ready || dev->setup_out_copying ||
+	    dev->ep0_req_queued) {
 		DBG(dev, "ep0 request busy!\n");
 		return -EBUSY;
 	}
@@ -1113,6 +1120,39 @@ static bool ep0_check_abort(struct dev_data *dev)
 	return true;
 }
 
+static int gadgetfs_do_setup(struct dev_data *dev,
+			     const struct usb_ctrlrequest *ctrl,
+			     bool process_ctx);
+
+/*
+ * Replay a SETUP packet that was NAKed while userspace had not yet read
+ * a completed control-OUT data stage.  Called with dev->lock held from
+ * process context (IRQs disabled).
+ */
+static void ep0_process_pending_setup(struct dev_data *dev)
+{
+	struct usb_ctrlrequest	ctrl;
+	int			status;
+
+	if (!dev->setup_pending)
+		return;
+
+	ctrl = dev->pending_setup;
+	dev->setup_pending = false;
+	if (dev->state != STATE_DEV_CONNECTED &&
+	    dev->state != STATE_DEV_UNCONNECTED)
+		return;
+
+	status = gadgetfs_do_setup(dev, &ctrl, true);
+	if (status < 0) {
+		++dev->udc_usage;
+		spin_unlock_irq(&dev->lock);
+		(void)usb_ep_set_halt(dev->gadget->ep0);
+		spin_lock_irq(&dev->lock);
+		--dev->udc_usage;
+	}
+}
+
 static ssize_t
 ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 {
@@ -1141,14 +1181,20 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			retval = -EL2HLT;
 			dev->state = STATE_DEV_CONNECTED;
 
-		} else if (len == 0) {		/* ack SET_CONFIGURATION etc */
-			struct usb_ep		*ep = dev->gadget->ep0;
+		} else if (dev->setup_wLength == 0) {	/* ack SET_CONFIGURATION etc */
 			struct usb_request	*req = dev->req;
 
-			retval = setup_req(ep, req, 0);
+			if (dev->setup_out_ready || dev->setup_out_copying ||
+			    dev->ep0_req_queued) {
+				retval = -EBUSY;
+				goto done;
+			}
+			req->buf = dev->rbuf;
+			req->complete = dev_req_complete;
+			req->length = 0;
+			req->zero = 0;
 			dev->state = STATE_DEV_CONNECTED;
-			if (retval == 0)
-				retval = queue_ep0_req(dev, true);
+			retval = queue_ep0_req(dev, true);
 
 			/* assume that was SET_CONFIGURATION */
 			if (dev->current_config) {
@@ -1171,32 +1217,47 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			}
 			spin_unlock_irq (&dev->lock);
 			retval = wait_event_interruptible (dev->wait,
-					dev->setup_out_ready != 0);
+					dev->setup_out_ready ||
+					dev->setup_abort ||
+					dev->state != STATE_DEV_SETUP);
 
-			/* FIXME state could change from under us */
 			spin_lock_irq (&dev->lock);
 			if (retval)
 				goto done;
 
-			if (dev->state != STATE_DEV_SETUP) {
+			if (ep0_check_abort(dev)) {
+				retval = -EIDRM;
+				goto done;
+			}
+			if (dev->state != STATE_DEV_SETUP ||
+			    dev->setup_in || !dev->setup_out_ready) {
 				retval = -ECANCELED;
 				goto done;
 			}
 			dev->state = STATE_DEV_CONNECTED;
 
-			if (dev->setup_out_error)
+			if (dev->setup_out_error) {
+				dev->setup_out_ready = 0;
+				dev->setup_out_error = 0;
+				dev->setup_out_len = 0;
 				retval = -EIO;
-			else {
-				len = min (len, (size_t)dev->req->actual);
+			} else {
+				len = min_t(size_t, len, dev->setup_out_len);
+				dev->setup_out_ready = 0;
+				dev->setup_out_len = 0;
+				dev->setup_out_copying = true;
 				++dev->udc_usage;
 				spin_unlock_irq(&dev->lock);
-				if (copy_to_user (buf, dev->req->buf, len))
+				if (copy_to_user(buf, dev->rbuf, len))
 					retval = -EFAULT;
 				else
 					retval = len;
 				spin_lock_irq(&dev->lock);
 				--dev->udc_usage;
-				clean_req (dev->gadget->ep0, dev->req);
+				dev->setup_out_copying = false;
+				if (dev->req)
+					clean_req(dev->gadget->ep0, dev->req);
+				ep0_process_pending_setup(dev);
 				/* NOTE userspace can't yet choose to stall */
 			}
 		}
@@ -1367,7 +1428,8 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 				kfree(kbuf);
 				return -ECANCELED;
 			}
-			if (dev->setup_out_ready || dev->ep0_req_queued) {
+			if (dev->setup_out_ready || dev->setup_out_copying ||
+			    dev->ep0_req_queued) {
 				kfree(kbuf);
 				return -EBUSY;
 			}
@@ -1460,6 +1522,8 @@ ep0_poll (struct file *fd, poll_table *wait)
 	if (dev->state == STATE_DEV_SETUP) {
 		if (dev->setup_in || dev->setup_can_stall)
 			mask = EPOLLOUT;
+		else if (dev->setup_out_ready)
+			mask = EPOLLIN;
 	} else {
 		if (dev->ev_next != 0)
 			mask = EPOLLIN;
@@ -1551,19 +1615,23 @@ config_buf (struct dev_data *dev, u8 type, unsigned index)
 	return len;
 }
 
+/* Called with dev->lock held. */
 static int
-gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
+gadgetfs_do_setup(struct dev_data *dev, const struct usb_ctrlrequest *ctrl,
+		  bool process_ctx)
 {
-	struct dev_data			*dev = get_gadget_data (gadget);
+	struct usb_gadget		*gadget = dev->gadget;
 	struct usb_request		*req = dev->req;
 	int				value = -EOPNOTSUPP;
 	struct usb_gadgetfs_event	*event;
 	u16				w_value = le16_to_cpu(ctrl->wValue);
 	u16				w_length = le16_to_cpu(ctrl->wLength);
 
-	spin_lock(&dev->lock);
 	/* invalidate userspace copies started for an older control request */
 	dev->setup_generation++;
+	dev->setup_out_ready = 0;
+	dev->setup_out_error = 0;
+	dev->setup_out_len = 0;
 
 	/*
 	 * If userspace has not collected a previous GADGETFS_SETUP event,
@@ -1591,20 +1659,16 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			*temp = cpu_to_le16(RBUF_SIZE);
 			w_length = RBUF_SIZE;
 		} else {
-			spin_unlock(&dev->lock);
 			return value;
 		}
 	}
-	if (dev->ep0_req_queued) {
-		spin_unlock(&dev->lock);
+	if (dev->ep0_req_queued)
 		return -EBUSY;
-	}
 	if (dev->state == STATE_DEV_UNCONNECTED) {
 		if (gadget_is_dualspeed(gadget)
 				&& gadget->speed == USB_SPEED_HIGH
 				&& dev->hs_config == NULL) {
-			spin_unlock(&dev->lock);
-			ERROR (dev, "no high speed config??\n");
+			ERROR(dev, "no high speed config??\n");
 			return -EINVAL;
 		}
 
@@ -1725,6 +1789,7 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			dev->setup_wLength = w_length;
 			dev->setup_out_ready = 0;
 			dev->setup_out_error = 0;
+			dev->setup_out_len = 0;
 
 			/* read DATA stage for OUT right away */
 			if (unlikely(!dev->setup_in && w_length)) {
@@ -1733,7 +1798,7 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				if (value < 0)
 					break;
 
-				value = queue_ep0_req(dev, false);
+				value = queue_ep0_req(dev, process_ctx);
 				if (value < 0)
 					break;
 
@@ -1745,7 +1810,6 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			event = next_event (dev, GADGETFS_SETUP);
 			event->u.setup = *ctrl;
 			ep0_readable (dev);
-			spin_unlock (&dev->lock);
 			/*
 			 * Return USB_GADGET_DELAYED_STATUS as a workaround to
 			 * stop some UDC drivers (e.g. dwc3) from automatically
@@ -1765,17 +1829,43 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 		req->zero = value < w_length;
 		req->complete = dev_req_complete;
 
-		value = queue_ep0_req(dev, false);
+		value = queue_ep0_req(dev, process_ctx);
 		if (value < 0) {
 			DBG(dev, "ep_queue --> %d\n", value);
 			req->status = 0;
 		}
-		spin_unlock(&dev->lock);
 		return value;
 	}
 
 	/* device stalls when value < 0 */
 	req->buf = dev->rbuf;
+	return value;
+}
+
+static int
+gadgetfs_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
+{
+	struct dev_data		*dev = get_gadget_data(gadget);
+	u16			w_length = le16_to_cpu(ctrl->wLength);
+	int			value;
+
+	spin_lock(&dev->lock);
+	/*
+	 * A properly completed control-OUT transfer has already been
+	 * acknowledged to the host; do not let a new SETUP erase it
+	 * before userspace reads the payload.  Leave ep0 without a
+	 * queued request so the controller NAKs the new transfer until
+	 * ep0_read() finishes collecting the data.
+	 */
+	if ((dev->setup_out_ready && !dev->setup_out_error) ||
+	    dev->setup_out_copying) {
+		dev->pending_setup = *ctrl;
+		dev->setup_pending = true;
+		spin_unlock(&dev->lock);
+		return w_length == 0 ? USB_GADGET_DELAYED_STATUS : 0;
+	}
+	dev->setup_pending = false;
+	value = gadgetfs_do_setup(dev, ctrl, false);
 	spin_unlock(&dev->lock);
 	return value;
 }
@@ -1875,6 +1965,10 @@ gadgetfs_unbind (struct usb_gadget *gadget)
 
 	spin_lock_irq (&dev->lock);
 	dev->state = STATE_DEV_UNBOUND;
+	dev->setup_out_ready = 0;
+	dev->setup_out_error = 0;
+	dev->setup_out_len = 0;
+	dev->setup_pending = false;
 	while (dev->udc_usage > 0) {
 		spin_unlock_irq(&dev->lock);
 		usleep_range(1000, 2000);
@@ -1969,6 +2063,10 @@ gadgetfs_disconnect (struct usb_gadget *gadget)
 		goto exit;
 
 	INFO (dev, "disconnected\n");
+	dev->setup_out_ready = 0;
+	dev->setup_out_error = 0;
+	dev->setup_out_len = 0;
+	dev->setup_pending = false;
 	next_event (dev, GADGETFS_DISCONNECT);
 	dev->state = STATE_DEV_UNCONNECTED;
 	ep0_readable (dev);
@@ -2174,6 +2272,10 @@ gadget_dev_open (struct inode *inode, struct file *fd)
 	if (dev->state == STATE_DEV_DISABLED) {
 		dev->ev_next = 0;
 		dev->setup_abort = 0;
+		dev->setup_out_ready = 0;
+		dev->setup_out_error = 0;
+		dev->setup_out_len = 0;
+		dev->setup_pending = false;
 		dev->state = STATE_DEV_OPENED;
 		fd->private_data = dev;
 		get_dev (dev);

-- 
Git-155)


