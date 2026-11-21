Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795276640;
	b=KkPN2ZNd6hcwtcZdWZmbTSvT4N9XZyRcw3jUIRtcAWItA1lOhAzyimExmUM4KXiMsrbh
	 qNiODz3qg25GJ9wejmhzFVlQggW0gQGtY4mwFeILBnp0xF2nvLuGzA1aGW/HqaWp0aao9
	 QA5wIIybmrb4KeGzF3CwzBlpcSnu8I3SDnmeDf1HXuCQfukyDsPMLZ0O95hpjz8FjaMmT
	 Vb3v8mzJrEC4BjukTii53rEfaDI6BAki1WyuB7qnNc0Hv94vl6HIGoJYNp/oxOiZew2Vu
	 NZ5fYw1s8ovviPjOO72/gFg8KWrYS6eythJYszLXuE7U2SnVZiWIll8MDe0/bm+WJIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795276640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7jYx29lk0VQ+rDyH5VI1Dp1pxPOIzH/Tyj7l1x2+Cvw=;
	b=FqSKFmTStGh6yseq80wkN3bv9nDIhkAC10/PJ4J/qxCQHWmC+qwA31h/N1H6iWnvpi43
	 PXEaRpmh72g4QK5tnIYccMeS+wdct0UQq7ZJlR0jha3r9XwOOKlhRu98xxC88sVWGiP5t
	 nox6w4O+m560lIm3y8ydPlRvK7T6X6lBIut1FaBhLNtE+ZPG+7NV8WO0iTl+wBwJsJTb+
	 5vv9fJM0zcTySb+0muQ2aN3zr+8tkIEbWk1IaJQZnQ6i0rDifTE2ODl3QUWswXPAwZnl+
	 oR77QDi7qYGPr/MCx9LKR2A30IxsNCWSUfrPsz+7woP5kcUnpl5Pgtmxm+fk0P5t9QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWChVtZ0;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20089606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 15:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20089606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWChVtZ0
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-38692f62b22so2532922eec.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795276638; x=1795881438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7jYx29lk0VQ+rDyH5VI1Dp1pxPOIzH/Tyj7l1x2+Cvw=;
        b=qWChVtZ0aUsopnqGgFXKl69UxHOk8YCl9EkEWEMNZiPzUm2AN8h0KmXppQKOTsuqHD
         Vr+ufazjphT67IO1MT6M70kvyP5LCLVEHSsFZJjo82qkRR2isOgZd1oq5+WpcSU3dVUW
         45vfvvGHFa9QyKky/DvBlUk11aVTZD6vGnTmxQp6IWXMRJMIUm06rdy7nb04RJ+3X+dq
         6/b6a3FGYMdGZRBYloBLopj/naVQw5jpIbx07hgRzhVpk0/HXG+o8s/jdLpnB1Qw7/8+
         brujktESsOCEpoOwHfmmEpzUm4flpP1A6woA4vhLYfxkn84Vwhf7Udn9V0NO6LXb7bA1
         FZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795276638; x=1795881438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jYx29lk0VQ+rDyH5VI1Dp1pxPOIzH/Tyj7l1x2+Cvw=;
        b=oH0aSX2DNBqi3hb+dUUVnDgQjqw06xY+jmzlPAHF3OTGqLlHeJxyEIoCawn2t6yljo
         MZ55ArQj1QaK6SVnCWv/7707Ihkh7O2sDbxMk6nSD9AJ+OW8BFr+Wencxq6eqAazxQP+
         udKjcLRMMZV6ey5vF+9KGRmEE5ddOXtePy5pGfw5PvjDZdq+r6kYsy7TWeSSR+SezzbE
         km4ho7vC7LlYI40A/LHHV3VUjbeMnv+1NYBIpkETmy5OgUdrruxGSEYhz8djWFicLzgB
         wQnt3AFKPf+2LYbwdLXagOd8z0pihVzU7xDaC3wZ5ZpFvyh9oHEldEhe9G4kSa9k5xzS
         aguA==
