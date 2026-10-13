Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FE47252E
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860286; cv=none; b=eXVC1dgAM9R6YqXYFEHYcnvDulR7MVTmeYZJE0lJWAckZAunXCgVRkVQolVBf+sTAQkTgvNWz8XPbGBGMisKyN1ZF0ospV2KvrmtQ7vfidUWjUd8tmg1N0XBg6eoghWzZ1EwEgM27eXqb3krL0Pc5OZv70JcmjBL+VhCzoLuvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860286; c=relaxed/simple;
	bh=Hmp6kD33CCTxbaHRrfzwTFQCBpL1CL9ksWeMOwmFTb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDQBmyHbXMAPzOWXuZHpZTZwDVeD2dsAFf93zu84niwK7U8SZ3S93TrH8OHmvt5S2DNzIs94D7Qbq3b6lVmTgllx/Yz9TdaRLnKreknRFQwJfkAR528VFtwz60j7apWYoQds0nB+elrtimY7pDgGevSRM60lNwrESePWERhQtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security; spf=pass smtp.mailfrom=octane.security; dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b=E0/PbZOE; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b="E0/PbZOE"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15943c9c005so3147714c88.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 19:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1791860284; x=1792465084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQbi0ubk7/MCTKPm4mHPKxuy2uo+88OVn5fQMncOhr8=;
        b=E0/PbZOEehz0Fqarhk6KzqtqljcWh0aUv6TgyzNNUReFY9DlwojpPkAq+9YiAvHWtv
         PdZT6qiT+b9+PYM692FRL4YIfDwhs+l0TnsLtyzpxSgD2BexcQLH4hQIVUV64oXQ3RiF
         NluIShE0zcN6PICkb9Qh2M4+g69Dim3X0CqoJLFyD9L/OoBVmLzhUYfi4Xw3cCuZurhK
         WseC/D4vNoh8QhlrIZle3tyWiBpYNsvvyL0Uji6mr95AoyINLRNFAzDRyWhtN1jxMGKA
         jDPmbFWLEz6xs9rvy+XsIyaEmDRlHm+f3hrTzncngc6kIZvPXJKHZY2M4iWR+ntm5xOE
         HFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860284; x=1792465084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qQbi0ubk7/MCTKPm4mHPKxuy2uo+88OVn5fQMncOhr8=;
        b=kFuoKpjEQeZQ1+PI1nAgkxsFzCC6ZiRf4cY24aqq/W7+7NGLzgfAaQUeKctHCcFXr4
         QytKUVhZ0NtESQEPAKAUb5Ptfctr2texFSKB11x5oAtUDY8W9FQYAhe3dbXkBZ9tb8WA
         zzsDKskzdoPD7mCgEXERmnOtHvQck6ssX6ng4q25r0bi9MLuYiOo/g2Gk1Qy18z4bn9G
         5cmvDx1guj3t3h0VGB9t5i1H6iAwG6J7LfyhXSHfVaLfwXYpzhZ8VYKsh3LTScvRAGcf
         8LqBJd90r4IzH5JWibVmfJM+uh2U2P/0QQtViAutSUQuLtzDVBwC2frVopLMpyGeVYoJ
         LIpg==
X-Forwarded-Encrypted: i=1; AKwUvBxljwpBRZbIaWuE40Ur/RBzAT4cp6mB4f8qMHYuUCodRmNhDpgp/PmisbNK2DVFCCDYZvKMuGw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0YApjsUix9+q+ULnwJGvZuLogW9+YgnOz1fqhdflR/P4KY7Bt
	xuJUaYR6GAvLCutkkHoHUNj4n6ewyEn/bFqiDVx/xR4uHu3/1xu9jDYfV/rs8FDf8dM=
X-Gm-Gg: AYBFou1A0ed8tYcOl+0KXYGk970C5t+wjOtgyrc+zx9V7BjPt+KXajsRB6b05c62KMP
	W1sa4En8+JIYNZf5oekxEuvfbsnVg29dJQ3D94V3HDOdFBQLeYt0NAMEWeflCiVSeVok+YhwGxq
	bxng38RT8fxYN9xrOEr4ms/nChwpLALZQ6kmGgzZIaq6e+15lkblTWcVyNRWNm35KyhnR+MpqaO
	Rb+7p5dZvs58c8TdnrR6FYK12LDUDDsbep1cLiSOyNUL8JQ/Ed04xySm75CfyGN15t4i3SPQOF3
	MYtNeBlpMyLtB899w9hQxBto+OFBlkR810E0GCfyI9E6dbUWe2FF9SkBfUpQTrJU8T/336GR17m
	4FuOB4cTU9GiqPH5xBeisbz0mGtISH+bsbbaeEiiXsmdYKZDEjIB1dD9B3Jqvt/qA6DOa+HMwnu
	cCGjqFxfWCJz/VfpcJarTiCNxijsItqE3gjH16PIIzCZ85weQDNgt+p6BpHpD1NiudcJjBFIzGw
	MTT/QSyGNFScMW6byD7XHNDIKg+UWohZ5KMdsvP9I9Du4LSAf0oIoDCPUYgEs4JEqQtgxqw0glV
	WvmK5ynim2XddA==
