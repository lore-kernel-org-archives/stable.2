Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794278518;
	b=y6y7A4UpSVIovxc84Zl13997jLdDb81zsOL8Wd8HQ/BnLdDig/gdU1zQ7w7P+e9gKD8n
	 XHjl1QCK4jvG/Bu1vva0udfEnpObCQ3aDBSwkCaRmqEnfUxN6l2cOqtORljNnoFhIfJxT
	 e926mm3QzYmSKg3uSlJOTYc+4zolbEkalYwh07DABVKrJ6G3b047Km5GdeuivVsYbZhmN
	 vPgueJ5eeTfXJhFEwjg1JxAK2qtAPf62N+vLEexKosMKi1etV/nWOP0HyejBkDpwyH1d/
	 QBHCzkY71pr+SFScJmQ6M/Q72RN86MEA/OzISHE9QwPOpTrSgXOFAymXXbEht+Pb3zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278518;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vl73RAoHu3DDDqyJa3kkxKxPZRkPk6ZF96btBbDbs5c=;
	b=WC7Epo+n026JqHtlVS3j9xqzlPDzrz7/HytZN4yShz5BRIKFgghhxHolnY6HC0lHqKi6
	 2TrW38kCsVNBtumsevK8qw4LaWEazy0BfNPmHWxtIzgLajqri0VWaOIfX8+QDCqZ5BFNa
	 /iOhaMGyNm2ba3LCHirkWW1fqFczDlXlmxGQ/Eac77t2fvWzmuiM672ZVIQ7cpVzZAjxv
	 HV038VCpw/IZBgnvYGnL5OfwO5bCBR1IyKz3ItrP7ZmdnZ/xHclUYCdBb6qBYISZMknmI
	 Cgi9olf2kv+FFHh9Qk6MjFcv/Zl0s3MZ5TvRhqjm4ktgDts2iM5M/xV1Dmd/Pq/CsTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3LWw8r6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A260A260D;
	Tue, 10 Nov 2026 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3LWw8r6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794278517;
	b=dYKjPPOVeo6Efuvnugrw7N7cUa6uTN2JoZXBDsYB1VK0a+vTO4fbfg7/NctBRm8kQ/Ns
	 sNsbqsQ0EhxtELZHbp4IyCSBPRN8cQBTMfTDp6plVZ2//wLAMYw1PslX+qpKUBM/r/sck
	 /czJImF4kaARYSssZYExtsIcLyW2P1eJQwD6uJ6nTO15yOma5Cp2FTGgK9Ks/qlUZRtCz
	 MU1DcoVqx+b/UCDJcYvghjPECoE/vzgWHQJSrcVrkEK4l++GX3GdQ1djpBgmm9Yf/CDcF
	 NC7bW/6bN+FiWjnuVz1+S5SoDOj4OMgTsau1zA5I9Q/YjTIFZvSfgbMmGB72mJSy4LA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794278517;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vl73RAoHu3DDDqyJa3kkxKxPZRkPk6ZF96btBbDbs5c=;
	b=wvZgLYkkqgfWgnIVG75mHt6AhWz97sIXFjintrgjK+OETztxwq0cxYIwPqHtWs3jkSrG
	 geNi/4D0cDr6crixkB2akqHwCE9Nnsmjdru8GJEOGypdFGDJ2Sr+zkkBFtjsDP8bge+H3
	 lW0gljaksWs70XKNkuLhOIIrWCZ5vHVCnqena6qfxXalI0W1BmmBo8FYWjVbB8cMdnzvn
	 9KeI1zM+Ju42c5cnBJOQB4+235JBqZgNxdnzSsEjHxMggEyX4xxCDJ+RIjFhWSj/Mtgoy
	 JPM4qUOoCBjpwb3ONvXwDXgYIB0eVGMYY61k4kllRjWgeTXN2m1Zw07XUyHVd/9+Dew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B16B11F008A2;
	Tue, 10 Nov 2026 02:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278517;
	bh=vl73RAoHu3DDDqyJa3kkxKxPZRkPk6ZF96btBbDbs5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=T3LWw8r6bXvY1TxdQj+PcfglU6/ADjKyZgXmbmbHpqgDQ0la9B5ANBhTNXQYHtIvj
	 MzNSlvEDyY7EgZ9if+Q5aWwXcrt9RU4sxJo5DMJZCfcacGSFrPqwiGEW7QyVHFkn2w
	 OnS6jMVb5cmsoiBK2w/O2UO+942UNEumdz/pAdGCtfhNP8syGGMajJQSAcSFV0mUPm
	 vJdQNra0iyF2qfd0+3ZyNjsO1edpdVZc4v9vHYGH9f3BU3mEl2qy+5fywH52+JFPgy
	 cpyFyHnvMOshlCxPQSEVLSMWEySvcClPZNJw9lPfp1mDYrVXqMTy8EdSp77/JaPVbB
	 CJHUTumBhP5lQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3CAEC4878A;
	Tue, 10 Nov 2026 02:41:55 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 11:40:48 +0900
