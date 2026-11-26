Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795697108;
	b=rjhWuirIg8UBjsGwh2ELm8yRXPGPFCqaOKSTVrKOPuiU9sDAUheQdPO3x0cF0TLnjyZD
	 Wt8nBk8oFJrthyFuqwTGGCL2tuuOw2Pifuy6OZu77/20QE0xLILFtspQelP3/obbtr4Qb
	 vlNHzTX69yMlnC7fQARilya7OcVK0GvMq4RfJEuiZUbiqRGyrosJr+WGuldIQW5+Iypfx
	 yuRCN546osi7mGBnL/1CoiUA9hAANZthn3TJdzgoTF+6GKYcjHWHTNydM4+t4QABtcN59
	 5M/gEG8NLr9WECUnbB2VRuC9gDOyoilhyiSq5dcguUJKKn6477QTTDsSx7tUHM1u8TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697108;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zB85Zu90o0AjeaWc71212P7aFlY6bvpmZEHuV23k/DA=;
	b=PdG6usUQduNQiEu6BTD/2n3ajLCGFhtX24frqdJjx5EMPwLbKKJZirJ7K5EtUYSaD5gt
	 vi0UUI8ykb9F32u5LB97coqmVdONQN6+gaXcGOO0z0LkXDkFe1OrIRVx+P/BMIwYO845X
	 ARONdrc4ioR+PNZAerUz7/8xQ8w+GPDsNPvKxO+HAe6fbSyOPtXnCzK32fmeqdBaoUbLR
	 rgRckgXCMdzC5O/YO4sFTPROl0DD/RbitE552r4IpJ67/Lfa0zwRz8bsC/jPC2ed+0MQS
	 9Stt8AxqL+Kj9d6UFykIjW7a3trFKNimlocGmk9keMnQqRULpjOH1W8kfaQcB8xJTtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbopaLrc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E948606A323;
	Thu, 26 Nov 2026 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbopaLrc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795697107;
	b=GAVOVyjhbSHVKM8fbUJU/ZTPVLzp36Ef5LcYPqgcSwEhNezR7LZ24EbaWUNsYslZUG7/
	 Ap+35JMKTdCOYZMn2VDKj++XyjDSBQOO1tthlq/0zEsvh7gbQBFW7UxIacUxhjQenr2D3
	 I1547FaIJAgaFCwNRRKPOKxuhlPKdLF5Veho9kdarVvZvT+3h4RwAR9aAuqZb/1CTCFLj
	 3r/lbA90thRS48u7u1OlFoEFV5MUc7QsALfDgybhxGtNgREXDY7mgek1xCEnEsAG+fHIF
	 HmLoWwGBJF7IdnnYhPfDoUrdzUYi/3L5BHmMntQ+zaglVCzlUcSH2A0dwWhSLqWcsGg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697107;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zB85Zu90o0AjeaWc71212P7aFlY6bvpmZEHuV23k/DA=;
	b=VzWeg/HxQ+nekyAgEBnkAfWjMsp4cvU+RYdYX3F3YG76KpncwRhrV9uiSrX+FnhBB2JP
	 rrv+7gXhkNr20iWUdwIzqvYtUKmLajr9MbjPtF4B8ms8m41UwSQiDp+Z5EHEB3UFgwqtC
	 Le6oBZfo/8vYg8BxI/qC41TeAjeCpm7i4ctv3/XyVCi2fd8gidh92bLcExhphxpsmrRE2
	 ar/kWGFiQTUbecf11AolcrFaSnr50/F/UGqtXUg+n3jMmmYBtV1J+FHu8U1BaunymsPCl
	 yGkxkyOt5H+YTD/RAfjJTuc/a5wvLORVdKEbOW9mfVl65hq82hHGNSfGDtMc/H15Bhg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 539811F000E0;
	Thu, 26 Nov 2026 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697107;
	bh=zB85Zu90o0AjeaWc71212P7aFlY6bvpmZEHuV23k/DA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fbopaLrcQ34ySzE2ifxiR8itXOnd+XrPTOd26tSd1xz6FzYoot+qf4OrQzAmgfMaj
	 xI5QVD6AfE0OLfVoG3KQOJS98ggQi4wKh8ijlbg1LaIXW8/glhLaBrIGwzx9vHvWBZ
	 4NWfrZSC5gdKitqc05DuMOzKzSYueTKN1UcMzlerx5pceJKHUcX5xyd5PcWilTdUmq
	 JuNP5cWmYv9+SYgYy7ZTJgqthTTFN4869V85EVGmHczoQaBTlXsFyhX4pG7upbxIyr
	 Nmr/3ZaI5MuorLm6ZapE2AcZbywXdZuT6opUoBOVnT7pu+RXAH8AZxi2i8RKW6LNGm
	 lBeo/Qh41+5uA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D3A724D4D4;
	Thu, 26 Nov 2026 12:44:54 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 21:44:52 +0900
Subject: [PATCH v10 2/6] usb: gadget: gadgetfs: isolate ep0_write() buffer
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
Message-Id: <20261126-gadgetfs-ep0-v10-2-8add6d9cace2@gmail.com>
References: <20261126-gadgetfs-ep0-v10-0-8add6d9cace2@gmail.com>
In-Reply-To: <20261126-gadgetfs-ep0-v10-0-8add6d9cace2@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795697092; l=4408;
 i=kayano050408@gmail.com; s=20261106-gadgetfs-gmail;
 h=from:subject:message-id;
 bh=loBcx7ZfuErPGb5OqeYZ9pNroPFE6ZnpAS/g4iY/mvc=;
 b=tYpkxN8102g+pm3WXINJNy0BXNYL/zpymLRNKrq/hSl80Hf1g568n+cBopsKzwmREcuDVNgOZ
 p7405JANY2rBcTjgLRj5IwYnUJKLIVF4AsAVWjMPVDB4gUlJQ/MyMti
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=DtAI52kU3F0sVbAiS4n+5b4UKMnVF398eKHlj3H9KBY=
X-Endpoint-Received: by B4 Relay for
 kayano050408@gmail.com/20261106-gadgetfs-gmail with auth_id=1433
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
index 911419a4e..a0dc350a7 100644
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


