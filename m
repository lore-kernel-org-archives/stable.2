Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553107;
	b=K7qlajiM1Ww6UMe4gRIF65qqno3guu7AwLinLwMneIiG6rgQC2Y3Fijrwo4SrxzEszMG
	 OIbQoLiZsP3e0SphhwsIrU3lgkZks4tH0jlOeAe1FNasTWy2zev1t0ZDniZEVLxzL8CFA
	 ki2oMryLZylb0dZbriyI0TQ8zhTySciLuRixVzTtJjthiLTJ6i8KVot7yEhZYOeMKyg8t
	 U+pMD8Jo32BzpjJppiQDr5O8bKuh9gulldKnUUOcgurWVG6k0rkk6Vs/04d57fTOu/Ph6
	 IfuJljFCsbyJ0SfoW+X41IdIMANkHLZQLUjjqwHRzM78oJTWzV+RTYYSPgPox9h2EdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9pcPsn8TofkJbxgDpVMM8vXhRe7u1bu5HlbvuAojIL0=;
	b=aNFkfo+1xb8fjUFprRAVS9Kg+54O553LS/t6R4Q7d7s0bOBbRR5oW71hdCsXtYriCYwG
	 xMA5ZLJbjvGVsPzR99A7lxKU1dYH5uEJvTWVbNbdOpXK8RbxW+vLw1BNC0rKqBiV4bLxK
	 VqQ7/DZoFSBV0NR37GSFTT/05YBDe3aJACceoDFU4G5AxIJwXVyYtSsdAHjECvWVzqq2U
	 954HusOj3Ka0ImnTBIZL6feOqG7M67/eYt247ECPafu8eQeilflJLBOl7tItrK1Vo+Zd+
	 FpgywEfNuYqbmusLaKGB0OvtOlMNUvUUNXOo+dE0gV8zQC31kC26trV096hIfmBOcQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=jWZkw3wU;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A993606E87C
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A993606E87C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=jWZkw3wU
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e60f9af6e6so2206395ad.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792553106; x=1793157906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9pcPsn8TofkJbxgDpVMM8vXhRe7u1bu5HlbvuAojIL0=;
        b=jWZkw3wUn+vNPxnGmVR8e3/EPyKYxxYo0vh7oR0/foVpO4PU1LDGd5EIh9vTuks15d
         zv0skLHSkysxwxWZ5N1yyUDfZmx6JeRm5IkJWDs4uh/zRrzioNMMh+Xqk9jrT1HaM959
         ksASDkw396r6fBpZIawE8Q7ktK7Nln6zXLqeI8tVexXBQUoJMRk1OdHYyAr9dPgllaek
         4cVNbRegyHxg7EylhKkl3AW8PNBi9RgEeTSsTxiJgkcW1dQ5nYWESdf3xss6TLFV0yIN
         IxW3IxoHwLeVEzLLBcY/40djmeO4zcXTPEGtdf/fBcuSc3gf54Nmsu6/8GpERGtVD/F/
         fVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553106; x=1793157906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9pcPsn8TofkJbxgDpVMM8vXhRe7u1bu5HlbvuAojIL0=;
        b=pMWt6nRvmNk1Ub0mJ06HXgbPeXQZIbeiAR9Cibn6gBcEfsIOn5epSOnCQthDNA++9K
         Am9/axDuw6EWz6U/6gyuW3vc63fnuEiZgESnU7HqF+HTj+/RxAJABCyz0FXntigiUMnH
         WLFRjSkHh2axwGtFXc3/CbM9qNRX2TaiWJjJoBiIBnoMiv30+78nESF/QTr97OBtOKHM
         6PXZ2GpWTD+rEkKx14htHe7dn9ZKH9i7O6A93SBCAZfR1kxpxnKDlz5z3n4aaaKjbbu/
         ry/cYY2siMDZGQoQsr6ZFasu1b9ip7yf+UWar0E49ajaeqcX6q2MEO0iU4hnRZMQKHQb
         MY3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwWQab7W5Krl6xalsWNgZd9bsK5lDfosMy3eXYtdjXrQkFUEvuRvfhnKmCryOgrGC0UtaEnUMg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOUFl1FsPMcXSunyUHfvkXaLaU4IqRSwyCstSPKCwOm7kTLCPZ
	L9d84AjaWF8pndaX6g9FMk1fXMpfWhO0mGmvRx+078wDFpWw3UuSlvLwjuCk24npw8w=