Subject: [PATCH v7 2/4] usb: gadget: gadgetfs: fix ep0 setup abort and
 unbind state races
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
Message-Id: <20261110-gadgetfs-v7-v7-2-6d05409cc61a@gmail.com>
References: <20261110-gadgetfs-v7-v7-0-6d05409cc61a@gmail.com>
In-Reply-To: <20261110-gadgetfs-v7-v7-0-6d05409cc61a@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jing Lin <kayano050408@gmail.com>, stable@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794278513; l=9772;
 i=kayano050408@gmail.com; s=p600; h=from:subject:message-id;
 bh=jVrzqL81agp0mZCK4TcRxveRz0lx5bOeNkTKKGobMxQ=;
 b=N0syhRr8j1myTiVDhEbTJBPzbStKE1kb7B7kJaIS+L9CN3mPzfx7mKSgMeSHXGBdkpVImuVoK
 9AKRenG7+N9D/cMTddb0hGDvuxsk7qqTEa03Jz1GMbrQ7LyUTgQJE2h
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=DtAI52kU3F0sVbAiS4n+5b4UKMnVF398eKHlj3H9KBY=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/p600 with
 auth_id=1475
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

Several ep0 state transitions lose setup abort notifications or leave
the file descriptor in an inconsistent state when control requests,
disconnects, or unbinds race with userspace I/O:

1. ep0_write() drops dev->lock while copying an IN payload from
   userspace.  If a new SETUP packet arrives in that window, the stale
   response must not be queued for the new transfer.

2. ep0_read() waiting for a delegated control OUT data stage only checks
   dev->setup_out_ready, so it does not wake when a new SETUP packet,
   disconnect, or unbind aborts the transfer, and can consume a newer
   transfer's payload if dev->state re-enters STATE_DEV_SETUP.  In
   addition, gadgetfs_disconnect() overwrites STATE_DEV_UNCONNECTED
   before next_event() checks for STATE_DEV_SETUP, skipping setup_abort.

3. Early returns in gadgetfs_setup() on oversized OUT requests or a busy
   ep0 request skip setting setup_abort when aborting STATE_DEV_SETUP,
   while ep0_poll() clears setup_abort before ep0_read() or ep0_write()
   can report -EIDRM.

4. gadgetfs_unbind() leaves queued events readable in STATE_DEV_UNBOUND.
   Delivering a queued GADGETFS_SETUP event after unbind puts dev->state
   back into STATE_DEV_SETUP after dev->req and ep0->driver_data have
   been cleared, causing a NULL pointer dereference on the next ep0 I/O.

Count setup callbacks in dev->setup_generation, record setup_abort and
return from STATE_DEV_SETUP to STATE_DEV_CONNECTED at the start of
gadgetfs_setup(), and consume setup_abort only in ep0_read() and
ep0_write() via ep0_check_abort().  Include setup_abort, state changes,
and setup_generation in the ep0_read() wait condition, fix the state
update order in gadgetfs_disconnect(), and return -ESRCH from ep0_read()
once the device is unbound.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 97 ++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 1e7e8f4bb..6514220ef 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -144,6 +144,7 @@ struct dev_data {
 	bool				ep0_req_queued;
 	bool				ep0_req_free;
 	void				*ep0_req_buf;
+	unsigned int			setup_generation;
 
 	/* the rest is basically write-once */
 	struct usb_config_descriptor	*config, *hs_config;
@@ -1108,6 +1109,23 @@ static int queue_ep0_req(struct dev_data *dev, bool process_ctx)
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
@@ -1123,8 +1141,7 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 	}
 
 	/* report fd mode change before acting on it */
-	if (dev->setup_abort) {
-		dev->setup_abort = 0;
+	if (ep0_check_abort(dev)) {
 		retval = -EIDRM;
 		goto done;
 	}
@@ -1165,6 +1182,8 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			}
 
 		} else {			/* collect OUT data */
+			unsigned int generation = dev->setup_generation;
+
 			if ((fd->f_flags & O_NONBLOCK) != 0
 					&& !dev->setup_out_ready) {
 				retval = -EAGAIN;
@@ -1172,13 +1191,20 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			}
 			spin_unlock_irq (&dev->lock);
 			retval = wait_event_interruptible (dev->wait,
-					dev->setup_out_ready != 0);
+					dev->setup_out_ready ||
+					dev->setup_abort ||
+					dev->state != STATE_DEV_SETUP ||
+					dev->setup_generation != generation);
 
-			/* FIXME state could change from under us */
 			spin_lock_irq (&dev->lock);
 			if (retval)
 				goto done;
 