X-Received: by 2002:a05:701b:2910:b0:143:6080:668f with SMTP id a92af1059eb24-16a61789c7cmr15341521c88.7.1791860283446;
        Mon, 12 Oct 2026 19:58:03 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becefdsm34223721c88.7.2026.10.12.19.57.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 19:58:02 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	cuissard@marvell.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gio@octane.security,
	Shubham Antil <shubham@octane.security>,
	stable@vger.kernel.org
Subject: [PATCH net v5 2/2] nfc: nci: uart: quiesce write_work during teardown
Date: Tue, 13 Oct 2026 08:27:46 +0530
Message-ID: <20261013025746.41292-3-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013025746.41292-1-shubham@octane.security>
References: <20261013025746.41292-1-shubham@octane.security>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_uart_tty_close() releases the active transmit state before ensuring
write_work has stopped.  A TTY write-wakeup can queue or run that worker
immediately before close, leaving the worker active while teardown
proceeds.

Serialize work scheduling and the worker's final state handoff with a
transmit lock.  Once closing starts, block new scheduling and synchronously
cancel the worker before freeing its skbs and queue.  Test and clear the
wakeup bit under the producers' lock.  This prevents a lost wakeup between
the worker's final test and clearing the sending bit.

Keep the transport close callback before the generic stop barrier because
NCI unregister may transmit a CORE_RESET command.  Require the transport to
quiesce UART callbacks before releasing its private state; the Marvell UART
transport does so after NCI unregister and before freeing that state.  Also
hold the transport module while its open callback runs and apply the same
worker barrier to the open-error path.

The teardown ordering issue was found during an LLM-assisted source audit
and reproduced using a pty-backed NCI UART under KASAN.

Fixes: 9961127d4bce ("NFC: nci: add generic uart support")
Cc: stable@vger.kernel.org
Assisted-by: LLM (OpenAI Codex, gpt-5.6-sol)
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/main.c    |  7 +++
 drivers/nfc/nfcmrvl/nfcmrvl.h |  1 +
 drivers/nfc/nfcmrvl/uart.c    |  8 ++++
 include/net/nfc/nci_core.h    |  3 ++
 net/nfc/nci/uart.c            | 90 ++++++++++++++++++++++++++++-------
 5 files changed, 91 insertions(+), 18 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index 3d26a54ef51b..45c7d3546b0e 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -170,6 +170,8 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 	return priv;
 
 error_fw_dnld_deinit:
+	if (priv->if_ops->nci_quiesce)
+		priv->if_ops->nci_quiesce(priv);
 	nfcmrvl_fw_dnld_deinit(priv);
 	if (priv->if_ops->nci_unready)
 		priv->if_ops->nci_unready(priv);
@@ -186,10 +188,15 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
 	struct nci_dev *ndev = priv->ndev;
 
 	nci_unregister_device(ndev);
+	if (priv->if_ops->nci_quiesce)
+		priv->if_ops->nci_quiesce(priv);
+
 	if (priv->ndev->nfc_dev->fw_download_in_progress)
 		nfcmrvl_fw_dnld_abort(priv);
 
 	nfcmrvl_fw_dnld_deinit(priv);
+	if (priv->if_ops->nci_unready)
+		priv->if_ops->nci_unready(priv);
 
 	nci_free_device(ndev);
 	kfree(priv);
diff --git a/drivers/nfc/nfcmrvl/nfcmrvl.h b/drivers/nfc/nfcmrvl/nfcmrvl.h
index 66f8cc06e2d5..3b7483e5aff9 100644
--- a/drivers/nfc/nfcmrvl/nfcmrvl.h
+++ b/drivers/nfc/nfcmrvl/nfcmrvl.h
@@ -114,6 +114,7 @@ struct nfcmrvl_if_ops {
 	int (*nci_send) (struct nfcmrvl_private *priv, struct sk_buff *skb);
 	void (*nci_ready)(struct nfcmrvl_private *priv);
 	void (*nci_unready)(struct nfcmrvl_private *priv);
+	void (*nci_quiesce)(struct nfcmrvl_private *priv);
 	void (*nci_update_config)(struct nfcmrvl_private *priv,
 				  const void *param);
 };
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index d688071f4b26..164896070dfc 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -61,6 +61,13 @@ static void nfcmrvl_uart_nci_unready(struct nfcmrvl_private *priv)
 	nu->ndev = NULL;
 }
 
