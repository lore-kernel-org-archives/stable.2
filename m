Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794278517;
	b=Wdd39Bd80qf7Xl4aH/2OKQa08YFBwWqH0iLCuzgDBFMzNn+jWjMROohhMKtYujPhDTdT
	 /5sQhq6j7r2YnucRxWxwj77B9BwHpAvLuo8l0VwiCtAFdt40hHts+uqalRUQ8LIML6Voc
	 pGAFPd9D3sURedZlDrpAXHTycqwXqQWGZLsAIIGnTvXeogGpPKiyYKj5JkrihCXHRdkYt
	 ymaOXdYaTPduM3HQ2DVgzzP1Pms6o1nJ/MGlk9WXyV+zRANMJlep/mRMjc+dtO2rvRImD
	 sZBlnhxz+97fIG8T8zzUcOj2gkmXRYyy37uq21eFC7KEnsQ5g7xaUfFkx6EtJ/xcK6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278517;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=P6zg6npAhreWicwc/FI9i2ATVZQoqseDoVJe2Yqx7LA=;
	b=RUJxYo8UZSRt4GOcIPKswd2uGW5zrp51P4KoBfBfIHpL9HTrPeWUwR3BjMFq9oDWlEwB
	 QF1//zbFLtaDSJuagIXWr6rRz6TPE/we+IZeximfDS/Y2nfbLqDuVHtO+MBLHOlE4vcIK
	 R7UDzZKBTim4k037wP+gy4YkUjOaeLNj1sg6cFhM5Qii7XuiKrVJUX6Wqneb7c2Unuyau
	 kJ1rIIR0A/FyZTNVeawO7OBNgMLS6OTBYCH5lYM3pY6HxFfUhN+fVuM2H9r5e25QlGos2
	 xEocYt6WouGfp3q/Lu25ZmMoth6MQcGarZTH44HjcyinIi/uQAhww+oZRhdl//Tbz4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJ06U85j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5E6606A321;
	Tue, 10 Nov 2026 02:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJ06U85j
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794278516;
	b=Gr3MTbSM4RccOy5tyuv3roHYZ6Oh7BB6xLm4v4HBGEgi3iFxfRDgCD99rSP1hjbJCNgi
	 ndp3G6QIZIrmjJ++Ej5Ty4rT303Cs2cjRxOBrabBw3EEovaKyfttcvMeGnxy6M6rkUkZI
	 UBvc1aBNz1G5Ws9ONnmsLZe5Km7A/da6XWwkkuBUOXycUPUzywGDgzlaDd86yJ5+DJcsF
	 qOU7iYxiMBnb3dpN2AYYh3YKCUgr+ezMA5+aD3vckyo1i8aDGFOS/ZUlbf6v56gpUAItZ
	 YeRP+ghhteSfmomk6VdOJbD7IhlaufO39MN4MUrmZvioT0Xq2VJt/EUOqNwG3Mouaxg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794278516;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=P6zg6npAhreWicwc/FI9i2ATVZQoqseDoVJe2Yqx7LA=;
	b=MDlf9Bv2EFy6D09SnA+SnEo8aAtp+DuvZ9w38n9A9C7q4fYTmYcB8H1EZnw8gZFu4aDy
	 3DBUT2rGGmIsARlQhOrKufrHg8I1msst2dj7rs+wmXzSelbs4oQ5Lfz1A5oCdRWG6E4oF
	 a8mCiIf00vosYRZOjZ/0pljsxSMg7ztkNoM5pkeo1N4yOQzQTnRa0S6xAMo97/XFgJufu
	 Yxs12a/OE94oleLG3JweX4vRwLlE0v70d2cvOEN2Fd4HDcFfS718Wae5+TnsR19WVt0/X
	 DTjeWd/NCFCrfrHSZXn955PStPXkKXC4rKOD2IdkFO0h4QDCSIZaz65T2LdqlBXxspg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C51341F008A3;
	Tue, 10 Nov 2026 02:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278516;
	bh=P6zg6npAhreWicwc/FI9i2ATVZQoqseDoVJe2Yqx7LA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hJ06U85jtJeqmavRozNBRQZ0Bi3SJ3ftGqRpqfOURiAHY9iCaxmIL5XesjoECQ9M2
	 VAtCkfDt6UeLQS45NVca2BaBo6qkUIrpLds2eMFjg2YdszkdqzX3QoA1CbcP8W8XRt
	 /x/lZxapOd/WseQ19ZBNDfZNKLSsH3z+2Lvkp/nqbqEfIlrBFfM4gaqP+1TfpASmT0
	 uw4SjBvJPFr58s2K6y6iQq56jD/DyQxQwtYX3ZF7isEMSg+KDvUC++c28jpU0zY7hJ
	 unfYEHmgL87PWi31n/rhd9aXw+rpnKNIsmJHBG42bpgxZHe4omX/Xcg89cUWz91U7S
	 rGKj8Qz0fPxmQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 50C6A4878E;
	Tue, 10 Nov 2026 02:41:55 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 11:40:49 +0900
Subject: [PATCH v7 3/4] usb: gadget: gadgetfs: prevent ep0 event counter
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
Message-Id: <20261110-gadgetfs-v7-v7-3-6d05409cc61a@gmail.com>
References: <20261110-gadgetfs-v7-v7-0-6d05409cc61a@gmail.com>
In-Reply-To: <20261110-gadgetfs-v7-v7-0-6d05409cc61a@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jing Lin <kayano050408@gmail.com>, stable@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794278513; l=2000;
 i=kayano050408@gmail.com; s=p600; h=from:subject:message-id;
 bh=lkYUW+XIlbdK/rh+1VF/WDnE3MNRdwNCKjzdXPE9Fvo=;
 b=xdV0LO301dIjt70LNgqdbL4X13NcnfFZpK9haUSjFq+MHE5dxKccphBn6t20Z9TFL1xps3SyL
 3ncoWLRvj3+CnWTSA/aWLb4bOQGY+J9s1z2a8W6ru7qBn7ZTm3M9N1H
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=DtAI52kU3F0sVbAiS4n+5b4UKMnVF398eKHlj3H9KBY=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/p600 with
 auth_id=1475
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

ep0_read() snapshots dev->ev_next, drops dev->lock while copy_to_user()
runs directly from dev->event[], and subtracts the snapshot afterwards.
A concurrent disconnect, connect, setup, or another reader can reset,
deduplicate, or consume the queue in that window.  This races on
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
index 6514220ef..0b3210f87 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1266,25 +1266,19 @@ scan:
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


