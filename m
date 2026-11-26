Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675036;
	b=1yxPXlkxKx4Meso4F7leO1Xoe7CH5QL2cO6ibW8cH3HphR4B7Z83ZGviqk9oly4v5cJ3
	 0DCED/8cFw7wP7Rvn6SiOK6ekEDHzfbnbzwrpNvkgmN4w5JF4ALXsMD5Mr+vV8etu7CLS
	 tOgOjPYATxxdm59AkXfssF5c/4epsfKmlpj1NSFreU2nG+tP5Zu3R/8VZ1894EEJOSS+I
	 d2f5rZ0xSNhWHLztspZFF2msdBApxUzcx/6N/epMDYxHsa2yCWKGRrGEAgQhksT8g4ptw
	 V+W/J04DwQbfd8xruiOTO715nqBUTjVKRrbrkAVObfsXn8n8rGZ1HpyKfIkQ3bz9b0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675036;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MmH7ntWms3zTjzmc6njQii6ovLhsPVkt+EHHeV5KxS0=;
	b=zROAuvTdSXT5hIl27YdMvuM7hEmSFfcarpyYmcYVGt8yEgB+yx71S3r/N5vO6FhCkz0o
	 02RWUaEM4WNI3O8eIp7WffCKSkPZzbC6UlwifDhF16KB8IKOCmOsCrSfvlaVhv+vPZgya
	 XUEQle6DFVLE8ZfQM5oUv5/4Wj6BByGaE1av/cMEk8fmWtQdhnfkrV6lsKajgX8e6sWHO
	 XKCmT2DNOYLAgholLKogshdGc2Xoti4rd8sj4Z+GfOWpNxSP3YQumOJ8ApsDl9T+jWq6t
	 4D1JOzJphJPExtNA7sDYoK/1Mw8PYWGceX4hK2G3Z3tZXVQrt7gK+iCbiW0ZfjZutQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJwCzHPv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA7C606A31E;
	Thu, 26 Nov 2026 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJwCzHPv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795675035;
	b=dYnEdUMBnW64REIJR5ezqBxypFL75eDdKaFhCsGLSKN/2GIzLT/4GZTz3XdGYO2FmH16
	 EAxjHjVqULnyLt/BNIopp91yqChQeFToYxaVbFxgDFleLxSjtIea+aX9FCoM1PzBtFvn9
	 2zjY3PGVJY0gJmg7XNGBq4qEAs9aUlUCBYvP3x9gNkhKCTyemjaOe6o6L1fnMn5COqOmv
	 Rb8hKvxbbrMb/wFjtTiVcX4jxoqf4UtcZZli8UwMk1NkqQqWLVk1WiKPhn+5Ue7zv38hQ
	 UzG18NcnnTpBeJfBKVF6NvMjBI6F7EdftOXEGTukrs24fWfHmpU4VmfU31GMzW7TubQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675035;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MmH7ntWms3zTjzmc6njQii6ovLhsPVkt+EHHeV5KxS0=;
	b=fQxlKwhP4m6Jj+hqeBB+S4qCw/O9RgU8Fb4EG2sLRYDJMwEzpi7lE1a5CQagaxbIrVLV
	 pwlx8jiSImMlSXCF6r/k5l9xO/CyQR9vQMazr2J5aj8YW674ozIg67mFY97oJrAlVvtxT
	 QTZkRTg5lfGJlJbZRaz/JOFEllE+AHrOrMyCf3WWnf7r9EVZaR5Ktok9Pcq9C0IeRo/uR
	 VH1CXF2T1aghdyhC4JxwDll+w9dDsOZC3wYUMJcP0UTPeIisBnAkMNBLsrO76n7hzBx9X
	 uKvn5KPxV60RLd0i5bjq04zOJbbuDDzc8eVrYpbVD3q9fNgLVPRT+umOVlC8WLb7AHQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 54E861F000C4;
	Thu, 26 Nov 2026 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675035;
	bh=MmH7ntWms3zTjzmc6njQii6ovLhsPVkt+EHHeV5KxS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SJwCzHPvySD4y+yZfCcGdtSN9KJ5rjIn5a7zH45mkX0w/4NG7/amFdQtRkV1MtY9s
	 1zcT/NQFcIcXIWxGDr54e01m5PLh12/3vZpM1uz8HEJgPqWStvlI9+nc/Y9S2c8XFm
	 Bkv2kCWGgwsyk+EI7JuCgPAbhigU/mSv5NjCJMjGhHCV3U9rpTIMVW8Q/Quk+u8CrT
	 DB345/58vtaTNc7Pp11DVWIuu3jzLiFeohQ6OhrBVymIu26QnwMZhOfuZZL1SsFpfS
	 1zgMCf1MnmFhVCWxRk5E3JcO19HRlS9kRWRkuPa7/L7rKCXXTeZEX0O62MhQZwtRMa
	 vDi0r4KVZPDoA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D91ED4D285;
	Thu, 26 Nov 2026 06:37:06 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:37:04 +0800
