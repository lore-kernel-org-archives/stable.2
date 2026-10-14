Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2704A5EDC;
	Wed, 14 Oct 2026 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963901; cv=none; b=gR2SHcwIe9b8u6LRQ51uHHOvo1pAdWNHvmKml8Hhj1LwzCVpuO7dhJMWx1czZt/0YFlEgjWbQ/+PBCqjBEl0m8xa6cmIXSfVXOL6ybwFTRi99tYg5r1gjaeLJMXou7+M1wcZbm0w4l9+v/w88vHwkzNWLwtlLKE3d4za0LHrJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963901; c=relaxed/simple;
	bh=ORnRaQLL8zzknMPX/RYkZdHRb1feto8n5O7zVQqanCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utMTIpRm4Nj5R0UxB9kh171aVELpb3xpzDb7JmKngzKjnjpNvhJhaS9vtI4QySuXxialGzEItQwmSt/JRqeabFE+XRjy8QMFXNNlpmtAEpY7KPItySkDJy2oPdFlQPgVi3Bh4fritSlLeDRfoAlBZgS6OiFEsDraq5EyKERJ0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=BDNVhUxO; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="BDNVhUxO"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 4E8BC4347E;
	Wed, 14 Oct 2026 18:44:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1791963882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzcCnJK5jnBld07I1KNlKYdOh6RAxjyggoqSCbtGqiQ=;
	b=BDNVhUxOiOaxeUphGCkdnwqAfYM/ujRcIIOht9Jj1SFvzcY9tPPkwlNV6nw8pKwc9ITbmK
	/q5cj3b5GgrstuH2ZK2xg9WiLGikzNE3WXtx/zLhJ60uDQYBLVFsHW5S5HOvwsSgZq635N
	47/c5VesJN7+NsgmKQy1cNtomQWV3G5UozEe+QH/j0yLBwJDT+cqwymTGcjBj9jDArxBOz
	d53SiAFDiHPWzMKrnTRu0/ankoFlT5YR+Kvv6vCDBsUweh7ap/1IfsdMuZz3SAEFtpVXAN
	Y4x5FU8XHQzp68r+JTxzcUDJl2X4xC4MbjCTVc4Jy+wJ7UWRAldZiXdevk3yzQ==
X-GPT-Reason: legitimate; the email is a technical software patch
	submission for a Linux kernel driver, which perfectly aligns with
	the personal/professional context of the recipient and sender;
	the content contains a standard "Signed-off-by" signature, a specific
	commit hash, and technical code diffs (C code) rather than marketing
	or phishing links; the From domain (d-silva.org) matches the sender's
	name and the content is purely developmental/functional.
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
Subject: [PATCH rtw-next v6 2/4] wifi: rtw88: sdio: Track running state and cancel TX worker on stop
Date: Wed, 14 Oct 2026 18:44:24 +1100
Message-ID: <20261014074426.2183095-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014074426.2183095-1-alastair@d-silva.org>
References: <20261014074426.2183095-1-alastair@d-silva.org>
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
 drivers/net/wireless/realtek/rtw88/sdio.c | 33 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/sdio.h |  3 +++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index e39284b71837..2e26e7a2a0fd 100644
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
@@ -1069,20 +1072,36 @@ static int rtw_sdio_start(struct rtw_dev *rtwdev)
 
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
@@ -1470,6 +1489,11 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 	rtwdev = hw->priv;
 	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 
+	scoped_guard(mutex, &rtwsdio->irq_lock) {
+		if (!rtwsdio->running)
+			return;
+	}
+
 	rtwsdio->irq_thread = current;
 
 	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
@@ -1703,6 +1727,11 @@ static void rtw_sdio_tx_handler(struct work_struct *work)
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

