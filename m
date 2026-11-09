Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794203744;
	b=BYf/MSPUN93thOtZPK3SqdH83RWx+Z/p5D1+Is4Iu/h+u03e9MipeS5NFEcc1Bs/QCec
	 8xHdwQ3yK1D0rshTm0y1xj9/Wl5LyhW8hIOPMNJbklb2zZYQTj67f0MB4CIwduZNPL8bt
	 e6VmOP1Bt+fPMNgyp1CW9hexBcsl9w441Cd3qLCIiJiqJdGGosz4Kvn7AoT3dHoN2VbPL
	 W+r296bpgHCralKbHu6ucxauyKlH7m6KOAMdDuusHLlNfS5ynNoeIhPDmLksratZomq8g
	 UkcSFYE05A5nNXTVRXJq3G5xpbNtcLvXeeGIT3TG895v4ngi8P1ZDgePCovozoGegrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203744;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6OUSNSxMZsg67QBLvCHwQmVqNkeStUkNWeSYAio0bFw=;
	b=Xd2nXkPSK+gBF9YXzZeBbEUiMqPpHC/Nm2MhKmRHsuxV8JJYLn/SB+4Z/GE8vvyBld8p
	 oLUzOMCP3o7FiCEaK90cCqQSwK0D/st/EldWKclXvmh9hqjNj1P7MlEqRzVeQS6U+gehR
	 owU0je4U7sav9dcvVjtYpigUG8eaAfwKdkENig00yy0F1Fg/dRe1FA2k04xO/EAoTXJSp
	 J1+BCIrFx92GHNZVzv1ag7D2cwqeSG/JaeVNqhiM5z9spg9P4JoGy9FkMKSoZot94P5Ri
	 y6B44qIzhJLPQKHh1SA9iwZhLfPAkYQOIpIlf6xPwXcRA4rwk1Oufuiv4N70tnbLmHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UW6DQUiD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB481606A32A;
	Mon,  9 Nov 2026 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UW6DQUiD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794203743;
	b=mJHyGbBWTR+hSWQ/lI6AJ/B4r9lIrwTi/UfLEFgvuZDFkpwH+oXfhK/sY5bY53WN9Y/F
	 7HQZVzgZlrb1mT28582flLLMBt+bwJDHN0AEATJgY+V/hPhzM+sX1+Ic3au2MuC2OBN0H
	 T4mP4U6lkgEHFKW06OOMD9naHsAEdVmkwIEc77wm8q0RQCUm2TrReaUEfjmsQTjffy3rB
	 zN+CTrfy+v3QawoBRYgK9IHCehV8XlYNPygqp6d1y2W/tJkb5WhKWylfV10X/LnVD87uh
	 GfP6KYvyrJWGklpEYaAOrx4r4ha/VnTR4a2fZf2/519fPsi6sGHb3KH8DDr9Uv4u6uA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794203743;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6OUSNSxMZsg67QBLvCHwQmVqNkeStUkNWeSYAio0bFw=;
	b=rCqtwIsTymITiNW111/vswiJjidD7RaBmf9/hH13EumhbYu/e4i6XRjb2Neo1lM18J7g
	 P0iL8GA8gsgsSSFt9LEkf1ruhs8mXLg0ZndgpSKwp7Q0jMghKwuvSq+sBZotlTAO6NtDq
	 jSb1xSFvzYFMpNSLpxnM4Mt6Cr/dFg5aYuXw9zyqHa3pA6CshJ59LR41ec/wmpJ+Q+2Dx
	 KH5yhjQNs74MrsVasT10fDL6xE5owJ0QcpMA9WQWB8g3BUy27VN0qpc7R/qcXUyBv2V+4
	 VzJhYMdg8GFb2he0EKmz3xArFzp9b0ds7Cms33fewIxp6FyCDOniuNxu4Tv57P9P/FA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 132B41F0089F;
	Mon,  9 Nov 2026 05:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203743;
	bh=6OUSNSxMZsg67QBLvCHwQmVqNkeStUkNWeSYAio0bFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UW6DQUiD6YrtcpuRUACP6U5L7+Y1yF0D66vh7NZIG2A3HA0aSBAl/IQLadrXcieu1
	 b4hDQzwp/FlmfUtVqkwTmFPc/5Bq1W8CWk/tUgTc+8Hq1tGaa20Ha223kgAnWK8Aij
	 xNdNM7dnypPjrshvsmOsTLTrH14h94JNE0bQv5N+/f2zMZ+eSncFh60+zivgOigQ6O
	 ahCh21cZcxATf1I4EIwWTaoR3epFws1Z57Yf6wz8UFJ41XBWUsCrpXoQHhdj4FLQSG
	 iMgtXqMxTUaqOsptXVxrWtxtxewbF5qKqEOZq5BEfle1GLITLZotht+1Y1w36s4MPU
	 n6k1d1r0VLouA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7C30348295;
	Mon,  9 Nov 2026 05:55:41 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 13:55:39 +0800
