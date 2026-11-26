Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661110;
	b=ddXzNdZ07n+LR8caDSo1EFvzNnF0br7h8VOo7DYyq/CtJz1WWiBelZIDv9JhVJUT5m/B
	 08ntT5EAiB4WJ8qfZxmxil2EW/gN5FQ5MEP2koP1wVaRAgkyL6XJ1VzDrS+DOfyq3eHwm
	 wR9yFOZwdLUXxwMDwf00RauMsB4EAVWn4uVfqKrS8vpuND4cixx5TYv3GigbxtuNJFavd
	 b+wF5ZNvAtjmIfJBmpqJ0UVSZ8FdUQrnzcK/laK5jH9z5fYg1LGqpBmRFe4HjLRi2qrgH
	 H8KAg1L27jcWjYB+BDwJrRS99UlJ5ruZk6wvLBTDxDxvobykQmCdQxwH0gCl35uMFzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=/0xg9WnJ4xA4j3RnhckkeXOmdyeehSClwBqizSGK2+E=;
	b=4O7upMohiibqxbW42A9FoicxJlYq842h+UJiIEON2C3I5aBMaw1gUCI+Pb6p7HSyubYz
	 ZxTjWOzDSh3pA5pPLPOJM43tYVuFTdZaHCjK9+ZLuUkW4w2UzGujn1qZTahGm7qxhHetM
	 L76bqh67Mw1d1XkOrZb6OZ2saHCRpOh8mYaCV/gip86SOwSajCyhiWPxm4qrB7ZZUAkNq
	 YvIc0Hcrn2GWOUWerRBcM5B5QffKebaltjmBziyXdrGrbusjadzANY+nebdBqfGIpRcj2
	 4h+zSLF9yucRWAfuBn4/IUtRUNO2sm07wXvtghUPQKuofQLFgQqfmHbXYGnucpjbAYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=YSZyFojK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0D606A32A
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41F0D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=YSZyFojK
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-677bc4704cbso7726960d50.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661109; cv=none;
        d=google.com; s=arc-20260327;
        b=iUhRUv7zEsPlzOutthByWQ3o6heF3dQTP1w1Wga97bNPrjwKwnNB8kiAh8i0/bCdyV
         +mPRm7rTivxk8ypNuLxTYKNg5tLdTwcHVe7rwIoC0y8ezYO3qAs1dCMxPT7JHVVO0Rk7
         W//lrFiuus0xiOr5qLwONc3gNQrTVhOZFbvqHqSNqvZ4Kq/siNZtmZZz9GDFrwtPsfnn
         U7iuzPfiouAtbhqnSwrM7iii2ePEai3+FTVjvupq2eSR9pF9UBQqqVsnOE9I4eeomV1E
         4ElHh42nQ75aaBXhdOkjI7l36yAu58c/c70KivAtS9gE+xEPadjxgXSnUOrWL8s81MOx
         ef7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/0xg9WnJ4xA4j3RnhckkeXOmdyeehSClwBqizSGK2+E=;
        fh=59V8OffDL4lTKuEjiGaz+wvnez2O8ZH196QtmfEDrMw=;
        b=H1eyE64F79mYfhqfLz/Og2iWl+nNztwtRH5bq7GtJn77jjuneWXEAT74ZszecWyfbH
         pI6+DqFozGP9G57VddkghU7FyVZuksYugXaOV5UW94uZGmiqDf7J9vBOt4JpcQO6UBob
         lDMb/N1DGWi50RbniJUsCxnOgmP6brrQsADrOOs/5izl4Yh7aLp5VM7JfkM6e8PUu9oV
         NMJEF2ujBHAyJZwXxwRvoODULlFg23kDd+rChdmQHMQEZET0ePvyeF6ch9NPGLQIr1BS
         RzbQGjc39ioShTelQXi5em2Kv02xu9Hlv4Xq1q1CTHSLpk55dcDOodd178SbQwENQVlA
         TgSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661109; x=1796265909; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/0xg9WnJ4xA4j3RnhckkeXOmdyeehSClwBqizSGK2+E=;
        b=YSZyFojKq3bG4WC8T2VFHphp90WVwR7sQy3s2Qq53CeOw3XNRFZpI+qpJ8Qn7ADhDL
         FoWn/llGclwpr+4muEtL7hKhwiI7VYdLwR+O578uaAIWwOdogiNtRPiD5fJqZoEQgxFm
         7yDkzZ7FAWOSyE0aq2XI+LAwnl7i/58KxcCHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661109; x=1796265909;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/0xg9WnJ4xA4j3RnhckkeXOmdyeehSClwBqizSGK2+E=;
        b=cseWHufwryAOlCYPeSFMwF1bs+dcLFMgqPr0jS1G2jL0d4WEcrc9NIJ5O1uJbAL/vw
         2gbe6G6a7b/GDDeU5a90MOJyOhtVzRl2A+jkVF44/axlQrNOtQ+CZMG7jaURAn6b0AQR
         A08LsIshndG/yAb5EoNtnkKvm67QUoxBG7W58EQd6oICA+K2aHm4OUurlhrpkbpgrslA
         mcqdRlGVj5wbimUmM48xgAWngxKm5bu02PaKbJ7nQWg/drXimQoYI/w1QuEPeZl5j2Fl
         dGnRvS8ipnPg/Zum0N2kwg5ckKqWaUQTZNQBT4uz87ceaeXCGV6/YjDzCkReHdm9vk+f
         FLLQ==
