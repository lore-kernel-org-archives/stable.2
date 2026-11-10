Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794284017;
	b=3zONmkMDVov8FE74SstBPT6rwq37NKVsZhtBxuf1FW1z0CknoHh0CKHOYXhC+JYttF/y
	 a5FUsYuZ0EX/6Q3QOlm9xq7/cpwlLqYtILA0gS1re+aafKCJHseOkjYfniVgURGGgHp1a
	 VWFzySH2psbo111QeUVhsjED/8bbZJOAjzwxb6uptXvoGw6JKImp/lLOOcDmrqgw4rZGP
	 wxTH20FEb24bkI9yzFlctkBDwLvr1IB8yDBVpyYtoIRSNxgYKMnavn2hXNeBsehjJU/go
	 YfpJSmmBAnif/j3eUeM+/OK0TkEQtkjZwVWo4e18JJd3UzeE64mjWMv13Fbj2BEIjaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284017;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qzeQKFBbRu5kOEu8S3kxSqYM+utJe0klGg2LKpdGEq4=;
	b=GSoWunS3472Yw/UWIu9RZHokERhZ5Ck/KWkS48qgATpaWvKzWJqaUpqq471It5rGSRIR
	 BWee1Ib5RaroCEp312IZPOUg0NNQNf7U/NvMBSy/3hCl/ZAMwp4J1WKG5SRl6VQ2XtJ1Z
	 yWs9sDxNzMhjStI6Ljqo5ebRj5zxKggo2Sre/PBUc70qehhNnZ1lA9PFF0LYnV6WKl0bX
	 aO8S0Rxx//MKsYOQq3tF3qwrIq3jjdRUkrJSHDLWWJbOB0CokCilbMJcjov7n4DX+i0g3
	 q60HczYtPjGdMkfntgzXRJIvgY4m91Or1xzZJDOuLk907Bz8/THfWxYryTm/H5QlNjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQ8QRIwI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6985D606A32A;
	Tue, 10 Nov 2026 04:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQ8QRIwI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794284006;
	b=Ja6L7kiNOm/VsmTVddaJz9ek5CB/j+fIRr2TRchqNKzslEfuYyCnXGrdy6moAsIcr9ud
	 qa1XxqBcE65mkpvh0JqLWn6rUasbCU+dqJT+1FC8DhZ9ooS053ZcO+1NcIHZE5t32GAQG
	 42ZxWVytZxlGP6mg8jAsOWEX1tzT7ejIRygPy9ZhHMMiVMr+wymAvcm3paAtlHuDdVzWh
	 cU7oNGlikFgzp1tAHdNYH5YH2mBaGBYyOj14oG1XA0rweIol95eX7RL7s7oZA2QPe0h68
	 56h2+QvA1eXyFvC+puo1HLNUkCYlSGWJPqXoKPz/D66MzLZqDur+x5XjJM8eKjWEO0A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794284006;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qzeQKFBbRu5kOEu8S3kxSqYM+utJe0klGg2LKpdGEq4=;
	b=r10l0i2rPx0noV6w07JAesBBg5lyr/ddt1aaLtltlOOLEVQmbESvPNwiEOqoDkj2dK/y
	 8z3R+Lh23E36yWyaRvutie7GHX+fABEqsZykXKz1TzxTj3kmkwdhwC+5A/owe0WNIMFTh
	 NvdP0XLGnfZQ6aaqcl9zIgmEizFBGsXWUGFJjlpzxARH4dVW4R3prFsYAl526aj289S9L
	 4wmjbtrOJJ+VxzEBhWPIYrCmdcfISHv3kX44QNE4v6q8E1PxgU/azri74BVBSHbzuKBA/
	 I3KVIV4ZA83U7viCVn7OyQmBPV5TnfDL+kivN9Y/aKC/ygynmqin9Pru2Pc7LX0IvCA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E6F081F008A3;
	Tue, 10 Nov 2026 04:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284006;
	bh=qzeQKFBbRu5kOEu8S3kxSqYM+utJe0klGg2LKpdGEq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CQ8QRIwIeGC/KgPlhe6QTGMsuUlqNo1gGJjpaz5erTVo8J0cRHRmsj4GBaJ3N9eV/
	 gBqgQnhdGncmDxDS0vE702JR0VvJm3FmXp/I+FgxX+EYu+lTMI+xSKjdwMqZ976BCi
	 R/7pT2vmRoN/JIKTxVAvpuNNkvYaSQV+BYhVEPEteOSmYOpz1G0dhyVgkOrHX/kokA
	 PUKJ7lm5YpuBBxc+o2UmrB7NlO3klhdCK2M3gbDsn+14aMVsik5l4g3ZUMMIKG19B2
	 TAT+0FgftabPX3qSI8cDYahq8Y/UK6GQuW0LSK6wQVmI4sKrX8ZAxSYGoTPzwBwSN/
	 bEzQfHhNo0TxQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 731F448818;
	Tue, 10 Nov 2026 04:13:24 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 12:13:22 +0800