+static void nfcmrvl_uart_nci_quiesce(struct nfcmrvl_private *priv)
+{
+	struct nci_uart *nu = priv->drv_data;
+
+	nci_uart_tx_stop(nu);
+}
+
 static void nfcmrvl_uart_nci_update_config(struct nfcmrvl_private *priv,
 					   const void *param)
 {
@@ -77,6 +84,7 @@ static const struct nfcmrvl_if_ops uart_ops = {
 	.nci_send = nfcmrvl_uart_nci_send,
 	.nci_ready = nfcmrvl_uart_nci_ready,
 	.nci_unready = nfcmrvl_uart_nci_unready,
+	.nci_quiesce = nfcmrvl_uart_nci_quiesce,
 	.nci_update_config = nfcmrvl_uart_nci_update_config
 };
 
diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 664d5058e66e..ce0ffe56593a 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -436,6 +436,7 @@ struct nci_uart;
 
 struct nci_uart_ops {
 	int (*open)(struct nci_uart *nci_uart);
+	/* Quiesce callbacks before releasing transport-private state. */
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
 	unsigned long		tx_state;
@@ -465,5 +467,6 @@ struct nci_uart {
 int nci_uart_register(struct nci_uart *nu);
 void nci_uart_unregister(struct nci_uart *nu);
 void nci_uart_set_config(struct nci_uart *nu, int baudrate, int flow_ctrl);
+void nci_uart_tx_stop(struct nci_uart *nu);
 
 #endif /* __NCI_CORE_H */
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index aa20e8603f32..8e54eb1c8712 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -33,6 +33,7 @@
 /* TX states  */
 #define NCI_UART_SENDING	1
 #define NCI_UART_TX_WAKEUP	2
+#define NCI_UART_CLOSING	3
 
 static struct nci_uart *nci_uart_drivers[NCI_UART_DRIVER_MAX];
 
@@ -58,24 +59,59 @@ static inline int nci_uart_queue_empty(struct nci_uart *nu)
 
 static int nci_uart_tx_wakeup(struct nci_uart *nu)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&nu->tx_lock, flags);
+	if (test_bit(NCI_UART_CLOSING, &nu->tx_state))
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
@@ -93,48 +129,65 @@ static void nci_uart_write_work(struct work_struct *work)
 		kfree_skb(skb);
 	}
 
-	if (test_bit(NCI_UART_TX_WAKEUP, &nu->tx_state))
-		goto restart;
-
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
 }
 
 static int nci_uart_set_driver(struct tty_struct *tty, unsigned int driver)
 {
+	struct nci_uart *template;
 	struct nci_uart *nu = NULL;
 	int ret;
 
 	if (driver >= NCI_UART_DRIVER_MAX)
 		return -EINVAL;
 
-	if (!nci_uart_drivers[driver])
+	template = nci_uart_drivers[driver];
+	if (!template)
+		return -ENOENT;
+
+	if (!try_module_get(template->owner))
 		return -ENOENT;
 
 	nu = kzalloc_obj(*nu);
-	if (!nu)
+	if (!nu) {
+		module_put(template->owner);
 		return -ENOMEM;
+	}
 
-	memcpy(nu, nci_uart_drivers[driver], sizeof(struct nci_uart));
+	memcpy(nu, template, sizeof(struct nci_uart));
 	nu->tty = tty;
 	skb_queue_head_init(&nu->tx_q);
 	INIT_WORK(&nu->write_work, nci_uart_write_work);
+	spin_lock_init(&nu->tx_lock);
 	spin_lock_init(&nu->rx_lock);
 
 	ret = nu->ops.open(nu);
-	if (ret) {
-		kfree(nu);
-		return ret;
-	} else if (!try_module_get(nu->owner)) {
-		nu->ops.close(nu);
-		kfree(nu);
-		return -ENOENT;
-	}
+	if (ret)
+		goto err_stop;
+
 	tty->disc_data = nu;
 
 	return 0;
+
+err_stop:
+	nci_uart_tx_stop(nu);
+	kfree_skb(nu->tx_skb);
+	kfree_skb(nu->rx_skb);
+	skb_queue_purge(&nu->tx_q);
+	module_put(nu->owner);
+	kfree(nu);
+	return ret;
 }
 
 /* ------ LDISC part ------ */
@@ -180,17 +233,18 @@ static void nci_uart_tty_close(struct tty_struct *tty)
 	if (!nu)
 		return;
 
+	/* The transport quiesces callbacks before releasing private state. */
+	nu->ops.close(nu);
+	nci_uart_tx_stop(nu);
+
 	kfree_skb(nu->tx_skb);
 	kfree_skb(nu->rx_skb);
 
 	skb_queue_purge(&nu->tx_q);
 
-	nu->ops.close(nu);
 	nu->tty = NULL;
 	module_put(nu->owner);
 
-	cancel_work_sync(&nu->write_work);
-
 	kfree(nu);
 }
 
-- 
2.43.0
