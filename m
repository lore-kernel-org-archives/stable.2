Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558179;
	b=O3xjdlnjLRuv9TC2nu3lOwfJOjwr/bIfA9G1IpBm8iqw8cyO7e6pzRSu2XWEszvweBIg
	 6yn39vPRpVq9Fm/koQiWzL3SPkTZVEEE/z97U/WopNaUN2YsucDJbJV7ZYn/MfwxWjUVA
	 6Omtq3FNFSMeajG5CATujRCor6SZCM2N/6WcXAW4Z1hle9w5ShooH5Tuy0MXsS471a9dI
	 DR1DMFRBlAfve6PwM2GnHB47wXmJTgh9iY5DcZ/uXGs4PV3YW843DgEN5X7bx3mhRF+a4
	 J6prujXduR6fo9Pw7TdpJ24JD8g37cRUXu3i/xmxVtFaz485U5Itx1BZGHwf2FWTjCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558179;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jq9t4i4p9xF2mSol4zZx3RitgWvrWh8XynSKXKryK9o=;
	b=rbEQ4r6Bf81SyFV3J9Uj+c4fEBevWyC+ZccLLYC4LJej5SDhJqwkoQAXqmjIHQWER0Eo
	 uIAikA/mmrE4suF4fpIUW7K6Hg1aNyb797JCjv9HvE7sqtf8HtG7z37gZ6MrzNI5uCCxy
	 GG8tZvKl32/nUbq1T4ZynIJnH7NQegVc7FOW63/i9zD1MteShL+7cXDdGWFSY8orh2ddN
	 3e9+cWYuBSVEo5rnxh/Yf8dc+T4EwTd7e2ANNq8oz6t2nu/55kaKIkEtBpcpAobr33Ylg
	 BydhEUnh/2tW6N8pHxQIB3soFbLjEddRlDHYcgmJuZYx/GzOEDiYbj9j4qgyQGs3d1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=FL35QDJ3;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6487A606A321;
	Fri, 13 Nov 2026 08:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6487A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=FL35QDJ3
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 19A2040DB9;
	Fri, 13 Nov 2026 19:22:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1794558170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jq9t4i4p9xF2mSol4zZx3RitgWvrWh8XynSKXKryK9o=;
	b=FL35QDJ3zT1hVHXtEPjMRv7NCy6GpwzIT/AT6vXrxqPYKFEFd2wrbTmsoZD/Ta1qzPG5fC
	zmleoFLjpyF6nh/+9RA4Xd8mLLT06Jz27U8/XM2ZsGphXQ/9rnmrQtwJB5fBKqhm/L/AVl
	0vFnsTpbAVbj6lJsdD41TG+ucL7VzUgXKGJ+EWTdQi7DVluhL1zS7Ay3EpR/4OmS5vW/l8
	8XVfEoWLJSyzlAHmc7pSX5iwCwzD3SH9T1Ynu0aF+loff5oIoSDgibJYG3WKiZ0Vbg/G20
	n7B1rTvIMcU8tGwE9VYacWFveFX8uBTjfXMENFXloeZ2mYnJ5fwdCRCRaEdYaA==
X-GPT-Reason: legitimate; the email is a technical kernel patch
	submission that perfectly aligns with the personal/professional
	identity of the sender (alastair@d-silva.org) and the recipient
	(alastair@d-silva.org); it contains no marketing, scam, or phishing
	indicators; the content describes specific Linux kernel code fixes
	(rtw88, sdio, rtx_sdio_rxfifo_recv) and includes standard development
	metadata like "Fixes," "Cc," and "Signed-off-by" headers; there
	are no suspicious URLs, urgency tactics, or requests for sensitive
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
Subject: [PATCH rtw-next v10 1/4] wifi: rtw88: sdio: Handle allocation and read errors in rtw_sdio_rxfifo_recv
Date: Fri, 13 Nov 2026 19:22:39 +1100
Message-ID: <20261113082242.2773369-2-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113082242.2773369-1-alastair@d-silva.org>
References: <20261113082242.2773369-1-alastair@d-silva.org>
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

