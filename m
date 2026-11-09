Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794203744;
	b=gy8xJm1IjLLrTWdc4jaEyrc0q8I1YiLr3yaRXnfHUf86pn9+Yk+zSMvsGuF+z93wYmxB
	 jpJsxWiRFYnWTfOlB7845hX+Fisp5sPhJtRVS2LTM0DEpgRASLPz9eAwRz401B3vjoQvy
	 KXkoS/7Sfx1VWoZJpDo1Z+nx8atlCjmXSlmDtjJrosJJ3mWZV0ExPFWh0srptjlO0GxGd
	 TqhZP5AF6t2URxf8jfi35OJC2DM7GRfHMzCl1HPJpOzFW3EKHxH39ifQUnvhtUgnofy8S
	 sEf+Bj4YzgaZ/qpyG766UY1Ns+y/tKmenmKP1x2KNy3tUxhtFQVgrNwod/oExhOCDMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203744;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+8zu6JFXVibAB97Q9yxckB/ueOt/mDgkczf1Z0EUMjo=;
	b=iWG/kGHDnkp1ZaB37Ydvz+76JGTjFKjS1uro8F7ycy2B4qcPdia69nVllhhTMRvrspTo
	 qnwiWxJUV2jvO7SfKj1znE63X9y/onnNgW4ZY4q+bImZLVG/HeOXdkWr1V9Gor/hTBB5d
	 GPDyapAl/2o5uPXSuxAQRYCQ4frt9R4oNWm8ZJkSM7MhIEyAXMYvp+SMwOmHTuABODUvk
	 2Bvk8JLx3bOaciTJhWNA3YhHtXHx9yqf2XRg73Sdrpm74gaYfVb4YCcYrJVfAMLXtrtYc
	 O92knLts663nmtmIzcm/eMI+sglAHk5ma2AvLvNnZdYZnbQl7bExezIH81qIGQ/oCqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Znztl/jn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64A606A322;
	Mon,  9 Nov 2026 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Znztl/jn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794203743;
	b=s62NqadJYrm8GVOheYWshEquuyQmqz8vuyRT6QMAd9w3VXv/F3A1Gzyq5aw6FMRxIuzU
	 4T/XXfeFlYouJRfRZr0fERDExc/AOTb5TZLLCyFJdDgo2hgTaHFQCCnOshE6GefvdUT1s
	 WUalYIMbYj0tpGj8k9ThNT8vuLR0C8xeFaMn6czgaT5/FqILnxQ57SdzJQqFNZzsnpQzX
	 fqHEoVPRDYtSuzKygELAcVzPkbyBjb83Om3e5FPA+1Q7Lq+2o6ZqHR+u4t25zBb9Q3ccy
	 RxVa+v0s1et+rVzA3T12WaxIiIjDdpnENe//1vDUoTl+Xu7lgOgT7wXz7FL9Hmx0XeA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794203743;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+8zu6JFXVibAB97Q9yxckB/ueOt/mDgkczf1Z0EUMjo=;
	b=IsATBadIgi76aiMOE6zADLl32i+ZfmnxeCD597dzUiQe1ny3M6kHPEFUNjMXBNQ93v1D
	 kzXc3ua2QO+TrC3L310ME2fsS5+xp2NXh3JDpGzUZ8O+KU7sqPER/XPCG2zhUYJ24Lrtx
	 /8olzf8VFZsg9B1vhfOiuHYZQcH9R4aQd2JIDCSErUjMMv8yJNiVyqq1lW3U27CGcmKSw
	 OnIniFgg+xlSm4wczqPd4ZlWBD8ohczLiwjPcK9rFJcxt4WwfCdB8IK3k9LwnqkksMVA6
	 z9B8E6lxeKU3x9YPPJhtq30rp5gRhqVAUoeovR7M7Rd410UFma2gNfaJZ2S24sviiFA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 149D01F008A1;
	Mon,  9 Nov 2026 05:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203743;
	bh=+8zu6JFXVibAB97Q9yxckB/ueOt/mDgkczf1Z0EUMjo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Znztl/jncLtUdrUs9HcbGM5LQW6sHXCkTvd3gNKeAgTGwE7k6Pru44WusuJSPue3p
	 pUsm9TbV7PglBBF96uafhXLW+hEnieui/u9xCvdxnemk9KE0eW/AmTOhqNg2ifrqSK
	 c2F6OWxAZB1KlR6zzf+StDUqrRXoRRxhRE90i449AkuXeUwxjxCbQeMWmyFi0cWlcq
	 rNR63W1uXv2uUx7GrrY8TgHiZeSw21rbkAH9X34ZsNGX/vJ01xr/Ms9DAlqcb17B2N
	 RwIY0gvwZmX84NqXJfEHTZ/z0fj/uwxTXT5qxWi/ECUDMoMDfxCPMgoLUThe3sAefM
	 OLv36XOUiUqoA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8CE51482D8;
	Mon,  9 Nov 2026 05:55:41 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 13:55:40 +0800
