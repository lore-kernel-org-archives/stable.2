Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910450;
	b=RLjfo1/Kq7JZLlxGfWCiSPSzcOZVfIgpB/gkUCA5c9BBCG8F5fbRXj2dA1ik6eUO9gFZ
	 uiaW6QBOow3zhZAqegiDcTkwrmE0swsBEw9G0vbbhCnFETr1S0ZfMNWjW1wAvISRwV2PS
	 9ttyw8zkWNk1yawe51M8OrVhds+l+ckBYOwpFn12EINsJWktei5ZE7AFFxxbuQG4upCnm
	 cXE6ZskoBhKcYT9VJdOeFSOtWC+7ybs6+8bY4q9ettvUqNY3JzV9OFrXAGWtXvywRUN2h
	 3sACJuaAZbsxSx/llZp7ErJgsZInzcMmobgHPG9SGQ5Vg5resb7J5NwsNuJ72zQIeBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910450;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ppnId+Tg1jnzc66apKySSTZOlEeyH/itQpXYhu1v22w=;
	b=XTEUYKhju2Cy7Th/aICr/n87fxXANIVl6nkKno1bDiIXf08BpKsCrQ6byAbjy1pO4oV0
	 oaGbsnBTDJWamgKy/YNz4Be0nmziZQRk1hm0eclzN9/eSidNimcFTjBh56+iWhxaw3VnM
	 0WVXqYpqQ7wnqvoPZtOsog/OoGcW/PBBbCnKo8k0FN/yAftHKxRRmx7ffYKjbQf1jTEQ+
	 lf0RyM7XvZsg6TDO+vDa4EZhltTKrzUV4n0LkUnaLtS+Zph8xx5SthLAY51T3ZCwQswW3
	 TXJp1tlCyw6CaJKUpeyiRGUdYALSWkKJT8opPaueO38FbDNHVFmQL9Bl2culQGNLsuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=TuNLN7sl;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA856606A8AE;
	Tue, 17 Nov 2026 10:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA856606A8AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=TuNLN7sl
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 35C3744A4D;
	Tue, 17 Nov 2026 21:14:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1794910442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppnId+Tg1jnzc66apKySSTZOlEeyH/itQpXYhu1v22w=;
	b=TuNLN7slaDhv62KJrnBlu7i9Zosbcuj5p+eQkno9Txto5EhQZfIR6eyLDTOKvowZePJ8KS
	xS91G8QIyQePRH9bVcD6vv2U+/fatve65Choit8G16xTR40oZHEzCU1XjsdxC5cSBUGHIf
	y4SMjk8xzlsAQXwDICjUtRbvUhizArwyhb3OHvXf5pL1QGKab/pAEGc6OiyG+26I4C7H4q
	j7fXx9EJxIrLueP/4N+V7k459TZ3oB4WhM9IvMm8n/y2xDfE+szsNzMDihygrETfi/CjMQ
	4SS94WJYabsBnNlby5NQ65Qlfei2QC9q/sNUpinePYHqNC8kFWqDflHIONzBzQ==
X-GPT-Reason: legitimate_transactional: The email is a technical
	Linux kernel patch submission which aligns perfectly with the
	personal mailbox of alastair@d-silva.org. The From domain (d-silva.org)
	matches the recipient mailbox, the content is highly specific technical
	code commentary (rtw88 wifi driver) without any marketing or phishing
	indicators, and there are no external links or requests for sensitive
	information.
From: Alastair D'Silva <alastair@d-silva.org>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Luka Gejak <luka.gejak@linux.dev>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alastair D'Silva <alastair@d-silva.org>,
	stable@vger.kernel.org
Subject: [PATCH rtw-next v11 2/4] wifi: rtw88: sdio: Track running state and cancel TX worker on stop
Date: Tue, 17 Nov 2026 21:13:45 +1100
Message-ID: <20261117101347.2157211-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117101347.2157211-1-alastair@d-silva.org>
References: <20261117101347.2157211-1-alastair@d-silva.org>
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

When rtw_sdio_stop() disables interrupts, in-flight interrupt handlers or
delayed TX work may still run against a powered-down device.

Track the operational state in rtwsdio->running with an irq_lock mutex
(similar to PCI), check it at the entry of rtw_sdio_handle_interrupt()
and rtw_sdio_tx_handler(), serialize state transitions in rtw_sdio_start()
and rtw_sdio_stop() under sdio_claim_host() and irq_lock, and cancel the
TX worker synchronously in rtw_sdio_stop().

Drain rtwsdio->tx_queue[] with locked skb_dequeue() and
ieee80211_free_txskb() in rtw_sdio_stop() and again in rtw_sdio_start() to
catch any frames queued by an in-flight rtwdev->tx_work after
rtw_sdio_stop() completes, and reset rtwsdio->tx_queue_stopped[] while
waking stopped AC queues under tx_queue[].lock in rtw_sdio_start().

