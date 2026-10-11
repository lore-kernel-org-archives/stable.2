Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFEF35E956;
	Sun, 11 Oct 2026 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756503; cv=none; b=fgm4McNCGK7SAhQLbtuHxYcJPJe3CDarLl9+C8Y91MkLCVl03qi4meEtxphDLpU/NCRoUjkhhNm0SH1E7k453dtIug2dQU/xZ2y7N4mr6o5IH5h4JAOXyt8fiLgZBiFL7ZIk56KDHtkYmE74Jf5wnZuWnkQcQHzHi2s3a73BR/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756503; c=relaxed/simple;
	bh=LezMMeZuSUp4M8zIm3VZKHh/txrDoLK0mBjDGnbQTuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeQchTcociebQeYX31ZkQpJe6p6yZ4HJy9RJp2Iz06JFhu7J/c/kyVWoVOg7JFF+94vIF6ry0xWCs1b1BX9Q/jHn1V4OMeC/AbvDkw5hI9Ckkk1oU4Spli9qVFDXtxaqDfOYrFe2uzOh5uqGn/NkOZd6AKhRcYc5qxRW4tAHmCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=pjMVbMp/; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="pjMVbMp/"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 445C54341A;
	Mon, 12 Oct 2026 09:08:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1791756490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AC1HoNfzreKEgwvs/WZ+6JzwyPhLYpfVUpptn+hQzEU=;
	b=pjMVbMp/bsty4uiMy5NHRMnP9dVC501c9z9cZ7N6fPKFFhkE81pfk7dfm8TV85IIHj5WJC
	tJ1wj6p7JlHmpeiZBDJ7lB5Oi6ykFPejintCMWT8uqGW0B9D2Pz2+40fPwQQe/KkGdtyjj
	4tcXQQMe0BuJlqeSQ3F6kq0t0PWm2lC5k7tQ8+0D3ae8gEOQJYeCKXI/D4v26ZOoN/Fppa
	pGHInpnrrWeS6WzTAZVrTwKnhg1VMAeeSYOckUqsUL0EgPtctcr9OnV6Zxc1eHh9jLg+MM
	2yEOKynS+bX49GoUa4FhYSzcARUQo33vdjsxK1HV8UH/j9UH6NKR0SELstREZg==
X-GPT-Reason: legitimate; the email is a technical software patch
	(kernel driver update) which perfectly matches the sender's domain
	(alastair@d-silva.org) and the technical nature of the content;
	there are no phishing indicators, urgency, or external links, and
	the presence of "Signed-off-by" and "Cc: stable@vger.kernel.org" confirms
	it is a standard Linux kernel development workflow.
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
Subject: [PATCH rtw-next v5 2/4] wifi: rtw88: sdio: Track running state and cancel TX worker on stop
Date: Mon, 12 Oct 2026 09:07:53 +1100
Message-ID: <20261011220755.1673367-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011220755.1673367-1-alastair@d-silva.org>
References: <20261011220755.1673367-1-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rtw_sdio_stop() disables interrupts, in-flight interrupt handlers or
delayed TX work may still run against a powered-down device.

Track the operational state in rtwsdio->running with an irq_lock mutex
(similar to PCI), check it at the entry of rtw_sdio_handle_interrupt()
and rtw_sdio_tx_handler(), serialize state transitions in rtw_sdio_start()
and rtw_sdio_stop() under sdio_claim_host() and irq_lock, and cancel the
TX worker synchronously in rtw_sdio_stop().

Fixes: 28eaf7971a20 ("wifi: rtw88: sdio: add TX back-pressure and retry on page starvation")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 46 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/sdio.h |  3 ++
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index e39284b71837..7d4f17e96648 100644
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
@@ -948,6 +950,13 @@ static void rtw_sdio_init(struct rtw_dev *rtwdev)
 				    REG_SDIO_HIMR_CPWM1;
 }
 
+static void rtw_sdio_deinit(struct rtw_dev *rtwdev)
+{
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+
+	mutex_destroy(&rtwsdio->irq_lock);
+}
+
 static void rtw_sdio_enable_rx_aggregation(struct rtw_dev *rtwdev)
 {
 	u8 size, timeout;
@@ -1054,6 +1063,7 @@ static int rtw_sdio_8723bs_check_rqpn(struct rtw_dev *rtwdev)
 
 static int rtw_sdio_start(struct rtw_dev *rtwdev)
 {
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 	u32 clear;
 
 	if (rtw_is_8723bs(rtwdev)) {
@@ -1069,20 +1079,36 @@ static int rtw_sdio_start(struct rtw_dev *rtwdev)
 
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
@@ -1470,6 +1496,11 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 	rtwdev = hw->priv;
 	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		if (!rtwsdio->running)
+			return;
+	}
+
 	rtwsdio->irq_thread = current;
 
 	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
@@ -1703,6 +1734,11 @@ static void rtw_sdio_tx_handler(struct work_struct *work)
 	rtwdev = work_data->rtwdev;
 	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		if (!rtwsdio->running)
+			return;
+	}
+
 	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_TX_WAKE))
 		rtw_sdio_deep_ps_leave(rtwdev);
 
@@ -1818,7 +1854,7 @@ int rtw_sdio_probe(struct sdio_func *sdio_func,
 	ret = rtw_sdio_init_tx(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to init SDIO TX queue\n");
-		goto err_sdio_declaim;
+		goto err_deinit;
 	}
 
 	ret = rtw_chip_info_setup(rtwdev);
@@ -1843,7 +1879,8 @@ int rtw_sdio_probe(struct sdio_func *sdio_func,
 	rtw_sdio_free_irq(rtwdev, sdio_func);
 err_destroy_txwq:
 	rtw_sdio_deinit_tx(rtwdev);
-err_sdio_declaim:
+err_deinit:
+	rtw_sdio_deinit(rtwdev);
 	rtw_sdio_declaim(rtwdev, sdio_func);
 err_deinit_core:
 	rtw_core_deinit(rtwdev);
@@ -1869,6 +1906,7 @@ void rtw_sdio_remove(struct sdio_func *sdio_func)
 	rtw_sdio_free_irq(rtwdev, sdio_func);
 	rtw_sdio_declaim(rtwdev, sdio_func);
 	rtw_sdio_deinit_tx(rtwdev);
+	rtw_sdio_deinit(rtwdev);
 	rtw_core_deinit(rtwdev);
 	ieee80211_free_hw(hw);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.h b/drivers/net/wireless/realtek/rtw88/sdio.h
index 6e7e6009744b..00a61415ba9c 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.h
+++ b/drivers/net/wireless/realtek/rtw88/sdio.h
@@ -168,6 +168,9 @@ struct rtw_sdio {
 	bool sdio3_bus_mode;
 
 	void *irq_thread;
+	bool running;
+	/* protect running state and interrupt mask */
+	struct mutex irq_lock;
 
 	struct workqueue_struct *txwq;
 	struct rtw_sdio_work_data *tx_handler_data;
-- 
2.53.0