X-Gm-Gg: AYBFou3Panj+mZuLfV1eE98QUoyC2AGx/M5NZHnrUMs7oiIOLdJUGTMJ9ygYxS+kp1v
	hsc9GUENSVfq9dimOQ8eW03wZULpDTzXY4WPtMPvHlLsfjcpvlA3c2TJ1PtW2wVKoGo7uxEP+ZL
	1K0QoeJoTCmPgU2/1zf7AeW4WGZK5SvN+sNFkbf3Ky2vflh2fEXK1++6vk8qm7A/g8kCGGvfV54
	1D5NAh6LJpbYDlq6Nug8LWWDqumZhMGffX0LG1Rx0618eRjge6/e+9Byb68n7qmwXIyu0svUwNQ
	Fs1eWeeWpwKrVhj93WQs/xM/MVIZqMHCOvC+fMQ0wuRMCoaaTBtvfYQjpEIskvT3ZUxf+sU2/3u
	G0kJ46bntzcG8Kwd5T99wjMY4ARxKIAVH1cEJWQ8tamVsf+Laj0p5L3JXbzExpIqqzY0Q0HzXu3
	1bQfuqgJ2YbItyDcU4HjSsTzb6Yo1oacEC32P2dhrVr1/47mR65cLsbovpbOFbsgKtdM0TxIPH+
	KFm7UW5ItczaX86nELLifw0hdC5o4l1YCFtpW8vCMUgLnPYcpmFGR9aTRCLMBQYG/8O/unINEo8
	38li52hvvCPpd3VHHeXXHTiu6lkcQHKnq4BQLOJZYYGQyaJQ+yp6cPGUCmz53ImZBryJfYdBbSD
	k
X-Received: by 2002:a17:90a:e7ca:b0:3ac:7556:8eec with SMTP id 98e67ed59e1d1-3ad87071486mr745441a91.39.1792553105682;
        Tue, 20 Oct 2026 20:25:05 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8030226csm2155285a91.12.2026.10.20.20.25.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 20:25:05 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH net v6 6/6] nfc: nfcmrvl: stop firmware work before unregistering
Date: Wed, 21 Oct 2026 08:54:43 +0530
Message-ID: <20261021032443.44412-7-shubham@octane.security>
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

nfcmrvl_nci_unregister_dev() destroys the NCI workqueues before draining
the firmware receive worker.  That worker can still submit NCI commands,
while the later abort can release firmware state that it is processing.
The firmware timeout can also complete the same download in parallel with
the receive worker.

Add active and stopping states protected by the firmware receive lock.
Once completion or teardown starts, reject new firmware receives and wait
for active receive entry points.  Shut down the firmware timer, cancel the
receive worker, and purge its queue before releasing firmware state.
Perform this shutdown before unregistering the NCI device so its
command workqueues remain available until the firmware worker has finished.
Queue timeout completion on the same single-thread workqueue and claim
completion under the receive lock so download state is released once.  Use
a local copy of the firmware name while reporting completion so a following
request cannot change the notification.  Unregister the NCI device before
withdrawing the UART back-pointers so core admission is closed first.
Process one receive frame per work invocation so queued timeout work cannot
be starved by a continuously replenished receive queue.

Initialize the firmware timer with the receive workqueue so the shutdown
path is valid even when a download was never started.  Serialize the
stopping transition with firmware start through the NFC device lock.
Use non-synchronous timeout-work cancellation because completion can run
from the timeout work itself.

OpenAI Codex, gpt-5.6-sol assisted a source audit of the UART teardown
path.

Fixes: 3194c6870158 ("NFC: nfcmrvl: add firmware download support")
Cc: stable@vger.kernel.org
Assisted-by: LLM KASAN
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/fw_dnld.c | 199 +++++++++++++++++++++++++---------
 drivers/nfc/nfcmrvl/fw_dnld.h |   8 ++
 drivers/nfc/nfcmrvl/main.c    |   5 +-
 3 files changed, 156 insertions(+), 56 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
