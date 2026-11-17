Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910445;
	b=v88pgdVu+ww0ghPeUt2DVKqQ/sltjecHxmyDJ5nns/6XK0bAFiaB2TDcY7Rt6yM6HBnU
	 j/LS6SEl2qJBj3XXcl14/J2ZJ9Veav4b1hqHlm68lOtcxGdettNnPCNZan9cMnewk7cJ9
	 DtPb2rN9Mv73QD6xSJcnJtEt/QDrmVym8o8wAupHpn7bEgOWkZDKM0GIxXCaa+nMrcjDv
	 zl5NKyaON8b/lAE6stzeFRxhAl8E7bfSjuHxUYQmlivJilruMG3WW++ki9sDVzdzb9ZtQ
	 yKwe/kRAqJfpMZ9C4NKoXDqryhLGgGexPhZwQ1X7tbSg02OSTVb9yUZL7GE/33O/z2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910445;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T9LTWcbD005QQqdXMPWTKY++J5doOXE93nTPA/oLwiw=;
	b=y/tukyJ+TkTdQ4ojvWuGUTAzAJB5Rg8Nt56B1JEVTARwKEB49Zk89mrewH3p31FJ9Y9/
	 +5X+T+m+TuYbveKKY+CVNucEINcycx/rH0v+lw6nom5xWs7Pr0KASqrjgRY5wXtpMtCwd
	 enHmMjfCQMDZM8R2yARd0XJLsDqaaYB4ZCO6ohG/Iy0NWD6j1gJNlrvcyKFKzCS/gGXYw
	 WKXEooMd/2mlIXVZ0M3yMr6u2os0jIQAzy1Gv+Rrj+sGNZGAw2jPAdRTfAudbdMMC4nA4
	 XMLjGzC9jIV/gYy75PTc17XFuIwbvTP74NIt2EuDOBB8BjsTKa/cHRBPRYmNAgCxJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=nr3WZ+73;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072FB606A32A;
	Tue, 17 Nov 2026 10:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 072FB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=nr3WZ+73
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id B2A3F416C0;
	Tue, 17 Nov 2026 21:13:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1794910435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9LTWcbD005QQqdXMPWTKY++J5doOXE93nTPA/oLwiw=;
	b=nr3WZ+73RwzLDGszUKjqZIsoTY6pe7ecaS6sufxPjtdEGAFz6ozkj/1TCaqU1aHVMfJDTv
	2TKsErSZEdLueFhpzTFUKNV3KaXGOQ6KqID8EXSjg72L/nRLmxQsPp1hruQavhiiz1ESjG
	cDNpNq2O3EKN1Dzj2O0vlib+ko/gYx1LsqT8i+xDay33o7OfPGD1uB3gi4AIGCyOmqiUIC
	xU6F8dZ/vk9RoFAm1mYW/R/jIapeKRRIyiwzRKPSbZ8VuiQmr+UQmTgPYL1kYoqtdnNCJM
	2ECTOV2GCCM7gg3VwlF4FoxBdUlgp3MMLIv3yC+0NzcqWPgl+zgH+yjc/RtKvw==
X-GPT-Reason: This is a legitimate personal/technical communication.
	The message is a kernel patch submission (indicated by the [PATCH]
	subject and technical content regarding wifi drivers) sent from
	the personal domain alastair@d-silva.org to a mailbox that is
	expected to receive such content. There are no phishing indicators,
	no unsolicited marketing, and the sender identity aligns perfectly
	with the "Signed-off-by" footer and the From header.
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
Subject: [PATCH rtw-next v11 1/4] wifi: rtw88: sdio: Handle allocation and read errors in rtw_sdio_rxfifo_recv
Date: Tue, 17 Nov 2026 21:13:44 +1100
Message-ID: <20261117101347.2157211-2-alastair@d-silva.org>
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

When dev_alloc_skb() or rtw_sdio_read_port() fails, rtw_sdio_rxfifo_recv()
returns without reading data. Because it returned void, the caller still
counted rx_len against the loop budget while leaving data stranded in the
FIFO.

Return an error code from rtw_sdio_rxfifo_recv() on failure and break out
of the receive loop in the caller immediately.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index ecd4d751c05a5..172aa7ad4732a 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1348,7 +1348,7 @@ static void rtw_sdio_rx_skb(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	ieee80211_rx_irqsafe(rtwdev->hw, skb);
 }
 
-static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
+static int rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 {
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 	const struct rtw_chip_info *chip = rtwdev->chip;
@@ -1365,12 +1365,12 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 
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
@@ -1379,7 +1379,7 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 					   &pkt_stat, &rx_status);
 		if (ret) {
 			dev_kfree_skb_any(skb);
-			return;
+			return ret;
 		}
 
 		pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
@@ -1393,7 +1393,7 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 				"oversized RX packet: %u, %u bytes left\n",
 				pkt_offset + pkt_stat.pkt_len, rx_len);
 			dev_kfree_skb_any(skb);
-			return;
+			return -EINVAL;
 		}
 
 		if ((curr_pkt_len + pkt_desc_sz) >= rx_len) {
@@ -1423,11 +1423,14 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
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
@@ -1438,7 +1441,9 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 		if (!rx_len)
 			break;
 
-		rtw_sdio_rxfifo_recv(rtwdev, rx_len);
+		ret = rtw_sdio_rxfifo_recv(rtwdev, rx_len);
+		if (ret)
+			break;
 
 		total_rx_bytes += rx_len;
 
-- 
2.53.0

