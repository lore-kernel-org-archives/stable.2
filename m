Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553098;
	b=rfhpSXLNBoLtGflS/1FMP2UtrRUtMW0Dw7kgRBrguObcPR817B3YBApW3M5QERRiCaVq
	 gCFfbQUlx8/iIYXh1XtPDz124k+HhN/idN0NxIeag5II4BMFMSCb6/NtBkLW5/mSzFvEL
	 FJo0+puO8nva+78VVCNsqyUh5OUCwXhpX8jP0hkrGTIMytpv3fKF6h2I8iTTgoI9lvxC9
	 JMrFyvq19JZ1rQFVG1OJpUlPURzwDMHjJSLcHeDmf6Wf+X83/RYyyINl8rfkbxlYxFpsw
	 8ch5f8fMZCN2UAWN25tRcC8ApmjssZo6zW2uCnKGpSmELyRs2EAlNWuktLqCiCx43TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SHIJveT2qEl6mEl/fACF0XBVBweH9o3cdD3vFDkGWvQ=;
	b=yzLEzi/YdlfYbdXN8yB/jNamWj3Nbreze/LP7RG+kBY/aNkhIWa7uIWJvvQFkXgG/sGf
	 h+tjuo4LdGUuDbwL73ODFtQbrPrw0CfHR2kEYrhNW60v41ah+j7jc8Hni0o3KBZYG6O2B
	 9kfOUqy9cG0E4Ye4DbQohI4ogSRRj4XWyUj/B+0qVBUqsa8glhsqwrsyioSuuBT/aISkD
	 6r3IppWmz5aoHowdbq7kKV0GKt3z5cDT5iyCWHBuvOacG/tgyuTTpgpFeA80JLvEZ1TZi
	 ft5ha8rXFSL2hRFp7o2QTSSxIKMLt9y4U9bVSOCqlhWmsdfmuP8AAWXXqBrl7KQBSGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=ZQfjAgr5;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C69606E853
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45C69606E853
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=ZQfjAgr5
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so228242a91.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792553097; x=1793157897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SHIJveT2qEl6mEl/fACF0XBVBweH9o3cdD3vFDkGWvQ=;
        b=ZQfjAgr5346/xk1M8hUFjEulsM9AW08od+UXsAH2zsPTpw5BKucSLHvYFUl6AwxCCU
         3VjCUFt/Adl03+0QJh6LAILg9eot/sD6fzJA+TRDJAR0R2ICCHBR5BcspGJTMN96TdXC
         T7BkU49yHmpPXAO/3f8IrkKDxQxOEPpkEkLTMvvlG8VfrnTHqOHA5nluCZ/fov+VIqTO
         dBCCtc8DVDTZ1iQYRhxFbJ3lVXry18+2xM6Q0dl7RpAh3V+SQEcJnPykIHjfYxrtWUSx
         RMNlro4yHpOQr+9igCdD+KqGhd62kXQgIzZIu+20yLIGSYKPRNW2ShAwFUnOJN4VewD2
         nRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553097; x=1793157897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SHIJveT2qEl6mEl/fACF0XBVBweH9o3cdD3vFDkGWvQ=;
        b=gIxs3tO4BtqAdK9eHMoznwWyXBge5MLjamT+6zDs80qhlETpmcz/t+/nEuDzhN86tx
         ldhnFvL+wB3tO77L5/PSL7bOpZSm4h7Htpn4WQt5edgsONkHX7mtAZR6Cn3QfOd+WZBw
         rnA2iNAanQOIvwyBmhzz5pdAZLNlCWlKCSnq1Ltu93SAVgYnNpqYBGHtvHTD+5jrB8Wf
         kpNP14pSzSNmgd7Pd4GZmyIWT1FxbMLaOz0Vm0qZMsmpDZ3nwEQe/l4jNe0+XL9W5UwM
         +0p7+7X7CMCOUAB2Y5HBnhQqu72s+m4A3EyqhsXo5ql+awuQ2sAgwDXZedGimC5zETv+
         zdKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLlubB+Z8AeEL65IcrLm1hJzZ45lAI0pssu5CiCVL7cUnLC6C+y+1grm8oG0oDd6HkwhL2Kcw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8EDu7spX3no7ulUPkxJobRZdCN8O/HhCzWZhIh3+1kVbCtAAq
	KSk87Xk45Tqsnbv/t72hjzkoCNN8C1NiBAht+m0yfZmqPRiim9YzMYAwhiIoJLu2jgE=
