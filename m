Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675047;
	b=mtrk5nwe7RyUM/4GcRlXuQ/yK094XEVo2VweIWe39sgTORidQGWJxhw6xKQMC610QuVP
	 IKcZxeJl66zqgX4vz5RSP65//4eMQ5QAY0yIqK9FVjK7C4O90wUo3lEF5z7yTyavM+w6A
	 wospO+BXnMpeDd0p+nqlflwMAQk7FoKpQkXgk771FHaKy0lPvlyS6Z+ef9TPwNkyXxEwz
	 EZ1NAaOzHuZDIaIn9ZWEQyu+FMXfo3sLzJEoUj8+VEDLcaP+RLmzEFcCngDc9k/axGGcT
	 2IT+WjB8yTYJE8PuXiM25HpywvFXZqKeiy1rct6wScsPgqHlPzGujIUDaSjGjFOAmOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675047;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qHjsBM1MQK0Tm0txBflrplVCdr5U5hbbf9rXdvT/460=;
	b=rWXvs+Tjt6Up80JeF5hTYQoc+Zr4ssa9vxgHBLulqt5UclpI0SNy9ypJb9xJqwVVJE+f
	 mdjsMgHBwMpLIkUkVLFggrC5Lr321aeKiXcwpgxh6MTyB/dAl3VA8CnRQ+5B735E7Nvi5
	 dPB98MQYoi4NU/QVCx8zeLCQZ0rDjWvR9l3ggz3fZUgMPkv8vAh76U6lcNX/zlt2INZma
	 1lExJZv/mKRzjmiW/MNh2F2Pn05Gu4URideSiL7gM3ADcnRApmC7jHjwFFOUlMXaL4sdX
	 vfSyCQfdI5/Eha0TlmFOsRGignbhl0HvBS7gbbKenEpAitlPDgFinJK8EyoOuYlrpiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VefeUbDj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C43606A6A8;
	Thu, 26 Nov 2026 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VefeUbDj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795675047;
	b=c02IwBRDd2/ZomgmmMNKtknL/vF2gAyeUvv7QPwngMeyQSZbnmdvyC8zuVFN9zdwj4AL
	 hZkd4nPqaDUcBNk2eUva4rgHFWWaoaehX1tUDr70GRfQ3vg+cWViSmD680cKHSEmfKHSf
	 2mIEGsONeb06PB2oHbuRRA18MT+2670vZl+khcC342TE49CaCcYqZ9tDAQr5cH8Vyc6Oa
	 yck4y7TYgF2bBlAKldVFyZ8QLhDSr+eD+gFHeukCGKPfp9M8y0zVr/dbecWqafKzu4iUv
	 ZlJiWHE3gd7rVlofKQ2TPnlo+O1nJ/qcegAAdwpgunVsdPpeC5wuROJDYj6wut/cRVg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675047;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qHjsBM1MQK0Tm0txBflrplVCdr5U5hbbf9rXdvT/460=;
	b=1h/BmnxBwLkY7LYQEPdPQjkmwhMkd797w3qVsUTCnWI1x+QEk4OumzQc92DmeVWh1RHN
	 InT2AjpyqLZmeWSnjDt2uCQcbMNRMVLx1IiXFdyyXqJfoOnoWT8TTDBnYITllwiAA6E+k
	 XQa8AuHiy4MH11nUcWGxjHyOTdvLdiGejIXET8r3KPi/OIXOfNDE4besELG/Yg8VSnUaZ
	 BYZumvQELIIKo0vsM+PLfkRSca4oqQ2pG9EXVChJziklwQvi0q5Q89tGMz3alxnhndLxS
	 Tc8gB6WFrDsHpKoZ72Tbu7wgj4bLVh21OoFr9soFQ9guQg5K0U/y31h8dxGUOdG+Nxw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 71BD91F000C0;
	Thu, 26 Nov 2026 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675047;
	bh=qHjsBM1MQK0Tm0txBflrplVCdr5U5hbbf9rXdvT/460=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VefeUbDjBEze59AKnnez3jZW0h16nFooqz0Lg5B6DR39UnbbIAsNfTb1ywn6YucnH
	 SHLHGvBW9eWrlIY9wLKpOo+32ej7W4BhNOZfrPRUAnk2YfIPqHriqAvGywiK5h2M5o
	 EfWv4g6SdKnGGlF12Yopza8tG2THLvBPm9IqVwrJ+yGHThwak1Sk96FiWvUWJa79sk
	 JT+xyeo1UYCeFT/pz5GPHeYrmEVWjYrO2PCFFcYesItpwfOcpz1phazq4C50KDBjrL
	 AzPc3nodjuc/uEl+USzgX2y/ALS7rdF1qrv1F5NPhBA3fZOBXFFrCJH4PGc1d4NlpC
	 QZq1M5idClFcQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 02E144D281;
	Thu, 26 Nov 2026 06:37:07 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:37:05 +0800