Subject: [PATCH v8 1/4] usb: gadget: gadgetfs: fix ep0 request lifetime and
 buffer races
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
Message-Id: <20261110-gadgetfs-ep0-v8-v8-1-8f90434574fe@gmail.com>
References: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
In-Reply-To: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jing Lin <kayano050408@gmail.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794284002; l=15583;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=KoJVHpSK0gRdihXKoaSLuKDSCE5sJYs4jomQmSeT68E=;
 b=1fPU/4UyQ3NR9tjhBnOxDeUpt2BO8Xmo2EoRE0xRrkD3pmJl+1aX04Z3wwWE+zry5gDmoEaFB
 8UE14hNolkID+VBxtTL2tDyzMCsFMpdv/jSw16mxUdzcIDpzbDb3Qr8
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

With controllers such as dummy_hcd, disconnecting does not necessarily
drain ep0, so a delayed userspace response can leave dev->req queued
when it is freed.  This triggers the warning in dummy_free_request() and
a use-after-free when dummy_udc_stop() subsequently drains the endpoint
queue.

gadgetfs_setup() and the userspace copy helpers also race on dev->req
and req->buf:

1. ep0_read() versus gadgetfs_setup().  A delegated control OUT request
   is queued by gadgetfs_setup() and completed by ep0_complete(), which
   leaves the payload in dev->req->buf and sets setup_out_ready.
   ep0_read() copies that payload with copy_to_user() after dropping
   dev->lock, so the copy can fault and sleep.  If a new control
   transfer arrives during that window, gadgetfs_setup() reuses dev->req
   for it; for example, GET_DESCRIPTOR(config) points req->buf at
   dev->config.  When ep0_read() resumes, clean_req() frees whatever
   req->buf points to, which is now dev->config.

2. ep0_write() versus gadgetfs_setup().  For a delegated control IN
   request, ep0_write() prepares dev->req and copies the response from
   userspace with copy_from_user() after dropping dev->lock.  A control
   request that arrives during that copy can point req->buf at dev->dev
   or dev->config, so the userspace copy overwrites a descriptor buffer,
   or reset req->buf to dev->rbuf so completion calls clean_req() on the
   wrong object.

Copy completed control OUT payloads into a private setup_buf in
ep0_complete(), copy control IN payloads into a stack buffer before
preparing dev->req and leaving STATE_DEV_SETUP in ep0_write(), and track
buffers allocated by setup_req() separately in dev->ep0_req_buf so
clean_req() never frees descriptor storage.  Ignore zero-length reads
while a non-zero control OUT data stage is pending so they cannot queue
a status request early and clobber setup_out_len.

