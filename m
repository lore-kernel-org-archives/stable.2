Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661101;
	b=zpBNF62jTEt0Ct8uOEBwt+1w9sC4zVjC2viC9qBIhDgowtkwqH02tb1vtopLgwJ3NkTu
	 +wAhlxFG9bFetYd9Q0+RrkiygnpmQ07u00WJk6hcn1eAb9GQ2eIAMRfXDhPkbQ80JNo9u
	 zAfz3cbT1683rCZORYXf6utZgYqcskTjiXV1gnfcSOrD43WBSVPkFXN/z3KTIJ2Uvs+Mi
	 GsdFXgZqGv8wb1lYdZPrB7Xqpqh8ax9XNdBFqFmw0qjRgH9O5tCwram4BEKNmeH7a01y5
	 Ev/AL5jltZBDwDKlU8sQ0D9R5AVtTAmcn+GAUiV9TBI33C16T4CRj3HDs2tBEQ6jwiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=VhNUJQwP8CSjFXalqYtowL6Skz/j8h1yFOaRbiFXG5k=;
	b=Obp2O+OH+G3bG50Iku4E2KcSrGnqhyCHajP7u8nyMbVEVNDj8bBEpYszdv9WEbFsNg4t
	 dQFWxUICKdyy8sgdhKfr63n6MDAd1l8m5gRGBUZVLTTYXrablrTfmUcixIiQCHBKrkfyr
	 Ha2ZY1wINusus2uyhkilqfJ0Yg5x24n0/+YS20gZTrXlow75KSi7n1xUl0E3QqmD5cZ3o
	 lJht6HuuPWBh7WRC2B1toaZQ7Wn46/5ojmoOFAUHIuDl+VR5l5yGiFDUFh/vLatD7tWM+
	 acGt5MZeUrfKPT5Sfp7/0UHtjHY6TyAIYgUcVeKG7TWFoPfQWzfq+d+bYs36oaMqL1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=HInRNYWB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C78606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80C78606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=HInRNYWB
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67db763cec7so6732808d50.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661099; cv=none;
        d=google.com; s=arc-20260327;
        b=YK1gNU6HZd2HcJj6F5utIhwnIts9S5x+gzCn+MNgeMvuWTLcR6OM7ixi4n/XrCI6B/
         Dy56Zv8QYNEHRdmEyGPdz9C6e/O3mPTnPhkuKHhmBvn+7+l5KtgcIAF6sT0FTdd8XWjn
         +Z84q19C4KeVNukld2OeXza+7GQqmU7+I0wqjwYxRDuJrL6C0qB0tc0eyeyi76zvEvUl
         hBXW7YlcjXdiuA7uKtyK80jGMD7McLUjXTZWdrHyVejVFDuN0J/a0CLUGwElQVkSaFn0
         1dclFO96jFgG+lzdimswbrUMQGmxx/tRaHIiyCQIhiIyPD66mkRLeHQJIiE9oj875sNf
         6TgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VhNUJQwP8CSjFXalqYtowL6Skz/j8h1yFOaRbiFXG5k=;
        fh=59V8OffDL4lTKuEjiGaz+wvnez2O8ZH196QtmfEDrMw=;
        b=MRi3fo93LepQhTPs6sXOi+0BHHKjtPqZ9eyusM9uemcQs2ChUJyITOWkO5m6mzkeAt
         3ocjLTkRebXSyl/Az3zsnCWWBub2aa+u8RRawmZ3PnaNqVOJVvQ/FIyPfU54h4O8jH2E
         8vtEyuMuYkIYVjbU55P4KQsn7RTHhYhbb359BIfqjXTmBfLrZ4Yv1GFDbjVEsPfyzMiq
         AwDS05ZlQxLo8ooYzBdbPQd855tXJxRz5ItY1eBTkWyp98n9mmxd+WiaSZs0HYwe8Afh
         DQtAzLTy0FGZbU1nrwBrCpUS5fKUv5IVoeLjMceo0MmAGtYF/MbjYLgsTM5C47WRPPLb
         Vgzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661099; x=1796265899; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VhNUJQwP8CSjFXalqYtowL6Skz/j8h1yFOaRbiFXG5k=;
        b=HInRNYWBEpAkttfKoUKhCN9ya9AJs+VgL556Fw0wlghjBJgcF7YfaYfSn/XV7OSihH
         d28Fx/8m05flpEmtgBQiIQImNSRC7jvfPY2GgPaXLkWB/j0u3kj+4oBOh1+bJU2Senjo
         pHbJABXpDnhrWieTIszJo78B4jmxB7MU7NZgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661099; x=1796265899;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VhNUJQwP8CSjFXalqYtowL6Skz/j8h1yFOaRbiFXG5k=;
        b=GJFQ9VxPAqZSG26uMzVUYuvPYRKt1qJDq6Q4zNV1CepHqvePcbU8zO8u40UQlVONCR
         xha5pGnsNwqEtnYPW0Bxs0A6NcMmemUcxWVmomusLVWFRoaEJqOLzrtQEEkh4CZWSoQ+
         tQ+fLvSJJfS/euTYZoO/KhdixtJN9Y95o7GJxIoM0hc9i9sG7lxVatO9pNz66DjrKrt6
         XjB6BRE1h6pRlQENKpQ38jglz8Pyh5Ulk8/DoyyL+jJwuoc6RWvFi+/HGR5+YbREBjP1
         ciLDQpnQxnYJhF7x25e1PjtzvRwZ7IFZOALii7XzQN/Z+dWd6ynZb+VjjxrzBOzVR/3C
         cEaw==
