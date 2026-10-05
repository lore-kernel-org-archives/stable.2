Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FFE37F322;
	Mon,  5 Oct 2026 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190152; cv=none; b=HxS7sJyvG3cT0cVKYe7PooeUcn8TYfj/utzZMt7qCJ5IpWWmV9A5HXiYKhyocbfjVFFBe49Vt2tKzpomG0xGznZdKpuCQW5Q8+DaHp75YDiXNm7nuwVADIrVAK9UVTib8gSyvYRaVyhJJwUCsiFNiaH/w1vGFZafJ9TCFbHa8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190152; c=relaxed/simple;
	bh=kTkhrVTAO5GMjPKBb3aCo2c3nPtQ9xe7/SLbVhe4i+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rteF9fsWNuA8GrlSvWM2aiZ2VP2F8AlSChRWotoOcr6jkeIUJq9yFHkA3NgH4TTdwL5VExUwq7kPSbGmu92N2ozFECp9HA0yJzzzoy3KAd3FzLY1+GT4doMdXEvgahjNv+oaswmzEocdNC9cFnoZjVKGoRXN4MFc5+ovs/eMWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=lHs8c/NK; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="lHs8c/NK"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 70C87424F4;
	Mon,  5 Oct 2026 19:49:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1791190142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGW3NlkX62S45sEbjjI+fX46KWVMMEaNaAB1fTOPLCs=;
	b=lHs8c/NK9rkYDzrMA9IaGZbQRCgMWzIN3EYbYDb05Oa8NuPGYbqc8z4GQQ/kazUx9gYQfk
	0pUqS2vNRvk8k22jXv+6Clqu4auGbqqwNyLLYRAaBjagnykeqKLTklNjw8HPwgYa48PpmP
	Gbsq6/Tda68mUTdol9dpJtkbH+NFHyiVFsOzct/cm0cmjvM7/E4Z0tumNvR7okdAoF3qgk
	wtVycROLEXAxKxnKgLVIzPoG2Ul0wTuURRZjHpaMAUA2hWFNyPiMb8HWhUZVwddaxpeaBn
	g2O9+MMC6be3KsLrnkeMrgq0QM4q1GHpu80pdCLZlxPFEnS/W6tD5+yDvvVhLg==
X-GPT-Reason: legitimate; the message is a technical software patch
	(Linux kernel driver update) that perfectly aligns with the
	personal/professional context of the recipient (alastair@d-silva.org);
	the From domain (d-silva.org) matches the recipient's domain; the
	content contains a standard git diff and technical documentation
	with no external links, urgency, or marketing elements; and it follows
	a standard developer workflow for code contributions.
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
Subject: [PATCH rtw-next v4 2/4] wifi: rtw88: sdio: Track running state and cancel TX worker on stop
Date: Mon,  5 Oct 2026 19:48:47 +1100
Message-ID: <20261005084849.3109337-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005084849.3109337-1-alastair@d-silva.org>
References: <20261005084849.3109337-1-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rtw_sdio_stop() disables interrupts, in-flight interrupt handlers or
delayed TX work may still run against a powered-down device.

Track the operational state in rtwsdio->running (similar to PCI), check it
at the entry of rtw_sdio_handle_interrupt() and rtw_sdio_tx_handler(), and
cancel the TX worker synchronously in rtw_sdio_stop().

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw88/sdio.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index e39284b71837..d2f4d7e8bc83 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1054,6 +1054,7 @@ static int rtw_sdio_8723bs_check_rqpn(struct rtw_dev *rtwdev)
 
 static int rtw_sdio_start(struct rtw_dev *rtwdev)
 {
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 	u32 clear;
 
 	if (rtw_is_8723bs(rtwdev)) {
@@ -1075,6 +1076,7 @@ static int rtw_sdio_start(struct rtw_dev *rtwdev)
 			rtw_write32(rtwdev, REG_SDIO_HISR, clear);
 	}
 
+	rtwsdio->running = true;
 	rtw_sdio_enable_interrupt(rtwdev);
 
 	return 0;
@@ -1082,7 +1084,11 @@ static int rtw_sdio_start(struct rtw_dev *rtwdev)
 
 static void rtw_sdio_stop(struct rtw_dev *rtwdev)
 {
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+
+	rtwsdio->running = false;
 	rtw_sdio_disable_interrupt(rtwdev);
+	cancel_delayed_work_sync(&rtwsdio->tx_handler_data->work);
 }
 
 static void rtw_sdio_deep_ps_enter(struct rtw_dev *rtwdev)
@@ -1470,6 +1476,9 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 	rtwdev = hw->priv;
 	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 
+	if (!rtwsdio->running)
+		return;
+
 	rtwsdio->irq_thread = current;
 
 	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
@@ -1703,6 +1712,9 @@ static void rtw_sdio_tx_handler(struct work_struct *work)
 	rtwdev = work_data->rtwdev;
 	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 
+	if (!rtwsdio->running)
+		return;
+
 	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_TX_WAKE))
 		rtw_sdio_deep_ps_leave(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.h b/drivers/net/wireless/realtek/rtw88/sdio.h
index 6e7e6009744b..a3851d4a58e7 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.h
+++ b/drivers/net/wireless/realtek/rtw88/sdio.h
@@ -168,6 +168,7 @@ struct rtw_sdio {
 	bool sdio3_bus_mode;
 
 	void *irq_thread;
+	bool running;
 
 	struct workqueue_struct *txwq;
 	struct rtw_sdio_work_data *tx_handler_data;
-- 
2.53.0

