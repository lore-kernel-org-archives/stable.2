Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78A6379C29;
	Sat, 13 Jun 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364611; cv=pass; b=eKSsHkBiUWgPIgo5iln9J948fuXQ6BoF5vEpFXOEEE7Ly4Ydb3yxWga+NV+Dp4K7BjqG3ySXhtbRYP9LKD12ANnRABTexTs2rZhgOZIC0on2IiNCVTz5a7YqplHw8JndsqjyzSraTz61/q4Nd4apcsr8hSfIsnNLP+aQlxdWqD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364611; c=relaxed/simple;
	bh=S5dYuLv4N6nSh5hPQxsSe7bwHSQolb/RIp7nc0RL5mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvZZTZhuUVoNNcXxVx3imJZgp2kGOhtPkIY61aYpWjTVZUcVbugUh6n8h/568hOX+hYI91DJFE24w/1aOiYiLEdBE5KWDM31FewZ1U3Fo8e+hp1Lc/2HmVFcUh3gPjHS04oE18JFycruT9YLE18oHDo2B+5so33jna0e2L+iuNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LtaD9Kax; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LtaD9Kax"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gd0gX118dzyWH;
	Sat, 13 Jun 2026 18:30:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781364601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=88kYt8eEzESBaOFkzHodNaDnLTBS/6KbUlbalEizkuQ=;
	b=LtaD9KaxYsUBRvLjRL3HZ3fm+hbqg3IpBEjjeL7uNiNLIO6JKoqOP4vza/48ow6NUo+RQ3
	nMz/mUyqet4TixRacAXeb/sFBP/g8r7xDBaLgizt+LbEkuuahP6n6EjOzTm00gAiAJuZdO
	bo0yPSrdUnNJH/5LmaJ5J4DpAaBAslk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781364601;
	b=c/V1stdoTxgI5F+IotZtXx1Nn/PSuYXn5Dp08Mt/X3VSbSMNONN5J4yx3Xu1wKfzl+4Mth
	Vqv6AVAmcYZMSzW2KfmFwKy96YZ+CuhWQdGYm0Sa4Ss6ZGeTTwe7/e81kNdpSdKBZjNVT1
	8U9ox/jSqmkNVeytZO4rOBueYxBUgwA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781364601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=88kYt8eEzESBaOFkzHodNaDnLTBS/6KbUlbalEizkuQ=;
	b=jyl6WKH7bM6pbuj6iUc+6dMbSuNvJirPEO5WryTycekiA2S4zmn9rCYyPkGHrNwTkiu5/a
	PQkhcaadpyI7VkWpepVBsYGi2XeWwyzjwbsIY1PNueiTeQ22RTuVfjLklq1iG/9jC9H59c
	WhWczRVcjeBZ7Uam+7+hK5CqPjc1hQ0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	25181214217@stu.xidian.edu.cn,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work is canceled
Date: Sat, 13 Jun 2026 18:29:57 +0300
Message-ID: <6888691461070a011d31632e6dcbfd73016dcc6e.1781364475.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HCI_UART_SENDING bit in tx_state means write_work is pending and blocks
queueing it again.  Currently this bit is not cleared when canceling the
work in hci_uart_close(), which blocks future writes when device is
reopened later if write_work was pending.

Fix by clearing HCI_UART_SENDING when canceling the work.

Also make clearing of tx_skb safe by using disable_work_sync +
enable_work instead of just cancel_work_sync.  hci_uart_flush() purges
the proto tx queue so we can cancel the pending write_work there,
instead of doing it just in hci_uart_close().

Fixes: c1bb9336ae6b ("Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths")
Link: https://lore.kernel.org/linux-bluetooth/07e0a28650773abec711ee492fdb1bf5d21a6c98.camel@iki.fi/
Cc: stable@vger.kernel.org
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 drivers/bluetooth/hci_ldisc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 47f4902b40b4..b0708ec9751c 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -239,10 +239,17 @@ static int hci_uart_flush(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p tty %p", hdev, tty);
 
+	disable_work_sync(&hu->write_work);
+
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
 	}
 
+	if (test_and_clear_bit(HCI_UART_SENDING, &hu->tx_state))
+		wake_up_bit(&hu->tx_state, HCI_UART_SENDING);
+
+	enable_work(&hu->write_work);
+
 	/* Flush any pending characters in the driver and discipline. */
 	tty_ldisc_flush(tty);
 	tty_driver_flush_buffer(tty);
@@ -271,12 +278,8 @@ static int hci_uart_open(struct hci_dev *hdev)
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
-- 
2.54.0