X-Gm-Gg: AYBFou1xxiWyO9PBiBGX1thoxwXbqNCgfMo2UPjLTD/PHeNfi3BDYBkOmgquIEhHcZT
	wHZNUEPBx9qQPXKYKQ5msnLHaUirlA4cp0NOGIphYnVkBGK2JGTF4Y6Ffw+Ex05tYQA1Gm0GQFP
	PyRQKfh2M232OeWqtMSo3ZuDlpLbGKXuurl4MWuBA/Hepwiz7sbSINFOWGGgYSQJHUr4jtEJoAP
	TidTOzlwAwuVGqWJJR12rtcZPXfxJj6t1onOYPIWMEbdRByOVAWhcFY1GPIv0F81r9SYyYsmqXd
	qr1U8D5UnFv1SvXR+H7Df20rP7f+gEYgoWfXKJaVhaGGlF1iwPVOtjeDVPPcKijIs18Nm4qGcV5
	5YVLoPYKeXTJSjlTBch8r3xLAx4uHobfjC+vXMqKJxMpGyK/z5Z68IX1Dl2LB7okfwYIb+5dhZs
	1bwvUp5ChGbVLf5txlT8DjtlFRfKeaq2V+vkltyEbQvS+CSV+z2G3AjlxTBlG/seAJmoeK+TIwm
	OCOB+ddiLNTOk+4d0Fqa+dy7bi1YwEkqXma6ob8BGEzb722TdF+IN5NQYC4SpNUMk7GeDOQkbHl
	UI30tRp22/tUn3xqkW/HE4oyr12g74ZoprrCC8fzaInl4N/YRoxJz8Vb/MuJ5xH7aFUsADqu7VU
	hYQ==
X-Received: by 2002:a17:90b:28c5:b0:3ab:be66:ddba with SMTP id 98e67ed59e1d1-3ad86f44cddmr671354a91.23.1792553097355;
        Tue, 20 Oct 2026 20:24:57 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8030226csm2155285a91.12.2026.10.20.20.24.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 20:24:57 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH net v6 3/6] nfc: nci: uart: quiesce callbacks during teardown
Date: Wed, 21 Oct 2026 08:54:40 +0530
Message-ID: <20261021032443.44412-4-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021032443.44412-1-shubham@octane.security>
References: <20261021032443.44412-1-shubham@octane.security>
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

nci_uart_tty_close() releases transport state before ensuring that the
UART write worker and receive callback have stopped using it.  A write
wakeup can also race the worker's final TX_WAKEUP test and SENDING handoff.

Serialize work scheduling and the worker's final state transition with a
transmit lock.  Once quiescing starts, block new scheduling and cancel the
worker synchronously.  Clear the TTY write-wakeup request after the
cancellation.  Keep a locked TX_WAKEUP check before tx_done() and another
after it so the original Marvell BREAK timing is preserved while the
lost-wakeup window remains closed.

Stop generic receive and transmit callbacks before invoking the transport
close operation.  The preceding change skips the unregister-time controller
reset because the TTY core cannot deliver its response after line
discipline close starts.  Detach the UART context from the TTY before
quiescing, and let the Marvell transport teardown clear its back-pointers
before releasing private state.  Apply the same barriers to the failed-open
path.

Found during a source audit assisted by OpenAI Codex, gpt-5.6-sol, and
reproduced with repeated pty-backed NCI UART registration and hangup cycles
under KASAN.