X-Forwarded-Encrypted: i=1; AL+hErHPfQCAwTB8jNkSUEmeGtxZtAjhwP0bS8nYqTXOhMy/K0u8fDQDx85aW7iOn2FukI/IZzDb1ME=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jvGRk0CxLROUkp0Wlfrsl0Qri9sckicrTWUM00raxls8joku6
	xvrRCtcaYu9IA4seSHk1kruj0792w4y9mUDYFDz/11uN0vvd3wN1rceh
X-Gm-Gg: AZFdTZflvMSmosZxFMP004Xscj8zY08EFHuKWIzelvtdIzEDCoLw8KUU4lxdZJZa09R
	9ja0PUTnf1SBydlKGgWOab5F8pI2fxzrLMF+LvWDDZ8y1Oo5a7nACeUfKKQ1EmV6gsL8XPkZbd5
	blBCbTHuswFLTBe0bEaqQb5JPEraBBLG1HF56KRKEKcM6Rqjq5m8pJUUuMgKL9O8TIZ1H3EJSy7
	V9VlH0ZDHTR4irJws8AxJiRPrAYAAWNd2O/YPwMeI7eBLZmC//BIIfDdRqE6BlmCWOgJovUUHCp
	T+npSmynkhkUCGJc/JqxqOXPbKMyQB0ioAuvUZlOyKLiXM3n+JPcWABX+YfJjj361+p1zETNpbP
	/ARpSPfnd69i7HxlMJvfk6GX/hneqI2Wi3NbMBdPCIEWXQYA0wjGKvxZWa61PHzTqxL5KMxEKsw
	r62b1Cwd3sLyafZsAEhherorWzDwvsZjW7Ibd/xO2faD1aZSIVpa492TBNc0LShSiJ6FhHSBzlZ
	SwZB/9YVX0Qz7m0rzA7WWfVUNSeBESkzoeSSwaJI7DOcXnXZOlpEV2lDHLOo/nTByC9dugl5g1a
	RKrqgmHZ5CkSYtX9AuNOnK1eKZ8vXLBqQTvEO5RKu+sWsZ3DBw3xphBmK3E=
X-Received: by 2002:a05:7301:3a82:b0:374:ea35:9069 with SMTP id 5a478bee46e88-3856fb67380mr5886149eec.39.1795276637942;
        Sat, 21 Nov 2026 07:57:17 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:8549:3fe7:526f:af9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm20136479eec.6.2026.11.21.07.57.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 07:57:17 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael McAllister <me@michaelmcallister.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH v3] Bluetooth: hci_serdev: stop write_work before closing the port
Date: Sat, 21 Nov 2026 23:56:48 +0800
Message-ID: <20261121155648.1151-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With HCI_QUIRK_NON_PERSISTENT_SETUP, hci_uart_close() closes the serdev
port without keeping write_work off. The hci_uart_flush() call right
before closing re-enables write_work and may replay a recorded wakeup,
and hci_uart_tx_wakeup() queues it from any caller that passed the
HCI_UART_PROTO_READY test, such as the serdev write_wakeup callback.
write_work can then call ttyport_write_buf() while ttyport_close()
releases the tty, so it writes through a released tty.

Move the flush into __hci_uart_flush() with a resume_tx argument.
hci_uart_close() passes false when it is about to close the port, so
write_work stays disabled and HCI_UART_SENDING stays set after the
flush. It then clears HCI_UART_PROTO_READY under percpu_down_write(),
which waits for any hci_uart_tx_wakeup() already past its
HCI_UART_PROTO_READY test, and closes the port. Only then does it clear
HCI_UART_TX_WAKEUP, re-enable write_work and clear HCI_UART_SENDING: the
next open reuses hu and does not reset tx_state, and a stale SENDING
would stop every later wakeup from queuing write_work.

Found by code review. Compile-tested with W=1.

