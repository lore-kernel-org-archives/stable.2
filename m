Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847439;
	b=l6XxHMjY7ax7o+4i7XJyJno4Np3NL7j7jdxIqIcYAe89fBv0dvTzsJZjb0xmLuzUZ0+E
	 RlsApM0cGDivVLcvlrutwa4xpxFUsp5vMU/fwU7DxC6J0fjAjpMj/FP7f67OBrDUQmVTM
	 BWVgZDsMkxSizaXhZFlA6i7FcJiejFxaugShoMRsx8rQ3LQXXYcIkbqdJD8VJ/MEYAZhb
	 RUzWyqhPyNtCqWEodA3Qqa2hpavQW7A2KPRO3LSneVxToezmny5bvbUEbHmFXiT1pHkp2
	 7yajw8dLnRFIHoJz0UYlnqMtt7oQ+SFdjiWGxNOXglSLwAsSLg5dWalIr2ZOttIUXaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847439;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jq9t4i4p9xF2mSol4zZx3RitgWvrWh8XynSKXKryK9o=;
	b=nWNs9hdNPRGEYethIl/yUMpX+Xrz07mpx/5RwEPpn+e00/wDbioxI879fKQOdIFtlNgg
	 bu7QbB50Gfrgy4izd6lbIIZVTKS+IBS3lQzTaHLJK1DhlgNoXTC8YpHRoYHxi/8TTc8AR
	 7WZHZb8XszUPU7l4oDWwqI30rY3zLFUt1dzheqO/UY976QPZJ03XbKhZaRL+WpVFnksdv
	 jUZQo1TgcG1wVED5DVPIAHegPJbEI7RPjxpjUMq7vgbpC2D0vxFfce8LSpxnu07sC7oqF
	 7ecVGmqwFpcuOY3psVRGfn0Ns064TdEw9MzDJBm/PlBbt1Njnz82MQ5YzV8dMsiifzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=RpmkdZsZ;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A8606A328;
	Thu,  5 Nov 2026 02:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA2A8606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=RpmkdZsZ
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id B2C4C41A1E;
	Thu,  5 Nov 2026 13:57:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1793847428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jq9t4i4p9xF2mSol4zZx3RitgWvrWh8XynSKXKryK9o=;
	b=RpmkdZsZgbcqwmyzDPOHCYuMU0SBv/jUzTl1QoMHcQVeo0u/j6SGGCqv+w/ndAa13kSVAA
	wo6WG8mTHMZG74TD2ywRBD3jGdpSMVQrhsFyD8F+t0NxR/0xBn6bkv0XOij2z5Qx9WvqvO
	9WhaIKy8AkqL6NBL8xJN92IVkOaOYfpz3l2dUaIA0aVQWOtlldR6aIdg1T2H35mfznO9FT
	lCx2BAR2LN2km3Xa2GYIw3X2F7wlT603IOdoJa0kFWsmh6fs6UYXkCLhv7ekwlmESQXeiN
	Woma5LxrMLM2EUHmpQGEoqkhl/6ZqiHZ7pcAIgWErjpBbJgIdInm0tjQPbWDSQ==
X-GPT-Reason: This email is classified as legitimate personal/professional
	communication. The content is a technical kernel patch description
	regarding a wifi driver (rtw88), which aligns perfectly with the
	personal mailbox of alastair@d-silva.org. The sender domain (d-silva.org)
	matches the recipient domain, the "Cc" and "Reviewed-by" headers
	reference known Linux kernel development entities (vger.kernel.org,
	linux.dev), and there are no indicators of marketing, phishing, or
	urgency.
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
Subject: [PATCH rtw-next v8 1/4] wifi: rtw88: sdio: Handle allocation and read errors in rtw_sdio_rxfifo_recv
Date: Thu,  5 Nov 2026 13:56:57 +1100
Message-ID: <20261105025700.1655219-2-alastair@d-silva.org>
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

When dev_alloc_skb() or rtw_sdio_read_port() fails, rtw_sdio_rxfifo_recv()
returns without reading data. Because it returned void, the caller still
counted rx_len against the loop budget while leaving data stranded in the
FIFO.

Return an error code from rtw_sdio_rxfifo_recv() on failure and break out
of the receive loop in the caller immediately.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
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