Subject: [PATCH v5 2/3] usb: gadget: gadgetfs: prevent ep0 event counter
 underflow
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
Message-Id: <20261109-b4-gadgetfs-ep0-v5-2-f16d0b648bc2@gmail.com>
References: <20261109-b4-gadgetfs-ep0-v5-0-f16d0b648bc2@gmail.com>
In-Reply-To: <20261109-b4-gadgetfs-ep0-v5-0-f16d0b648bc2@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neill Kapron <nkapron@google.com>
Cc: Jing Lin <kayano050408@gmail.com>, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794203739; l=2063;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=vqwB+Wlcpj/WeJeMyvBHLGgJ+JSJZK1Q6iHMWRJUsu0=;
 b=jP/KXYyXBBEv1X8X/NIF7qL7n36OvBHWCi/dJEuX/gS8U9WtJygerBK8rmYPA14uTGd2i1xZ9
 yyjiZof0HrADZslBDPG3A+P6v1IjQvfb0iS13CVMQn20Duy8MEex7A1
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=pr6i8RN1WEON1jbXPdghSglxaBSzfuJjXNGFknX//+A=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/default with
 auth_id=1441
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

ep0_read() snapshots dev->ev_next, drops dev->lock while copy_to_user()
runs directly from dev->event[], and subtracts the snapshot afterwards.
A concurrent disconnect, connect, setup, or another reader can reset,
deduplicate, or consume the queue in that window. This races on
dev->event[], can drop newly arrived GADGETFS_SETUP events, and wraps
dev->ev_next if the queue shrinks below the snapshot.

Dequeue the events into the local buffer and update dev->ev_next before
dropping dev->lock for copy_to_user().

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index e9380538e..4635a603e 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1196,25 +1196,19 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 				break;
 			}
 		}
-		spin_unlock_irq (&dev->lock);
-		len = n * sizeof (struct usb_gadgetfs_event);
-		if (copy_to_user (buf, &dev->event, len))
+		len = n * sizeof(struct usb_gadgetfs_event);
+		memcpy(tmp, &dev->event, len);
+		if (dev->ev_next > n) {
+			memmove(&dev->event[0], &dev->event[n],
+				sizeof(struct usb_gadgetfs_event)
+					* (dev->ev_next - n));
+		}
+		dev->ev_next -= n;
+		spin_unlock_irq(&dev->lock);
+		if (copy_to_user(buf, tmp, len))
 			retval = -EFAULT;
 		else
 			retval = len;
-		if (len > 0) {
-			/* NOTE this doesn't guard against broken drivers;
-			 * concurrent ep0 readers may lose events.
-			 */
-			spin_lock_irq (&dev->lock);
-			if (dev->ev_next > n) {
-				memmove(&dev->event[0], &dev->event[n],
-					sizeof (struct usb_gadgetfs_event)
-						* (dev->ev_next - n));
-			}
-			dev->ev_next -= n;
-			spin_unlock_irq (&dev->lock);
-		}
 		return retval;
 	}
 	if (fd->f_flags & O_NONBLOCK) {

-- 
Git-155)


