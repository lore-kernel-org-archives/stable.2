Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675041;
	b=TvmJHeT+tRW8pJIkqYXVZht5jXsnVt1G0a3sEKk+SQFP4z0yWpKWq+ZLZETRcLeLuTjT
	 fxcVUQ37MVVltUIaIJM/8Pg4UJ+3sqG5N1IErE2VA2EcHt2lh/zg/zeDH2vjKAT9KdVP5
	 K9f6XgS1lOWududuKrZJIajYlMB9CptAY53ZCBk6sfZnWG9lhKHLzGvfnZ85eeBYfW2Jt
	 owe3PK5gL3yxGY1sJPUHhi/O/2fmFXxKy4m3MV5m/t+JCVQOaErb1/lrCSBQ8TzUkgkxO
	 Oy9y81TxmVS4+CTn1w4IQJ+vp6eH/ZcX2E4V1ldPUQhsfWW7slR/urrqKdSfnLF9ncw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675041;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AirZcCYAhOiqqs98NS20LD0UwX1RkFduFDMrs8r1xYc=;
	b=jDEe9NG9HkqDVlJtiFniX1cJ0E2Opfc9MULrZnS8OM4wnx+v0qJLcNNe1Tfji36Ga9gx
	 Hh3vgxMALUJr04gaWWdxNXlnZ0SG1S/hhASZR0/vnEluwaHY0IXXiJpjDt/oxhgtWZrKs
	 33afyQ4KDZqBXB6LPZjGB2/8nb7rPvia5gsFWXENJpAEzqiMVTxiJ4YdHeWZUyidsTIxo
	 ol5s00PF/8fz1dBlST6qFzE7RcY4IG3c6fXPsnogNdRbAlFk0iufIBdNxvV40aGKPaoG7
	 tgV9Kzl6zbMU+b0UWhYgKAv40qxWlJLRLlKeCIikXxhFUyZWurvhekI7Ub13zSbNRcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxJyiNEx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E6D606A684;
	Thu, 26 Nov 2026 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxJyiNEx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795675041;
	b=JGj0seF8zsrJW3teeC1Z4np08q1v/Usjdb8uFO+J1Nyx9fSpBrSB045ksiPfc4mwqBBB
	 xLYx3kkRMdG54y/zMcYdY6z07esP9Q/UtKeBPENzpTyZpWZBzHZlhk2nnwpt4E4qa4xGy
	 pb0WEoV4wr5TJCOxTwakwQkxvCff3FienOz3ruWy01nGEBy7rvTTtJGxopD35epO4SMTs
	 E7eazsmftXl1j+0zlbhxwerVrIuN6ZzJVG9Y9QCWPs8p60CzZeu8lkHP0vw3QpXbviaF9
	 4t2vITvEF3wYM50ONNB165qVglYuh+vy2jVmlROXEjAm8KUh1ShW42mRIh2FVQwIYvw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675041;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AirZcCYAhOiqqs98NS20LD0UwX1RkFduFDMrs8r1xYc=;
	b=mpw8S7++GO63/3T/R1UpLrnUWjhjyxzy65pVfia5w7cSZmW5e4ywhM1e6lYLJifAf/4x
	 6mjLckEgHeFlwCy5ziQtiyJs7ODiX0b8v8kV7xanRRPPdpJgZOsoX9WqHtUpayyJCf2Ve
	 vs3RccvLj/4cL1IGkSdSRfla/z5NrdMQ5X1bvqFkkk+PGeC+4VJlFKTMhuaD3GEO0gWxi
	 Ywn6pzj+tZD3674oKY1aah+nT8WrZEccMPHs4clbhk3IXCm0O7Oy+wIANWFCtH9D8K9HG
	 FSw3/F+SR1eJ3iasYqYM6Ier92/2y54gwlaWiMgyDR7gQHUi4Ly0y0VdHnimjR5Ab9g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8CD471F000CA;
	Thu, 26 Nov 2026 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675041;
	bh=AirZcCYAhOiqqs98NS20LD0UwX1RkFduFDMrs8r1xYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RxJyiNExXq2T44/gOzoeN2Y1X5pMWyZVoKTkAxIH4shC/WyZ6BGI8rmkr63KsBUmV
	 vikAAt+K/P4WSNZfFCe6UwhenGXkpJ7B8cp8Va7iWFukx8GSMhcoDh89ucVWJ0iEew
	 9tly/eHJt5b3C8mIqGgaB3ge/KJkMtnM+Y+bctOMm3LvqLbVmZG4aZJVcdVeaasz2C
	 zn8cRKmU+6mGH25GJOX/jj92v0A7Yt7t2GBkvtoV16HA2iR5/pJlfKnRBm9H/dUtCs
	 YaXZLzlB5Vz7Pqgf7R/KNkB4GdE5XBJRy1VP/l27RUrtsCROfkscSdEAr62cqZt+ij
	 blBv8wFGdpDuw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1EFE34D295;
	Thu, 26 Nov 2026 06:37:07 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:37:06 +0800
