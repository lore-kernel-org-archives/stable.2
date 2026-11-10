Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794284021;
	b=YlvSutZyf795CvVmbUdwulIzeezni9MZti2hjvvg9S5a54+7x7MRWSozzZmWHmibHZTy
	 Qm5ez+uE3VyW1YjZDNpZ22lIWs68he8C6XMcK/85sjciFW7v2PFEKVQ2fnVXoy+nP+GWm
	 4wRILt/BFbdHKf4j6NJhOaQdVEOsyEWEetzQVWUULU+1SSm3lvCkI/mIosT/oc2kguiMg
	 npB5uXFn7tqsa5sLEu7c82POAHlCB8qAQ+SBmYrjcCwMoL2skWJ7PTMtawS5mnFqojqyb
	 PiGS4dt6V4auh3KuMl3viEqkuoTfOUzsmjF5YpFp/lWHRTRtmsxz/R4LXug8ZAzP9SA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284021;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=U7vGwuEB9odoWnQog5MmmFCSbG5OaAeTQ42qeG8FuYA=;
	b=mx3/xAKUm3fryVc0peo++He8jkZpM8uKKdaJnnmFoCjxyJsr6MGu7iL4W8C770z3L+q7
	 Fz6j4yYgAX46VlHH6nPv/VnEC+K7qw31czuZp0AHM0v1JfVekeO3OLVYowYeFPp32WJnR
	 wwhUulizCDZo3Al17iiS8XUcqhUutp5xK0a6i1T6ecKtyDJZZwIA+/kZkgj0zatNmJUAI
	 RBVr3xlrZwOiLgyIelr6DPoYlLUltNVWDTizpuVHIyAW60RCuHyH1jD6AprZJDgXJIB8j
	 AEJeB1xChClb80zYDG+ytfsxPBHhLyUVsBcnazkhwIJW3ArpnnnMZ1jRVo3GzMRcH3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5hD11Dm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C230606A338;
	Tue, 10 Nov 2026 04:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5hD11Dm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794284006;
	b=BrrgtTL6lHTaupCZpOwvvC4s/gMp2cD2Q1KMeu4WKmAo5pQLAG5WM1mMzzl270dV/Jh5
	 izsslYjiFB+8dLv5+RrS6vbVZXVgvVADVJ40IP+d3ohIXBdeF/0wX+SlwGgXuuuNWfLPp
	 jTiAAcLJ91uweO9azwdGtRMnJLO96jTIXuVdeCgL8IO0UcNeWKPOXvl5mpn/PX8sgmsQy
	 KEP4LhOT6Hh9PvLwPS9VeTyStfkFFSK1U8StIaLTa6/5maOpXtdnQgj4X0PmofXr9LpVG
	 i9Fjs6h31qrEwoVWzxjqX+8zKdGBv/A46nLLyvsh4r8YkeZLA1PpQGfuxnZk7JIca4Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794284006;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=U7vGwuEB9odoWnQog5MmmFCSbG5OaAeTQ42qeG8FuYA=;
	b=FdBQqaUz/wT0+AB3KxD7JDEkg/1wUI9wOZJ/O3wFRaEJziyvy+YSQu7vGxte9XveSyP9
	 3M4+ax2MiFmbnSK5siaCyWCNRJpDA+TJEdiKI6oFIb5KGA0gGMaSHlDY18eYuxaqgasP2
	 yDXkRhdlvjE+4rFXktg8EZNkXHpwHcRVJYCpueDZRfEw8KXj+Ef6bkAW6HEvV8WvE3qH+
	 u4Z/tqA8b88zfbI8z15zgyFbbx1PmzTTJj89RJKzmC2El8B5cO934zUdvg7pPqrWgiyMh
	 PuP7uVZtVDPEKdA/VDxl35TVbM0VCDeHldyypeMeSneiL1a4f2vouqxALh0mgUc7Tdg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 027DC1F0089F;
	Tue, 10 Nov 2026 04:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284006;
	bh=U7vGwuEB9odoWnQog5MmmFCSbG5OaAeTQ42qeG8FuYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=A5hD11DmCaSbguY7EiH27mb2bSB0IBbHJrVu1rWjdZHlP/uHtLfN7dg8n1CP/s8W3
	 GS7/oRYkKCNCOq1enDpsyQ0bBkifWVUt+cohJpD4T8/IcixL1yP0ZQOpSXR7A6xeI5
	 pwq8dYHT/zHVRdDpHVM7a/nUbqobhLGLUMpQd5r4rGF+kq7M3oqag6yTBivvbZDjWV
	 8gmXVViMFVd9WnmG3IUc5vwXgG29shv0g0GQMLOdVX/z56hsnKN1Fj7R4CnCSt7Rop
	 Ab7gM/X+5ODq6DPCCzstSRTcw/AQwQs0D3V9qo7bVjqH4sw4ICx1dmWpu7yLhhsW6n
	 Mpf2MkCn5/1/A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8463748814;
	Tue, 10 Nov 2026 04:13:24 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 12:13:23 +0800