Subject: [PATCH v5 1/3] usb: gadget: gadgetfs: fix ep0 request lifetime on
 disconnect
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
Message-Id: <20261109-b4-gadgetfs-ep0-v5-1-f16d0b648bc2@gmail.com>
References: <20261109-b4-gadgetfs-ep0-v5-0-f16d0b648bc2@gmail.com>
In-Reply-To: <20261109-b4-gadgetfs-ep0-v5-0-f16d0b648bc2@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neill Kapron <nkapron@google.com>
Cc: Jing Lin <kayano050408@gmail.com>, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794203739; l=13085;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=T+EewESsLpTheAavrmZE/3zf4CnpZRva/EsRTBgSYfI=;
 b=w9p6vdHpDgQDz/+3F8FL2/tVAuwgkN67gMIByHVAriwEMPd/yXlp0uG9YuRcLdCw2h9UeOp+q
 bQTOglm57q7A2TY68d4ngzMHwpUxSDLQCHc2/613NWJjNxL/snrmUPd
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=pr6i8RN1WEON1jbXPdghSglxaBSzfuJjXNGFknX//+A=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/default with
 auth_id=1441
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

gadgetfs_unbind() frees the preallocated ep0 request after disconnecting
the gadget, assuming that no I/O remains active.

With dummy_hcd, disconnecting does not necessarily drain ep0, so a delayed
userspace response can leave dev->req queued when it is freed.  This
triggers the warning in dummy_free_request() and a use-after-free when
dummy_udc_stop() subsequently drains the endpoint queue.

gadgetfs_setup() and the userspace copy helpers also race on dev->req and
req->buf:

1. ep0_read() versus gadgetfs_setup().  A delegated control OUT request
   is queued by gadgetfs_setup() and completed by ep0_complete(), which
   leaves the payload in dev->req->buf and sets setup_out_ready.
   ep0_read() copies that payload with copy_to_user() after dropping
   dev->lock, so the copy can fault and sleep.  If a new control transfer
   arrives during that window, gadgetfs_setup() reuses dev->req for it;
   for example, GET_DESCRIPTOR(config) points req->buf at dev->config.
   When ep0_read() resumes, clean_req() frees whatever req->buf points to
   at that moment, which is now dev->config.  The following
   GET_DESCRIPTOR(config) dereferences the freed descriptor.

2. ep0_write() versus gadgetfs_setup().  For a delegated control IN
   request, ep0_write() prepares dev->req and copies the response from
   userspace with copy_from_user() after dropping dev->lock.  A control
   request that arrives during that copy can point req->buf at dev->dev
   or dev->config, so the userspace copy overwrites a descriptor buffer,
   or it can reset req->buf to dev->rbuf, so the request is queued with
   the wrong buffer.  Completion then calls clean_req() on the wrong
   object.

Copy completed control OUT payloads into a separate setup_buf in
ep0_complete(), copy control IN payloads from userspace into a stack
buffer before preparing dev->req in ep0_write(), and reset req->buf when
control transfers finish.  Track whether dev->req is queued, reject reuse
while it is queued, and dequeue it without dev->lock before freeing it in
gadgetfs_unbind().

