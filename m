Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675044;
	b=K4BtGgUV09bzoeoORyFJ9lOOPllq8xayZPAuFeTXGghOqfp8tKuLHpEPT3dOx48bAP8h
	 SCRrCL/PdlEDX/menVknP5zE7hcnlOn2Py7jgMB3GfY1pwcCaWMhkUFvFwRUaL3cejRBB
	 FiIypzEHFbczdt6NziF3F8m8m2PX6LtwU1Z12G3623z3VIiIIFs2cSfjTJfEAzr26eI3N
	 2d5K2o81LX0SH6mJ4pQqEqSaDlh0FKhLClMzTayYF3X2g5aGR5yF2QmwgcCFPOqXHNsAc
	 S/7b5RexfKJDxKCJln56t7q9IcvVVUwJS1gZp0Hgctn49NsmMIG6txlWXIHM7b4ye2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675044;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mOoLZb1ISBhR9iBBeNr9Mgn96TDs36erUEgke8JE7Po=;
	b=2pZ3gZDoB1FEkww4S6ZgZAVYOcCpV3PB9RZeRuZoIHgvIyAbwhI2rASMSp68JhvxG+Cx
	 zlrQoAMnyGi+rd0bRPrtrcgHyzYaLWHcW3ZJZkP0gNPCz1NT7Kkf3V45gaDaasln819jM
	 VY84msgakcXPlFNiZsrJMu/9cvQ/pIAnughqO6p3O0EhskWQQW/YI1uETKHthoZFFRCc9
	 pXKjg0MkHvAno8Z+YRMrP5gYryluThwHvG3/TnOEUscn0MJfbvfvsJwBQM/JifNsF8Dnh
	 nFWeigwhWxHnXjVl3fskdISq2hVy21cu4nYmcy64itNEjy4aPDbDTSpqcbTJ+DrtW1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g3/VxemK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC5606A32E;
	Thu, 26 Nov 2026 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3/VxemK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795675043;
	b=XzxKLa5Ttv1MsaGWtxJLKh/HzXuIo66LilJsj2f4MvJ6os5gz7MK/4j2obhOtSMPrx5z
	 4qLrEfHNN7pGynxmTusU7TKg9jgSol2icQyo+TwxPEE1stVi8JNGbPw5UKPqRIeo/8c3l
	 Fc3F2+Yd/zvzHI0DY0CZCBwasnVkdF6fy+BN9/m1ZrZ36WHWi6n1smb2lYsqsYpb/PZZp
	 7BHwyAvvc+a2V48uTMhkKW571X0Gcgoj7Za4unJaYIKVn8b/jg2+F3RIAFRvHu5OZXykl
	 YQJGwfsfDl8kXSUGOlJDpStM2PzHLriiG9K3egpd9G7zRfXncH7cqEg0jEBhbV85HhA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675043;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mOoLZb1ISBhR9iBBeNr9Mgn96TDs36erUEgke8JE7Po=;
	b=GpjQB1mBFxtBtJz9YC13T90KwcmPdAqN5PyoHYbE6x0i9fQTDdHjuFflglKeMxCldcwM
	 W4fF3X1jxnaQr8b9VlsoC7GE6QGU7g/BN3JRpsDTJyOZdsybidWtsuWrc9Z4Wmrk/PPzz
	 Sz6Jbqx3YW04a/25qcYwV2D3nB5OrLfjLqykCutmDM6T0n7hrL6KJGJ+ZM1OClg+yY0K6
	 bYHHH6jMTOTh8YahAuzXKQbvNAswuHOm/sRhW2X401YkxsQ7o7H5cbTPfx0K7Lg3VwKEw
	 rXjDev3CkT3JfVzrud6ehn1129i3Nc/F5rtcjutBR8QApo1v/djphMf69oqAq3kku/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AE0131F000C6;
	Thu, 26 Nov 2026 06:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675043;
	bh=mOoLZb1ISBhR9iBBeNr9Mgn96TDs36erUEgke8JE7Po=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=g3/VxemKJ4aaIb6jLRZIIW0L9e5bb0jcA2ByjGNmBnfbpX/tuBAgAUhxPlsBVdEHa
	 c2fivYsX1Cpkoj0odUKvRL5PCylmHVFa+aj7WgBrNEaiA1ZvnlLPvTGj+Twz972jtG
	 z+UDAMmVy85kl9Puw+RkkFiho50v+Hy9vm9OGyOXq4b0vSOZlC02mnL6EHa/pP1ML1
	 oACRt1AnbfLnhZ8HVHtu+7Dshsbqs3hAAoTaD/lkRuL2BG6IpsSGUOYF4+IvjgmIff
	 KC9w0N7Ug+fTp4hHnzEkP/WeynVinkp3BxA7tgZL8zovoZrgh5rIoEUUdPIM7K3l59
	 rIOMVDxdPEDpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 585704D2A0;
	Thu, 26 Nov 2026 06:37:07 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:37:08 +0800
Subject: [PATCH v9 5/6] usb: gadget: gadgetfs: prevent ep0 event counter
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
Message-Id: <20261126-gadgetfs-ep0-v9-5-81b464c6e641@gmail.com>
References: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
In-Reply-To: <20261126-gadgetfs-ep0-v9-0-81b464c6e641@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795675025; l=2649;
 i=kayano050408@gmail.com; s=20261126; h=from:subject:message-id;
 bh=Ev8mN1dp8ankrYQgghHH6uHCg4My/ictcIhW7RajJbY=;
 b=bQXR4g91XKEE885M41iUBLml1A3jGw0rvKUmpN0/4dFebPFid+rtupxoRqpiQQJpRxN6OX7o0
 fu5IHJshu17CAZQIXd5xuhoG7rkoL8fPGMOx6Sa7wvNF6AW6QwDt+JD
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=40M3hugIx++9w3nkAoFXGcN/vLWsPMGDYdbduV+lUlI=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/20261126 with
 auth_id=1648
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

Dequeue the events into a local buffer and update dev->ev_next before
dropping dev->lock for copy_to_user().

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 12ae17f45898..bd77d0848db2 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1275,39 +1275,34 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 scan:
 	/* return queued events right away */
 	if (dev->ev_next != 0) {
-		unsigned		i, n;
+		struct usb_gadgetfs_event	events[N_EVENT];
+		unsigned int			i, n;
 
-		n = len / sizeof (struct usb_gadgetfs_event);
+		n = len / sizeof(struct usb_gadgetfs_event);
 		if (dev->ev_next < n)
 			n = dev->ev_next;
 
 		/* ep0 i/o has special semantics during STATE_DEV_SETUP */
 		for (i = 0; i < n; i++) {
-			if (dev->event [i].type == GADGETFS_SETUP) {
+			if (dev->event[i].type == GADGETFS_SETUP) {
 				dev->state = STATE_DEV_SETUP;
 				n = i + 1;
 				break;
 			}
 		}
-		spin_unlock_irq (&dev->lock);
-		len = n * sizeof (struct usb_gadgetfs_event);
-		if (copy_to_user (buf, &dev->event, len))
+		len = n * sizeof(struct usb_gadgetfs_event);
+		memcpy(events, &dev->event, len);
+		if (dev->ev_next > n) {
+			memmove(&dev->event[0], &dev->event[n],
+				sizeof(struct usb_gadgetfs_event)
+					* (dev->ev_next - n));
+		}
+		dev->ev_next -= n;
+		spin_unlock_irq(&dev->lock);
+		if (copy_to_user(buf, events, len))
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


