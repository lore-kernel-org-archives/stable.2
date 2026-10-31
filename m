Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417751;
	b=4rh2VIPDEXgVFaKIeMMfr21/jtyn2NuKTTUj0HQ3PMmLDOMYwhvO2YAwwB6zmYz4cyi2
	 sw87W+QY9yjl17yPnyW8rpNIKunqBj/7v8254KwZIpgt2jEgHsJSanN5JRqkiA0FphmVV
	 Zgnx7eaRXefgVaITnEOFUumQBUtGoJACelo5unFL2hqF+h/zZrTpOabOyVXietmgoINtL
	 gUqnMo0oRWPQO9h5qE+uGSNcEiwhJhhM6hNeY8tuFyXYuXEpGSSYpag7e2rNav4ve4BTW
	 HP4lolK/iRIu3drvNB9Ls/aV2be+1YJcWDhxWCgh50jhTHz/Eyj+/+hEWi0w6+jatoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417751;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EtMuEczTwNbcfN6Jb3sHVVATn5gLyv+kEp9Pwa2uXKE=;
	b=2k1nwEUKWutluzZ4LAlMMtEVKtS3pceqnLkLI80c73PyRi0vBMGrOjm9mCTnr9ptiv8v
	 dyzD0OxoKSMqBXJE3CDWBcUz63m5JHimXYg+ZimR+rVKg3hZTfEM5jfaZtKJCNxbjHo/k
	 O9B3n+IcEQDt91qoUraxO/UZd3GzFD5xJK0os+4MwC+tktARdt2z4t8kfMmziSxdpPHsI
	 78/g1FrIyf/2f41Xj5+U9+0E9IOZA77rLlRfiIDbr7oEewlhTxrfMkqCby6yBShWl/2F8
	 HvEtXS8bhvkeiyaOvLPCkn6QyCJxy+anrhFr8/RycoEfC/+mfysdssuKhzfKJ1EfoOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=jUJ286m3;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26389606A31A;
	Sat, 31 Oct 2026 03:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26389606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=jUJ286m3
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 8E6E0413FF;
	Sat, 31 Oct 2026 14:35:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1793417743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtMuEczTwNbcfN6Jb3sHVVATn5gLyv+kEp9Pwa2uXKE=;
	b=jUJ286m3NlCEMK5t480q/UVtbZWAWBz53BYMnVLFSWuiqljgv36hT/G8khlwKyh08rSypu
	i5NJ9wvXdIcH/0G6ra1PQVJj4WUZmw7jbFkpSVHVhNP+BJGNk44yYFay+I5uUg4MlvgHSH
	O5ZLCSa1dERo6oi6WX/529l7SWk54Nq8gKnE8q0iuWLjhRe8K/4r5TvQ1T8Ja7sq5NcVyZ
	DKyDqM5o3VU/Epf9uyiKKQFm4sieDfEf3uOsPyYTSFTR19/FV/oeKvOl8d9ChumMYLqyw+
	VpzjvsnwhPPEZ95Z3y6Mcr7KrOmXB3y3Nm09w2GrdZd+IJznLDDJSZzaG9D5Jw==
X-GPT-Reason: legitimate; the email is a technical kernel patch
	submission from a known personal mailbox (alastair@d-silva.org)
	which aligns with the content; the subject and body describe specific
	technical changes to the Linux kernel (rtw88 wifi driver) including
	a fix for a specific commit ID; there are no phishing indicators,
	marketing elements, or suspicious links.
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
Subject: [PATCH rtw-next v7 2/4] wifi: rtw88: sdio: Track running state and cancel TX worker on stop
Date: Sat, 31 Oct 2026 14:35:24 +1100
Message-ID: <20261031033526.474710-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031033526.474710-1-alastair@d-silva.org>
References: <20261031033526.474710-1-alastair@d-silva.org>
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
worker synchronously in rtw_sdio_stop(), and re-arm it in rtw_sdio_start()
so any frames left parked across a stop are drained and stopped queues are
woken.

Fixes: 28eaf7971a20 ("wifi: rtw88: sdio: add TX back-pressure and retry on page starvation")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 35 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/sdio.h |  3 ++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index e39284b71837..253467250ee6 100644
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
@@ -1069,20 +1072,38 @@ static int rtw_sdio_start(struct rtw_dev *rtwdev)
 
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
+
+	queue_delayed_work(rtwsdio->txwq, &rtwsdio->tx_handler_data->work, 0);
 
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
 }
 
 static void rtw_sdio_deep_ps_enter(struct rtw_dev *rtwdev)
@@ -1470,6 +1491,11 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 	rtwdev = hw->priv;
 	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		if (!rtwsdio->running)
+			return;
+	}
+
 	rtwsdio->irq_thread = current;
 
 	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
@@ -1703,6 +1729,11 @@ static void rtw_sdio_tx_handler(struct work_struct *work)
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
index 6e7e6009744b..64266b54f595 100644
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