Return to STATE_DEV_CONNECTED when a delegated data read is aborted by a
new setup, so that the following event read is not misdirected into the
control data path.

The setup() callback runs in interrupt context and may not sleep, so a
mutex cannot be used to serialize it against ep0_read() and ep0_write().
The shared request state is protected by dev->lock and the payloads are
handed off through private buffers instead.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Reported-by: syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c73e1942197af9f54ca3
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 146 ++++++++++++++++++++++++++++----------
 1 file changed, 108 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 7f6d84601..e9380538e 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -140,6 +140,8 @@ struct dev_data {
 					setup_abort : 1,
 					gadget_registered : 1;
 	unsigned			setup_wLength;
+	unsigned int			setup_out_len;
+	bool				ep0_req_queued;
 
 	/* the rest is basically write-once */
 	struct usb_config_descriptor	*config, *hs_config;
@@ -153,6 +155,7 @@ struct dev_data {
 
 	/* except this scratch i/o buffer for ep0 */
 	u8				rbuf[RBUF_SIZE];
+	u8				setup_buf[RBUF_SIZE];
 };
 
 static inline void get_dev (struct dev_data *data)
@@ -984,6 +987,17 @@ static inline void ep0_readable (struct dev_data *dev)
 	kill_fasync (&dev->fasync, SIGIO, POLL_IN);
 }
 
+static void dev_req_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct dev_data		*dev = ep->driver_data;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	req->buf = dev->rbuf;
+	dev->ep0_req_queued = false;
+	spin_unlock_irqrestore(&dev->lock, flags);
+}
+
 static void clean_req (struct usb_ep *ep, struct usb_request *req)
 {
 	struct dev_data		*dev = ep->driver_data;
@@ -992,30 +1006,31 @@ static void clean_req (struct usb_ep *ep, struct usb_request *req)
 		kfree(req->buf);
 		req->buf = dev->rbuf;
 	}
