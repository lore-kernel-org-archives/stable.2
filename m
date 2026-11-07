Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794055577;
	b=Hv/uBgux4Avw0Q9Dt9kpVwulLJDZfC/agBAytDnl5MyY3AeK9vz3xCBXQiJMqPL4yvEG
	 vmifUdjH7j7YAFG9MM0QHUOekJCNCTRbqrEGcaJMdjMd2vGXTiNodTqajSvVyJxRFyk8h
	 NqzohNob4FREfYEpp+HsLjLgjHGLuAxiD2GCM8mZsos+GOvzCgpbqF6suBwjOdsBwWrJG
	 N1jYzoNZX5mFgp+TCII+Ghlvnq+vmTIVijElzhLKX5Xd9gcik91QzIuoveNmSCiwH/0kT
	 k420IUVNQaHdHac9UpMdSp3azErl/P1YTHKB2ntQsl0/UJKMAZLo+figJdC33/jqAng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055577;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4mMo7011NcpInl6+4G96ilpKFOyPXZHMuVK7Jy2KF8s=;
	b=yJXdD4VEmL1KoPa7wKTM2nSlgp6GImTZBljVQPY5pfsx/cOaspzsAlb7wTPF5XZz9K1/
	 K7AVwPRgC/4utGpKwjA6g+ZxYGxkdTUClqyYKi9NdcodpcYkQ0ozYnXx4KZdsVG1/VqDL
	 hMzEdSC8kZ94Hw9LMpN/zuB1y+pjeK94eRpyM3H9x7grxDqEVCVj3U32/CDcUiXdZ2I6z
	 cvD9X748NqdVVFO7jRCQj2B5iI5EjyrO2mKHuFJBbc9xO/Jcw9sJeXe5OCzAVsKWi7B89
	 HyqO6vcg3HRF0STsFFTo5301p8wekzl3wGv+G+b2oeUUTrom7GB9vbDOnaBm22qO1Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Be+F4JcX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C880C606A33A;
	Sat,  7 Nov 2026 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Be+F4JcX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794055576;
	b=A6Ptl5HMTeX2j+brATF0+6Bm41GBmDkkP+Su5hmVrrNBTUsVtaObnXvyy0RtV+6BC/PH
	 5onpJJTOU7fkky1Vo5xZgoYJra+BOqOp3kOwbBvrdz+G+aHTZNMBxw6fiXI1qITe4JJIw
	 TbqIZIGLF4ApU5tg2BT44ykuuTW6W0mry65JfDKrXM3TuKKnMmXHuhuBitaWhVyWHBrDp
	 41MFaoDr+wxioSlmIau6KyDMmgrpKMctpY5e86kFLQsQLdOWxvWrOszQ9aaXdQlkDGxnf
	 8l1A8M7qy+A5EMMycqlCDg3dKBT8AL+xhU4s1sAsB5PX3QBofwiB6mVIyVuSZqR0C6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055576;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4mMo7011NcpInl6+4G96ilpKFOyPXZHMuVK7Jy2KF8s=;
	b=HEm6vpU0Q4KoN48AWS/ZwYh6Jcnn9FaozDDVnSTaMslXPQ3OFJZeS1495SgunbX0NI2m
	 fdnsOM9U5KJlmuHLVxkgzxbyEztSHsNqNvsgugozTCqjLNqbL5GBomg83FWWe1VTnoJ+e
	 kOgilkx8RE4+q/YUiITXZsyqOhstxzFv1sXMXQNixFSDWPINLYz5FUFc87tKMaMFZFjfY
	 yDoAIkJxZs83KNbPfND+4O0U5/mf7PcgZGIOo8sWkYwFTHFy0Hrw6ln2QnnTt9VXey8Y4
	 6KZNW/vKosEgz11cXG7Zybny5oy3j5PEpb3iVr92Yo2S7YYSLdlrPXkcWObgtYG/zJA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3B59D1F008BC;
	Sat,  7 Nov 2026 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794055576;
	bh=4mMo7011NcpInl6+4G96ilpKFOyPXZHMuVK7Jy2KF8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Be+F4JcXjigKCFmYzSwEL+sJS3VyWl3SI2zthFwUf2iDyyTsjyL8bOQ9q59o3w0D4
	 oYJVFkcRWg0cI6d0h09ExCzuKMEVDbz4pHJal8G29q/XL6e2pcB0NCd0L7l6mf/Tof
	 pnt3kDK4w6Bl16H0QFIXJV8xZLu9d6p3SVkvlPF0VUDjZM5Ngaz3Ygj7nu77q2RY9Z
	 1reYyyO20MpBvFxYcQL/VYk92eq5TH8InTwDKmAVRA/4T8StdBb34P2p8LUBFj6pPe
	 v9LNk5AOys9VL8GrzCSc6Xj+gqnjj5UM/FLS4OvGeHI2dVnKbYFwAQgrzCXiRABlOf
	 59TwWKqPKNUmw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A630447BF7;
	Sat,  7 Nov 2026 12:46:14 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:46:13 +0900