Fixes: de8892df72be ("Bluetooth: hci_serdev: Close UART port if NON_PERSISTENT_SETUP is set")
Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
v3:
- Add __hci_uart_flush() with a resume_tx argument and call it from
  hci_uart_close() instead of repeating the flush. write_work is
  re-enabled only after serdev_device_close() (Loic Poulain's review of
  v2).
v2:
- Clear HCI_UART_SENDING and HCI_UART_TX_WAKEUP after cancelling
  write_work. A pending write_work cancelled there left SENDING set, so
  the next power-on never queued write_work (Sashiko's review of v1).

v2: https://lore.kernel.org/linux-bluetooth/20261120062048.40310-1-enderaoelyther@gmail.com/
v1: https://lore.kernel.org/linux-bluetooth/20261118124821.3990-1-enderaoelyther@gmail.com/

Merging with Michael McAllister's hci_serdev v3 series (Patchwork
14989810-14989814):
https://lore.kernel.org/linux-bluetooth/179484638195.54009.16928291772826938293.wcn3950-poweroff-v3-1@michaelmcallister.org/
- 1/5 adds "if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) return 0;" at the
  top of hci_uart_flush() and hci_uart_close(). The flush check has to
  stay in hci_uart_flush(), not move into __hci_uart_flush().
- Once hci_uart_close() is past its own check, __hci_uart_flush() must
  always run disable_work_sync(), which the enable_work() after
  serdev_device_close() balances. Otherwise write_work is not disabled
  during the close and the enable underflows the disable count.
- 2/5: use hci_uart_serdev_close(hu) in place of
  serdev_device_close(hu->serdev) in the close_port branch.

This needs ee43bade37c4, which no stable branch has yet, and
disable_work_sync() from v6.10. With the flush body of ee43bade37c4
backported it applies as is to 7.3.y and 6.18.y and, with the older
test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) context line, to
6.12.y; 6.6.y has no disable_work_sync().

No new W=1, sparse or smatch warnings.

AI assistance was used.

 drivers/bluetooth/hci_serdev.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 194f11251cc5..9f038ab65a73 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -91,7 +91,7 @@ static void hci_uart_write_work(struct work_struct *work)
 /* ------- Interface to HCI layer ------ */
 
 /* Reset device */
-static int hci_uart_flush(struct hci_dev *hdev)
+static void __hci_uart_flush(struct hci_dev *hdev, bool resume_tx)
 {
 	struct hci_uart *hu  = hci_get_drvdata(hdev);
 
@@ -112,11 +112,19 @@ static int hci_uart_flush(struct hci_dev *hdev)
 		hu->proto->flush(hu);
 	}
 
+	if (!resume_tx)
+		return;
+
 	/* Resume TX and replay a wakeup recorded while it was stopped. */
 	enable_work(&hu->write_work);
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
 		hci_uart_tx_wakeup(hu);
+}
+
+static int hci_uart_flush(struct hci_dev *hdev)
+{
+	__hci_uart_flush(hdev, true);
 
 	return 0;
 }
@@ -150,22 +158,34 @@ static int hci_uart_open(struct hci_dev *hdev)
 static int hci_uart_close(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
+	bool close_port;
 
 	BT_DBG("hdev %p", hdev);
 
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		return 0;
 
-	hci_uart_flush(hdev);
+	close_port = hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
+
+	/* Keep write_work disabled until the port is closed. */
+	__hci_uart_flush(hdev, !close_port);
 	hdev->flush = NULL;
 
 	/* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by driver,
 	 * BT SOC is completely powered OFF during BT OFF, holding port
 	 * open may drain the battery.
 	 */
-	if (hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
+	if (close_port) {
+		/* Drain wakeups that passed the PROTO_READY test. */
+		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
+
 		serdev_device_close(hu->serdev);
+
+		clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
+		enable_work(&hu->write_work);
+		clear_bit(HCI_UART_SENDING, &hu->tx_state);
 	}
 
 	return 0;

base-commit: cf357cfc025e7f72851479ed3fb60d5f16413c1b
-- 
2.56.1

