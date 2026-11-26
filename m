Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795697116;
	b=Y45KyYgVca7WlGWUzOocskwxOqJxN0nNqCEMWXyCqfhD33fZ4pVXn+WSZhHikhnXZjKV
	 KUPO4sNNG5tqG0EfSKDNjZc7ikBylYbsO12Q5sSnw/2fzI7nsZhoSJp36TQ8QDoypejOk
	 zLX/2yTHIR/a47UPobHNr7rZo90VwUqNt0OO6mNIJKhm6w4Q/UZYdnnXcQfXV0swjXx9E
	 tjySz9uNPVP2eHuyDznsKj0FsqGaRHOsWNyGLs3YLzxFwLLlM4Ze3UbUW6QcPb17qYIN5
	 8CSs7LGaEzwVHZOYMzT9YTs19bTwKMa3Lp+/9+kbeb94suabdorFpMa4reyM/TyO2kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697116;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8je/0oGrusta0mUZ6M6HZmtd38yKDaggVcYGdc+rRi4=;
	b=dTih4LMqm7QKroHrKy466Gc4AU47j9x0gsaPyxswsEkvzM4IZBFI/vynJ6zc+rfKwzFM
	 NNAd+ZlHWEfoQrUdBz8WX+u9TIcGwyUJePXiboYf/EOE+CPDsUCmneYCuI+1YhrK5/exJ
	 DjueimGR7wnQ1OrwdXvfHw5tWcQQaRtLHigZOjF+0u/idKbpbXWeraplbqn94OMb5DVHt
	 u60vIGAS7V0GJZy1lg6oaE6e07wlOeJyUIxJEMXeRA9HIUvqWJtka/zStXtYHPd1537ao
	 VtZmwj298kGNJjhlB0+RWeohllVZ1za6jGySKUAaoh02rHvVIZbGerRoxweJnzcNAWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I42PQ0DE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7418606A692;
	Thu, 26 Nov 2026 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I42PQ0DE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795697116;
	b=plx3PPGcIbTHAnFNWwW7POsZ50N2/coQ0h08b4cRINUKRpaLSb8KXswYiPnCXmxk0r5F
	 +yds5eW/myFUgP9raKMEKCT5iJwH5ZturwRUZS7vweM8kkNWPA/9NGduxiWe++lH0WZs7
	 UMYymwKC3bykFSf9zvzi9064srHJQ/plZHDICOjqnVYJOKLxExe6tHxZIrvU1Dner9e2r
	 kxI/J1MZJZxRg0gFnIQiDtMOLxt+MNXPixmPbhUmfO0Fr2vNMUg24eoFoItPOOSJo/n7U
	 D5PRxpJFbjTzMf5uiyXmGFSe3ozBAnGfJPwQOgMFD9l259JwrnJjqbMniOLjR1n10BA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697116;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8je/0oGrusta0mUZ6M6HZmtd38yKDaggVcYGdc+rRi4=;
	b=ZgiVVZN08L3EDaWt0ndWo6sBsV6ajYSekY2Nu8B7ZQdYse5JPCKGAiHYWBKjLvVTjFfm
	 y4woHM6XOk+PEeHoozlKXkpK5JZ3vrCSkIvDhNioYUR5Ih/GBDswNkXLYjz7v2xagKVDX
	 vUMJc0Yf6or8RRm1n2glmUVIHqtEp6uwhJbcSQN7qIhaWOHNPFCn3j++uZLrrU474P/rX
	 84lAL0lPrURHkLBS5DpXn/HPGJY1dVDo5YgMJMp1yWpH+E4b7YxazpGn4+dzrfzjzFVkf
	 EsnOZE5EvBiO3PBOE/uH06DHBDYmgLbAXKpwQaQbyBYKARxdKFq1oAFxGGrN7a6IOWg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C33751F000C0;
	Thu, 26 Nov 2026 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697116;
	bh=8je/0oGrusta0mUZ6M6HZmtd38yKDaggVcYGdc+rRi4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=I42PQ0DE6IFDRwxUeFANt28whEE2BQZsqiJtuyYsHd+pd7nkKYmOJyk3okL3IRoXv
	 FhH0HCGZKIhH9sBPs+BpfZ2c8+illyAaIQqXy9uBU92ykCGK3RCaNWrl9R2B5IUILq
	 uiRQFNYxEAXtAN3hYeHBsGUgGe+0HCp9fuPCLrNMo8Rw3AaWO+TnosqeGmVBMnIixu
	 KWqO7/u6xoXFSCaayZfVpbiLG1uKhpsnn5e9zBzs2OkG4a0yPKuWbkqygLSqwvtPzH
	 sf5egz67zem1BSWfLaWlSv3wHFcbIZFRNTbt3Ior3GrvSFuWzLgdgDZw9DAMrR4+jA
	 4VjmuFel7GNQQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3CDDC4D4F3;
	Thu, 26 Nov 2026 12:44:55 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 21:44:55 +0900
Subject: [PATCH v10 5/6] usb: gadget: gadgetfs: prevent ep0 event counter
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
Message-Id: <20261126-gadgetfs-ep0-v10-5-8add6d9cace2@gmail.com>
References: <20261126-gadgetfs-ep0-v10-0-8add6d9cace2@gmail.com>
In-Reply-To: <20261126-gadgetfs-ep0-v10-0-8add6d9cace2@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Jing Lin <kayano050408@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795697092; l=2643;
 i=kayano050408@gmail.com; s=20261106-gadgetfs-gmail;
 h=from:subject:message-id;
 bh=gnhARaBCg06mbwKKexBvzjAqQQE3d8915jbK+awmKUM=;
 b=fxiFwfcVN6cs8Z4fC37d0SMTe4B0bNapyNXvym6M30SEJv219Ac9rT9cQ8He8l+Y9Ejn5REXP
 OxPXLBsPk/kBkCPOqNvyYhRV37KBVlAqXcppUWjCbGuLY96PAqPglxd
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=DtAI52kU3F0sVbAiS4n+5b4UKMnVF398eKHlj3H9KBY=
X-Endpoint-Received: by B4 Relay for
 kayano050408@gmail.com/20261106-gadgetfs-gmail with auth_id=1433
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
index 2d96320cb..ed26cef30 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1285,39 +1285,34 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
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