Subject: [PATCH v9 2/6] usb: gadget: gadgetfs: isolate ep0_write() buffer
 and reduce setup race
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
Message-Id: <20261126-gadgetfs-ep0-v9-2-81b464c6e641@gmail.com>
References: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
In-Reply-To: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795675024; l=4414;
 i=kayano050408@gmail.com; s=20261126; h=from:subject:message-id;
 bh=RVJHc4be5aHnDrJZDAsXTiK0Nae84ZkXu+4RgSSPN6g=;
 b=id5dB3M9gxzBvZHwPBSRQRxNiNEwG+LFhj8s6VK4M20GcXueT43mG9LqYxtPOcdfOTHS8Zonz
 ihi8n949GjnDsTjZAuUdW0tTiUiYBLFsyb6BrXq56CXXBARKDt/LMiZ
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=40M3hugIx++9w3nkAoFXGcN/vLWsPMGDYdbduV+lUlI=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/20261126 with
 auth_id=1648
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

For a delegated control-IN request, ep0_write() prepares dev->req and
copies the response from userspace with copy_from_user() after dropping
dev->lock.  A control request that arrives during that unlocked copy can
point req->buf at dev->dev or dev->config, letting copy_from_user()
overwrite a descriptor buffer, or supersede the transfer that userspace
is responding to.

Copy non-empty control-IN payloads from userspace into a private buffer
with memdup_user() before leaving STATE_DEV_SETUP or modifying dev->req,
and count setup callbacks in dev->setup_generation so ep0_write() can
discard a superseded response after retaking dev->lock.  This eliminates
the copy_from_user() race window, leaving only the unavoidable window
after dev->lock is dropped to call usb_ep_queue().

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 65 +++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 911419a4e1a3..a0dc350a7a0d 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -142,6 +142,7 @@ struct dev_data {
 	unsigned			setup_wLength;
 	bool				ep0_req_queued;
 	void				*ep0_req_buf;
+	unsigned int			setup_generation;
 
 	/* the rest is basically write-once */
 	struct usb_config_descriptor	*config, *hs_config;
@@ -1319,27 +1320,50 @@ ep0_write (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 
 		len = min_t(size_t, len, dev->setup_wLength);
 		if (dev->setup_in) {
-			retval = setup_req (dev->gadget->ep0, dev->req, len);
-			if (retval == 0) {
-				dev->state = STATE_DEV_CONNECTED;
-				++dev->udc_usage;
+			unsigned int	generation = dev->setup_generation;
+			bool		zero = len < dev->setup_wLength;
+			void		*kbuf = NULL;
+
+			if (len > 0) {
 				spin_unlock_irq(&dev->lock);
-				if (copy_from_user(dev->req->buf, buf, len))
-					retval = -EFAULT;
+				kbuf = memdup_user(buf, len);
 				spin_lock_irq(&dev->lock);
-				--dev->udc_usage;
-				if (retval < 0) {
-					clean_req(dev->gadget->ep0, dev->req);
-				} else {
-					if (len < dev->setup_wLength)
-						dev->req->zero = 1;
-					retval = queue_ep0_req(dev, true);
-					if (retval == 0)
-						retval = len;
-				}
+				if (IS_ERR(kbuf))
+					return PTR_ERR(kbuf);
+			}
 
-				return retval;
+			/*
+			 * Reject the write if a new control request arrived
+			 * while dev->lock was dropped for memdup_user().
+			 */
+			if (dev->setup_generation != generation) {
+				kfree(kbuf);
+				if (dev->setup_abort) {
+					dev->setup_abort = 0;
+					if (dev->state == STATE_DEV_SETUP)
+						dev->state = STATE_DEV_CONNECTED;
+				}
+				return -EIDRM;
+			}
+			if (dev->state != STATE_DEV_SETUP || !dev->setup_in) {
+				kfree(kbuf);
+				return -ECANCELED;
 			}
+			if (dev->setup_out_ready || dev->ep0_req_queued) {
+				kfree(kbuf);
+				return -EBUSY;
+			}
+
+			dev->state = STATE_DEV_CONNECTED;
+			dev->ep0_req_buf = kbuf;
+			dev->req->buf = len ? kbuf : dev->rbuf;
+			dev->req->length = len;
+			dev->req->zero = zero;
+			dev->req->complete = dev_req_complete;
+			retval = queue_ep0_req(dev, true);
+			if (retval == 0)
+				retval = len;
+			return retval;
 
 		/* can stall some OUT transfers */
 		} else if (dev->setup_can_stall) {
@@ -1520,6 +1544,10 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	u16				w_value = le16_to_cpu(ctrl->wValue);
 	u16				w_length = le16_to_cpu(ctrl->wLength);
 
+	spin_lock(&dev->lock);
+	/* invalidate userspace copies started for an older control request */
+	dev->setup_generation++;
+
 	if (w_length > RBUF_SIZE) {
 		if (ctrl->bRequestType & USB_DIR_IN) {
 			/* Cast away the const, we are going to overwrite on purpose. */
@@ -1528,11 +1556,10 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			*temp = cpu_to_le16(RBUF_SIZE);
 			w_length = RBUF_SIZE;
 		} else {
+			spin_unlock(&dev->lock);
 			return value;
 		}
 	}
-
-	spin_lock(&dev->lock);
 	if (dev->ep0_req_queued) {
 		spin_unlock(&dev->lock);
 		return -EBUSY;

-- 
Git-155)