index 8b9d5257320d..d3dec74a333d 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -92,11 +92,29 @@ static struct sk_buff *alloc_lc_skb(struct nfcmrvl_private *priv, uint8_t plen)
 
 static void fw_dnld_over(struct nfcmrvl_private *priv, u32 error)
 {
-	if (priv->fw_dnld.fw) {
-		release_firmware(priv->fw_dnld.fw);
-		priv->fw_dnld.fw = NULL;
-		priv->fw_dnld.header = NULL;
-		priv->fw_dnld.binary_config = NULL;
+	struct nfcmrvl_fw_dnld *fw_dnld = &priv->fw_dnld;
+	char name[NFC_FIRMWARE_NAME_MAXSIZE + 1];
+	unsigned long flags;
+
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	if (!fw_dnld->active) {
+		spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+		return;
+	}
+	fw_dnld->active = false;
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+
+	strscpy(name, fw_dnld->name);
+	wait_event(fw_dnld->rx_wait, !READ_ONCE(fw_dnld->rx_active));
+	timer_delete_sync(&fw_dnld->timer);
+	/* Timeout and receive work share a single-thread workqueue. */
+	cancel_work(&fw_dnld->timeout_work);
+
+	if (fw_dnld->fw) {
+		release_firmware(fw_dnld->fw);
+		fw_dnld->fw = NULL;
+		fw_dnld->header = NULL;
+		fw_dnld->binary_config = NULL;
 	}
 
 	atomic_set(&priv->ndev->cmd_cnt, 0);
@@ -104,8 +122,7 @@ static void fw_dnld_over(struct nfcmrvl_private *priv, u32 error)
 	if (timer_pending(&priv->ndev->cmd_timer))
 		timer_delete_sync(&priv->ndev->cmd_timer);
 
-	if (timer_pending(&priv->fw_dnld.timer))
-		timer_delete_sync(&priv->fw_dnld.timer);
+	skb_queue_purge(&fw_dnld->rx_q);
 
 	nfc_info(priv->dev, "FW loading over (%d)]\n", error);
 
@@ -114,7 +131,7 @@ static void fw_dnld_over(struct nfcmrvl_private *priv, u32 error)
 		nfcmrvl_chip_halt(priv);
 	}
 
-	nfc_fw_download_done(priv->ndev->nfc_dev, priv->fw_dnld.name, error);
+	nfc_fw_download_done(priv->ndev->nfc_dev, name, error);
 }
 
 static void fw_dnld_timeout(struct timer_list *t)
@@ -122,6 +139,18 @@ static void fw_dnld_timeout(struct timer_list *t)
 	struct nfcmrvl_private *priv = timer_container_of(priv, t,
 							  fw_dnld.timer);
 