Subject: [PATCH v9 3/6] usb: gadget: gadgetfs: fix ep0 setup_abort tracking
 and reporting
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
Message-Id: <20261126-gadgetfs-ep0-v9-3-81b464c6e641@gmail.com>
References: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
In-Reply-To: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795675025; l=8073;
 i=kayano050408@gmail.com; s=20261126; h=from:subject:message-id;
 bh=wDQtIk5OzzL/YProskk/THeKk2QZ9dJHqaVAYLqAO/A=;
 b=UxUzVxwfxOcL4fpPdtF5YJDS1b6VgyhTu8eYYIvKjdcjDBjNR/j545KpKgEsjGG8xSF8v07Ar
 3kW/TwYxq1IAWETUaUZUIp/krtAWiBZwMy2VinT2sJ13cbsBixqDmx2
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=40M3hugIx++9w3nkAoFXGcN/vLWsPMGDYdbduV+lUlI=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/20261126 with
 auth_id=1648
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

Several ep0 state transitions lose setup_abort notifications or leave
dev->state stuck in STATE_DEV_SETUP:

1. ep0_poll() clears dev->setup_abort when reporting EPOLLHUP, so the
   following ep0_read() or ep0_write() never sees -EIDRM.

2. gadgetfs_disconnect() sets dev->state to STATE_DEV_UNCONNECTED before
   calling next_event(GADGETFS_DISCONNECT), skipping the STATE_DEV_SETUP
   check that sets dev->setup_abort.

3. gadgetfs_setup() skips setting dev->setup_abort on early returns,
   leaves an uncollected GADGETFS_SETUP event queued when a non-delegated
   request supersedes it, and leaves dev->state in STATE_DEV_SETUP when
   aborting an active delegated transfer so in-kernel responses are not
   queued.

Report EPOLLHUP in ep0_poll() without clearing setup_abort, consume
setup_abort via ep0_check_abort() in ep0_read() and ep0_write(), update
dev->state after next_event() in gadgetfs_disconnect(), and discard any
stale GADGETFS_SETUP event and record setup_abort at the start of
gadgetfs_setup().

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 101 ++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index a0dc350a7a0d..4915906d782c 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1096,6 +1096,23 @@ static int queue_ep0_req(struct dev_data *dev, bool process_ctx)
 	return ret;
 }
 
+/*
+ * Consume a pending setup abort and report it to userspace.  Called with
+ * dev->lock held.  Return to the connected state so that the next event
+ * read is not misdirected into the control data path, without overwriting
+ * a state that disconnect or unbind already changed.
+ */
+static bool ep0_check_abort(struct dev_data *dev)
+{
+	if (!dev->setup_abort)
+		return false;
+
+	dev->setup_abort = 0;
+	if (dev->state == STATE_DEV_SETUP)
+		dev->state = STATE_DEV_CONNECTED;
+	return true;
+}
+
 static ssize_t
 ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 {
@@ -1110,8 +1127,7 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 	}
 
 	/* report fd mode change before acting on it */
-	if (dev->setup_abort) {
-		dev->setup_abort = 0;
+	if (ep0_check_abort(dev)) {
 		retval = -EIDRM;
 		goto done;
 	}
@@ -1262,11 +1278,29 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 	return retval;
 }
 