X-Gm-Message-State: APuU4Z9SIIp8Q5PVcNbileXViUgfuF5TwBajQXz/cbYznuUM/fxtrCDK
	D76bN553MTcCrXOxm4YJ4jWTwNWBH3ThN1vYFlLXcf+W46zBrlV85KdtLmgeefCqIuk+AuwjLBf
	jGEwKDqBO5q6BGVUZymNWaTcyNsJmJ+yzCfK8OpmhtkXyrVFlZZBUXf4=
X-Gm-Gg: AZFdTZfpZSWaoYPFDEE9y4oLwgv6on5VrLq3/uTEkcRfjQs1a2EQAdZWfV1fxd533it
	n6DlWOmSQk74kKIy6zUpy6jpnzVl0YQOYtXvZcGvMclSOw6OY2WH04kcnfzAmMiq4/ImsntGcak
	H4ZqnIFriVIw3QNYZIRiIHhKf1zXj2W2+BaMIskq4b8h5ggvhuHl8wKGFNJJXbjFr6DGMV0LWbk
	93UTQkrKVZl5phEe5kx82JJHx1/HYDs+CxmzcX/juRy/iOizP3oHrEZcz9iHAThiVzTUbqW/195
	0l5esa0ULX4n80WHrh5Z6qWyydclyOUVs667wlR65GrwZ+5Ge+Mn0auACjW/0MAX3RnKFf9c5FF
	0gBD28qUq6TZyELygXLu5Vf3NQhwdYFE0mZmemoDs8+RepBxKT+AAVOAx3F4E7Eog7a3ibmEA8q
	815FWXuuLeJiYbUjlP74UmzYFD77upp4kChj/a9moRcgVy6ekyg2UyLqvaHh5ZLa90ieQlZ/GvD
	czvBkBRJCQDrebmuCKpWM9Ct+n19dm0kO3+
X-Received: by 2002:a05:690e:1388:b0:67c:1cf8:84fc with SMTP id
 956f58d0204a3-67df44f731dmr8007625d50.125.1795661099430; Wed, 25 Nov 2026
 18:44:59 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 18:44:59 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 18:44:59 -0800