+	queue_work(priv->fw_dnld.rx_wq, &priv->fw_dnld.timeout_work);
+}
+
+static void fw_dnld_timeout_work(struct work_struct *work)
+{
+	struct nfcmrvl_fw_dnld *fw_dnld = container_of(work,
+						       struct nfcmrvl_fw_dnld,
+						       timeout_work);
+	struct nfcmrvl_private *priv = container_of(fw_dnld,
+						    struct nfcmrvl_private,
+						    fw_dnld);
+
 	nfc_err(priv->dev, "FW loading timeout");
 	priv->fw_dnld.state = STATE_RESET;
 	fw_dnld_over(priv, -ETIMEDOUT);
@@ -395,6 +424,7 @@ static int process_state_boot(struct nfcmrvl_private *priv,
 
 static void fw_dnld_rx_work(struct work_struct *work)
 {
+	unsigned long flags;
 	int ret;
 	struct sk_buff *skb;
 	struct nfcmrvl_fw_dnld *fw_dnld = container_of(work,
@@ -404,53 +434,64 @@ static void fw_dnld_rx_work(struct work_struct *work)
 						    struct nfcmrvl_private,
 						    fw_dnld);
 
-	while ((skb = skb_dequeue(&fw_dnld->rx_q))) {
-		nfc_send_to_raw_sock(priv->ndev->nfc_dev, skb,
-				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
-		switch (fw_dnld->state) {
-		case STATE_RESET:
-			ret = process_state_reset(priv, skb);
-			break;
-		case STATE_INIT:
-			ret = process_state_init(priv, skb);
-			break;
-		case STATE_SET_REF_CLOCK:
-			ret = process_state_set_ref_clock(priv, skb);
-			break;
-		case STATE_SET_HI_CONFIG:
-			ret = process_state_set_hi_config(priv, skb);
-			break;
-		case STATE_OPEN_LC:
-			ret = process_state_open_lc(priv, skb);
-			break;
-		case STATE_FW_DNLD:
-			ret = process_state_fw_dnld(priv, skb);
-			break;
-		case STATE_CLOSE_LC:
-			ret = process_state_close_lc(priv, skb);
-			break;
-		case STATE_BOOT:
-			ret = process_state_boot(priv, skb);
-			break;
-		default:
-			ret = -EFAULT;
-		}
+	skb = skb_dequeue(&fw_dnld->rx_q);
+	if (!skb)
+		return;
 
-		kfree_skb(skb);
+	nfc_send_to_raw_sock(priv->ndev->nfc_dev, skb,
+			     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
+	switch (fw_dnld->state) {
+	case STATE_RESET:
+		ret = process_state_reset(priv, skb);
+		break;
+	case STATE_INIT:
+		ret = process_state_init(priv, skb);
+		break;
+	case STATE_SET_REF_CLOCK:
+		ret = process_state_set_ref_clock(priv, skb);
+		break;
+	case STATE_SET_HI_CONFIG:
+		ret = process_state_set_hi_config(priv, skb);
+		break;
+	case STATE_OPEN_LC:
+		ret = process_state_open_lc(priv, skb);
+		break;
+	case STATE_FW_DNLD:
+		ret = process_state_fw_dnld(priv, skb);
+		break;
+	case STATE_CLOSE_LC:
+		ret = process_state_close_lc(priv, skb);
+		break;
+	case STATE_BOOT:
+		ret = process_state_boot(priv, skb);
+		break;
+	default:
+		ret = -EFAULT;
+	}
 
-		if (ret != 0) {
-			nfc_err(priv->dev, "FW loading error");
-			fw_dnld_over(priv, ret);
-			break;
-		}
+	kfree_skb(skb);
+
+	if (ret) {
+		nfc_err(priv->dev, "FW loading error");
+		fw_dnld_over(priv, ret);
 	}
+
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	if (!fw_dnld->stopping && fw_dnld->active &&
+	    !skb_queue_empty(&fw_dnld->rx_q))
+		queue_work(fw_dnld->rx_wq, &fw_dnld->rx_work);
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
 }
 
 int nfcmrvl_fw_dnld_init(struct nfcmrvl_private *priv)
 {
 	char name[32];
 
+	spin_lock_init(&priv->fw_dnld.rx_lock);
+	init_waitqueue_head(&priv->fw_dnld.rx_wait);
 	INIT_WORK(&priv->fw_dnld.rx_work, fw_dnld_rx_work);
+	INIT_WORK(&priv->fw_dnld.timeout_work, fw_dnld_timeout_work);
+	timer_setup(&priv->fw_dnld.timer, fw_dnld_timeout, 0);
 	snprintf(name, sizeof(name), "%s_nfcmrvl_fw_dnld_rx_wq",
 		 dev_name(&priv->ndev->nfc_dev->dev));
 	priv->fw_dnld.rx_wq = create_singlethread_workqueue(name);
@@ -462,12 +503,24 @@ int nfcmrvl_fw_dnld_init(struct nfcmrvl_private *priv)
 
 void nfcmrvl_fw_dnld_deinit(struct nfcmrvl_private *priv)
 {
+	nfcmrvl_fw_dnld_abort(priv);
 	destroy_workqueue(priv->fw_dnld.rx_wq);
 }
 
 void nfcmrvl_fw_dnld_recv_frame(struct nfcmrvl_private *priv,
 				struct sk_buff *skb)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->fw_dnld.rx_lock, flags);
+	if (priv->fw_dnld.stopping || !priv->fw_dnld.active) {
+		spin_unlock_irqrestore(&priv->fw_dnld.rx_lock, flags);
+		kfree_skb(skb);
+		return;
+	}
+	priv->fw_dnld.rx_active++;
+	spin_unlock_irqrestore(&priv->fw_dnld.rx_lock, flags);
+
 	/* Discard command timer */
 	if (timer_pending(&priv->ndev->cmd_timer))
 		timer_delete_sync(&priv->ndev->cmd_timer);
@@ -475,13 +528,38 @@ void nfcmrvl_fw_dnld_recv_frame(struct nfcmrvl_private *priv,
 	/* Allow next command */
 	atomic_set(&priv->ndev->cmd_cnt, 1);
 
-	/* Queue and trigger rx work */
-	skb_queue_tail(&priv->fw_dnld.rx_q, skb);
-	queue_work(priv->fw_dnld.rx_wq, &priv->fw_dnld.rx_work);
+	spin_lock_irqsave(&priv->fw_dnld.rx_lock, flags);
+	if (!priv->fw_dnld.stopping && priv->fw_dnld.active) {
+		/* Queue and trigger rx work */
+		skb_queue_tail(&priv->fw_dnld.rx_q, skb);
+		queue_work(priv->fw_dnld.rx_wq, &priv->fw_dnld.rx_work);
+		skb = NULL;
+	}
+	priv->fw_dnld.rx_active--;
+	if (!priv->fw_dnld.rx_active &&
+	    (priv->fw_dnld.stopping || !priv->fw_dnld.active))
+		wake_up_all(&priv->fw_dnld.rx_wait);
+	spin_unlock_irqrestore(&priv->fw_dnld.rx_lock, flags);
+	kfree_skb(skb);
 }
 
 void nfcmrvl_fw_dnld_abort(struct nfcmrvl_private *priv)
 {
+	struct nfcmrvl_fw_dnld *fw_dnld = &priv->fw_dnld;
+	unsigned long flags;
+
+	device_lock(&priv->ndev->nfc_dev->dev);
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	fw_dnld->stopping = true;
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+	device_unlock(&priv->ndev->nfc_dev->dev);
+
+	wait_event(fw_dnld->rx_wait, !READ_ONCE(fw_dnld->rx_active));
+	timer_shutdown_sync(&fw_dnld->timer);
+	cancel_work_sync(&fw_dnld->rx_work);
+	cancel_work_sync(&fw_dnld->timeout_work);
+	skb_queue_purge(&fw_dnld->rx_q);
+
 	fw_dnld_over(priv, -EHOSTDOWN);
 }
 
@@ -489,6 +567,7 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
 {
 	struct nfcmrvl_private *priv = nci_get_drvdata(ndev);
 	struct nfcmrvl_fw_dnld *fw_dnld = &priv->fw_dnld;
+	unsigned long flags;
 	int res;
 
 	if (!priv->support_fw_dnld)
@@ -497,6 +576,13 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
 	if (!firmware_name || !firmware_name[0])
 		return -EINVAL;
 
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	if (fw_dnld->stopping) {
+		spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+		return -ENODEV;
+	}
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+
 	strscpy(fw_dnld->name, firmware_name);
 
 	/*
@@ -520,6 +606,7 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
 			firmware_name, fw_dnld->header->magic,
 			fw_dnld->header->phy);
 		release_firmware(fw_dnld->fw);
+		fw_dnld->fw = NULL;
 		fw_dnld->header = NULL;
 		return -EINVAL;
 	}
@@ -532,11 +619,6 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
 		fw_dnld->binary_config = &fw_dnld->header->firmware;
 	}
 
-	/* Configure a timer for timeout */
-	timer_setup(&priv->fw_dnld.timer, fw_dnld_timeout, 0);
-	mod_timer(&priv->fw_dnld.timer,
-		  jiffies + msecs_to_jiffies(FW_DNLD_TIMEOUT));
-
 	/* Ronfigure HI to be sure that it is the bootrom values */
 	priv->if_ops->nci_update_config(priv,
 					&fw_dnld->header->bootrom.config);
@@ -546,8 +628,19 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
 
 	/* First, reset the chip */
 	priv->fw_dnld.state = STATE_RESET;
+
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	fw_dnld->active = true;
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+
 	nfcmrvl_chip_reset(priv);
 
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	if (fw_dnld->active)
+		mod_timer(&fw_dnld->timer,
+			  jiffies + msecs_to_jiffies(FW_DNLD_TIMEOUT));
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+
 	/* Now wait for CORE_RESET_NTF or timeout */
 
 	return 0;
diff --git a/drivers/nfc/nfcmrvl/fw_dnld.h b/drivers/nfc/nfcmrvl/fw_dnld.h
index 7c4d91b01910..6bd8d580cd6a 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.h
+++ b/drivers/nfc/nfcmrvl/fw_dnld.h
@@ -8,6 +8,8 @@
 #ifndef __NFCMRVL_FW_DNLD_H__
 #define __NFCMRVL_FW_DNLD_H__
 
+#include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 
 #define NFCMRVL_FW_MAGIC		0x88888888
@@ -72,7 +74,13 @@ struct nfcmrvl_fw_dnld {
 
 	struct workqueue_struct	*rx_wq;
 	struct work_struct rx_work;
+	struct work_struct timeout_work;
 	struct sk_buff_head rx_q;
+	spinlock_t rx_lock; /* protects stopping, active, and rx_active */
+	wait_queue_head_t rx_wait;
+	unsigned int rx_active;
+	bool stopping;
+	bool active;
 
 	struct timer_list timer;
 };
diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index 27fadd64155e..86cf65396253 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -185,13 +185,12 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
 {
 	struct nci_dev *ndev = priv->ndev;
 
+	nfcmrvl_fw_dnld_abort(priv);
 	nci_unregister_device(ndev);
+
 	if (priv->if_ops->nci_quiesce)
 		priv->if_ops->nci_quiesce(priv);
 
-	if (atomic_read(&priv->ndev->nfc_dev->fw_download_in_progress))
-		nfcmrvl_fw_dnld_abort(priv);
-
 	nfcmrvl_fw_dnld_deinit(priv);
 
 	nci_free_device(ndev);
-- 
2.43.0