+/* Called with dev->lock held.  Drop a queued event of @type, if any. */
+static void ep0_discard_event(struct dev_data *dev,
+			      enum usb_gadgetfs_event_type type)
+{
+	unsigned int			i;
+
+	for (i = 0; i != dev->ev_next; i++) {
+		if (dev->event[i].type != type)
+			continue;
+		DBG(dev, "discard old event[%d] %d\n", i, type);
+		dev->ev_next--;
+		if (i == dev->ev_next)
+			break;
+		/* indices start at zero, for simplicity */
+		memmove(&dev->event[i], &dev->event[i + 1],
+			sizeof(struct usb_gadgetfs_event) * (dev->ev_next - i));
+	}
+}
+
 static struct usb_gadgetfs_event *
 next_event (struct dev_data *dev, enum usb_gadgetfs_event_type type)
 {
 	struct usb_gadgetfs_event	*event;
-	unsigned			i;
 
 	switch (type) {
 	/* these events purge the queue */
@@ -1280,18 +1314,7 @@ next_event (struct dev_data *dev, enum usb_gadgetfs_event_type type)
 	case GADGETFS_SETUP:		/* previous request timed out */
 	case GADGETFS_SUSPEND:		/* same effect */
 		/* these events can't be repeated */
-		for (i = 0; i != dev->ev_next; i++) {
-			if (dev->event [i].type != type)
-				continue;
-			DBG(dev, "discard old event[%d] %d\n", i, type);
-			dev->ev_next--;
-			if (i == dev->ev_next)
-				break;
-			/* indices start at zero, for simplicity */
-			memmove (&dev->event [i], &dev->event [i + 1],
-				sizeof (struct usb_gadgetfs_event)
-					* (dev->ev_next - i));
-		}
+		ep0_discard_event(dev, type);
 		break;
 	default:
 		BUG ();
@@ -1311,8 +1334,7 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	ssize_t			retval = -ESRCH;
 
 	/* report fd mode change before acting on it */
-	if (dev->setup_abort) {
-		dev->setup_abort = 0;
+	if (ep0_check_abort(dev)) {
 		retval = -EIDRM;
 
 	/* data and/or status stage for control request */
@@ -1336,13 +1358,9 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 			 * Reject the write if a new control request arrived
 			 * while dev->lock was dropped for memdup_user().
 			 */
-			if (dev->setup_generation != generation) {
+			if (ep0_check_abort(dev) ||
+			    dev->setup_generation != generation) {
 				kfree(kbuf);
-				if (dev->setup_abort) {
-					dev->setup_abort = 0;
-					if (dev->state == STATE_DEV_SETUP)
-						dev->state = STATE_DEV_CONNECTED;
-				}
 				return -EIDRM;
 			}
 			if (dev->state != STATE_DEV_SETUP || !dev->setup_in) {
@@ -1433,9 +1451,8 @@ ep0_poll (struct file *fd, poll_table *wait)
 
 	spin_lock_irq(&dev->lock);
 
-	/* report fd mode change before acting on it */
+	/* report fd mode change without consuming it before read/write */
 	if (dev->setup_abort) {
-		dev->setup_abort = 0;
 		mask = EPOLLHUP;
 		goto out;
 	}
@@ -1548,6 +1565,24 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	/* invalidate userspace copies started for an older control request */
 	dev->setup_generation++;
 
+	/*
+	 * If userspace has not collected a previous GADGETFS_SETUP event,
+	 * this SETUP supersedes it; drop it before any early return or
+	 * in-kernel handling so ep0_read() cannot enter STATE_DEV_SETUP
+	 * for an abandoned transfer.
+	 */
+	ep0_discard_event(dev, GADGETFS_SETUP);
+
+	/*
+	 * Record abort of an active delegated transfer and return to the
+	 * connected state before any early return or in-kernel response.
+	 */
+	if (dev->state == STATE_DEV_SETUP) {
+		dev->setup_abort = 1;
+		dev->state = STATE_DEV_CONNECTED;
+		ep0_readable(dev);
+	}
+
 	if (w_length > RBUF_SIZE) {
 		if (ctrl->bRequestType & USB_DIR_IN) {
 			/* Cast away the const, we are going to overwrite on purpose. */
@@ -1564,7 +1599,6 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 		spin_unlock(&dev->lock);
 		return -EBUSY;
 	}
-	dev->setup_abort = 0;
 	if (dev->state == STATE_DEV_UNCONNECTED) {
 		if (gadget_is_dualspeed(gadget)
 				&& gadget->speed == USB_SPEED_HIGH
@@ -1580,14 +1614,7 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 		event = next_event (dev, GADGETFS_CONNECT);
 		event->u.speed = gadget->speed;
 		ep0_readable (dev);
-
-	/* host may have given up waiting for response.  we can miss control
-	 * requests handled lower down (device/endpoint status and features);
-	 * then ep0_{read,write} will report the wrong status. controller
-	 * driver will have aborted pending i/o.
-	 */
-	} else if (dev->state == STATE_DEV_SETUP)
-		dev->setup_abort = 1;
+	}
 
 	req->buf = dev->rbuf;
 	switch (ctrl->bRequest) {
@@ -1937,12 +1964,13 @@ gadgetfs_disconnect (struct usb_gadget *gadget)
 	unsigned long		flags;
 
 	spin_lock_irqsave (&dev->lock, flags);
-	if (dev->state == STATE_DEV_UNCONNECTED)
+	if (dev->state == STATE_DEV_UNCONNECTED ||
+	    dev->state == STATE_DEV_UNBOUND)
 		goto exit;
-	dev->state = STATE_DEV_UNCONNECTED;
 
 	INFO (dev, "disconnected\n");
 	next_event (dev, GADGETFS_DISCONNECT);
+	dev->state = STATE_DEV_UNCONNECTED;
 	ep0_readable (dev);
 exit:
 	spin_unlock_irqrestore (&dev->lock, flags);
@@ -2145,6 +2173,7 @@ gadget_dev_open (struct inode *inode, struct file *fd)
 	spin_lock_irq(&dev->lock);
 	if (dev->state == STATE_DEV_DISABLED) {
 		dev->ev_next = 0;
+		dev->setup_abort = 0;
 		dev->state = STATE_DEV_OPENED;
 		fd->private_data = dev;
 		get_dev (dev);

-- 
Git-155)