Subject: [PATCH v4 1/2] usb: gadget: gadgetfs: fix ep0 request lifetime on
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
Message-Id: <20261107-b4-gadgetfs-ep0-v4-1-86bdfd684b54@gmail.com>
References: <20261107-b4-gadgetfs-ep0-v4-0-86bdfd684b54@gmail.com>
In-Reply-To: <20261107-b4-gadgetfs-ep0-v4-0-86bdfd684b54@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794055573; l=11648;
 i=kayano050408@gmail.com; s=20261106-gadgetfs-gmail;
 h=from:subject:message-id;
 bh=zpQOHmlQwRjGrBepJrO84PIIdbA+Tl6x07uSNmmbWB8=;
 b=y/yXeU+hG/a855w85SqVRHROHpJWBAAx+RScz5tmAqh5ZQqe5z2QaObX7+98Idg+K2TTQI214
 Nd2ZB43AzX5BEuPXCcvZ8ZQlghvIOqwxPbdRMG1MW8NJqI8c523P/ZC
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=DtAI52kU3F0sVbAiS4n+5b4UKMnVF398eKHlj3H9KBY=
X-Endpoint-Received: by B4 Relay for
 kayano050408@gmail.com/20261106-gadgetfs-gmail with auth_id=1433
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

gadgetfs_unbind() frees the preallocated ep0 request after disconnecting
the gadget, assuming that no I/O remains active.

With dummy_hcd, disconnecting does not necessarily drain ep0, so a delayed
userspace response can leave dev->req queued when it is freed. This
triggers the warning in dummy_free_request() and a use-after-free when
dummy_udc_stop() subsequently drains the endpoint queue.

gadgetfs_setup() and ep0_write() can also race on dev->req and req->buf
while a control transfer is in flight or while a completed delegated OUT
transfer is waiting for ep0_read() to copy the payload to userspace.
Overwriting req->buf with a descriptor pointer causes clean_req() to free
the descriptor buffer instead of the request buffer.

Copy completed control OUT payloads into a separate setup_buf in
ep0_complete(), copy control IN payloads from userspace into a stack
buffer before preparing dev->req in ep0_write(), and reset req->buf when
control transfers finish. Track whether dev->req is queued, reject reuse
while it is queued, and dequeue it without dev->lock before freeing it in
gadgetfs_unbind().

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Reported-by: syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c73e1942197af9f54ca3
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 145 ++++++++++++++++++++++++++++----------
 1 file changed, 107 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 7f6d84601..31fc83427 100644
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
@@ -1109,25 +1134,36 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			if (retval)
 				goto done;
 
-			if (dev->state != STATE_DEV_SETUP) {
+			if (dev->setup_abort) {
+				dev->setup_abort = 0;
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
@@ -1267,29 +1303,41 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 
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
@@ -1483,6 +1531,10 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	}
 
 	spin_lock (&dev->lock);
+	if (dev->ep0_req_queued) {
+		spin_unlock(&dev->lock);
+		return -EBUSY;
+	}
 	dev->setup_abort = 0;
 	if (dev->state == STATE_DEV_UNCONNECTED) {
 		if (gadget_is_dualspeed(gadget)
@@ -1618,6 +1670,7 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			dev->setup_wLength = w_length;
 			dev->setup_out_ready = 0;
 			dev->setup_out_error = 0;
+			dev->setup_out_len = 0;
 
 			/* read DATA stage for OUT right away */
 			if (unlikely (!dev->setup_in && w_length)) {
@@ -1627,12 +1680,14 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
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
@@ -1663,21 +1718,26 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
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
@@ -1771,6 +1831,7 @@ static void
 gadgetfs_unbind (struct usb_gadget *gadget)
 {
 	struct dev_data		*dev = get_gadget_data (gadget);
+	bool			queued;
 
 	DBG (dev, "%s\n", __func__);
 
@@ -1781,15 +1842,21 @@ gadgetfs_unbind (struct usb_gadget *gadget)
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
@@ -1816,11 +1883,13 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
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