Fixes: 9961127d4bce ("NFC: nci: add generic uart support")
Cc: stable@vger.kernel.org
Assisted-by: LLM KASAN
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/main.c    |   5 ++
 drivers/nfc/nfcmrvl/nfcmrvl.h |   1 +
 drivers/nfc/nfcmrvl/uart.c    |  11 ++++
 include/net/nfc/nci_core.h    |   5 ++
 net/nfc/nci/uart.c            | 109 ++++++++++++++++++++++++++++------
 5 files changed, 113 insertions(+), 18 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index 6efa83219117..baf4c781ee6b 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -167,6 +167,8 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 	return priv;
 
 error_fw_dnld_deinit:
+	if (priv->if_ops->nci_quiesce)
+		priv->if_ops->nci_quiesce(priv);
 	nfcmrvl_fw_dnld_deinit(priv);
 error_free_dev:
 	nci_free_device(priv->ndev);
@@ -181,6 +183,9 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
 	struct nci_dev *ndev = priv->ndev;
 
 	nci_unregister_device(ndev);
+	if (priv->if_ops->nci_quiesce)
+		priv->if_ops->nci_quiesce(priv);
+
 	if (priv->ndev->nfc_dev->fw_download_in_progress)
 		nfcmrvl_fw_dnld_abort(priv);
 
diff --git a/drivers/nfc/nfcmrvl/nfcmrvl.h b/drivers/nfc/nfcmrvl/nfcmrvl.h
index 62fa77d587b2..61b3f4a4f096 100644
--- a/drivers/nfc/nfcmrvl/nfcmrvl.h
+++ b/drivers/nfc/nfcmrvl/nfcmrvl.h
@@ -112,6 +112,7 @@ struct nfcmrvl_if_ops {
 	int (*nci_open) (struct nfcmrvl_private *priv);
 	int (*nci_close) (struct nfcmrvl_private *priv);
 	int (*nci_send) (struct nfcmrvl_private *priv, struct sk_buff *skb);
+	void (*nci_quiesce)(struct nfcmrvl_private *priv);
 	void (*nci_update_config)(struct nfcmrvl_private *priv,
 				  const void *param);
 };
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 9aedd168759c..66803f1c6fd3 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -44,6 +44,16 @@ static int nfcmrvl_uart_nci_send(struct nfcmrvl_private *priv,
 	return nu->ops.send(nu, skb);
 }
 
