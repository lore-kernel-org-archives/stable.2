Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CA38F935;
	Sat, 13 Jun 2026 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781376336; cv=pass; b=ZHXZsU/3kc4FLiSddTtRGAcBpkSNRZroWWvOv3iFsTXFjNcPZMA8XkWjIwuH2MI1t/mT7gz4niObiufcbRpHqjWaQGIDVajSi2AdXW2X06AtR0WeidZaqK2JtxYTTND8bPCphzhJO/PwZNoswQYh1Kk6uO57YjqnTJck3bwdDyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781376336; c=relaxed/simple;
	bh=9f+zVou29lEV9SZuVJJgXyhDEy7OX65g9PxBdn7gSTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBMG3IF2pKuiMtt/9no+sylOgWrLAewcgnEUQjiHkevQg6zrKX+tXqlaNju9dR9+oiVNdq+lvxMEoEOSRiKrJoYTyc4DubkwHKeE+0nHQDK9akbWxuyqpcCYzKhXb+YMCkXiMj6AYkZum+6kCoK5wQ+gyBNUyG5GfRuTMKMUueQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=V6jX7q2d; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="V6jX7q2d"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gd5153shVzyQ6;
	Sat, 13 Jun 2026 21:45:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781376330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MV4P8RB45pbcl8M0UwnNRzaYkSS0MYDpNa9SCfx3QoA=;
	b=V6jX7q2dNEoRlDrF5/sysb5RCJ4ERNgS+d1j1qg0XGlri0PAi6lgh56zKLpOEcrGLm4hRB
	Jsq4XTA591vh+uWLjYAaD67qrRNLoazWKcdyVtY5HFwDJEQbiBaX1FPqcIMQZWm/begQtF
	oEJPTdxy0tgtT+l2sk79Z20M7x6I6ts=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781376330;
	b=Qaz/SrHFMPRsi/LvZ/m1mLACk+u89gFhQpcyeS79IG58WMFl2o6guiBfEmsoQfbuc/OSpD
	ctLnAxAirNNusQxiSoVRlCDd0sJha/8TGZoUeWV/oRQT0nMiSs38JAS8l4CbA2SNs5YIp6
	Vev2PrNY5+JCnIdHs/YQe2HKxFL85T8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781376330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MV4P8RB45pbcl8M0UwnNRzaYkSS0MYDpNa9SCfx3QoA=;
	b=iqazC5aRuB/pce7fVHTxe4sw2DcEGm4Gqan0UgmpzG2U9SbFV6a2KWsaeQlg0BcjAVXlPc
	O85/1+eGr+b8QQRSDlADqr1UCOEouv92WbOaYuPsDv72nyRN5+09b0Vd4qCqK5by1FcdTX
	tKK1RbFDaAgjz8TKvodfDzAJWv2Nv2w=
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
Subject: [PATCH v2] Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work is canceled
Date: Sat, 13 Jun 2026 21:43:37 +0300
Message-ID: <9fdead8517c36f37c0b23b7b60f590d735792cfa.1781375875.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6888691461070a011d31632e6dcbfd73016dcc6e.1781364475.git.pav@iki.fi>
References: <6888691461070a011d31632e6dcbfd73016dcc6e.1781364475.git.pav@iki.fi>
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
instead of doing it just in hci_uart_close().  Re-enable and possibly
requeue the work after queue flush.

Fixes: c1bb9336ae6b ("Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths")
Link: https://lore.kernel.org/linux-bluetooth/07e0a28650773abec711ee492fdb1bf5d21a6c98.camel@iki.fi/
Cc: stable@vger.kernel.org
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - extend disable_work section to after proto->flush where the queue is
      supposed to be empty
    - clear HCI_UART_SENDING after enable_work() to avoid concurrent
      bt_tx_wakeup() having set it
    - requeue write_work in case something concurrently added more tx

 drivers/bluetooth/hci_ldisc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 47f4902b40b4..2ad42c3bbaac 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -239,6 +239,8 @@ static int hci_uart_flush(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p tty %p", hdev, tty);
 
+	disable_work_sync(&hu->write_work);
+
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
 	}
@@ -254,6 +256,14 @@ static int hci_uart_flush(struct hci_dev *hdev)
 
 	percpu_up_read(&hu->proto_lock);
 
+	/* Resume TX. Also reschedule in case work was queued concurrently;
+	 * this may schedule write_work although there's nothing to do.
+	 */
+	enable_work(&hu->write_work);
+	clear_bit(HCI_UART_SENDING, &hu->tx_state);
+	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
+		hci_uart_tx_wakeup(hu);
+
 	return 0;
 }
 
@@ -271,12 +281,8 @@ static int hci_uart_open(struct hci_dev *hdev)
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

