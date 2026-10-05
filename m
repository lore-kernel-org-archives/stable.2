Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C14F31F99C;
	Mon,  5 Oct 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190146; cv=none; b=A1jAj+/Tg2BT5sM/5H5ObAdF1NzoFe6AuH6a4gJnI6412nJ1FMiLbdQnFYXBhXkGM61wQzWG5wk3VHsrx5bdw0GQAQRsN4ah4rplgLHk2HvsD3CSzPdLm8UY2P0M3P+6ms9p12AwtLB4fKEJJDu8zatqF4hNzQ1epyc+BFSaM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190146; c=relaxed/simple;
	bh=ZOFDXKT9pT7NF5wfa2BqNEVmLTyM+7q+Z9SIUx/78b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSOhCa/o4xXvhfPVPYAgGfgYV/xb1fOqeHU1hYTfFFKK6QyGRaxPyM0/kJva7bfWhX6Q5vtzYDru9c7Nk9reMl9blSQAiRH7010r4Id4Eco8GF7MvDTXgNyl7OBbogdQENMbWfsyWCV341nkWGEw5Q/qe9W9q8EF+N5mXbB9GeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=1AfoSKjS; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="1AfoSKjS"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id DECEA4086D;
	Mon,  5 Oct 2026 19:48:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1791190135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIZ2AGLmaSEsGXYA99RwBuup26bsgg2d0YHri6TJQ/Q=;
	b=1AfoSKjSXRsREwn2HSqH4bWzRLcMVWLYt1wFklopJIHhhDs8/MO+hhc5OdnM1lE5HmrIAA
	9XFR6/wv75NEy2PuIYAlM8IiMi7KrTi/DXn/QKrVu4RzTlFVJ/RpskI4Log+dn2jq20j2t
	roUH5NaJfFF7iUywzClwjsNEFbqMmLd1lfg3FIb55gHkOltIpfOgX3DInYVWSSCaJBzm3r
	OdiGomVNHuqbt9CGbjGZY4SWfXbMwm+jg9sLv5dVYd9JLFkNRzBn4E3t/Qx8OgepXTnFZv
	/5T8zCcE9ecWQrYqvReON3O7wuh8DLhI7EPc5VFbD75vecfLTaIuwi23UGA4sA==
X-GPT-Reason: legitimate; the email is a technical kernel patch
	submission containing a code diff and a description of a fix for
	a realtek wireless driver; the sender (alastair@d-silva.org) matches
	the personal mailbox address provided in the context; the content
	is highly specific, technical, and lacks any marketing, urgency, or
	phishing indicators; the subject line follows standard Linux kernel
	mailing list formatting for patches.
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
Subject: [PATCH rtw-next v4 1/4] wifi: rtw88: sdio: Handle allocation and read errors in rtw_sdio_rxfifo_recv
Date: Mon,  5 Oct 2026 19:48:46 +1100
Message-ID: <20261005084849.3109337-2-alastair@d-silva.org>
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

When dev_alloc_skb() or rtw_sdio_read_port() fails, rtw_sdio_rxfifo_recv()
returns without reading data. Because it returned void, the caller still
counted rx_len against the loop budget while leaving data stranded in the
FIFO.

Return an error code from rtw_sdio_rxfifo_recv() on failure and break out
of the receive loop in the caller immediately.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index dc2fd0f8f9ff..e39284b71837 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1349,7 +1349,7 @@ static void rtw_sdio_rx_skb(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	ieee80211_rx_irqsafe(rtwdev->hw, skb);
 }
 
-static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
+static int rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 {
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 	const struct rtw_chip_info *chip = rtwdev->chip;
@@ -1366,12 +1366,12 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 
 	skb = dev_alloc_skb(bufsz);
 	if (!skb)
-		return;
+		return -ENOMEM;
 
 	ret = rtw_sdio_read_port(rtwdev, skb->data, bufsz);
 	if (ret) {
 		dev_kfree_skb_any(skb);
-		return;
+		return ret;
 	}
 
 	while (true) {
@@ -1380,7 +1380,7 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 					   &pkt_stat, &rx_status);
 		if (ret) {
 			dev_kfree_skb_any(skb);
-			return;
+			return ret;
 		}
 
 		pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
@@ -1416,11 +1416,14 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 		skb_reserve(skb, curr_pkt_len);
 		rx_len -= curr_pkt_len;
 	}
+
+	return 0;
 }
 
 static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 {
 	u32 rx_len, hisr, total_rx_bytes = 0;
+	int ret;
 
 	do {
 		if (rtw_chip_wcpu_8051(rtwdev))
@@ -1431,7 +1434,9 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 		if (!rx_len)
 			break;
 
-		rtw_sdio_rxfifo_recv(rtwdev, rx_len);
+		ret = rtw_sdio_rxfifo_recv(rtwdev, rx_len);
+		if (ret)
+			break;
 
 		total_rx_bytes += rx_len;
 
-- 
2.53.0