Fixes: 28eaf7971a20 ("wifi: rtw88: sdio: add TX back-pressure and retry on page starvation")
Cc: stable@vger.kernel.org
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 66 ++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/sdio.h |  3 ++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 172aa7ad4732a..7ae56a35ae7b8 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -941,6 +941,8 @@ static void rtw_sdio_init(struct rtw_dev *rtwdev)
 {
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 
+	mutex_init(&rtwsdio->irq_lock);
+
 	if (rtw_is_8723bs(rtwdev))
 		rtwsdio->irq_mask = REG_SDIO_HIMR_RX_REQUEST;
 	else
@@ -1052,8 +1054,38 @@ static int rtw_sdio_8723bs_check_rqpn(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static void rtw_sdio_purge_tx_queues(struct rtw_dev *rtwdev)
+{
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+	struct sk_buff *skb;
+	int i;
+
+	for (i = 0; i < RTK_MAX_TX_QUEUE_NUM; i++) {
+		while ((skb = skb_dequeue(&rtwsdio->tx_queue[i])))
+			ieee80211_free_txskb(rtwdev->hw, skb);
+	}
+}
+
+static void rtw_sdio_reset_tx_queue_state(struct rtw_dev *rtwdev)
+{
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+	enum rtw_tx_queue_type queue;
+	int i;
+
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		queue = rtw_tx_ac_to_hwq(i);
+		scoped_guard(spinlock_irqsave, &rtwsdio->tx_queue[queue].lock) {
+			if (rtwsdio->tx_queue_stopped[queue]) {
+				rtwsdio->tx_queue_stopped[queue] = false;
+				ieee80211_wake_queue(rtwdev->hw, i);
+			}
+		}
+	}
+}
+
 static int rtw_sdio_start(struct rtw_dev *rtwdev)
 {
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 	u32 clear;
 
 	if (rtw_is_8723bs(rtwdev)) {
@@ -1069,20 +1101,40 @@ static int rtw_sdio_start(struct rtw_dev *rtwdev)
 
 	rtw_sdio_enable_rx_aggregation(rtwdev);
 
+	rtw_sdio_purge_tx_queues(rtwdev);
+	rtw_sdio_reset_tx_queue_state(rtwdev);
+
+	sdio_claim_host(rtwsdio->sdio_func);
+
 	if (rtw_is_8723bs(rtwdev)) {
 		clear = rtw_read32(rtwdev, REG_SDIO_HISR) & RTW_SDIO_HISR_CLEAR_MASK;
 		if (clear)
 			rtw_write32(rtwdev, REG_SDIO_HISR, clear);
 	}
 
-	rtw_sdio_enable_interrupt(rtwdev);
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		rtwsdio->running = true;
+		rtw_sdio_enable_interrupt(rtwdev);
+	}
+
+	sdio_release_host(rtwsdio->sdio_func);
 
 	return 0;
 }
 
 static void rtw_sdio_stop(struct rtw_dev *rtwdev)
 {
-	rtw_sdio_disable_interrupt(rtwdev);
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+
+	sdio_claim_host(rtwsdio->sdio_func);
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		rtwsdio->running = false;
+		rtw_sdio_disable_interrupt(rtwdev);
+	}
+	sdio_release_host(rtwsdio->sdio_func);
+
+	cancel_delayed_work_sync(&rtwsdio->tx_handler_data->work);
+	rtw_sdio_purge_tx_queues(rtwdev);
 }
 
 static void rtw_sdio_deep_ps_enter(struct rtw_dev *rtwdev)
@@ -1477,6 +1529,11 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 	rtwdev = hw->priv;
 	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		if (!rtwsdio->running)
+			return;
+	}
+
 	rtwsdio->irq_thread = current;
 
 	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
@@ -1710,6 +1767,11 @@ static void rtw_sdio_tx_handler(struct work_struct *work)
 	rtwdev = work_data->rtwdev;
 	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		if (!rtwsdio->running)
+			return;
+	}
+
 	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_TX_WAKE))
 		rtw_sdio_deep_ps_leave(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.h b/drivers/net/wireless/realtek/rtw88/sdio.h
index 6e7e6009744b0..64266b54f595d 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.h
+++ b/drivers/net/wireless/realtek/rtw88/sdio.h
@@ -168,6 +168,9 @@ struct rtw_sdio {
 	bool sdio3_bus_mode;
 
 	void *irq_thread;
+	bool running;
+	/* protect running state and enabling interrupts */
+	struct mutex irq_lock;
 
 	struct workqueue_struct *txwq;
 	struct rtw_sdio_work_data *tx_handler_data;
-- 
2.53.0

