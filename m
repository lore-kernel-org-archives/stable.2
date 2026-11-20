Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155670;
	b=kFm5bkmhfAgj9gomkrdE5fzge1DBdKnuqqb72W1lbNAgcJqhvYfNV4Szg9tXu5XrgBHG
	 2fOlzCnTaXLuH0gj5w31PrAJ9tEtL61PQN0YiQJ5GXHKM9cvS893hsTJb8+C1G8IV9rUV
	 WeFbb6EypZyBDFKc3FWQxqZ9XdDHdS3Lv3J1pA26Jazll0J3udFvqITfQ2hQBdah5+Jaq
	 Q+QgD/yVL4vVrVBn81U/LLx/9bXIxTlZAL/MLVdo1x6HDyY75yxtZiu+7JABiiEJt7OcW
	 IkQpfEYmB8vehrErZ/0wIiGw7L907wVTV0AGIYaXtuDYLgInX5eSQHlDhMBerWOa8BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ylQ5NpR+7iB87MylzEu3DJ9CieEThMAM4Vq8MsEW9S4=;
	b=uuN0MT0u+J2D7vTcajxagtYX5ly8eJsJK70zqabSuwIF8Dvjaf8/4vIKj9jeMzPOvKsd
	 +B/uV+pMtDLDr1ItCSUZnCLGnLkOnqIe2s4vGv7oKvXSBF7MC01nbFkn5kNdO/BcgqmQm
	 tBu1PZK0klwBREtF92f1Nze5L+1ZQTHGXO+JkY35w4HD+DbqkdJPDIBi5BZVHI2lGi/zx
	 IVfHj2PQqw2eUCl0WwnLFwXY1Pz3QyOx3BnJBByrbOoG63IgNe1sXDTc5aNFf9DRa99Dw
	 GbFLi43KtxLoDBp2NJJJibUXYVG68+tVvjBWMZrQgw1S/2agYCD/1lYRqRG9Xn/XQ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jf9CV78f;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13360A2601
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE13360A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jf9CV78f
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so1361671eec.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795155669; x=1795760469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ylQ5NpR+7iB87MylzEu3DJ9CieEThMAM4Vq8MsEW9S4=;
        b=jf9CV78fTEHK77xABUNuLqeS77oUBYpR+16bljYgb0KLdAWnIC/IJI+3N04IHXm2Yc
         xciabRbXXTjGCK+TPK2aBYJ9r+9vAennl2WJGwAvxCC6ACdA3fbxP+Zoul6dm0x1GjSd
         lWLSGdMfwzub5nLl87rkdWrulgyYQ9zJlv0ufpxSqpXN+QchkFHOCJILENf9gwiEFBAI
         7V7uqpre3uWfn7D9a1XitMGgfCp2C9XLDzS/TC5Vy7GKAXhFgMN3eNRDH0oDqsrIhaky
         vXMoB/AkH9LNqSmfgh6vvRRVrJ78mqMoDymPL/bkhgNgjJLbEazlcR2RdfLxD4MFWjvf
         t0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795155669; x=1795760469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ylQ5NpR+7iB87MylzEu3DJ9CieEThMAM4Vq8MsEW9S4=;
        b=n0fU/iahP6DRetlh0VRe8HTLHrR/7GH1tvgBYOlgFlqeGINnb4KzCIF/oGC95Tfi+E
         RQgfLoLalt5kfY2pD1uFvSpnwZY0FrsW9kTLG3BRilGEVrEsV1yVCpRMm3cK5aUiro5h
         xt4iYnc5EXSu+I+xywg4qKu/6OICvbsxM5vjDBEOqiqOwGZokECJw0PBYWpWUY55KANX
         aHsqfDstrMAylfhaewGA1WCAVJNQypN8xXbogvkjlsqN3pmsHHKAkaEA9gXiXtGJZApV
         uZT+wlwpDoV9jNu8tIk9HymrkklQmQwwDYOzhrj61+Q43ky7ArM3b6WkpzEZHeheOUG9
         81pw==
X-Forwarded-Encrypted: i=1; AL+hErE45cv0lwOHfUVZtlwJcSXkoIes01+y/L32vPtf8z3E+gkACmGJiATuFROnpQNXD4amqlWqwao=@vger.kernel.org
X-Gm-Message-State: APuU4Z/L3OjiQgwjIGDX2ln0k7ZGBKR0zFOvJRw+aJX3Sx3rdE0lk16p
	5UR0R+7oHJ8n+BBsW9xnLYDOdbnaNqi2mq8kgLEZJ6NjoKLBQU6aNzBW
