Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794023620;
	b=RP1vnCpjxjNWIxnkj3KR0EnQrb9WX175lF9DgsA0U1q0MeK1X28eruze8zsHc6pLRjcH
	 GkgiCsT81tiq6wtyPMDE96lutjwDcZXtxKZgtwovMvMT3olrNaMLimSNodJ11ILJj7WbT
	 OTXgP8NCQuh42+kIbW8DKQhkfgPumSb6MMfH3uajeRoHTsPdvxUXBUKLPGfjsxap35JYL
	 UtgbAH993fFIIKqvRtfSjkjv+oW4aW7v1fiMCz+3d45fBSDOtl7lkMaYhH0IeKgeUk3PV
	 f28Dwtko+Tj2aqaFGS7Tl2c94hVIP4pXhCRwMfeP3F1k3OncwaKNziJjE+kikRoxsEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794023620;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jq9t4i4p9xF2mSol4zZx3RitgWvrWh8XynSKXKryK9o=;
	b=2ny4gXcm3GY/uEFkbwGrkjUav5ToBedzxwmEqVXjM3ur1fd+yqiTdKLIK8EjFfImxEZB
	 OOughmh5X7pztOQ2Pn+0I1UysgAe3Vf93wUk1JVaCNQDfd0Ch++kI8z/2ZZVuJiBxqtem
	 aClK/C9dIeexKm19DyxpTnBEZXxazz2yYtJvXDuwYjqhlurg/Mw+z54O/UtTwSiZBvd7g
	 T0bzU1kal7664SgPadVKt4yhP1IpHBHc5srP6wxzXexSnYa9e6jGQTwJdizvkQ98vd/JI
	 LUGJG31NTyzgH4HgrpH3HSH+xLi/vQkWP+sxfIJoypZ4dTpPhNR+m6K51htvPm1MDNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=a4YKOuVJ;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71E606A326;
	Sat,  7 Nov 2026 03:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E71E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=a4YKOuVJ
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 2424D401FC;
	Sat,  7 Nov 2026 14:53:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1794023610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jq9t4i4p9xF2mSol4zZx3RitgWvrWh8XynSKXKryK9o=;
	b=a4YKOuVJK6k/Ai4OrSX0bLMIuSFFr0hVgUKJAAixhinb6a5/o2vKxTrgmrYqfU0/e+iNW3
	PiCES9j/zvrhjn305UXR7eVJb9C+f+j9Fz1k5m4d2XBT9Hvd05aLoVOadl5mTiqFSTX6m5
	xeYAkooiZw1Ftddn6uhmrXNjLKQ3gOE2aM9lBxlbCsSmARBAdNG9eAOWuO95Aq9uXHkKtx
	kk7INJVU+RvOl+6nCXTZUXxvXMc4Ua2pC9Ok6aHEEsglwbtOw59r4GIQaS3Dca5DGxGFal
	xr/DcTblyfXaUoU5wZmroagsiaXlawuiboVA14EuzLcMVAW+5jys48306gf+Wg==
X-GPT-Reason: This email is classified as legitimate. The content
	is a technical software patch description for a Linux kernel driver,
	which is highly consistent with the personal/professional identity
	of the sender (alastair@d-silva.org) and the recipient
	(alastair@d-silva.org). There are no phishing indicators, urgency
	tactics, or external links; the email contains standard developer
	metadata such as "Fixes," "Cc," and "Signed-off-by," and the From
	domain matches the local mailbox perfectly.
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
Subject: [PATCH rtw-next v9 1/4] wifi: rtw88: sdio: Handle allocation and read errors in rtw_sdio_rxfifo_recv
Date: Sat,  7 Nov 2026 14:53:18 +1100
Message-ID: <20261107035321.1210303-2-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107035321.1210303-1-alastair@d-silva.org>
References: <20261107035321.1210303-1-alastair@d-silva.org>
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