Subject: [PATCH v9 1/6] usb: gadget: gadgetfs: fix ep0 request lifetime on
 unbind
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
Message-Id: <20261126-gadgetfs-ep0-v9-1-81b464c6e641@gmail.com>
References: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
In-Reply-To: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795675024; l=11076;
 i=kayano050408@gmail.com; s=20261126; h=from:subject:message-id;
 bh=h/ZSZJB1RT3g3upZaFfvf56AJ1LuqVGKJQvbk+k42A4=;
 b=2wnT8xwn4PAbtEOgDllqJXTtW4IMsKYL+BuT3EHrmv0XV2j76XN8+4NhtotPjF6onavNXyYr+
 s+WmQ68nJ/9BKzHYZ9ZHju/UiRwej83gYLewlAymYUyZrjgTtFv/kIS
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=40M3hugIx++9w3nkAoFXGcN/vLWsPMGDYdbduV+lUlI=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/20261126 with
 auth_id=1648
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

gadgetfs_unbind() frees the preallocated ep0 request after disconnecting
the gadget, assuming that no I/O remains active.

With controllers such as dummy_hcd, disconnecting does not necessarily
drain ep0, so a delayed userspace response can leave dev->req queued
when it is freed.  This triggers the warning in dummy_free_request() and
a use-after-free when dummy_udc_stop() subsequently drains the endpoint
queue.

Submit ep0 requests through a shared queue_ep0_req() helper that tracks
dev->ep0_req_queued under dev->lock and wakes dev->wait whenever the
flag clears.  Track dynamically allocated ep0 buffers separately in
dev->ep0_req_buf so clean_req() never frees descriptor storage inside
dev->buf.

In gadgetfs_unbind(), tear down non-ep0 endpoints first, then dequeue
any active ep0 request and wait under dev->lock with
wait_event_lock_irq() for completion to finish before freeing dev->req.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Reported-by: syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c73e1942197af9f54ca3
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 199 +++++++++++++++++++++++++-------------
 1 file changed, 133 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index cc059a6ee262..911419a4e1a3 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -140,6 +140,8 @@ struct dev_data {
 					setup_abort : 1,
 					gadget_registered : 1;
 	unsigned			setup_wLength;
+	bool				ep0_req_queued;
+	void				*ep0_req_buf;
 
 	/* the rest is basically write-once */
 	struct usb_config_descriptor	*config, *hs_config;
@@ -984,21 +986,39 @@ static inline void ep0_readable (struct dev_data *dev)
 	kill_fasync (&dev->fasync, SIGIO, POLL_IN);
 }
 
-static void clean_req (struct usb_ep *ep, struct usb_request *req)
+static void dev_req_complete(struct usb_ep *ep, struct usb_request *req);
+
+static void clean_req(struct usb_ep *ep, struct usb_request *req)
 {
-	struct dev_data		*dev = ep->driver_data;
+	struct dev_data		*dev = req->context;
 
-	if (req->buf != dev->rbuf) {
-		kfree(req->buf);
-		req->buf = dev->rbuf;
-	}
-	req->complete = epio_complete;
+	/*
+	 * req->buf may also point into dev->buf, which holds the
+	 * descriptors; only the buffer allocated for the request may be
+	 * freed here.
+	 */
+	kfree(dev->ep0_req_buf);
+	dev->ep0_req_buf = NULL;
+	req->buf = dev->rbuf;
+	req->complete = dev_req_complete;
 	dev->setup_out_ready = 0;
 }
 
-static void ep0_complete (struct usb_ep *ep, struct usb_request *req)
+static void dev_req_complete(struct usb_ep *ep, struct usb_request *req)
 {
-	struct dev_data		*dev = ep->driver_data;
+	struct dev_data		*dev = req->context;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	clean_req(ep, req);
+	dev->ep0_req_queued = false;
+	wake_up(&dev->wait);
+	spin_unlock_irqrestore(&dev->lock, flags);
+}
+
+static void ep0_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct dev_data		*dev = req->context;
 	unsigned long		flags;
 	int			free = 1;
 
@@ -1009,29 +1029,36 @@ static void ep0_complete (struct usb_ep *ep, struct usb_request *req)
 		if (!dev->setup_out_error)
 			free = 0;
 		dev->setup_out_ready = 1;
-		ep0_readable (dev);
+		ep0_readable(dev);
 	}
 
 	/* clean up as appropriate */