X-Gm-Message-State: APuU4Z+oXHDdPZn2f/1ZZW4MqL7UqKiLNKA0GeQbKr8XUYqAlvsjIktY
	NzuUEeKhV/5lzWNYLoLXlyR7pcQHcx5wmStUQQ/P7NShoE2+eCMHmLmBiLjB2zYxDp5GwM+/amK
	KRp8CFxzt2tOpYctfEzu4c6xEfWelzzSotxiAtwNdNcQuuhv2WMWZmHU=
X-Gm-Gg: AZFdTZe0/5lRyiCXeBM9Stw1XanuGiysNIM7bAfUyvgqKkbPhxWFEAQrq/HEBEmXwUf
	R+eMgW3RKBVLXAH345PoYFZokPCUVJBZXCHJFtYWkadvdSk/8dLUc9Pewuo9iOcSRxOViVslPWf
	kR3GBCkrclFmxjjZQmm9bJfP8JkgVwIO+9ZMYz3OKwr9yTlStsYdfVHanI2AjS2GeHabOS1DcFM
	rmuwd5d1sslEqSpapiFZ62J/9ALrnxMhfwP4YxKYzA1ECW6bKRctcsyoNn0sn+fjcY85pi5xGt1
	FcnYcZkjdgtM8ZC8dToEo94qq1Bpp51W29PHNo1N/DsK94BxmNCHcoHiHXSzB0nqRQv0bTJh/tb
	6NJNTTxR6XQnl9Ca6I0hitOJz8kUCMeKmHCTQLsKStDblSFpxvrMiu5WVGBc9ycSRFlfWc/Pdl7
	CWUG7YBuPR7gz0JTN9gVkCUDDNSHrrHEwOqp/hSDvoS/HehqunwPtPi8Vm9XNknjetZIW0ICi3l
	wOf8gC1YrsyX3r3On/217hknNP4ZCpVS/xb
X-Received: by 2002:a05:690e:438d:b0:67d:b9c2:3d39 with SMTP id
 956f58d0204a3-67df44556ecmr4098773d50.97.1795661109244; Wed, 25 Nov 2026
 18:45:09 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:08 -0600
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
Date: Wed, 25 Nov 2026 20:45:08 -0600
X-Gm-Features: Aa3M54paIFJUchZVb6P5CQuzxQRXvyj5HLL0xeT27KaPRrHW7XTFKnxEJ06Kuhw
Message-ID: <CAFaZ9ep1MzprNHirA++5XpLuQC4PhibJr_FBWHxEt=Exvic1QA@mail.gmail.com>
Subject: [PATCH 6.6.y] Bluetooth: hci_uart: clear HCI_UART_SENDING when
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
[ adapted to 6.6: no disable_work_sync()/enable_work(), use tx_lock
and HCI_UART_FLUSHING around cancel_work_sync() ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.12.y and 6.18.y already have this. 6.6 has no disable_work_sync() or
enable_work(), so instead of disabling write_work during the flush this
adds a tx_lock and an HCI_UART_FLUSHING bit. hci_uart_tx_wakeup() won't
queue write_work while a flush is running, the flush cancels and waits
for any running work, holds HCI_UART_SENDING while it frees tx_skb, then
clears both bits and replays a wakeup that came in meanwhile. That's the
sequence upstream gets from disable_work_sync() and enable_work().

The serdev follow-up, ee43bade37c4 ("Bluetooth: hci_serdev: serialize
flush with transmit work"), isn't in 6.12.y or 6.18.y yet, so it's not
included here.

Tested on v6.6.163:
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
index 548e58e69eb7..8c43ffb30725 100644
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
index 753343ca8489..835ec8f2f09e 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -313,6 +313,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu,

 	if (percpu_init_rwsem(&hu->proto_lock))
 		return -ENOMEM;
+	spin_lock_init(&hu->tx_lock);

 	err = serdev_device_open(hu->serdev);
 	if (err)
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 39f39704be41..2687f76cc01b 100644
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