X-Gm-Gg: AZFdTZfdJZlNEFgTBGb/Ay8CLly1YWP6mMrFyhMIn4ySfkBDWFi3C8Wl5YUoWV/lofZ
	IUGg1++qErBW1D9vYu8I2aojoZsa8e4pKjrZTjZFuq6Jqtv/Q5hD+bp8L+a4gQcNHE6qkcA98hW
	yuYhTgcioNtGP035lg2zeroAKpK3o2+X+/hND2Qt/VcLIj+2r4itiXmgv8BpzY8J3SgF+CyIO0N
	DxFVp++phc22kQQN8R/BXTiSZYlZFSw3LkEn3kEdE7+D+N8HaXUjKD2Qjg8UZv7WpUKi0S2lAvG
	IIizfZr4aXSmT/DFRMKz7ZnxFd+vITLi9+QJaZAXirtVolr24gbJZXg9KDPmbCDK+4rv8hIk1vU
	dsrMOS9ZaiZlZJxp+m79jpTSw888SeyO8ZuMIQ/zl6DrhUVXHJrQVnPRoX0GNsfNkCe7Sp1Da8l
	B9XQe7BT4Mf/3E7A65hXu479mYHVLITseBX9uDmnt1LnuueMnL99OpCddVoEzNX8dvKESa3Y58Q
	vimukcNH37fDoqBmubZkxMGdWzzWoNAtCa3zvznkRSXc5YmvyM8SHbX9iCKcS9/xsYBL97cvggn
	bt1QYx9myv3B0AZdf0HRhfK8MZM5VGCmFwktgbDGM8KDi/nSzA==
X-Received: by 2002:a05:693c:80cd:b0:385:b8f4:756a with SMTP id 5a478bee46e88-385b8f47b36mr999820eec.12.1795155668669;
        Thu, 19 Nov 2026 22:21:08 -0800 (PST)
Received: from G7XWH7K1F3 ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm5476880eec.5.2026.11.19.22.21.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 22:21:08 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael McAllister <me@michaelmcallister.org>,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_serdev: stop write_work before closing the port
Date: Fri, 20 Nov 2026 14:20:48 +0800
Message-ID: <20261120062048.40310-1-enderaoelyther@gmail.com>
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

With HCI_QUIRK_NON_PERSISTENT_SETUP, hci_uart_close() clears
HCI_UART_PROTO_READY without hu->proto_lock and closes the serdev port
without waiting for write_work. The hci_uart_flush() just before it
re-enables write_work and may replay a recorded wakeup, and
hci_uart_tx_wakeup() queues it from any caller that passed the
HCI_UART_PROTO_READY test, such as the serdev write_wakeup callback.
write_work can then call ttyport_write_buf() while ttyport_close()
releases the tty, so it writes through a released tty.

A partial frame that write_work leaves in hu->tx_skb also survives into
the next open, which flushes nothing, and would be sent first to the
controller after it is powered on again.

Quiesce the transmit path as hci_uart_unregister_device() does: clear
HCI_UART_PROTO_READY under percpu_down_write() so that no wakeup is in
flight, cancel write_work, free the leftover frame, then close the port.
A wakeup sets HCI_UART_SENDING and HCI_UART_TX_WAKEUP before it queues
write_work, so clear both after the cancel: a work cancelled while
still pending would leave SENDING set, and the next open, which reuses
hu, would never queue write_work again.

Found by code review. Compile-tested with W=1.

Fixes: de8892df72be ("Bluetooth: hci_serdev: Close UART port if NON_PERSISTENT_SETUP is set")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
v2:
- Clear HCI_UART_SENDING and HCI_UART_TX_WAKEUP after cancelling
  write_work. A pending write_work cancelled there left SENDING set, so
  the next power-on never queued write_work (Sashiko's review of v1).
v1: https://lore.kernel.org/linux-bluetooth/20261118124821.3990-1-enderaoelyther@gmail.com/

Before 6.16 the quirk test in hci_uart_close() reads
test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks); with that
context line the patch applies to 6.12.y, 6.6.y, 6.1.y, 5.15.y and
5.10.y. It applies as is to 6.18.y and 7.3.y.

No new W=1, sparse or smatch warnings.

AI assistance was used.

 drivers/bluetooth/hci_serdev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 194f11251cc5..a5e4b3d32144 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -164,7 +164,20 @@ static int hci_uart_close(struct hci_dev *hdev)
 	 * open may drain the battery.
 	 */
 	if (hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
+		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
+
+		cancel_work_sync(&hu->write_work);
+		clear_bit(HCI_UART_SENDING, &hu->tx_state);
+		clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
+
+		/* Do not send a stale partial frame after the next open. */
+		if (hu->tx_skb) {
+			kfree_skb(hu->tx_skb);
+			hu->tx_skb = NULL;
+		}
+
 		serdev_device_close(hu->serdev);
 	}
 

base-commit: 1d79f61152c315e30e758116e525871732181a98
-- 
2.56.1