Submit ep0 requests through a shared queue_ep0_req() helper that tracks
dev->ep0_req_queued and wakes dev->wait whenever the flag clears.  In
gadgetfs_unbind(), tear down non-ep0 endpoints first, then dequeue any
active ep0 request and wait under dev->lock with wait_event_lock_irq()
for completion to finish.  If the controller rejects ep0 dequeue, keep a
reference on dev and let the completion handler free the request when
udc_stop() drains ep0.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Reported-by: syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c73e1942197af9f54ca3
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 266 +++++++++++++++++++++++++++-----------
 1 file changed, 188 insertions(+), 78 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 7f6d84601..1e7e8f4bb 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -140,6 +140,10 @@ struct dev_data {
 					setup_abort : 1,
 					gadget_registered : 1;
 	unsigned			setup_wLength;
+	unsigned int			setup_out_len;
+	bool				ep0_req_queued;
+	bool				ep0_req_free;
+	void				*ep0_req_buf;
 
 	/* the rest is basically write-once */
 	struct usb_config_descriptor	*config, *hs_config;
@@ -153,6 +157,7 @@ struct dev_data {
 
 	/* except this scratch i/o buffer for ep0 */
 	u8				rbuf[RBUF_SIZE];
+	u8				setup_buf[RBUF_SIZE];
 };
 
 static inline void get_dev (struct dev_data *data)
@@ -984,54 +989,89 @@ static inline void ep0_readable (struct dev_data *dev)
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
+	/*
+	 * req->buf may also point into dev->buf, which holds the
+	 * descriptors; only the buffer allocated by setup_req() belongs
+	 * to the request and may be freed here.
+	 */
+	kfree(dev->ep0_req_buf);
+	dev->ep0_req_buf = NULL;
+	req->buf = dev->rbuf;
+	req->complete = dev_req_complete;
+}
+
+static void complete_ep0_req(struct usb_ep *ep, struct usb_request *req,
+			     struct dev_data *dev, unsigned long flags)
+{
+	bool			free_req = dev->ep0_req_free;
+
+	clean_req(ep, req);
+	dev->ep0_req_queued = false;
+	dev->ep0_req_free = false;
+	wake_up(&dev->wait);
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	if (free_req) {
+		usb_ep_free_request(ep, req);
+		put_dev(dev);
 	}
-	req->complete = epio_complete;
-	dev->setup_out_ready = 0;
+}
+
+static void dev_req_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct dev_data		*dev = req->context;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	complete_ep0_req(ep, req, dev, flags);
 }
 
 static void ep0_complete (struct usb_ep *ep, struct usb_request *req)
 {
-	struct dev_data		*dev = ep->driver_data;
+	struct dev_data		*dev = req->context;
 	unsigned long		flags;
-	int			free = 1;
 
 	/* for control OUT, data must still get to userspace */
 	spin_lock_irqsave(&dev->lock, flags);
-	if (!dev->setup_in) {
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
-	spin_unlock_irqrestore(&dev->lock, flags);
+	complete_ep0_req(ep, req, dev, flags);
 }
 
 static int setup_req (struct usb_ep *ep, struct usb_request *req, u16 len)
 {
 	struct dev_data	*dev = ep->driver_data;
 
-	if (dev->setup_out_ready) {
+	if (dev->ep0_req_queued) {
 		DBG (dev, "ep0 request busy!\n");
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
@@ -1039,12 +1079,42 @@ static int setup_req (struct usb_ep *ep, struct usb_request *req, u16 len)
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
 	struct dev_data			*dev = fd->private_data;
 	ssize_t				retval;
 	enum ep0_state			state;
+	u8				tmp[RBUF_SIZE];
 
 	spin_lock_irq (&dev->lock);
 	if (dev->state <= STATE_DEV_OPENED) {
@@ -1072,14 +1142,14 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			struct usb_ep		*ep = dev->gadget->ep0;
 			struct usb_request	*req = dev->req;
 
-			if ((retval = setup_req (ep, req, 0)) == 0) {
-				++dev->udc_usage;
-				spin_unlock_irq (&dev->lock);
-				retval = usb_ep_queue (ep, req, GFP_KERNEL);
-				spin_lock_irq (&dev->lock);
-				--dev->udc_usage;
+			if (dev->setup_wLength) {
+				retval = 0;
+				goto done;
 			}
+			retval = setup_req(ep, req, 0);
 			dev->state = STATE_DEV_CONNECTED;
+			if (retval == 0)
+				retval = queue_ep0_req(dev, true);
 
 			/* assume that was SET_CONFIGURATION */
 			if (dev->current_config) {
@@ -1109,25 +1179,31 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			if (retval)
 				goto done;
 
-			if (dev->state != STATE_DEV_SETUP) {
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
@@ -1267,29 +1343,28 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 
 		len = min_t(size_t, len, dev->setup_wLength);
 		if (dev->setup_in) {
-			retval = setup_req (dev->gadget->ep0, dev->req, len);
+			u8	tmp[RBUF_SIZE];
+			bool	zero = len < dev->setup_wLength;
+
+			spin_unlock_irq(&dev->lock);
+			if (copy_from_user(tmp, buf, len)) {
+				spin_lock_irq(&dev->lock);
+				return -EFAULT;
+			}
+			spin_lock_irq(&dev->lock);
+			if (dev->state != STATE_DEV_SETUP || !dev->setup_in)
+				return -ECANCELED;
+
+			retval = setup_req(dev->gadget->ep0, dev->req, len);
 			if (retval == 0) {
 				dev->state = STATE_DEV_CONNECTED;
-				++dev->udc_usage;
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
-				spin_lock_irq(&dev->lock);
-				--dev->udc_usage;
-				if (retval < 0) {
-					clean_req (dev->gadget->ep0, dev->req);
-				} else
+				memcpy(dev->req->buf, tmp, len);
+				dev->req->zero = zero;
+				retval = queue_ep0_req(dev, true);
+				if (retval == 0)
 					retval = len;
-
-				return retval;
 			}
+			return retval;
 
 		/* can stall some OUT transfers */
 		} else if (dev->setup_can_stall) {
@@ -1483,6 +1558,10 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	}
 
 	spin_lock (&dev->lock);
+	if (dev->ep0_req_queued) {
+		spin_unlock(&dev->lock);
+		return -EBUSY;
+	}
 	dev->setup_abort = 0;
 	if (dev->state == STATE_DEV_UNCONNECTED) {
 		if (gadget_is_dualspeed(gadget)
@@ -1509,7 +1588,6 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 		dev->setup_abort = 1;
 
 	req->buf = dev->rbuf;
-	req->context = NULL;
 	switch (ctrl->bRequest) {
 
 	case USB_REQ_GET_DESCRIPTOR:
@@ -1618,24 +1696,18 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			dev->setup_wLength = w_length;
 			dev->setup_out_ready = 0;
 			dev->setup_out_error = 0;
+			dev->setup_out_len = 0;
 
 			/* read DATA stage for OUT right away */
 			if (unlikely (!dev->setup_in && w_length)) {
-				value = setup_req (gadget->ep0, dev->req,
-							w_length);
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
@@ -1663,21 +1735,19 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
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
+	req->buf = dev->rbuf;
 	spin_unlock (&dev->lock);
 	return value;
 }
@@ -1771,6 +1841,7 @@ static void
 gadgetfs_unbind (struct usb_gadget *gadget)
 {
 	struct dev_data		*dev = get_gadget_data (gadget);
+	struct usb_request	*req;
 
 	DBG (dev, "%s\n", __func__);
 
@@ -1784,12 +1855,48 @@ gadgetfs_unbind (struct usb_gadget *gadget)
 	spin_unlock_irq (&dev->lock);
 
 	destroy_ep_files (dev);
+
+	spin_lock_irq(&dev->lock);
+	req = dev->req;
+	dev->req = NULL;
+	if (req) {
+		if (dev->ep0_req_queued) {
+			int ret;
+
+			spin_unlock_irq(&dev->lock);
+			ret = usb_ep_dequeue(gadget->ep0, req);
+			spin_lock_irq(&dev->lock);
+			if (!dev->ep0_req_queued || ret == 0) {
+				/*
+				 * usb_ep_dequeue() may return before the
+				 * completion routine runs; wait under
+				 * dev->lock so completion finishes first.
+				 */
+				wait_event_lock_irq(dev->wait,
+						    !dev->ep0_req_queued,
+						    dev->lock);
+			} else {
+				/*
+				 * Some UDCs cannot dequeue ep0 requests and
+				 * drain ep0 in udc_stop() after unbind()
+				 * returns; let completion free req then.
+				 */
+				dev->ep0_req_free = true;
+				get_dev(dev);
+				req = NULL;
+			}
+		}
+		if (req)
+			clean_req(gadget->ep0, req);
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
@@ -1816,11 +1923,14 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
 	get_dev (dev);
 
 	/* preallocate control response and buffer */
+	dev->ep0_req_queued = false;
+	dev->ep0_req_free = false;
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