+static void nfcmrvl_uart_nci_quiesce(struct nfcmrvl_private *priv)
+{
+	struct nci_uart *nu = priv->drv_data;
+
+	nci_uart_rx_stop(nu);
+	nci_uart_tx_stop(nu);
+	nu->drv_data = NULL;
+	nu->ndev = NULL;
+}
+
 static void nfcmrvl_uart_nci_update_config(struct nfcmrvl_private *priv,
 					   const void *param)
 {
@@ -58,6 +68,7 @@ static const struct nfcmrvl_if_ops uart_ops = {
 	.nci_open = nfcmrvl_uart_nci_open,
 	.nci_close = nfcmrvl_uart_nci_close,
 	.nci_send = nfcmrvl_uart_nci_send,
+	.nci_quiesce = nfcmrvl_uart_nci_quiesce,
 	.nci_update_config = nfcmrvl_uart_nci_update_config
 };
 
diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 2f542f5c9496..99797872c2e0 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -436,6 +436,7 @@ struct nci_uart;
 
 struct nci_uart_ops {
 	int (*open)(struct nci_uart *nci_uart);
+	/* Release transport-private state after generic callbacks stop. */
 	void (*close)(struct nci_uart *nci_uart);
 	int (*recv)(struct nci_uart *nci_uart, struct sk_buff *skb);
 	int (*send)(struct nci_uart *nci_uart, struct sk_buff *skb);
@@ -452,6 +453,7 @@ struct nci_uart {
 	/* Dynamic data */
 	struct nci_dev		*ndev;
 	spinlock_t		rx_lock;
+	spinlock_t		tx_lock; /* protects tx_state */
 	struct work_struct	write_work;
 	struct tty_struct	*tty;
 	unsigned long		flags;
@@ -466,5 +468,8 @@ struct nci_uart {
 int nci_uart_register(struct nci_uart *nu);
 void nci_uart_unregister(struct nci_uart *nu);
 void nci_uart_set_config(struct nci_uart *nu, int baudrate, int flow_ctrl);
+void nci_uart_set_ready(struct nci_uart *nu);
+void nci_uart_rx_stop(struct nci_uart *nu);
+void nci_uart_tx_stop(struct nci_uart *nu);
 
 #endif /* __NCI_CORE_H */
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index fb9ed281f62c..aa24e1f572d9 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -34,6 +34,7 @@
 /* TX states  */
 #define NCI_UART_SENDING	1
 #define NCI_UART_TX_WAKEUP	2
+#define NCI_UART_CLOSING	3
 
 /* UART flags */
 #define NCI_UART_DRIVER_SET	0
@@ -64,24 +65,61 @@ static inline int nci_uart_queue_empty(struct nci_uart *nu)
 
 static int nci_uart_tx_wakeup(struct nci_uart *nu)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&nu->tx_lock, flags);
+	if (test_bit(NCI_UART_CLOSING, &nu->tx_state) ||
+	    !test_bit_acquire(NCI_UART_READY, &nu->flags))
+		goto unlock;
+
 	if (test_and_set_bit(NCI_UART_SENDING, &nu->tx_state)) {
 		set_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
-		return 0;
+		goto unlock;
 	}
 
 	schedule_work(&nu->write_work);
 
+unlock:
+	spin_unlock_irqrestore(&nu->tx_lock, flags);
+
 	return 0;
 }
 
+void nci_uart_tx_stop(struct nci_uart *nu)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&nu->tx_lock, flags);
+	set_bit(NCI_UART_CLOSING, &nu->tx_state);
+	spin_unlock_irqrestore(&nu->tx_lock, flags);
+
+	cancel_work_sync(&nu->write_work);
+	clear_bit(TTY_DO_WRITE_WAKEUP, &nu->tty->flags);
+
+	spin_lock_irqsave(&nu->tx_lock, flags);
+	clear_bit(NCI_UART_SENDING, &nu->tx_state);
+	clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
+	spin_unlock_irqrestore(&nu->tx_lock, flags);
+}
+EXPORT_SYMBOL_GPL(nci_uart_tx_stop);
+
 static void nci_uart_write_work(struct work_struct *work)
 {
 	struct nci_uart *nu = container_of(work, struct nci_uart, write_work);
 	struct tty_struct *tty = nu->tty;
 	struct sk_buff *skb;
+	unsigned long flags;
 
 restart:
+	spin_lock_irqsave(&nu->tx_lock, flags);
+	if (test_bit(NCI_UART_CLOSING, &nu->tx_state)) {
+		clear_bit(NCI_UART_SENDING, &nu->tx_state);
+		clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
+		spin_unlock_irqrestore(&nu->tx_lock, flags);
+		return;
+	}
 	clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
+	spin_unlock_irqrestore(&nu->tx_lock, flags);
 
 	if (nu->ops.tx_start)
 		nu->ops.tx_start(nu);
@@ -99,14 +137,50 @@ restart:
 		kfree_skb(skb);
 	}
 
-	if (test_bit(NCI_UART_TX_WAKEUP, &nu->tx_state))
+	spin_lock_irqsave(&nu->tx_lock, flags);
+	if (test_bit(NCI_UART_CLOSING, &nu->tx_state)) {
+		clear_bit(NCI_UART_SENDING, &nu->tx_state);
+		clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
+		spin_unlock_irqrestore(&nu->tx_lock, flags);
+		return;
+	}
+	if (test_and_clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state)) {
+		spin_unlock_irqrestore(&nu->tx_lock, flags);
 		goto restart;
+	}
+	spin_unlock_irqrestore(&nu->tx_lock, flags);
 
 	if (nu->ops.tx_done && nci_uart_queue_empty(nu))
 		nu->ops.tx_done(nu);
 