-	req->complete = epio_complete;
-	dev->setup_out_ready = 0;
+	req->complete = dev_req_complete;
 }
 
 static void ep0_complete (struct usb_ep *ep, struct usb_request *req)
 {
 	struct dev_data		*dev = ep->driver_data;
 	unsigned long		flags;
-	int			free = 1;
 
 	/* for control OUT, data must still get to userspace */
 	spin_lock_irqsave(&dev->lock, flags);
-	if (!dev->setup_in) {
+	dev->ep0_req_queued = false;
+	if (!dev->setup_in && dev->setup_wLength) {
 		dev->setup_out_error = (req->status != 0);
-		if (!dev->setup_out_error)
-			free = 0;
+		if (dev->setup_out_error) {
+			dev->setup_out_len = 0;
+		} else {
+			dev->setup_out_len = min_t(unsigned int, req->actual,
+						   sizeof(dev->setup_buf));
+			memcpy(dev->setup_buf, req->buf, dev->setup_out_len);
+		}
 		dev->setup_out_ready = 1;
-		ep0_readable (dev);
+		ep0_readable(dev);
 	}
 
-	/* clean up as appropriate */
-	if (free && req->buf != &dev->rbuf)
-		clean_req (ep, req);
-	req->complete = epio_complete;
+	clean_req(ep, req);
 	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
@@ -1023,12 +1038,14 @@ static int setup_req (struct usb_ep *ep, struct usb_request *req, u16 len)
 {
 	struct dev_data	*dev = ep->driver_data;
 
-	if (dev->setup_out_ready) {
+	if (dev->ep0_req_queued) {
 		DBG (dev, "ep0 request busy!\n");
 		return -EBUSY;
 	}
 	if (len > sizeof (dev->rbuf))
 		req->buf = kmalloc(len, GFP_ATOMIC);
+	else
+		req->buf = dev->rbuf;
 	if (req->buf == NULL) {
 		req->buf = dev->rbuf;
 		return -ENOMEM;
@@ -1045,6 +1062,7 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 	struct dev_data			*dev = fd->private_data;
 	ssize_t				retval;
 	enum ep0_state			state;
+	u8				tmp[RBUF_SIZE];
 
 	spin_lock_irq (&dev->lock);
 	if (dev->state <= STATE_DEV_OPENED) {
@@ -1073,13 +1091,20 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			struct usb_request	*req = dev->req;
 
 			if ((retval = setup_req (ep, req, 0)) == 0) {
+				dev->state = STATE_DEV_CONNECTED;
 				++dev->udc_usage;
+				dev->ep0_req_queued = true;
 				spin_unlock_irq (&dev->lock);
 				retval = usb_ep_queue (ep, req, GFP_KERNEL);
 				spin_lock_irq (&dev->lock);
 				--dev->udc_usage;
+				if (retval < 0) {
+					dev->ep0_req_queued = false;
+					clean_req(ep, req);
+				}
+			} else {
+				dev->state = STATE_DEV_CONNECTED;
 			}
-			dev->state = STATE_DEV_CONNECTED;
 
 			/* assume that was SET_CONFIGURATION */
 			if (dev->current_config) {
@@ -1109,25 +1134,37 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			if (retval)
 				goto done;
 
-			if (dev->state != STATE_DEV_SETUP) {
+			if (dev->setup_abort) {
+				dev->setup_abort = 0;
+				dev->state = STATE_DEV_CONNECTED;
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
+				memcpy(tmp, dev->setup_buf, len);
+				dev->setup_out_ready = 0;
+				dev->setup_out_len = 0;
 				++dev->udc_usage;
 				spin_unlock_irq(&dev->lock);
-				if (copy_to_user (buf, dev->req->buf, len))
+				if (copy_to_user(buf, tmp, len))
 					retval = -EFAULT;
 				else
 					retval = len;
 				spin_lock_irq(&dev->lock);
 				--dev->udc_usage;
-				clean_req (dev->gadget->ep0, dev->req);
 				/* NOTE userspace can't yet choose to stall */
 			}
 		}
@@ -1267,29 +1304,41 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 
 		len = min_t(size_t, len, dev->setup_wLength);
 		if (dev->setup_in) {
-			retval = setup_req (dev->gadget->ep0, dev->req, len);
+			u8	tmp[RBUF_SIZE];
+			bool	zero = len < dev->setup_wLength;
+
+			dev->state = STATE_DEV_CONNECTED;
+			spin_unlock_irq(&dev->lock);
+			if (copy_from_user(tmp, buf, len)) {
+				spin_lock_irq(&dev->lock);
+				return -EFAULT;
+			}
+			spin_lock_irq(&dev->lock);
+			if (dev->setup_abort) {
+				dev->setup_abort = 0;
+				return -EIDRM;
+			}
+			if (dev->state != STATE_DEV_CONNECTED)
+				return -ECANCELED;
+			retval = setup_req(dev->gadget->ep0, dev->req, len);
 			if (retval == 0) {
-				dev->state = STATE_DEV_CONNECTED;
+				memcpy(dev->req->buf, tmp, len);
+				dev->req->zero = zero;
 				++dev->udc_usage;
-				spin_unlock_irq (&dev->lock);
-				if (copy_from_user (dev->req->buf, buf, len))
-					retval = -EFAULT;
-				else {
-					if (len < dev->setup_wLength)
-						dev->req->zero = 1;
-					retval = usb_ep_queue (
-						dev->gadget->ep0, dev->req,
-						GFP_KERNEL);
-				}
+				dev->ep0_req_queued = true;
+				spin_unlock_irq(&dev->lock);
+				retval = usb_ep_queue(
+					dev->gadget->ep0, dev->req,
+					GFP_KERNEL);
 				spin_lock_irq(&dev->lock);
 				--dev->udc_usage;
 				if (retval < 0) {
+					dev->ep0_req_queued = false;
 					clean_req (dev->gadget->ep0, dev->req);
 				} else
 					retval = len;
-
-				return retval;
 			}
+			return retval;
 
 		/* can stall some OUT transfers */
 		} else if (dev->setup_can_stall) {
@@ -1483,6 +1532,10 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	}
 
 	spin_lock (&dev->lock);
+	if (dev->ep0_req_queued) {
+		spin_unlock(&dev->lock);
+		return -EBUSY;
+	}
 	dev->setup_abort = 0;
 	if (dev->state == STATE_DEV_UNCONNECTED) {
 		if (gadget_is_dualspeed(gadget)
@@ -1618,6 +1671,7 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			dev->setup_wLength = w_length;
 			dev->setup_out_ready = 0;
 			dev->setup_out_error = 0;
+			dev->setup_out_len = 0;
 
 			/* read DATA stage for OUT right away */
 			if (unlikely (!dev->setup_in && w_length)) {
@@ -1627,12 +1681,14 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 					break;
 
 				++dev->udc_usage;
+				dev->ep0_req_queued = true;
 				spin_unlock (&dev->lock);
 				value = usb_ep_queue (gadget->ep0, dev->req,
 							GFP_KERNEL);
 				spin_lock (&dev->lock);
 				--dev->udc_usage;
 				if (value < 0) {
+					dev->ep0_req_queued = false;
 					clean_req (gadget->ep0, dev->req);
 					break;
 				}
@@ -1663,21 +1719,26 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	if (value >= 0 && dev->state != STATE_DEV_SETUP) {
 		req->length = value;
 		req->zero = value < w_length;
+		req->complete = dev_req_complete;
 
 		++dev->udc_usage;
+		dev->ep0_req_queued = true;
 		spin_unlock (&dev->lock);
 		value = usb_ep_queue (gadget->ep0, req, GFP_KERNEL);
 		spin_lock(&dev->lock);
 		--dev->udc_usage;
-		spin_unlock(&dev->lock);
 		if (value < 0) {
+			dev->ep0_req_queued = false;
+			req->buf = dev->rbuf;
 			DBG (dev, "ep_queue --> %d\n", value);
 			req->status = 0;
 		}
+		spin_unlock(&dev->lock);
 		return value;
 	}
 
 	/* device stalls when value < 0 */
+	req->buf = dev->rbuf;
 	spin_unlock (&dev->lock);
 	return value;
 }
@@ -1771,6 +1832,7 @@ static void
 gadgetfs_unbind (struct usb_gadget *gadget)
 {
 	struct dev_data		*dev = get_gadget_data (gadget);
+	bool			queued;
 
 	DBG (dev, "%s\n", __func__);
 
@@ -1781,15 +1843,21 @@ gadgetfs_unbind (struct usb_gadget *gadget)
 		usleep_range(1000, 2000);
 		spin_lock_irq(&dev->lock);
 	}
+	queued = dev->ep0_req_queued;
 	spin_unlock_irq (&dev->lock);
 
+	if (dev->req) {
+		if (queued)
+			usb_ep_dequeue(gadget->ep0, dev->req);
+		clean_req(gadget->ep0, dev->req);
+		usb_ep_free_request(gadget->ep0, dev->req);
+		dev->req = NULL;
+	}
+
 	destroy_ep_files (dev);
 	gadget->ep0->driver_data = NULL;
 	set_gadget_data (gadget, NULL);
 
-	/* we've already been disconnected ... no i/o is active */
-	if (dev->req)
-		usb_ep_free_request (gadget->ep0, dev->req);
 	DBG (dev, "%s done\n", __func__);
 	put_dev (dev);
 }
@@ -1816,11 +1884,13 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
 	get_dev (dev);
 
 	/* preallocate control response and buffer */
+	dev->ep0_req_queued = false;
 	dev->req = usb_ep_alloc_request (gadget->ep0, GFP_KERNEL);
 	if (!dev->req)
 		goto enomem;
 	dev->req->context = NULL;
-	dev->req->complete = epio_complete;
+	dev->req->complete = dev_req_complete;
+	dev->req->buf = dev->rbuf;
 
 	if (activate_ep_files (dev) < 0)
 		goto enomem;

-- 
Git-155)