+			if (ep0_check_abort(dev) ||
+			    dev->setup_generation != generation) {
+				retval = -EIDRM;
+				goto done;
+			}
 			if (dev->state != STATE_DEV_SETUP ||
 			    dev->setup_in || !dev->setup_out_ready) {
 				retval = -ECANCELED;
@@ -1219,6 +1245,11 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 	dev->usermode_setup = 1;
 
 scan:
+	if (dev->state == STATE_DEV_UNBOUND) {
+		retval = -ESRCH;
+		goto done;
+	}
+
 	/* return queued events right away */
 	if (dev->ev_next != 0) {
 		unsigned		i, n;
@@ -1273,7 +1304,8 @@ scan:
 
 		/* wait for events */
 		retval = wait_event_interruptible (dev->wait,
-				dev->ev_next != 0);
+				dev->ev_next != 0 ||
+				dev->state == STATE_DEV_UNBOUND);
 		if (retval < 0)
 			return retval;
 		spin_lock_irq (&dev->lock);
@@ -1334,8 +1366,7 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	ssize_t			retval = -ESRCH;
 
 	/* report fd mode change before acting on it */
-	if (dev->setup_abort) {
-		dev->setup_abort = 0;
+	if (ep0_check_abort(dev)) {
 		retval = -EIDRM;
 
 	/* data and/or status stage for control request */
@@ -1345,6 +1376,7 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 		if (dev->setup_in) {
 			u8	tmp[RBUF_SIZE];
 			bool	zero = len < dev->setup_wLength;
+			unsigned int generation = dev->setup_generation;
 
 			spin_unlock_irq(&dev->lock);
 			if (copy_from_user(tmp, buf, len)) {
@@ -1352,6 +1384,14 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 				return -EFAULT;
 			}
 			spin_lock_irq(&dev->lock);
+			/*
+			 * A control request that arrived while dev->lock was
+			 * dropped supersedes this data stage; do not queue the
+			 * stale response for it.
+			 */
+			if (ep0_check_abort(dev) ||
+			    dev->setup_generation != generation)
+				return -EIDRM;
 			if (dev->state != STATE_DEV_SETUP || !dev->setup_in)
 				return -ECANCELED;
 
@@ -1434,9 +1474,13 @@ ep0_poll (struct file *fd, poll_table *wait)
 
 	spin_lock_irq(&dev->lock);
 
-	/* report fd mode change before acting on it */
+	if (dev->state == STATE_DEV_UNBOUND) {
+		mask = EPOLLHUP;
+		goto out;
+	}
+
+	/* report fd mode change without consuming it before read/write */
 	if (dev->setup_abort) {
-		dev->setup_abort = 0;
 		mask = EPOLLHUP;
 		goto out;
 	}
@@ -1545,6 +1589,21 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	u16				w_value = le16_to_cpu(ctrl->wValue);
 	u16				w_length = le16_to_cpu(ctrl->wLength);
 
+	spin_lock(&dev->lock);
+	/* invalidate userspace copies started for an older control request */
+	dev->setup_generation++;
+
+	/*
+	 * Host may have given up waiting for a response to a previous
+	 * delegated transfer.  Record the abort and return to the connected
+	 * state before any early return or in-kernel response handling.
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
@@ -1553,16 +1612,15 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			*temp = cpu_to_le16(RBUF_SIZE);
 			w_length = RBUF_SIZE;
 		} else {
+			spin_unlock(&dev->lock);
 			return value;
 		}
 	}
 
-	spin_lock (&dev->lock);
 	if (dev->ep0_req_queued) {
 		spin_unlock(&dev->lock);
 		return -EBUSY;
 	}
-	dev->setup_abort = 0;
 	if (dev->state == STATE_DEV_UNCONNECTED) {
 		if (gadget_is_dualspeed(gadget)
 				&& gadget->speed == USB_SPEED_HIGH
@@ -1578,14 +1636,7 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
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
@@ -1847,6 +1898,8 @@ gadgetfs_unbind (struct usb_gadget *gadget)
 
 	spin_lock_irq (&dev->lock);
 	dev->state = STATE_DEV_UNBOUND;
+	dev->setup_abort = 0;
+	ep0_readable(dev);
 	while (dev->udc_usage > 0) {
 		spin_unlock_irq(&dev->lock);
 		usleep_range(1000, 2000);
@@ -1953,12 +2006,13 @@ gadgetfs_disconnect (struct usb_gadget *gadget)
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
@@ -2161,6 +2215,7 @@ gadget_dev_open (struct inode *inode, struct file *fd)
 	spin_lock_irq(&dev->lock);
 	if (dev->state == STATE_DEV_DISABLED) {
 		dev->ev_next = 0;
+		dev->setup_abort = 0;
 		dev->state = STATE_DEV_OPENED;
 		fd->private_data = dev;
 		get_dev (dev);

-- 
Git-155)