+	spin_lock_irqsave(&nu->tx_lock, flags);
+	if (!test_bit(NCI_UART_CLOSING, &nu->tx_state) &&
+	    test_and_clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state)) {
+		spin_unlock_irqrestore(&nu->tx_lock, flags);
+		goto restart;
+	}
 	clear_bit(NCI_UART_SENDING, &nu->tx_state);
+	clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
+	spin_unlock_irqrestore(&nu->tx_lock, flags);
+}
+
+void nci_uart_set_ready(struct nci_uart *nu)
+{
+	/* Publish transport fields before callbacks observe READY. */
+	smp_mb__before_atomic();
+	set_bit(NCI_UART_READY, &nu->flags);
 }
+EXPORT_SYMBOL_GPL(nci_uart_set_ready);
+
+void nci_uart_rx_stop(struct nci_uart *nu)
+{
+	spin_lock(&nu->rx_lock);
+	clear_bit(NCI_UART_READY, &nu->flags);
+	kfree_skb(nu->rx_skb);
+	nu->rx_skb = NULL;
+	spin_unlock(&nu->rx_lock);
+}
+EXPORT_SYMBOL_GPL(nci_uart_rx_stop);
 
 static int nci_uart_set_driver(struct nci_uart *nu, unsigned int driver)
 {
@@ -136,21 +210,17 @@ static int nci_uart_set_driver(struct nci_uart *nu, unsigned int driver)
 	if (ret)
 		goto err_module;
 
-	/* Publish transport fields before callbacks observe READY. */
-	smp_mb__before_atomic();
-	set_bit(NCI_UART_READY, &nu->flags);
+	nci_uart_set_ready(nu);
 
 	return 0;
 
 err_module:
-	cancel_work_sync(&nu->write_work);
+	nci_uart_rx_stop(nu);
+	nci_uart_tx_stop(nu);
 	kfree_skb(nu->tx_skb);
 	nu->tx_skb = NULL;
-	kfree_skb(nu->rx_skb);
-	nu->rx_skb = NULL;
 	skb_queue_purge(&nu->tx_q);
-	clear_bit(NCI_UART_SENDING, &nu->tx_state);
-	clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
+	clear_bit(NCI_UART_CLOSING, &nu->tx_state);
 	module_put(nu->owner);
 	nu->owner = NULL;
 	goto err_clear;
@@ -188,6 +258,7 @@ static int nci_uart_tty_open(struct tty_struct *tty)
 	nu->tty = tty;
 	skb_queue_head_init(&nu->tx_q);
 	INIT_WORK(&nu->write_work, nci_uart_write_work);
+	spin_lock_init(&nu->tx_lock);
 	spin_lock_init(&nu->rx_lock);
 
 	tty->disc_data = nu;
@@ -208,26 +279,24 @@ static void nci_uart_tty_close(struct tty_struct *tty)
 {
 	struct nci_uart *nu = tty->disc_data;
 
-	/* Detach from the tty */
-	tty->disc_data = NULL;
-
 	if (!nu)
 		return;
 
+	tty->disc_data = NULL;
+
 	if (test_bit(NCI_UART_DRIVER_SET, &nu->flags)) {
-		kfree_skb(nu->tx_skb);
-		kfree_skb(nu->rx_skb);
+		nci_uart_rx_stop(nu);
+		nci_uart_tx_stop(nu);
+		nu->ops.close(nu);
 
+		kfree_skb(nu->tx_skb);
 		skb_queue_purge(&nu->tx_q);
 
-		nu->ops.close(nu);
 		module_put(nu->owner);
 	}
 
 	nu->tty = NULL;
 
-	cancel_work_sync(&nu->write_work);
-
 	kfree(nu);
 }
 
@@ -343,6 +412,10 @@ static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 		return;
 
 	spin_lock(&nu->rx_lock);
+	if (!test_bit(NCI_UART_READY, &nu->flags)) {
+		spin_unlock(&nu->rx_lock);
+		return;
+	}
 	nci_uart_default_recv_buf(nu, data, count);
 	spin_unlock(&nu->rx_lock);
 
-- 
2.43.0