-	if (free && req->buf != &dev->rbuf)
-		clean_req (ep, req);
-	req->complete = epio_complete;
+	if (free)
+		clean_req(ep, req);
+	else
+		req->complete = dev_req_complete;
+	dev->ep0_req_queued = false;
+	wake_up(&dev->wait);
 	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
-static int setup_req (struct usb_ep *ep, struct usb_request *req, u16 len)
+static int setup_req(struct usb_ep *ep, struct usb_request *req, u16 len)
 {
 	struct dev_data	*dev = ep->driver_data;
 
-	if (dev->setup_out_ready) {
-		DBG (dev, "ep0 request busy!\n");
+	if (dev->setup_out_ready || dev->ep0_req_queued) {
+		DBG(dev, "ep0 request busy!\n");
 		return -EBUSY;
 	}
-	if (len > sizeof (dev->rbuf))
-		req->buf = kmalloc(len, GFP_ATOMIC);
-	if (req->buf == NULL) {
+	if (len > sizeof(dev->rbuf)) {
+		dev->ep0_req_buf = kmalloc(len, GFP_ATOMIC);
+		if (!dev->ep0_req_buf) {
+			req->buf = dev->rbuf;
+			return -ENOMEM;
+		}
+		req->buf = dev->ep0_req_buf;
+	} else {
 		req->buf = dev->rbuf;
-		return -ENOMEM;
 	}
 	req->complete = ep0_complete;
 	req->length = len;
@@ -1039,6 +1066,35 @@ static int setup_req (struct usb_ep *ep, struct usb_request *req, u16 len)
 	return 0;
 }
 
+/* Called with dev->lock held. */
+static int queue_ep0_req(struct dev_data *dev, bool process_ctx)
+{
+	struct usb_ep		*ep = dev->gadget->ep0;
+	struct usb_request	*req = dev->req;
+	int			ret;
+
+	++dev->udc_usage;
+	dev->ep0_req_queued = true;
+	if (process_ctx)
+		spin_unlock_irq(&dev->lock);
+	else
+		spin_unlock(&dev->lock);
+
+	ret = usb_ep_queue(ep, req, process_ctx ? GFP_KERNEL : GFP_ATOMIC);
+
+	if (process_ctx)
+		spin_lock_irq(&dev->lock);
+	else
+		spin_lock(&dev->lock);
+	--dev->udc_usage;
+	if (ret < 0) {
+		clean_req(ep, req);
+		dev->ep0_req_queued = false;
+		wake_up(&dev->wait);
+	}
+	return ret;
+}
+
 static ssize_t
 ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 {
@@ -1072,14 +1128,10 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			struct usb_ep		*ep = dev->gadget->ep0;
 			struct usb_request	*req = dev->req;
 
-			if ((retval = setup_req (ep, req, 0)) == 0) {
-				++dev->udc_usage;
-				spin_unlock_irq (&dev->lock);
-				retval = usb_ep_queue (ep, req, GFP_KERNEL);
-				spin_lock_irq (&dev->lock);
-				--dev->udc_usage;
-			}
+			retval = setup_req(ep, req, 0);
 			dev->state = STATE_DEV_CONNECTED;
+			if (retval == 0)
+				retval = queue_ep0_req(dev, true);
 
 			/* assume that was SET_CONFIGURATION */
 			if (dev->current_config) {
@@ -1271,22 +1323,20 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 			if (retval == 0) {
 				dev->state = STATE_DEV_CONNECTED;
 				++dev->udc_usage;
-				spin_unlock_irq (&dev->lock);
-				if (copy_from_user (dev->req->buf, buf, len))
+				spin_unlock_irq(&dev->lock);
+				if (copy_from_user(dev->req->buf, buf, len))
 					retval = -EFAULT;
-				else {
-					if (len < dev->setup_wLength)
-						dev->req->zero = 1;
-					retval = usb_ep_queue (
-						dev->gadget->ep0, dev->req,
-						GFP_KERNEL);
-				}
 				spin_lock_irq(&dev->lock);
 				--dev->udc_usage;
 				if (retval < 0) {
-					clean_req (dev->gadget->ep0, dev->req);
-				} else
-					retval = len;
+					clean_req(dev->gadget->ep0, dev->req);
+				} else {
+					if (len < dev->setup_wLength)
+						dev->req->zero = 1;
+					retval = queue_ep0_req(dev, true);
+					if (retval == 0)
+						retval = len;
+				}
 
 				return retval;
 			}
@@ -1482,7 +1532,11 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 		}
 	}
 
-	spin_lock (&dev->lock);
+	spin_lock(&dev->lock);
+	if (dev->ep0_req_queued) {
+		spin_unlock(&dev->lock);
+		return -EBUSY;
+	}
 	dev->setup_abort = 0;
 	if (dev->state == STATE_DEV_UNCONNECTED) {
 		if (gadget_is_dualspeed(gadget)
@@ -1509,7 +1563,6 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 		dev->setup_abort = 1;
 
 	req->buf = dev->rbuf;
-	req->context = NULL;
 	switch (ctrl->bRequest) {
 
 	case USB_REQ_GET_DESCRIPTOR:
@@ -1620,22 +1673,15 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			dev->setup_out_error = 0;
 
 			/* read DATA stage for OUT right away */
-			if (unlikely (!dev->setup_in && w_length)) {
-				value = setup_req (gadget->ep0, dev->req,
-							w_length);
+			if (unlikely(!dev->setup_in && w_length)) {
+				value = setup_req(gadget->ep0, dev->req,
+						  w_length);
 				if (value < 0)
 					break;
 
-				++dev->udc_usage;
-				spin_unlock (&dev->lock);
-				value = usb_ep_queue (gadget->ep0, dev->req,
-							GFP_KERNEL);
-				spin_lock (&dev->lock);
-				--dev->udc_usage;
-				if (value < 0) {
-					clean_req (gadget->ep0, dev->req);
+				value = queue_ep0_req(dev, false);
+				if (value < 0)
 					break;
-				}
 
 				/* we can't currently stall these */
 				dev->setup_can_stall = 0;
@@ -1663,22 +1709,20 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	if (value >= 0 && dev->state != STATE_DEV_SETUP) {
 		req->length = value;
 		req->zero = value < w_length;
+		req->complete = dev_req_complete;
 
-		++dev->udc_usage;
-		spin_unlock (&dev->lock);
-		value = usb_ep_queue (gadget->ep0, req, GFP_KERNEL);
-		spin_lock(&dev->lock);
-		--dev->udc_usage;
-		spin_unlock(&dev->lock);
+		value = queue_ep0_req(dev, false);
 		if (value < 0) {
-			DBG (dev, "ep_queue --> %d\n", value);
+			DBG(dev, "ep_queue --> %d\n", value);
 			req->status = 0;
 		}
+		spin_unlock(&dev->lock);
 		return value;
 	}
 
 	/* device stalls when value < 0 */
-	spin_unlock (&dev->lock);
+	req->buf = dev->rbuf;
+	spin_unlock(&dev->lock);
 	return value;
 }
 
@@ -1771,6 +1815,7 @@ static void
 gadgetfs_unbind (struct usb_gadget *gadget)
 {
 	struct dev_data		*dev = get_gadget_data (gadget);
+	struct usb_request	*req;
 
 	DBG (dev, "%s\n", __func__);
 
@@ -1784,12 +1829,32 @@ gadgetfs_unbind (struct usb_gadget *gadget)
 	spin_unlock_irq (&dev->lock);
 
 	destroy_ep_files (dev);
+
+	spin_lock_irq(&dev->lock);
+	req = dev->req;
+	dev->req = NULL;
+	if (req) {
+		if (dev->ep0_req_queued) {
+			spin_unlock_irq(&dev->lock);
+			usb_ep_dequeue(gadget->ep0, req);
+			spin_lock_irq(&dev->lock);
+			/*
+			 * usb_ep_dequeue() may return before the completion
+			 * routine runs; wait until completion finishes.
+			 */
+			wait_event_lock_irq(dev->wait, !dev->ep0_req_queued,
+					    dev->lock);
+		}
+		clean_req(gadget->ep0, req);
+	}
+	spin_unlock_irq(&dev->lock);
+
+	if (req)
+		usb_ep_free_request(gadget->ep0, req);
+
 	gadget->ep0->driver_data = NULL;
 	set_gadget_data (gadget, NULL);
 
-	/* we've already been disconnected ... no i/o is active */
-	if (dev->req)
-		usb_ep_free_request (gadget->ep0, dev->req);
 	DBG (dev, "%s done\n", __func__);
 	put_dev (dev);
 }
@@ -1816,11 +1881,13 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
 	get_dev (dev);
 
 	/* preallocate control response and buffer */
+	dev->ep0_req_queued = false;
 	dev->req = usb_ep_alloc_request (gadget->ep0, GFP_KERNEL);
 	if (!dev->req)
 		goto enomem;
-	dev->req->context = NULL;
-	dev->req->complete = epio_complete;
+	dev->req->context = dev;
+	dev->req->complete = dev_req_complete;
+	dev->req->buf = dev->rbuf;
 
 	if (activate_ep_files (dev) < 0)
 		goto enomem;

-- 
Git-155)