Subject: [PATCH v8 2/4] usb: gadget: gadgetfs: fix ep0 setup abort and
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
Message-Id: <20261110-gadgetfs-ep0-v8-v8-2-8f90434574fe@gmail.com>
References: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
In-Reply-To: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jing Lin <kayano050408@gmail.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794284002; l=12143;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=1fIcXiFtUvmDcdNpX+qFeNZObcXDpLLUgd4PFWOhm28=;
 b=J5FmyXZoZ9KGa7ENh68DrYi19wGvGdU6bgDOIJIu7xYDRG7R+JeKrIUTy4vICZsqGmR5a7eQU
 1WDb6FUUVoJALmkFroylLetLyp+XvF2sSj+idQeZyRHV24yWjM/PZGe
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=pr6i8RN1WEON1jbXPdghSglxaBSzfuJjXNGFknX//+A=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/default with
 auth_id=1441
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

A new SETUP also supersedes a delegated request whose GADGETFS_SETUP
event userspace has not collected yet.  Discard that queued event before
any early return or in-kernel handling, so a later ep0_read() cannot
re-enter STATE_DEV_SETUP for a request the host has already abandoned.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 139 ++++++++++++++++++++++++++++----------
 1 file changed, 105 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 1e7e8f4bb..d2e148054 100644
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
@@ -1273,7 +1304,8 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 
 		/* wait for events */
 		retval = wait_event_interruptible (dev->wait,
-				dev->ev_next != 0);
+				dev->ev_next != 0 ||
+				dev->state == STATE_DEV_UNBOUND);
 		if (retval < 0)
 			return retval;
 		spin_lock_irq (&dev->lock);
@@ -1285,11 +1317,29 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
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
@@ -1303,18 +1353,7 @@ next_event (struct dev_data *dev, enum usb_gadgetfs_event_type type)
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
@@ -1334,8 +1373,7 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	ssize_t			retval = -ESRCH;
 
 	/* report fd mode change before acting on it */
-	if (dev->setup_abort) {
-		dev->setup_abort = 0;
+	if (ep0_check_abort(dev)) {
 		retval = -EIDRM;
 
 	/* data and/or status stage for control request */
@@ -1345,6 +1383,7 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 		if (dev->setup_in) {
 			u8	tmp[RBUF_SIZE];
 			bool	zero = len < dev->setup_wLength;
+			unsigned int generation = dev->setup_generation;
 
 			spin_unlock_irq(&dev->lock);
 			if (copy_from_user(tmp, buf, len)) {
@@ -1352,6 +1391,14 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
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
 
@@ -1434,9 +1481,13 @@ ep0_poll (struct file *fd, poll_table *wait)
 
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
@@ -1545,6 +1596,30 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	u16				w_value = le16_to_cpu(ctrl->wValue);
 	u16				w_length = le16_to_cpu(ctrl->wLength);
 
+	spin_lock(&dev->lock);
+	/* invalidate userspace copies started for an older control request */
+	dev->setup_generation++;
+
+	/*
+	 * If userspace has not collected the previous GADGETFS_SETUP event,
+	 * it describes a request this SETUP supersedes.  Drop it before any
+	 * early return or in-kernel handling so a later ep0_read() cannot
+	 * re-enter STATE_DEV_SETUP for that request.  If userspace did
+	 * collect it, the state check below reports the abort.
+	 */
+	ep0_discard_event(dev, GADGETFS_SETUP);
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
@@ -1553,16 +1628,15 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
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
@@ -1578,14 +1652,7 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
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
@@ -1847,6 +1914,8 @@ gadgetfs_unbind (struct usb_gadget *gadget)
 
 	spin_lock_irq (&dev->lock);
 	dev->state = STATE_DEV_UNBOUND;
+	dev->setup_abort = 0;
+	ep0_readable(dev);
 	while (dev->udc_usage > 0) {
 		spin_unlock_irq(&dev->lock);
 		usleep_range(1000, 2000);
@@ -1953,12 +2022,13 @@ gadgetfs_disconnect (struct usb_gadget *gadget)
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
@@ -2161,6 +2231,7 @@ gadget_dev_open (struct inode *inode, struct file *fd)
 	spin_lock_irq(&dev->lock);
 	if (dev->state == STATE_DEV_DISABLED) {
 		dev->ev_next = 0;
+		dev->setup_abort = 0;
 		dev->state = STATE_DEV_OPENED;
 		fd->private_data = dev;
 		get_dev (dev);

-- 
Git-155)


