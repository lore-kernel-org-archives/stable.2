Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847445;
	b=zdMj8Sa+pjjdhqi9Wv15Igt6mCtCD2muNLdCDaKJJzAwHneP9cF8Dy05IOX88ShBTMfg
	 fv1xDi/xR43+YdCPc4NQWU+T3Ah2ddUpJjps8T4yLHM6KnxjqsOxngsQwtR/Thr8Rck7x
	 fwztwthCWw0/hiW6tGB8Oks9o5E01UIMNiRoBrdDKCtm/JbGCjaSSuj+Jl6aUnfm+N4pW
	 JwEhkADeMwlz8T6ka4KAIyjGZICc/dKW5MK71eEcpVxtnSNyZEplCLuf71mfcLcwuFyET
	 YK52Sgo5r+gwqlRlIR7EKVNNYoJZFu1ZHnl9UDIgTtt+RHAeJGpPOS9FihwRo6YnVWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847445;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kFn1OX+6FsSsT47EB9T1OrR6/BEpjvhs9/Zdbykf1/M=;
	b=E09a7aaD/IqHom3g5MlptkJmS6qUAHTpZElx0dt09G2gCKqGa85IIIOdTomF9P3pznHv
	 3a41hide0gt8XHag1GYSNykbwWcU1q77lAD1wMhvQVYvNJ1bVVzw94ZafPjZ0lVDj5WqP
	 WYnRwm73Ab2bvti3Grb/KsZ9RUMuqtE0rFTre8kdaWd4zlBAEhRXnkYVLP3v3oiqHd82W
	 mPa5qxoI/XS1JDDMXYtVa3f94fiVb31U0PECAmY2Mbusgi4sXzYbqexjahWNybTQoSTJY
	 0ElyLxQPJ31S281ukyoDg2qn2Vy1+d5JdjZMLg7HmJOhDNIRnG/SHowQmQxe8CLxK3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=xNfkzy28;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EE6606A337;
	Thu,  5 Nov 2026 02:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8EE6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=xNfkzy28
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 0B16541A46;
	Thu,  5 Nov 2026 13:57:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1793847436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFn1OX+6FsSsT47EB9T1OrR6/BEpjvhs9/Zdbykf1/M=;
	b=xNfkzy281D829mYDxvBFa+soMiVZpjigiKe7X9l056CEDOfpWTp7ORxfFP28wAa+k2225K
	EEJpqdP8x72dvYpAFce6v4gNSRegffkC4ff62NNdcLPFcBYCROtuXd11KcI+owhVpVu0QY
	J29TWomxagGwRXqD41WCrc0bPdYPsoXyuzrSsRhTP8w3trh9aUdYNWotiY8aGHSpVAVH+T
	i9NZjVrN65bHQWjghKHkEX9ZHnYsyCL6tcm+alwM7e/Jb2ByNoPLWve3o6vArl8ZEOq6AR
	WqpP4dJFjmt6FsKPwaApSEKkupErRXfAYA6mUEUgMXvv8f/aQ3ZpybrgWfRRJQ==
X-GPT-Reason: This is a legitimate personal/professional communication.
	The mailbox (alastair@d-silva.org) is a personal address that
	aligns with the sender's identity (Alastair D'Silva <alastair@d-silva.org>),
	and the content is a technical Linux kernel patch description
	regarding "rtw88: sdio" drivers. There are no phishing red flags,
	no marketing elements, no suspicious links, and the technical nature
	of the "Signed-off-by" and "Fixes" lines confirms it is a standard
	software development workflow.
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
Subject: [PATCH rtw-next v8 2/4] wifi: rtw88: sdio: Track running state and cancel TX worker on stop
Date: Thu,  5 Nov 2026 13:56:58 +1100
Message-ID: <20261105025700.1655219-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105025700.1655219-1-alastair@d-silva.org>
References: <20261105025700.1655219-1-alastair@d-silva.org>
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
and rtw_sdio_stop() under sdio_claim_host() and irq_lock, cancel the TX
worker synchronously in rtw_sdio_stop(), and purge any remaining frames in
rtwsdio->tx_queue[] while waking any stopped AC queues.

Fixes: 28eaf7971a20 ("wifi: rtw88: sdio: add TX back-pressure and retry on page starvation")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 46 ++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/sdio.h |  3 ++
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 172aa7ad4732a..e318fefe5b5e7 100644
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
@@ -1054,6 +1056,7 @@ static int rtw_sdio_8723bs_check_rqpn(struct rtw_dev *rtwdev)
 
 static int rtw_sdio_start(struct rtw_dev *rtwdev)
 {
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 	u32 clear;
 
 	if (rtw_is_8723bs(rtwdev)) {
@@ -1069,20 +1072,49 @@ static int rtw_sdio_start(struct rtw_dev *rtwdev)
 
 	rtw_sdio_enable_rx_aggregation(rtwdev);
 
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
+	enum rtw_tx_queue_type queue;
+	int i;
+
+	sdio_claim_host(rtwsdio->sdio_func);
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		rtwsdio->running = false;
+		rtw_sdio_disable_interrupt(rtwdev);
+	}
+	sdio_release_host(rtwsdio->sdio_func);
+
+	cancel_delayed_work_sync(&rtwsdio->tx_handler_data->work);
+
+	for (i = 0; i < RTK_MAX_TX_QUEUE_NUM; i++)
+		ieee80211_purge_tx_queue(rtwdev->hw, &rtwsdio->tx_queue[i]);
+
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		queue = rtw_tx_ac_to_hwq(i);
+		if (rtwsdio->tx_queue_stopped[queue]) {
+			rtwsdio->tx_queue_stopped[queue] = false;
+			ieee80211_wake_queue(rtwdev->hw, i);
+		}
+	}
 }
 
 static void rtw_sdio_deep_ps_enter(struct rtw_dev *rtwdev)
@@ -1477,6 +1509,11 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 	rtwdev = hw->priv;
 	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		if (!rtwsdio->running)
+			return;
+	}
+
 	rtwsdio->irq_thread = current;
 
 	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
@@ -1710,6 +1747,11 @@ static void rtw_sdio_tx_handler(struct work_struct *work)
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