X-Gm-Features: Aa3M54rZmltByzdyAAi6FQe8eTe1tx6OXDLIAOKM4fBYabFft5IXKXsVufugpMg
Message-ID: <CAFaZ9epjtBjMgjWapQR6QAzUYK4Ytq1m+VvwFv1Wu9kYauW0Zg@mail.gmail.com>
Subject: [PATCH 6.1.y] Bluetooth: hci_uart: clear HCI_UART_SENDING when
 write_work is canceled
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Pauli Virtanen <pav@iki.fi>

commit 1b0d946d6f08bd39211385bc703a440911b41e46 upstream.

HCI_UART_SENDING bit in tx_state means write_work is pending and blocks
queueing it again. Currently this bit is not cleared when canceling the
work in hci_uart_close(), which blocks future writes when device is
reopened later if write_work was pending.

Fix by clearing HCI_UART_SENDING when canceling the work.

Also make clearing of tx_skb safe by using disable_work_sync +
enable_work instead of just cancel_work_sync. hci_uart_flush() purges
the proto tx queue so we can cancel the pending write_work there,
instead of doing it just in hci_uart_close(). Re-enable and possibly
requeue the work after queue flush.

Fixes: c1bb9336ae6b ("Bluetooth: hci_uart: fix UAFs and race
conditions in close and init paths")
Link: https://lore.kernel.org/linux-bluetooth/07e0a28650773abec711ee492fdb1bf5d21a6c98.camel@iki.fi/
Cc: stable@vger.kernel.org
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ adapted to 6.1: no disable_work_sync()/enable_work(), use tx_lock
and HCI_UART_FLUSHING around cancel_work_sync() ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.12.y and 6.18.y already have this. 6.1 has no disable_work_sync() or
enable_work(), so instead of disabling write_work during the flush this
adds a tx_lock and an HCI_UART_FLUSHING bit. hci_uart_tx_wakeup() won't
queue write_work while a flush is running, the flush cancels and waits
for any running work, holds HCI_UART_SENDING while it frees tx_skb, then
clears both bits and replays a wakeup that came in meanwhile. That's the
sequence upstream gets from disable_work_sync() and enable_work().

The serdev follow-up, ee43bade37c4 ("Bluetooth: hci_serdev: serialize
flush with transmit work"), isn't in 6.12.y or 6.18.y yet, so it's not
included here.

Tested on v6.1.193:
- x86_64 allmodconfig W=1 build of drivers/bluetooth/, base vs patched,
  no new warnings
- x86_64 defconfig with BT_HCIUART, BT_HCIUART_SERDEV and BT_HCIUART_H4
  built in, boots under QEMU/KVM
- I don't have UART Bluetooth hardware, so the close/flush race itself
  is untested here. No existing selftest reaches it.

Since the locking here differs from upstream, a look from the Bluetooth
folks would be very welcome.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

 drivers/bluetooth/hci_ldisc.c  | 37 ++++++++++++++++++++++++----------
 drivers/bluetooth/hci_serdev.c |  1 +
 drivers/bluetooth/hci_uart.h   |  4 ++++
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 0116dbaf7431..1378ae614ca4 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -116,6 +116,8 @@ static inline struct sk_buff
*hci_uart_dequeue(struct hci_uart *hu)

 int hci_uart_tx_wakeup(struct hci_uart *hu)
 {
+	unsigned long flags;
+
 	/* This may be called in an IRQ context, so we can't sleep. Therefore
 	 * we try to acquire the lock only, and if that fails we assume the
 	 * tty is being closed because that is the only time the write lock is
@@ -129,13 +131,14 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		goto no_schedule;

+	spin_lock_irqsave(&hu->tx_lock, flags);
 	set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
-	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state))
-		goto no_schedule;
-
-	BT_DBG("");
-
-	schedule_work(&hu->write_work);
+	if (!test_bit(HCI_UART_FLUSHING, &hu->tx_state) &&
+	    !test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
+		BT_DBG("");
+		schedule_work(&hu->write_work);
+	}
+	spin_unlock_irqrestore(&hu->tx_lock, flags);

 no_schedule:
 	percpu_up_read(&hu->proto_lock);
@@ -176,7 +179,8 @@ static void hci_uart_write_work(struct work_struct *work)
 	}

 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
-	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
+	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state) &&
+	    !test_bit(HCI_UART_FLUSHING, &hu->tx_state))
 		goto restart;

 	wake_up_bit(&hu->tx_state, HCI_UART_SENDING);
@@ -236,9 +240,16 @@ static int hci_uart_flush(struct hci_dev *hdev)
 {
 	struct hci_uart *hu  = hci_get_drvdata(hdev);
 	struct tty_struct *tty = hu->tty;
+	unsigned long flags;

 	BT_DBG("hdev %p tty %p", hdev, tty);

+	spin_lock_irqsave(&hu->tx_lock, flags);
+	set_bit(HCI_UART_FLUSHING, &hu->tx_state);
+	spin_unlock_irqrestore(&hu->tx_lock, flags);
+	cancel_work_sync(&hu->write_work);
+	set_bit(HCI_UART_SENDING, &hu->tx_state);
+
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
 	}
@@ -254,6 +265,13 @@ static int hci_uart_flush(struct hci_dev *hdev)

 	percpu_up_read(&hu->proto_lock);

+	spin_lock_irqsave(&hu->tx_lock, flags);
+	clear_bit(HCI_UART_FLUSHING, &hu->tx_state);
+	clear_bit(HCI_UART_SENDING, &hu->tx_state);
+	spin_unlock_irqrestore(&hu->tx_lock, flags);
+	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
+		hci_uart_tx_wakeup(hu);
+
 	return 0;
 }

@@ -271,12 +289,8 @@ static int hci_uart_open(struct hci_dev *hdev)
 /* Close device */
 static int hci_uart_close(struct hci_dev *hdev)
 {
-	struct hci_uart *hu = hci_get_drvdata(hdev);
-
 	BT_DBG("hdev %p", hdev);

-	cancel_work_sync(&hu->write_work);
-
 	hci_uart_flush(hdev);
 	hdev->flush = NULL;
 	return 0;
@@ -516,6 +530,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)

 	tty->disc_data = hu;
 	hu->tty = tty;
+	spin_lock_init(&hu->tx_lock);
 	tty->receive_room = 65536;

 	/* disable alignment support by default */
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 158b057ed3a6..b3148a84e9af 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -312,6 +312,7 @@ int hci_uart_register_device(struct hci_uart *hu,

 	if (percpu_init_rwsem(&hu->proto_lock))
 		return -ENOMEM;
+	spin_lock_init(&hu->tx_lock);

 	err = serdev_device_open(hu->serdev);
 	if (err)
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 70449949d527..195957f41f28 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -12,6 +12,8 @@
 #define N_HCI	15
 #endif

+#include <linux/spinlock.h>
+
 /* Ioctls */
 #define HCIUARTSETPROTO		_IOW('U', 200, int)
 #define HCIUARTGETPROTO		_IOR('U', 201, int)
@@ -76,6 +78,7 @@ struct hci_uart {

 	struct sk_buff		*tx_skb;
 	unsigned long		tx_state;
+	spinlock_t		tx_lock;

 	unsigned int init_speed;
 	unsigned int oper_speed;
@@ -94,6 +97,7 @@ struct hci_uart {
 /* TX states  */
 #define HCI_UART_SENDING	1
 #define HCI_UART_TX_WAKEUP	2
+#define HCI_UART_FLUSHING	3

 int hci_uart_register_proto(const struct hci_uart_proto *p);
 int hci_uart_unregister_proto(const struct hci_uart_proto *p);
